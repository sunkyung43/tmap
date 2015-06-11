package com.tmap.datafilemanagement.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.btb.mdcs.model.FileInfoVo;
import com.btb.mdcs.model.CodeVo.FileState;
import com.btb.mdcs.util.DSClient;
import com.btb.mdcs.util.ResultCondition;
import com.tmap.datafilemanagement.dao.DataFileInfoDAO;
import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.servermanagement.dao.SystemInfoDAO;

@Service
public class DataFileInfoService {
	@Autowired
	DataFileInfoDAO dataFileInfoDAO;
	
	@Autowired
	SystemInfoDAO systemInfoDAO;
	
	/**
	 * DataFile List Count 조회
	 * @param dataFileInfoVO
	 * @return
	 * @throws Exception
	 */
	public int countDataFileInfoList(DataFileInfoVO dataFileInfoVO) throws Exception {
		return dataFileInfoDAO.countDataFileInfoList(dataFileInfoVO);
	}

	/**
	 * DataFile List 조회
	 * @param dataFileInfoVO
	 * @return
	 * @throws Exception
	 */
	public List<DataFileInfoVO> datafileInfoList(DataFileInfoVO dataFileInfoVO) throws Exception {
		return dataFileInfoDAO.dataFileInfoList(dataFileInfoVO, dataFileInfoVO.getStartRowNum(), dataFileInfoVO.getCountPerPage());
	}
	
	/**
	 * DataFile 상세 조회
	 * @param dataFileInfoVO
	 * @return
	 * @throws Exception
	 */
	public DataFileInfoVO dataFileInfo(String dataFileId) throws Exception {
		return dataFileInfoDAO.dataFileInfo(dataFileId);
	}

	/**
	 * DataFile 상세 조회
	 * @param dataFileInfoVO
	 * @return
	 * @throws Exception
	 */
	public DataFileInfoVO dataFileInfo(DataFileInfoVO dataFileInfoVO) throws Exception {
		return dataFileInfoDAO.dataFileInfo(dataFileInfoVO.getDataFileId());
	}
	
	/**
	 * Data File 정보 등록
	 * @param dataFileInfoVO
	 * @return
	 * @throws Exception
	 */
	public boolean dataFileInfoInsert(DataFileInfoVO dataFileInfoVO) throws Exception {
		return dataFileInfoDAO.dataFileInfoInsert(dataFileInfoVO) > 0;
	}

	/**
	 * Data File 정보 수정
	 * @param dataFileInfoVO
	 * @return
	 * @throws Exception
	 */
	public boolean dataFileInfoUpdate(DataFileInfoVO dataFileInfoVO) throws Exception {
		return dataFileInfoDAO.dataFileInfoUpdate(dataFileInfoVO) > 0;
	}

	/**
	 * Data File 정보 삭제
	 * @param dataFileId
	 * @return
	 * @throws Exception
	 */
	public boolean dataFileInfoDelete(String dataFileId) throws Exception {
		return dataFileInfoDAO.dataFileInfoDelete(dataFileId) > 0;
	}
	
	
	// DS 파일 등록 요청
	public ResultCondition syncDsUpdateFileInfo(List<FileInfoVo> fileInfoList) {	
		return new DSClient(systemInfoDAO.dsSystemInfoSelect()).updateFileInfo(fileInfoList);
	}
	
	// DS 파일 동기화 요청
	public ResultCondition synvDsUpdateFileSync() {
		return new DSClient(systemInfoDAO.dsSystemInfoSelect()).updateFileSync();
	}
}
