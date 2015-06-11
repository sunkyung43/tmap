/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.dataservicemanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.datafilemanagement.vo.DataTypeInfoVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.dao.FileServiceInfoDAO;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.FileServiceInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */

@Service
public class FileServiceInfoService {

	@Autowired
	FileServiceInfoDAO fileServiceInfoDAO;

	//파일 서비스 리스트
	public List<FileServiceInfoVO> fileServiceList(FileServiceInfoVO fileServiceInfoVO) throws Exception{
		
		if(fileServiceInfoVO.getDataTypeId() == null || fileServiceInfoVO.getDataTypeId().equals("")){
			
			//리스트 수를 조회하여 설정
			int totalCount = fileServiceInfoDAO.countAllFileServiceList(fileServiceInfoVO.getDataFileName());
			fileServiceInfoVO.setTotalCount(totalCount);
			
			//파일 서비스 리스트
			return fileServiceInfoDAO.allFileServiceList(fileServiceInfoVO, fileServiceInfoVO.getStartRowNum(), fileServiceInfoVO.getCountPerPage());
		
		}else{
			
			//리스트 수를 조회하여 설정
			int totalCount = fileServiceInfoDAO.countFileServiceList(fileServiceInfoVO);
			fileServiceInfoVO.setTotalCount(totalCount);
			
			//파일 서비스 리스트
			return fileServiceInfoDAO.fileServiceList(fileServiceInfoVO, fileServiceInfoVO.getStartRowNum(), fileServiceInfoVO.getCountPerPage());
			
		}
		
		
	}
	
	//데이터 타입 리스트
	public List<DataTypeInfoVO> typeList() throws Exception{
		
		return fileServiceInfoDAO.typeList();
	}
	
	//데이터 파일 리스트(등록)
	public List<DataFileInfoVO> fileInType(FileServiceInfoVO fileServiceInfoVO) throws Exception{
		
		return fileServiceInfoDAO.fileInType(fileServiceInfoVO);
		
	}
	
	//데이터 파일 버전 리스트
	public List<FileVersionInfoVO> verInFile(FileServiceInfoVO fileServiceInfoVO) throws Exception{
		
		return fileServiceInfoDAO.verInFile(fileServiceInfoVO);
		
	}
	
	//파일 상세 정보
	public List<DataFileInfoVO> fileDetail(FileServiceInfoVO fileServiceInfoVO) throws Exception{
		
		return fileServiceInfoDAO.fileDetail(fileServiceInfoVO);
		
	}
	
	//버전 상세 정보
	public List<AppMappingInfoVO> verDetail(FileServiceInfoVO fileServiceInfoVO) throws Exception{
		
		return fileServiceInfoDAO.verDetail(fileServiceInfoVO);
		
	}
	
	//파일 서비스 등록 
	public int serviceInsert(FileServiceInfoVO fileServiceInfoVO) throws Exception{
		
		//매핑 정보 입력
		int result = fileServiceInfoDAO.serviceInsert(fileServiceInfoVO);
		
		if(result > 0 && fileServiceInfoVO.getDataFileIds() != null){
			
			//last file_serv_id
			int fileServId = fileServiceInfoDAO.fileServId(fileServiceInfoVO.getDataFileId());
			fileServiceInfoVO.setFileServId(String.valueOf(fileServId));
			
			//file_service_detail_info 등록
			fileServiceInfoDAO.fileServiceDetailInfo(fileServiceInfoVO);
			
		}
		
		return result;
	
	}
	
	//last file_serv_id
	public int fileServId(String dataFileId) throws Exception{
		
		return fileServiceInfoDAO.fileServId(dataFileId);
	}
	
	//파일 서비스 정보
	public FileServiceInfoVO fileServiceInfo(String fileServId) throws Exception{
		
		return fileServiceInfoDAO.fileServiceInfo(fileServId);
	}
	
	//데이터 버전 정보
	public List<FileVersionInfoVO> versionInfo(FileServiceInfoVO fileServiceInfoVO) throws Exception{
		
		return fileServiceInfoDAO.versionInfo(fileServiceInfoVO);
	}
	
	//파일 서비스 수정 
	public void fileServiceUpdate(FileServiceInfoVO fileServiceInfoVO) throws Exception{
		
		//파일 서비스 수정 
		int result = fileServiceInfoDAO.serviceUpdate(fileServiceInfoVO);
		
		if(result > 0 && fileServiceInfoVO.getDataFileIds() != null){
			
			//기존 등록된 file_service_detail_info 삭제
			fileServiceInfoDAO.fileServiceDetailDel(fileServiceInfoVO.getFileServId());
			
			//file_service_detail_info 등록
			fileServiceInfoDAO.fileServiceDetailInfo2(fileServiceInfoVO);
			
		}else{
			
			//기존 등록된 file_service_detail_info 삭제
			fileServiceInfoDAO.fileServiceDetailDel(fileServiceInfoVO.getFileServId());
		}
		
	}
	
	//파일 서비스 삭제
	public void fileServiceDelete(String fileServId) throws Exception{
		
		//파일 서비스 삭제
		fileServiceInfoDAO.fileServiceDelete(fileServId);
		
		//file_service_detail_info 삭제
		fileServiceInfoDAO.fileServiceDetailDel(fileServId);
	}
	
		
}
