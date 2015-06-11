/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.servermanagement.dao.ReleaseServerInfoDAO;
import com.tmap.servermanagement.vo.RsInterfaceInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;
import com.tmap.systemmanagement.vo.MessageInfoListVO;


/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Service
public class ReleaseServerInfoService {

	@Autowired
	ReleaseServerInfoDAO releaseServerInfoDAO;
	
	public List<SystemInfoVO> rsServerList() throws Exception{
		
		return releaseServerInfoDAO.rsServerList();
	}
	
	public List<RsInterfaceInfoVO> rsInterfaceList() throws Exception{
		
		return releaseServerInfoDAO.rsInterfaceList();
	}
	
	public List<MessageInfoListVO> messageList() throws Exception{
		
		return releaseServerInfoDAO.messageList();
	}
	
	// RS Cache refresh
	public void requestRemoveCache() {
		
	}
}
