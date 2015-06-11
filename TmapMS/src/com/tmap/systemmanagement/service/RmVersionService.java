/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.systemmanagement.dao.RmVersionDAO;
import com.tmap.systemmanagement.vo.RmVersionVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Service
public class RmVersionService {

	@Autowired
	RmVersionDAO rmVersionDAO;

	/** 
	 * @param rmVersionDAO the rmVersionDAO to set 
	 */
	public void setRmVersionDAO(RmVersionDAO rmVersionDAO) {
		this.rmVersionDAO = rmVersionDAO;
	}

	//맵 버전 긴급 운영설정
	public RmVersionVO rmVersionList() throws Exception{
		
		RmVersionVO rmVersionList = rmVersionDAO.rmVersionList();
		
		return rmVersionList;
	}
	
	public void rmVersionNewCommit(RmVersionVO rmVersionListVO) throws Exception{
		
		rmVersionDAO.rmVersionNewCommit(rmVersionListVO);
	}
	
}
