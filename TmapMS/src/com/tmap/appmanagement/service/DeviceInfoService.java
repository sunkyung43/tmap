/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.appmanagement.dao.DeviceInfoDAO;
import com.tmap.appmanagement.vo.PhModelInfoListVO;
import com.tmap.cdnmanagement.vo.CdnInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Service
public class DeviceInfoService {

	@Autowired
	DeviceInfoDAO deviceInfoDAO;

	/** 
	 * @param deviceInfoDAO the deviceInfoDAO to set 
	 */
	public void setDeviceInfoDAO(DeviceInfoDAO deviceInfoDAO) {
		this.deviceInfoDAO = deviceInfoDAO;
	}

	public String phModelInfoNew(PhModelInfoListVO phModelInfoListVO) throws Exception{
		
		String returnMessage = "";
		
		String phName = phModelInfoListVO.getPhName();
		String osVerName = phModelInfoListVO.getOsVerName();
		
		phModelInfoListVO.setPhModelName(phName + " _ " + osVerName);
		
		if (deviceInfoDAO.checkPhmodelInfo(phModelInfoListVO) == 0) {
			deviceInfoDAO.newPhModelInfo(phModelInfoListVO);
			/*if (deviceInfoDAO.newPhModelInfo(phModelInfoListVO) == null) {
				returnMessage = "등록 되었습니다.";
				
			} else {
				returnMessage = "등록 실패 되었습니다.";
			}*/
		} else {
			returnMessage = "이미 등록된 모델입니다.";
		}
		
		return returnMessage;
	}
	
	
}
