/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.appmanagement.dao.PhInfoDAO;
import com.tmap.appmanagement.vo.PhInfoListVO;
import com.tmap.servermanagement.vo.SystemInfoVO;

/**
 * <br/>
 * 
 * @author 김경민
 * @date 2012. 7. 13.
 */
@Service
public class PhInfoService {

	@Autowired
	PhInfoDAO phInfoDAO;

	// 단말정보 리스트 출력
	public List<PhInfoListVO> phInfoList(PhInfoListVO phInfoListVO) throws Exception {

		// 리스트 수를 조회하여 설정
		int totalCount = phInfoDAO.countPhInfoList(phInfoListVO);
		phInfoListVO.setTotalCount(totalCount);

		List<PhInfoListVO> phInfoList = phInfoDAO.phInfoList(phInfoListVO, phInfoListVO.getStartRowNum(), phInfoListVO.getCountPerPage());
		
		return phInfoList;
	}
	
	public List<PhInfoListVO> phMadeList(PhInfoListVO phInfoListVO) throws Exception {

		List<PhInfoListVO> phMadeList = phInfoDAO.phMadeList(phInfoListVO);
		
		return phMadeList;
	}

	// 단말정보 리스트 출력 --------------------------------------------------------------------------
	public List<PhInfoListVO> phOsInfo(PhInfoListVO phInfoListVO)
			throws Exception {

		// 리스트 수를 조회하여 설정
		/*int totalCount = phInfoDAO.countPhInfoList(phInfoListVO);
		phInfoListVO.setTotalCount(totalCount);*/

		//List<PhInfoListVO> phInfoFrame = phInfoDAO.phOsInfoList(phInfoListVO, phInfoListVO.getStartRowNum(), phInfoListVO.getCountPerPage());
		List<PhInfoListVO> phInfoFrame = phInfoDAO.phOsInfoList(phInfoListVO);
		
		return phInfoFrame;
	}

	// 단말정보 등록
	public void phInfoInsert(PhInfoListVO phInfoListVO) throws Exception {

		phInfoDAO.phInfoInsert(phInfoListVO);

	}

	// 단말정보 수정폼
	public PhInfoListVO phModifyList(PhInfoListVO phInfoListVO)
			throws Exception {

		PhInfoListVO phModifyList = phInfoDAO.phModifyList(phInfoListVO);

		return phModifyList;

	}

	// 단말정보 수정
	public int phInfoUpdate(PhInfoListVO phInfoListVO) throws Exception {

		return phInfoDAO.phInfoUpdate(phInfoListVO);
	}

	// 단말정보 삭제
	public int phInfoDelete(PhInfoListVO phInfoListVO) throws Exception {

		return phInfoDAO.phInfoDelete(phInfoListVO);
	}

}
