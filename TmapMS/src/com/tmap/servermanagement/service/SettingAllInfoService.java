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
import com.btb.mdcs.model.IPSectionVo;
import com.btb.mdcs.model.NetworkInfoVo;
import com.btb.mdcs.util.DSClient;
import com.btb.mdcs.util.ResultCondition;
import com.tmap.servermanagement.dao.SettingAllInfoDAO;
import com.tmap.servermanagement.dao.SystemInfoDAO;
import com.tmap.servermanagement.vo.SettingAllInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Service
public class SettingAllInfoService {

	@Autowired
	SettingAllInfoDAO settingIdInfoDAO;

	@Autowired
	SystemInfoDAO systemInfoDAO;

	private boolean result;

	//ipFilter 리스트
	public List<SettingAllInfoVO> ipFilter() throws Exception{
		return settingIdInfoDAO.ipFilter();
	}

	//제한IP 설정
	public String ipFilterUpdate(String[] notAllowIpList) throws Exception{
		String returnValue = "";
		ResultCondition condition = syncDsUpdateFilteringIP(systemInfoDAO.dsSystemInfoSelect(), notAllowIpList);
		if(condition.getFailCount() == 0 && condition.getSuccessCount() > 0)
		{
			int result = settingIdInfoDAO.ipFilterUpdate(notAllowIpList);
			if(result > 0){
				returnValue = "success";
				
			}else{
				returnValue = "failed";
			}
		}else{
			returnValue = "failed";
		}
		return returnValue;
	}

	// DS 제한 IP 설정 요청 
	public ResultCondition syncDsUpdateFilteringIP(List<DsInfoVo> dsList, String[] notAllowIpList) throws Exception {
		ResultCondition resultCondition = null;

		try {
			List<IPSectionVo> ipSectionList = new ArrayList<IPSectionVo>();
			for (String notAllowIP : notAllowIpList) {
				ipSectionList.add(new IPSectionVo(notAllowIP));
				//				ipSectionList.add(new IPSectionVo("192.168.62.2", "192.168.62.10"));
			}

			DSClient dsClient = new DSClient(dsList);
			resultCondition = dsClient.updateFilteringIP(ipSectionList);
		} catch (Exception e) {
			e.printStackTrace();
		} 	

		return resultCondition;
	}


	//dsComInfo
	public List<SettingAllInfoVO> defaultComSetList() throws Exception{

		return settingIdInfoDAO.defaultComSetList();	
	}

	//dsBandWidth
	public SettingAllInfoVO dsBandWidth() throws Exception{
		return settingIdInfoDAO.dsBandWidth();
	}

	//DS허용유무 설정
	public String dsComStateUpdate(SettingAllInfoVO settingAllInfoVO, String[] comState) throws Exception{

		int result = settingIdInfoDAO.dsComStateUpdate(settingAllInfoVO, comState);
		String condition = mapdown_manage_info(settingAllInfoVO);
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}

	//DS동시접속자 설정
	public String dsComCntUpdate(SettingAllInfoVO settingIdInfoVO, String[] comCnt) throws Exception{

		int result = settingIdInfoDAO.dsComCntUpdate(settingIdInfoVO, comCnt);

		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}

	public String mapdown_manage_info(SettingAllInfoVO settingIdInfoVO) {

		ResultCondition resultCondition = syncDsComStateAndCntUpdate(systemInfoDAO.dsSystemInfoSelect(), settingIdInfoVO);

		if (resultCondition.isSuccess()) {	
			//			1. syncDsComStateAndCntUpdate();
			//			2 .dsComStateUpdate();			
		}

		return null;
	}

	// DS 통신타입설정 및 접속자 개수 설정 
	public ResultCondition syncDsComStateAndCntUpdate(List<DsInfoVo> dsList, SettingAllInfoVO settingIdInfoVO) {
		ResultCondition resultCondition = null;

		String[] conStates = settingIdInfoVO.getComSetStates().split(",");
		String[] comTypeCodes = settingIdInfoVO.getComTypeCodes();
		String[] comCnt = settingIdInfoVO.getComSetCnts();

		try {
			ArrayList<NetworkInfoVo> networkTypeInfoList = new ArrayList<NetworkInfoVo>();
			for (int i=0; i<comTypeCodes.length; i++ ) {
				networkTypeInfoList.add(new NetworkInfoVo(Integer.parseInt(comTypeCodes[i]),
						conStates[i].equals("Y")?true:false,
								Integer.parseInt(comCnt[i])));
			}

			DSClient dsClient = new DSClient(dsList);
			resultCondition = dsClient.updateNetWorkInfo(networkTypeInfoList);
		} catch (Exception e) {
			e.printStackTrace();
		} 	

		return resultCondition;
	}

	//DS대역폭 설정
	public String dsBandWidthUpdate(SettingAllInfoVO settingIdInfoVO) throws Exception{
		ResultCondition resultCondition = null;

		try {						
			List<DsInfoVo> dsList = systemInfoDAO.dsSystemInfoSelect();
			resultCondition = syncDsUpdateBandWidth(dsList, settingIdInfoVO);

			if (resultCondition.isSuccess()) {			
				//최초등록 여부확인
				int count = settingIdInfoDAO.selectCount();

				if(count > 0){
					for (DsInfoVo dsInfoVo : dsList) {
						result = (settingIdInfoDAO.dsBandWidthUpdate(settingIdInfoVO) > 0)?true:false;
					}
				}else{
					for (DsInfoVo dsInfoVo : dsList) {
						result = (settingIdInfoDAO.dsBandWidthInsert(settingIdInfoVO) > 0)?true:false;						
					}
				}
			}			
		} catch (Exception e) {
			result = false;
			e.printStackTrace();
		} 			

		return result?"success":"failed";
	}

	// DS 대역폭 설정 요청
	public ResultCondition syncDsUpdateBandWidth(List<DsInfoVo> dsList, SettingAllInfoVO settingIdInfoVO) {
		return new DSClient(dsList).updateBandWidth(Integer.parseInt(settingIdInfoVO.getSessionMaxIdletime()), Integer.parseInt(settingIdInfoVO.getSessionMaxBandwidth()), Integer.parseInt(settingIdInfoVO.getTotalMaxBandwidth()));
	}	
}
