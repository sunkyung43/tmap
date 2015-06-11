package com.tmap.datafilemanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.datafilemanagement.dao.DataStorageInfoDAO;
import com.tmap.datafilemanagement.vo.DataStorageInfoVO;

@Service
public class DataStorageInfoService {
	@Autowired
	DataStorageInfoDAO dataStorageInfoDAO;
	
	/**
	 * DataStorage List Count 조회
	 * @param dataStorageInfoVO
	 * @return
	 * @throws Exception
	 */
	public int countDataStorageInfoList(DataStorageInfoVO dataStorageInfoVO) throws Exception {
		return dataStorageInfoDAO.countDataStorageInfoList(dataStorageInfoVO);
	}

	/**
	 * DataStorage List 조회
	 * @param dataStorageInfoVO
	 * @return
	 * @throws Exception
	 */
	public List<DataStorageInfoVO> dataStorageInfoList(DataStorageInfoVO dataStorageInfoVO) throws Exception {
		return dataStorageInfoDAO.dataStorageInfoList(dataStorageInfoVO, dataStorageInfoVO.getStartRowNum(), dataStorageInfoVO.getCountPerPage());
	}

	/**
	 * 검색/저장/수정을 위한 select Box 용 DataStorageInfoList 조회
	 * @return
	 */
	public List<DataStorageInfoVO> dataStorageInfoListForSelectBox() throws Exception {
		return dataStorageInfoDAO.dataStorageInfoListForSelectBox();
	}

	/**
	 * DataStorage 상세 조회
	 * @param dataStorageInfoVO
	 * @return
	 * @throws Exception
	 */
	public DataStorageInfoVO dataStorageInfo(DataStorageInfoVO dataStorageInfoVO) throws Exception {
		return dataStorageInfoDAO.dataStorageInfo(dataStorageInfoVO);
	}
	
	/**
	 * DataStorage 정보 수정
	 * @param dataStorageInfoVO
	 * @return
	 * @throws Exception
	 */
	public boolean dataStorageInfoUpdate(DataStorageInfoVO dataStorageInfoVO) throws Exception {
		return dataStorageInfoDAO.dataStorageInfoUpdate(dataStorageInfoVO) > 0;
	}
	
	/**
	 * DataStorage 정보 삭제
	 * @param dataStorageInfoVO
	 * @return
	 * @throws Exception
	 */
	public boolean dataStorageInfoDelete(DataStorageInfoVO dataStorageInfoVO) throws Exception {
		return dataStorageInfoDAO.dataStorageInfoDelete(dataStorageInfoVO) > 0;
	}
	
	/**
	 * DataStorage 정보 등록
	 * @param dataStorageInfoVO
	 * @return
	 * @throws Exception
	 */
	public boolean dataStorageInfoInsert(DataStorageInfoVO dataStorageInfoVO) throws Exception {
		boolean isSuccess = dataStorageInfoDAO.dataStorageInfoInsert(dataStorageInfoVO) > 0;
		
		// 디렉토리 생성
		
		return isSuccess;
	}
}
