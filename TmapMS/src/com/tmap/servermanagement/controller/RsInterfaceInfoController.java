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

import com.tmap.servermanagement.service.RsInterfaceInfoService;
import com.tmap.servermanagement.vo.RsInterfaceInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */

@Controller
public class RsInterfaceInfoController {

	@Autowired
	RsInterfaceInfoService rsInterfaceInfoService;
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(RsInterfaceInfoController.class);
	
	//검색 조건 초기화
	@SuppressWarnings("unused")
	@ModelAttribute("ContentsForm")
	private RsInterfaceInfoVO readAdminListParamInit(RsInterfaceInfoVO rsInterfaceInfoVO) {
		
		if(rsInterfaceInfoVO.getInterfaceName() == null){
			rsInterfaceInfoVO.setInterfaceName("");
		}
		
		return rsInterfaceInfoVO;
	}
	
	//RS Interface 정보
	@RequestMapping("/rsInterfaceInfo")
	public String rsInterfaceInfo(
			@ModelAttribute("ContentsForm") @Valid RsInterfaceInfoVO rsInterfaceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		List<RsInterfaceInfoVO> rsInterfaceInfoList = rsInterfaceInfoService.rsInterfaceInfoList(rsInterfaceInfoVO);
		
		model.addAttribute("rsInterfaceInfoList", rsInterfaceInfoList);
		
		return "jsp/servermanagement/rsinterfaceinfo/rsInterfaceInfo";
	}
	
	//RS Interface Edit폼
	@RequestMapping("/rsInterfaceInfoEdit")
	public String rsInterfaceInfoEdit(
			@ModelAttribute("ContentsForm") @Valid RsInterfaceInfoVO rsInterfaceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		if(rsInterfaceInfoVO.getInterfaceId().equals("")){
			
			model.addAttribute("rsInterfaceInfo", rsInterfaceInfoVO);
		
		}else{
			
			Object rsInterfaceInfo = rsInterfaceInfoService.rsInterfaceInfo(rsInterfaceInfoVO.getInterfaceId()); 
			
			model.addAttribute("rsInterfaceInfo", rsInterfaceInfo);
			
		}
		
		return "jsp/servermanagement/rsinterfaceinfo/rsInterfaceInfoEdit";
	}
	
	//프로토콜명 중복체크
	@RequestMapping("/processInterIdDuplication")
	public String processInterIdDuplication(
			@ModelAttribute("ContentsForm") @Valid RsInterfaceInfoVO rsInterfaceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String checkName = rsInterfaceInfoService.checkName(rsInterfaceInfoVO.getCheckName());
		
		codeMap.put("checkName", checkName);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//RS Interface 등록
	@RequestMapping("/interfaceInsert")
	public String interfaceInsert(
			@ModelAttribute("ContentsForm") @Valid RsInterfaceInfoVO rsInterfaceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String interfaceInsert = rsInterfaceInfoService.interfaceInsert(rsInterfaceInfoVO);
		
		historyInfoService.insert(TABLE_NAME.rs_interface_info, rsInterfaceInfoVO);
		
		String interfaceId = rsInterfaceInfoService.interfaceId(rsInterfaceInfoVO.getInterfaceProtocol());
		
		codeMap.put("interfaceInsert", interfaceInsert);
		codeMap.put("interfaceId", interfaceId);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//RS Interface 수정
	@RequestMapping("/interfaceUpdate")
	public String interfaceUpdate(
			@ModelAttribute("ContentsForm") @Valid RsInterfaceInfoVO rsInterfaceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String interfaceUpdate = rsInterfaceInfoService.interfaceUpdate(rsInterfaceInfoVO);
		
		historyInfoService.update(TABLE_NAME.rs_interface_info, rsInterfaceInfoVO);
		
		codeMap.put("interfaceUpdate", interfaceUpdate);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//RS Interface 삭제
	@RequestMapping("/interfaceDelete")
	public String interfaceDelete(
			@ModelAttribute("ContentsForm") @Valid RsInterfaceInfoVO rsInterfaceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String interfaceDelete = rsInterfaceInfoService.interfaceDelete(rsInterfaceInfoVO.getInterfaceId());
		
		historyInfoService.delete(TABLE_NAME.rs_interface_info, rsInterfaceInfoVO);
		
		codeMap.put("interfaceDelete", interfaceDelete);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
}
