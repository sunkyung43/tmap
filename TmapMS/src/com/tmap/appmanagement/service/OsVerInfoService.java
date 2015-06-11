/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.appmanagement.dao.OsVerInfoDAO;
import com.tmap.appmanagement.vo.OsVerInfoListVO;


/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Service
public class OsVerInfoService {

	@Autowired
	OsVerInfoDAO osVerInfoDAO;

	//OS버전정보 리스트 출력 (단말모델)
	public List<OsVerInfoListVO> phOsVerInfo(OsVerInfoListVO osVerInfoListVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		/*int totalCount = osVerInfoDAO.countOsVerInfoList(osVerInfoListVO);	
		osVerInfoListVO.setTotalCount(totalCount);*/
		
		List<OsVerInfoListVO> osVerInfoList = osVerInfoDAO.phOsVerInfoList(osVerInfoListVO);
		return osVerInfoList;
	}
	
	//OS버전정보 리스트 출력
	public List<OsVerInfoListVO> osVerInfoFrame(OsVerInfoListVO osVerInfoListVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = osVerInfoDAO.countOsVerInfoList(osVerInfoListVO);
		osVerInfoListVO.setTotalCount(totalCount);
		
		List<OsVerInfoListVO> osVerInfoFrame = osVerInfoDAO.osVerInfoFrame(osVerInfoListVO, osVerInfoListVO.getStartRowNum(), osVerInfoListVO.getCountPerPage());
		
		return osVerInfoFrame;
	}
		
	
	//OS버전정보 등록
	public int osVerInfoInsert(OsVerInfoListVO osVerInfoListVO) throws Exception{
		
		return osVerInfoDAO.osVerInfoInsert(osVerInfoListVO);
	
	}
	
	//OS버전정보 수정폼
	public OsVerInfoListVO osVerModifyList(OsVerInfoListVO osVerInfoListVO) throws Exception{
		
		OsVerInfoListVO osVerModifyList = osVerInfoDAO.osVerModifyList(osVerInfoListVO);
		
		return osVerModifyList;
		
	}
	
	//OS버전정보 수정
	public int osVerInfoUpdate(OsVerInfoListVO osVerInfoListVO) throws Exception{
		
		return osVerInfoDAO.osVerInfoUpdate(osVerInfoListVO);
	}
	
	//OS버전정보 삭제
	public int osVerInfoDelete(OsVerInfoListVO osVerInfoListVO) throws Exception{
		
		return osVerInfoDAO.osVerInfoDelete(osVerInfoListVO);
	}
	
	
}
