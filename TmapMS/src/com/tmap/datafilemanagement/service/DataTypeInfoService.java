package com.tmap.datafilemanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.datafilemanagement.dao.DataTypeInfoDAO;
import com.tmap.datafilemanagement.vo.DataTypeInfoVO;

@Service
public class DataTypeInfoService {
	@Autowired
	DataTypeInfoDAO dataTypeInfoDAO;
	
	/**
	 * DataType List Count 조회
	 * @param dataTypeInfoVO
	 * @return
	 * @throws Exception
	 */
	public int countDataTypeInfoList(DataTypeInfoVO dataTypeInfoVO) throws Exception {
		return dataTypeInfoDAO.countDataTypeInfoList(dataTypeInfoVO);
	}

	/**
	 * DataType List 조회
	 * @param dataTypeInfoVO
	 * @return
	 * @throws Exception
	 */
	public List<DataTypeInfoVO> dataTypeInfoList(DataTypeInfoVO dataTypeInfoVO) throws Exception {
		
		// 리스트 수를 조회하여 설정
		int totalCount = dataTypeInfoDAO.countDataTypeInfoList(dataTypeInfoVO);
		dataTypeInfoVO.setTotalCount(totalCount);
				
		return dataTypeInfoDAO.dataTypeInfoList(dataTypeInfoVO, dataTypeInfoVO.getStartRowNum(), dataTypeInfoVO.getCountPerPage());
	}
	
	/**
	 * 검색/저장/수정을 위한 select Box 용 DataTypeInfoList 조회
	 * @return
	 * @throws Exception
	 */
	public List<DataTypeInfoVO> dataTypeInfoListForSelectBox() throws Exception {
		return dataTypeInfoDAO.dataTypeInfoListForSelectBox();
	}
	
	/**
	 * DataType 상세 조회
	 * @param dataTypeInfoVO
	 * @return
	 * @throws Exception
	 */
	public DataTypeInfoVO dataTypeInfo(DataTypeInfoVO dataTypeInfoVO) throws Exception {
		return dataTypeInfoDAO.dataTypeInfo(dataTypeInfoVO);
	}
	
	/**
	 * DataType 정보 수정
	 * @param dataTypeInfoVO
	 * @return
	 * @throws Exception
	 */
	public boolean dataTypeInfoUpdate(DataTypeInfoVO dataTypeInfoVO) throws Exception {
		return dataTypeInfoDAO.dataTypeInfoUpdate(dataTypeInfoVO) > 0;
	}
	
	/**
	 * DataType 정보 삭제
	 * @param dataTypeInfoVO
	 * @return
	 * @throws Exception
	 */
	public boolean dataTypeInfoDelete(DataTypeInfoVO dataTypeInfoVO) throws Exception {
		return dataTypeInfoDAO.dataTypeInfoDelete(dataTypeInfoVO) > 0;
	}
	
	/**
	 * DataType 정보 등록
	 * @param dataTypeInfoVO
	 * @return
	 * @throws Exception
	 */
	public boolean dataTypeInfoInsert(DataTypeInfoVO dataTypeInfoVO) throws Exception {
		return dataTypeInfoDAO.dataTypeInfoInsert(dataTypeInfoVO) > 0;
	}
}
