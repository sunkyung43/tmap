/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.btb.mdcs.model.CodeVo;
import com.btb.mdcs.model.DsInfoVo;
import com.btb.mdcs.model.LoginInfoVo;
import com.btb.mdcs.model.NetworkInfoVo;
import com.btb.mdcs.model.UserMdn;
import com.btb.mdcs.util.DSClient;
import com.btb.mdcs.util.ResultCondition;
import com.tmap.servermanagement.dao.MapDownServiceDAO;
import com.tmap.servermanagement.dao.SystemInfoDAO;
import com.tmap.servermanagement.vo.SettingAllInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Service
public class MapDownServiceService {

	@Autowired
	MapDownServiceDAO mapDownServiceDAO;
	
	@Autowired
	SystemInfoDAO systemInfoDAO;
	
	//서버기기 정보
	public List<SystemInfoVO> systemInfo() throws Exception{
		
		return mapDownServiceDAO.systemInfo();
	}
	//상세 접속 정보(서버기기 정보)
	public SystemInfoVO systemDetailInfo(String systemId) throws Exception{
		
		return mapDownServiceDAO.systemDetailInfo(systemId);
	}
	
	//상세 접속 정보(통신방식 정보)
	public List<SystemInfoVO> comSetInfo(String systemId) throws Exception{
		
		return mapDownServiceDAO.comSetInfo(systemId);
	}
	
	//상세 접속 정보(서비스 운영 정보)
	public SystemInfoVO mapManageInfo(String systemId) throws Exception{
		
		return mapDownServiceDAO.mapManageInfo(systemId);
	}
	
	//서버기기 운영정보 수정
	public String mapDownServiceUpdate(SystemInfoVO systemInfoVO) throws Exception{
		
		//통신방식 정보 수정
		int result = mapDownServiceDAO.comSetUpdate(systemInfoVO);
		
		if(result > 0){
			//서비스 운영 정보 수정
			mapDownServiceDAO.mapManageUpdate(systemInfoVO);
		}
			
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}
	
	
	// DS 접속자 정보 리스트 
	public List<LoginInfoVo> syncDsLoginInfoList() {		
		return new DSClient(systemInfoDAO.dsSystemInfoSelect()).loginInfo();
	}
	
	// DS 접속자 정보
	public List<LoginInfoVo> syncDsLoginInfo(String systemId) {
	  return new DSClient(systemInfoDAO.dsSystemInfo(systemId)).loginInfo();
	}
	
	// DS 접속자 접속해제 
	public boolean syncDsDisConnectUser(String systemId, String mdn, int netWorkType) {
		return new DSClient(systemInfoDAO.dsSystemInfo(systemId)).disConnectUser(mdn, netWorkType);
	}
	// DS 접속자 접속해제 list
	public List<UserMdn> syncDsDisConnectUser(List<UserMdn> userMdnList, int netWorkType) {
		return new DSClient(systemInfoDAO.dsSystemInfoSelect()).disConnectUser(userMdnList, netWorkType);
	}
	
	// DS 서버상태 정보 
	public boolean syncDsServerState(DsInfoVo dsInfoVo) {
		return new DSClient(dsInfoVo).serverState();
	}
	// DS 서버상태 정보 list
	public ResultCondition syncDsServerStateList() {
		return new DSClient(systemInfoDAO.dsSystemInfoSelect()).serverStateList();
	}
		
	// DS 통신타입설정 및 접속자 개수 설정 
	public ResultCondition syncDsComStateAndCntUpdate(List<DsInfoVo> dsList, SettingAllInfoVO settingIdInfoVO, String[] comState, String[] comCnt) throws Exception{
		ResultCondition resultCondition = null;
	
		try {
			ArrayList<NetworkInfoVo> networkTypeInfoList = new ArrayList<NetworkInfoVo>();
			networkTypeInfoList.add(new NetworkInfoVo(CodeVo.NetworkType.WIFI.value, true, 0));
			networkTypeInfoList.add(new NetworkInfoVo(CodeVo.NetworkType.A3G.value, true, 0));
			networkTypeInfoList.add(new NetworkInfoVo(CodeVo.NetworkType.LTE.value, true, 0));
			
			DSClient dsClient = new DSClient(dsList);
			resultCondition = dsClient.updateNetWorkInfo(networkTypeInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		} 	
		
		return resultCondition;
	}
}
