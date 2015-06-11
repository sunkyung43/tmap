/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.appmanagement.dao.PhModelInfoDAO;
import com.tmap.appmanagement.vo.PhModelInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Service
public class PhModelInfoService {

	@Autowired
	PhModelInfoDAO phModelInfoDAO;

	//단말모델정보 리스트 출력
	public List<PhModelInfoListVO> phModelInfoList(PhModelInfoListVO phModelInfoListVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = phModelInfoDAO.countPhModelInfoList(phModelInfoListVO);
		phModelInfoListVO.setTotalCount(totalCount);
		
		return phModelInfoDAO.phModelInfoList(phModelInfoListVO, phModelInfoListVO.getStartRowNum(), phModelInfoListVO.getCountPerPage());
		
	}
	
	public List<PhModelInfoListVO> phModelNameList(PhModelInfoListVO phModelInfoListVO) throws Exception{
		
		return phModelInfoDAO.phModelNameList(phModelInfoListVO);
	}
	//단말모델정보 수정
	public void phModelChangeState(PhModelInfoListVO phModelInfoListVO) throws Exception{
		
		phModelInfoDAO.phModelChangeState(phModelInfoListVO);
	}
	
	//단말모델정보 삭제
	public void phModelDelete(PhModelInfoListVO phModelInfoListVO) throws Exception{
		
		phModelInfoDAO.phModelDelete(phModelInfoListVO);
	}
	//단말모델 상세정보
	public PhModelInfoListVO phModelInfoDetail(PhModelInfoListVO phModelInfoListVO) throws Exception{
		
		return phModelInfoDAO.phModelInfoDetail(phModelInfoListVO);
	}
	
}
