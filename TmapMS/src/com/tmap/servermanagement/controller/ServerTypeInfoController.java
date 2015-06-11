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
import com.tmap.servermanagement.service.ServerTypeInfoService;
import com.tmap.servermanagement.vo.ServerTypeInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */

@Controller
public class ServerTypeInfoController {

	@Autowired
	ServerTypeInfoService serverTypeInfoService;
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(ServerTypeInfoController.class);
	
	//검색 조건 초기화
	@SuppressWarnings("unused")
	@ModelAttribute("ContentsForm")
	private ServerTypeInfoVO readAdminListParamInit(ServerTypeInfoVO serverTypeInfoVO) {
		
		if(serverTypeInfoVO.getServerTypeCode() == null){
			serverTypeInfoVO.setServerTypeCode("");
		}
		if(serverTypeInfoVO.getServerTypeName() == null){
			serverTypeInfoVO.setServerTypeName("");
		}
		
		return serverTypeInfoVO;
	}
	
	//서버 구분 정보
	@RequestMapping("/serverTypeInfoList")
	public String serverTypeInfoList(
			@ModelAttribute("ContentsForm") @Valid ServerTypeInfoVO serverTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		List<ServerTypeInfoVO> serverTypeInfoList = serverTypeInfoService.serverTypeInfoList(serverTypeInfoVO);
		
		model.addAttribute("serverTypeInfoList", serverTypeInfoList);
		
		return "jsp/servermanagement/servertypeinfo/serverTypeInfoList";
	}
	
	//서버 구분 등록폼
	@RequestMapping("/serverTypeInfoNew")
	public String serverTypeInfoNew(
			@ModelAttribute("ContentsForm") @Valid ServerTypeInfoVO serverTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		return "jsp/servermanagement/servertypeinfo/serverTypeInfoNew";
	}
	
	//타입명 중복체크
	@RequestMapping("/processTypeDuplication")
	public String processTypeDuplication(
			@ModelAttribute("ContentsForm") @Valid ServerTypeInfoVO serverTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String checkType = serverTypeInfoService.checkType(serverTypeInfoVO.getCheckType());
		
		codeMap.put("checkType", checkType);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//코드명 중복체크
	@RequestMapping("/processCodeDuplication")
	public String processCodeDuplication(
			@ModelAttribute("ContentsForm") @Valid ServerTypeInfoVO serverTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String checkCode = serverTypeInfoService.checkCode(serverTypeInfoVO.getCheckCode());
		
		codeMap.put("checkCode", checkCode);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//서버 구분 등록
	@RequestMapping("/serverTypeInsert")
	public String serverTypeInsert(
			@ModelAttribute("ContentsForm") @Valid ServerTypeInfoVO serverTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String serverTypeInsert = serverTypeInfoService.serverTypeInsert(serverTypeInfoVO);
		
		historyInfoService.insert(TABLE_NAME.server_type_info, serverTypeInfoVO);
		
		String serverTypeId = serverTypeInfoService.serverTypeId(serverTypeInfoVO.getServerTypeName());
		
		codeMap.put("serverTypeInsert", serverTypeInsert);
		codeMap.put("serverTypeId", serverTypeId);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//서버 구분 수정폼
	@RequestMapping("/serverTypeInfoEdit")
	public String serverTypeInfoEdit(
			@ModelAttribute("ContentsForm") @Valid ServerTypeInfoVO serverTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Object serverTypeInfo = serverTypeInfoService.serverTypeInfo(serverTypeInfoVO.getServerTypeId());
		
		model.addAttribute("serverTypeInfo", serverTypeInfo);
		
		return "jsp/servermanagement/servertypeinfo/serverTypeInfoEdit";
	}
	
	//서버 구분 수정
	@RequestMapping("/serverTypeUpdate")
	public String serverTypeUpdate(
			@ModelAttribute("ContentsForm") @Valid ServerTypeInfoVO serverTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String serverTypeUpdate = serverTypeInfoService.serverTypeUpdate(serverTypeInfoVO);
		
		historyInfoService.update(TABLE_NAME.server_type_info, serverTypeInfoVO);
		
		codeMap.put("serverTypeUpdate", serverTypeUpdate);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//서버 구분 삭제
	@RequestMapping("/serverTypeDelete")
	public String serverTypeDelete(
			@ModelAttribute("ContentsForm") @Valid ServerTypeInfoVO serverTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String serverTypeDelete = serverTypeInfoService.serverTypeDelete(serverTypeInfoVO.getServerTypeId());
		
		historyInfoService.delete(TABLE_NAME.server_type_info, serverTypeInfoVO);
		
		codeMap.put("serverTypeDelete", serverTypeDelete);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	
}
