package com.tmap.datafilemanagement.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import ch.qos.logback.core.joran.spi.Pattern;

import com.btb.core.DirControll;
import com.btb.core.MD5Util;
import com.btb.mdcs.message.FileInfoMsg;
import com.btb.mdcs.model.DsInfoVo;
import com.btb.mdcs.model.FileInfoVo;
import com.btb.mdcs.model.CodeVo.FileState;
import com.btb.mdcs.util.DSClient;
import com.btb.mdcs.util.ResultCondition;
import com.tmap.datafilemanagement.dao.DataFileInfoDAO;
import com.tmap.datafilemanagement.dao.DataFileListInfoDAO;
import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.datafilemanagement.vo.DataFileListInfoVO;
import com.tmap.servermanagement.service.MapDownServiceService;
import com.tmap.servermanagement.vo.SystemInfoVO;

@Service
public class DataFileListInfoService {
  @Autowired
  DataFileListInfoDAO dataFileListInfoDAO;
  @Autowired
  DataFileInfoDAO dataFileInfoDAO;
  @Autowired
  MapDownServiceService mapDownServiceService;
  
  /**
   * Data File List Info 조회
   * 
   * @param fileVerId
   * @return
   * @throws Exception
   */
  public List<DataFileListInfoVO> dataFileListInfoList(String fileVerId) throws Exception {
    return dataFileListInfoDAO.dataFileListInfoList(fileVerId);
  }
  
  /**
   * Data File 업로드, 정보 등록
   * 
   * @param request
   * @param dataFileListInfoVO
   * @return
   * @throws Exception
   */
  public boolean fileInfoInsert(HttpServletRequest request, DataFileListInfoVO dataFileListInfoVO) throws Exception {
    MultipartFile file = dataFileListInfoVO.getUploadFileObj();
   
    // 필수값 셋팅
    dataFileListInfoVO.setFileName(file.getOriginalFilename());
    dataFileListInfoVO.setFileUpdate("N");
    
    String notAllowPattern = "(.*([\\\\/*?$@()^&+=#% |<>]).*|.*(\\.(?i)(php|asp|jsp|html|cgi|perl|pl))$)";
    java.util.regex.Pattern p = java.util.regex.Pattern.compile(notAllowPattern);
    Matcher m = p.matcher(dataFileListInfoVO.getFileName());
    if(m.matches()){
    	return false;
    }
    		
    
    // 저장경로 가져오기
    DataFileInfoVO dataFileInfoVO = dataFileInfoDAO.dataFileInfo(dataFileListInfoVO.getDataFileId());
    String dataTypeName = dataFileInfoVO.getDataTypeName();
    String storageMount = dataFileInfoVO.getStorageMount();
    String uploadPath = dataTypeName + "/" + dataFileListInfoVO.getDataFileName() + "/" + dataFileListInfoVO.getFileVerName();
    String fullPathFileName = storageMount + "/" + uploadPath + "/" + dataFileListInfoVO.getFileName();
    
    // 저장폴더 생성
    DirControll.makeDir(storageMount + "/" + uploadPath);
    
    // 파일저장
    File destFile = new File(fullPathFileName);
    FileUtils.copyInputStreamToFile(file.getInputStream(), destFile);
    
    // md5 생성
    MD5Util md = new MD5Util();
    md.setFileReadSize(1024 * 10);
    String md5 = md.getFileCheckSum(fullPathFileName);
    
    // DB 저장
    dataFileListInfoVO.setFileName("/" + uploadPath + "/" + dataFileListInfoVO.getFileName());
    dataFileListInfoVO.setFileSize(file.getSize());
    dataFileListInfoVO.setFileMd5(md5);
    
    boolean isSuccess = dataFileListInfoDAO.fileInfoInsert(dataFileListInfoVO) > 0;
    if (isSuccess) {
      List<FileInfoVo> fileInfoList = new ArrayList<FileInfoVo>();
      FileInfoVo fileInfo = new FileInfoVo(FileState.CREATE.value, fullPathFileName, dataFileListInfoVO.getFileName());
      fileInfo.setNasFilePathLength(fileInfo.getNasFilePath().getBytes().length);
      fileInfo.setDsFilePathLength(fileInfo.getDsFilePath().getBytes().length);
      fileInfoList.add(fileInfo);
      dsUpdateFileInfo(fileInfoList);
    }
    return isSuccess;
  }
  
  public Boolean dsUpdateFileInfo(List<FileInfoVo> fileInfoListVo ) throws Exception{
    List<SystemInfoVO> systemInfoList = new ArrayList<SystemInfoVO>();
    systemInfoList = mapDownServiceService.systemInfo();
    List<DsInfoVo> dsInfoList = new ArrayList<DsInfoVo>();
    for (SystemInfoVO dsSystemInfoVO : systemInfoList) {
      if (dsSystemInfoVO.getSystemIpIn() != null && dsSystemInfoVO.getSystemPortIn() != null) {
        dsInfoList.add(new DsInfoVo(dsSystemInfoVO.getSystemIpIn(), Integer.parseInt(dsSystemInfoVO.getSystemPortIn())));
      }
    }
    DSClient dsClient = new DSClient(dsInfoList);
    return dsClient.updateFileInfo(fileInfoListVo).isSuccess();
  }
  
  /**
   * File 삭제
   * 
   * @param dataFileListInfoVO
   * @return
   * @throws Exception
   */
  public boolean fileInfoDelete(DataFileListInfoVO dataFileListInfoVO) throws Exception {
    boolean isSuccess = false;
    
    // 물리적 파일 삭제
    DataFileInfoVO dataFileInfoVO = dataFileInfoDAO.dataFileInfo(dataFileListInfoVO.getDataFileId());
    String uploadPath = dataFileInfoVO.getStorageMount();
    DataFileListInfoVO deleteFileListInfo = null;
    for (String fileListId : dataFileListInfoVO.getFileListIds()) {
      deleteFileListInfo = dataFileListInfoDAO.dataFileListInfo(fileListId);
      File targetFile = new File(uploadPath + deleteFileListInfo.getFileName());
      isSuccess = targetFile.delete();
    }
    
    isSuccess = dataFileListInfoDAO.fileInfoDelete(dataFileListInfoVO) > 0;
    if(isSuccess)
    {
      List<FileInfoVo> fileInfoList = new ArrayList<FileInfoVo>();
      for(String path : dataFileListInfoVO.getFileNames()){
        FileInfoVo fileInfo = new FileInfoVo(FileState.DELETE.value, uploadPath + path, path);
        fileInfo.setNasFilePathLength(fileInfo.getNasFilePath().getBytes().length);
        fileInfo.setDsFilePathLength(fileInfo.getDsFilePath().getBytes().length);
        fileInfoList.add(fileInfo);
      }
     @SuppressWarnings("unused")
    Boolean dsResult = dsUpdateFileInfo(fileInfoList);
    }
    
    return isSuccess;
  }
  
  /**
   * 파일 다운로드 필수 여부 등록
   * 
   * @param dataFileListInfoVO
   * @return
   * @throws Exception
   */
  public boolean fileInfoRequisiteState(DataFileListInfoVO dataFileListInfoVO) throws Exception {
    return dataFileListInfoDAO.fileInfoRequisiteUpdate(dataFileListInfoVO) > 0;
  }
}
