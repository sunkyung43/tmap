/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.controller;

import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tmap.servermanagement.service.ReleaseServerInfoService;
import com.tmap.servermanagement.vo.ReleaseServerInfoVO;
import com.tmap.servermanagement.vo.RsInterfaceInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.systemmanagement.vo.MessageInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */

@Controller
public class ReleaseServerInfoController {

	@Autowired
	ReleaseServerInfoService releaseServerInfoService;
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(ReleaseServerInfoController.class);
	
	//서비스 운영정보 전체 수정
	@RequestMapping("/releaseServerInfo")
	public String settingAllInfoFrame(@ModelAttribute("ContentsForm") @Valid ReleaseServerInfoVO releaseServerInfoVO,BindingResult bindingResult,Model model) throws Exception{
		
		List<SystemInfoVO> rsServerList = releaseServerInfoService.rsServerList();
		List<RsInterfaceInfoVO> rsInterfaceList = releaseServerInfoService.rsInterfaceList();
		List<MessageInfoListVO> messageList = releaseServerInfoService.messageList();
		
		model.addAttribute("rsServerList", rsServerList);
		model.addAttribute("rsInterfaceList", rsInterfaceList);
		model.addAttribute("messageList", messageList);
		
		return "jsp/servermanagement/releaseserverinfo/releaseServerInfo";
	}
	
}
