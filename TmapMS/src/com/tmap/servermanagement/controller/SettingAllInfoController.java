/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.btb.mdcs.util.ResultCondition;
import com.tmap.servermanagement.service.SettingAllInfoService;
import com.tmap.servermanagement.vo.SettingAllInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */

@Controller
public class SettingAllInfoController {

	@Autowired
	SettingAllInfoService settingAllInfoService;
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(SettingAllInfoController.class);
	
	//서비스 운영정보 전체 수정
	@RequestMapping("/settingAllInfoFrame")
	public String settingAllInfoFrame(@ModelAttribute("ContentsForm") @Valid SettingAllInfoVO settingAllInfoVO,	BindingResult bindingResult, Model model) throws Exception{
		
		return "jsp/servermanagement/settingallinfo/settingAllInfoFrame";
	}
	
	//제한IP 설정폼
	@RequestMapping("/ipFilter")
	public String ipFilter(@ModelAttribute("ContentsForm") @Valid SettingAllInfoVO settingAllInfoVO, BindingResult bindingResult, Model model) throws Exception{
		
		List<SettingAllInfoVO> ipFilter = settingAllInfoService.ipFilter();
		
		model.addAttribute("ipFilter", ipFilter);
		
		return "jsp/servermanagement/settingallinfo/ipFilter";
	}
	
	//제한IP 설정
	@RequestMapping("/ipFilterUpdate")
	public String ipFilterUpdate(@ModelAttribute("ContentsForm") @Valid SettingAllInfoVO settingAllInfoVO, BindingResult bindingResult,	Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String result = settingAllInfoService.ipFilterUpdate(settingAllInfoVO.getNotAllowIpList());
		historyInfoService.update(TABLE_NAME.ip_filter_info, settingAllInfoVO);
		
		codeMap.put("result", result);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
		
	}
	
	//DS허용유무 설정폼
	@RequestMapping("/dsComState")
	public String dsComState(
			@ModelAttribute("ContentsForm") @Valid SettingAllInfoVO settingAllInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		//dsComInfo
	  List<SettingAllInfoVO> defaultComSet = settingAllInfoService.defaultComSetList();
//		List<SettingAllInfoVO> dsComInfo = settingIdInfoService.dsComInfo();
		
		model.addAttribute("dsComInfo", defaultComSet);
		
		return "jsp/servermanagement/settingallinfo/dsComState";
	}
	
	//DS허용유무 설정
	@RequestMapping("/dsComStateUpdate")
	public String dsComStateUpdate(
			@ModelAttribute("ContentsForm") @Valid SettingAllInfoVO settingAllInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String[] comStates = settingAllInfoVO.getComSetStates().split(","); 
		
		String result = settingAllInfoService.dsComStateUpdate(settingAllInfoVO, comStates);
		
		//전체설정 DS Sync
		//String condition = settingAllInfoService.mapdown_manage_info(settingAllInfoVO);
		
		historyInfoService.update(TABLE_NAME.ds_com_state, settingAllInfoVO);
		
		codeMap.put("result", result);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//DS동시접속자 설정폼
//	@RequestMapping("/dsComCnt")
//	public String dsComCnt(
//			@ModelAttribute("ContentsForm") @Valid SettingAllInfoVO settingAllInfoVO,
//			BindingResult bindingResult,
//			Model model) throws Exception{
//		
//		//dsComInfo
//		List<SettingAllInfoVO> dsComInfo = settingIdInfoService.dsComInfo();
//		
//		model.addAttribute("dsComInfo", dsComInfo);
//		
//		return "jsp/servermanagement/settingallinfo/dsComCnt";
//	}
	
	//DS동시접속자 설정
	@RequestMapping("/dsComCntUpdate")
	public String dsComCntUpdate(
			@ModelAttribute("ContentsForm") @Valid SettingAllInfoVO settingAllInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
//		String[] comCnt = settingAllInfoVO.getComSetCnts().split(",");
		
//		String result = settingIdInfoService.dsComCntUpdate(settingAllInfoVO, comCnt);
		
		historyInfoService.update(TABLE_NAME.ds_com_state, settingAllInfoVO);
		
//		codeMap.put("result", result);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
		
	}
	
	//DS대역폭 설정폼
	@RequestMapping("/dsBandWidth")
	public String dsBandWidth(
			@ModelAttribute("ContentsForm") @Valid SettingAllInfoVO settingAllInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		//dsBandWidth
//		Object dsBandWidth = settingIdInfoService.dsBandWidth();
//		
//		if(dsBandWidth == null){
//			model.addAttribute("dsBandWidth", settingAllInfoVO);
//		}else{
//			model.addAttribute("dsBandWidth", dsBandWidth);
//		}
//		
//		
		return "jsp/servermanagement/settingallinfo/dsBandWidth";
	}
	
	//DS대역폭 설정
	@RequestMapping("/dsBandWidthUpdate")
	public String dsBandWidthUpdate(
			@ModelAttribute("ContentsForm") @Valid SettingAllInfoVO settingAllInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String result = settingAllInfoService.dsBandWidthUpdate(settingAllInfoVO);
		historyInfoService.update(TABLE_NAME.ds_bandwidth_set, settingAllInfoVO);
		
		codeMap.put("result", result);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
		
	}
	
}
