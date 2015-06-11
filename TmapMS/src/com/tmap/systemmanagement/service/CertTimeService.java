/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.btb.mdcs.util.DSClient;
import com.btb.mdcs.util.ResultCondition;
import com.tmap.servermanagement.dao.SystemInfoDAO;
import com.tmap.systemmanagement.dao.CertTimeDAO;
import com.tmap.systemmanagement.vo.CertTimeVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */

@Service
public class CertTimeService {

	@Autowired
	CertTimeDAO certTimeDAO;
	
	@Autowired
	SystemInfoDAO systemInfoDAO;

	/** 
	 * @param certTimeDAO the certTimeDAO to set 
	 */
	public void setCertTimeDAO(CertTimeDAO certTimeDAO) {
		this.certTimeDAO = certTimeDAO;
	}

	//기존 인증 시간
	public CertTimeVO certTime() throws Exception{
		
		CertTimeVO certTime = certTimeDAO.certTime();
		return certTime;
	}
	
	//기존 보안 코드
	public CertTimeVO securityCode() throws Exception{
		
		CertTimeVO securityCode = certTimeDAO.securityCode();
		return securityCode;
	}
	
	//기존 인증 시간 삭제
	public void certTimeDelete(CertTimeVO certTimeVO) throws Exception{
		
		certTimeDAO.certTimeDelete(certTimeVO);
	}
	
	//인증 시간 수정
	public void certTimeUpdate(CertTimeVO certTimeVO) throws Exception{
		
		certTimeDAO.certTimeUpdate(certTimeVO);
	}
	
	//기존 보안 코드 삭제
	public void securityCodeDelete(CertTimeVO certTimeVO) throws Exception{
		
		certTimeDAO.securityCodeDelete(certTimeVO);
	}
	
	//보안 코드 수정
	public void securityCodeUpdate(CertTimeVO certTimeVO) throws Exception{
		
		certTimeDAO.securityCodeUpdate(certTimeVO);
	}
	
	// DS 통신타입설정 및 접속자 개수 설정 
	public ResultCondition syncDssecurityCodeUpdate(CertTimeVO certTimeVO) throws Exception{
		ResultCondition resultCondition = null;
	
		try {
				DSClient dsClient = new DSClient(systemInfoDAO.dsSystemInfoSelect());
				resultCondition = dsClient.updateSecurityCode(certTimeVO.getSecurityCode());
		} catch (Exception e) {
			e.printStackTrace();
		} 	
		return resultCondition;
	}
}
