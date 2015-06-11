package com.tmap.datafilemanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.datafilemanagement.dao.FileVersionInfoDAO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;

@Service
public class FileVersionInfoService {
	@Autowired
	FileVersionInfoDAO fileVersionInfoDAO;
	
	/**
	 * File Version List 조회
	 * @param dataFileId
	 * @return
	 * @throws Exception
	 */
	public List<FileVersionInfoVO> fileVersionInfoList(String dataFileId) throws Exception {
		return fileVersionInfoDAO.fileVersionInfoList(dataFileId);
	}

	/**
	 * File Version 조회
	 * @param fileVerId
	 * @return
	 * @throws Exception
	 */
	public FileVersionInfoVO fileVersionInfo(String fileVerId) throws Exception {
		return fileVersionInfoDAO.fileVersionInfo(fileVerId);
	}

	/**
	 * File Version 정보 저장
	 * @param fileVersionInfoVO
	 * @return new File Version Info Id
	 * @throws Exception
	 */
	public boolean fileVersionInfoInsert(FileVersionInfoVO fileVersionInfoVO) throws Exception {
		return fileVersionInfoDAO.fileVersionInfoInsert(fileVersionInfoVO) > 0;
	}
	
	/**
	 * File Version 정보 수정
	 * @param fileVersionInfoVO
	 * @return
	 * @throws Exception
	 */
	public boolean fileVersionInfoUpdate(FileVersionInfoVO fileVersionInfoVO) throws Exception {
		return fileVersionInfoDAO.fileVersionInfoUpdate(fileVersionInfoVO) > 0 ;
	}

	/**
	 * File Version 정보 삭제
	 * @param fileVerId
	 * @return
	 * @throws Exception
	 */
	public boolean fileVersionInfoDelete(String fileVerId) throws Exception {
		return fileVersionInfoDAO.fileVersionInfoDelete(fileVerId) > 0;
	}
}
