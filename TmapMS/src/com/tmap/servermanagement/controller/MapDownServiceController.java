/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.btb.mdcs.model.LoginInfoVo;
import com.btb.mdcs.util.ResultCondition;
import com.tmap.servermanagement.service.MapDownServiceService;
import com.tmap.servermanagement.service.SystemInfoService;
import com.tmap.servermanagement.vo.SystemInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */

@Controller
public class MapDownServiceController {

	@Autowired
	MapDownServiceService mapDownServiceService;
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	@Autowired
	 SystemInfoService systemInfoService;
	
	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(MapDownServiceController.class);
	
	//서비스 운영정보
	@RequestMapping("/mapDownServiceList")
	public String mapDownServiceList(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult, Model model) throws Exception{
		
		//서버기기 정보
		List<SystemInfoVO> systemInfo = mapDownServiceService.systemInfo(); 
		String activeId =  systemInfoVO.getActiveId();
		String sysId = systemInfoVO.getSystemId();
		if(systemInfoVO.getSystemId() == null){
			sysId = systemInfo.get(0).getSystemId();
		}
		
		//상세 접속 정보(서버기기 정보)
		SystemInfoVO systemDetailInfo = mapDownServiceService.systemDetailInfo(sysId);
		
		//상세 접속 정보(서비스 운영 정보)
		Object mapManageInfo = mapDownServiceService.mapManageInfo(sysId);
		
		List<SystemInfoVO> comSetInfoList = mapDownServiceService.comSetInfo(sysId);
		
		int totalComSetCnt = 0;
		for (SystemInfoVO systemInfoVO3 : comSetInfoList) {
			totalComSetCnt += Integer.parseInt(systemInfoVO3.getComSetCnt());
		}
		systemDetailInfo.setSumCount(totalComSetCnt);
		List<LoginInfoVo> connUsers = mapDownServiceService.syncDsLoginInfo(sysId);
		systemDetailInfo.setUserCount(connUsers.size());
				
		
		Collections.sort(connUsers);
		long currentTotalBandWidth = 0;
		for (SystemInfoVO comSetInfo : comSetInfoList) {
			for (LoginInfoVo loginInfoVo : connUsers) {
				if (comSetInfo.getComTypeCode().equals(loginInfoVo.getNetType())) {
					comSetInfo.addLoginInfoVO(loginInfoVo);
				}
			}
			currentTotalBandWidth += comSetInfo.getCurrentBandWidth();
		}
		
		model.addAttribute("connUser", connUsers);
		model.addAttribute("currentTotalBandWidth", currentTotalBandWidth);
				
		model.addAttribute("comSetInfo", comSetInfoList);
		model.addAttribute("systemDetailInfo", systemDetailInfo);
		model.addAttribute("mapManageInfo", mapManageInfo);
		
		// 타입별 max
	    
		//서버상태 체크
		ResultCondition condition = mapDownServiceService.syncDsServerStateList();
	
		model.addAttribute("activeId", activeId);
		model.addAttribute("systemInfo", systemInfo);
		model.addAttribute("serverState", condition);
				
		return "jsp/servermanagement/mapdownservice/mapDownServiceList";
	}
	
	//상세 접속 정보
	@RequestMapping("/connectPhoneList")
	public String connectPhoneList(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult, Model model) throws Exception{
		
		
		return "jsp/servermanagement/mapdownservice/mapDownServiceList";
	}
	
	//서버기기 운영정보 수정폼
	@RequestMapping("/mapDownServiceEdit")
	public String mapDownServiceEdit(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult,	Model model) throws Exception{
		
		//상세 접속 정보(통신방식 정보)
		List<SystemInfoVO> comSetInfo = mapDownServiceService.comSetInfo(systemInfoVO.getSystemId());
		
		//상세 접속 정보(서비스 운영 정보)
		Object mapManageInfo = mapDownServiceService.mapManageInfo(systemInfoVO.getSystemId());
		
		model.addAttribute("comSetInfo", comSetInfo);
		model.addAttribute("mapManageInfo", mapManageInfo);
		model.addAttribute("systemId", systemInfoVO.getSystemId());
		
		return "jsp/servermanagement/mapdownservice/mapDownServiceEdit";
	}
	
	//서버기기 운영정보 수정
	@RequestMapping("/mapDownServiceUpdate")
	public String mapDownServiceUpdate(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult, Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		//수정
		String mapDownServiceUpdate = mapDownServiceService.mapDownServiceUpdate(systemInfoVO);
		
		historyInfoService.update(TABLE_NAME.mapdown_manage_info, systemInfoVO);
		
		codeMap.put("mapDownServiceUpdate", mapDownServiceUpdate);
		codeMap.put("systemId", systemInfoVO.getSystemId());
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
		
	}
	//서버기기 운영정보 수정폼
		@RequestMapping(value="/disConnectUser", method=RequestMethod.POST)
		public String disConnect(HttpServletRequest request, HttpServletResponse resopnse, Model model) throws Exception{
			
			Map<String, Object> codeMap = new HashMap<String, Object>();
			boolean result = mapDownServiceService.syncDsDisConnectUser(request.getParameter("systemId"), request.getParameter("mdn"), Integer.parseInt(request.getParameter("netType")));
			codeMap.put("result", result);
			model.addAttribute("json", codeMap);
			return "jsonView";
		}
}
