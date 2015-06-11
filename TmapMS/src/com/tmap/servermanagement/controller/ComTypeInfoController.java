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

import com.tmap.servermanagement.service.ComTypeInfoService;
import com.tmap.servermanagement.vo.ComTypeInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */

@Controller
public class ComTypeInfoController {

	@Autowired
	ComTypeInfoService comTypeInfoService;
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(ComTypeInfoController.class);
	
	//검색 조건 초기화
	@SuppressWarnings("unused")
	@ModelAttribute("ContentsForm")
	private ComTypeInfoVO readAdminListParamInit(ComTypeInfoVO comTypeInfoVO) {
		
		if(comTypeInfoVO.getComTypeName() == null){
			comTypeInfoVO.setComTypeName("");
		}
		
		return comTypeInfoVO;
	}
	
	//통신방식 정보
	@RequestMapping("/comTypeInfoList")
	public String comTypeInfoList(
			@ModelAttribute("ContentsForm") @Valid ComTypeInfoVO comTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		List<ComTypeInfoVO> comTypeInfoList = comTypeInfoService.comTypeInfoList(comTypeInfoVO);
		
		model.addAttribute("comTypeInfoList", comTypeInfoList);
		
		return "jsp/servermanagement/comtypeinfo/comTypeInfoList";
	}
	
	//통신방식 등록폼
	@RequestMapping("/comTypeInfoNew")
	public String comTypeInfoNew(
			@ModelAttribute("ContentsForm") @Valid ComTypeInfoVO comTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		return "jsp/servermanagement/comtypeinfo/comTypeInfoNew";
	}
	
	//통신방식명 중복체크
	@RequestMapping("/processTypeNameDuplication")
	public String processNameDuplication(
			@ModelAttribute("ContentsForm") @Valid ComTypeInfoVO comTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String checkName = comTypeInfoService.checkName(comTypeInfoVO.getCheckName());
		
		codeMap.put("checkName", checkName);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//통신방식 등록
	@RequestMapping("/comTypeInsert")
	public String comTypeInsert(
			@ModelAttribute("ContentsForm") @Valid ComTypeInfoVO comTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String comTypeInsert = comTypeInfoService.comTypeInsert(comTypeInfoVO);
		
		historyInfoService.insert(TABLE_NAME.com_type_info, comTypeInfoVO);
		
		String comTypeId = comTypeInfoService.comTypeId(comTypeInfoVO.getComTypeName());
		
		codeMap.put("comTypeInsert", comTypeInsert);
		codeMap.put("comTypeId", comTypeId);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//통신방식 수정폼
	@RequestMapping("/comTypeInfoEdit")
	public String comTypeInfoEdit(
			@ModelAttribute("ContentsForm") @Valid ComTypeInfoVO comTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Object comTypeInfo = comTypeInfoService.comTypeInfo(comTypeInfoVO.getComTypeId());
		
		model.addAttribute("comTypeInfo", comTypeInfo);
		
		return "jsp/servermanagement/comtypeinfo/comTypeInfoEdit";
	}
	
	//통신방식 수정
	@RequestMapping("/comTypeUpdate")
	public String comTypeUpdate(
			@ModelAttribute("ContentsForm") @Valid ComTypeInfoVO comTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String comTypeUpdate = comTypeInfoService.comTypeUpdate(comTypeInfoVO);
		
		historyInfoService.update(TABLE_NAME.com_type_info, comTypeInfoVO);
		
		codeMap.put("comTypeUpdate", comTypeUpdate);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//통신방식 삭제
	@RequestMapping("/comTypeDelete")
	public String comTypeDelete(
			@ModelAttribute("ContentsForm") @Valid ComTypeInfoVO comTypeInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String comTypeDelete = comTypeInfoService.comTypeDelete(comTypeInfoVO.getComTypeId());
		
		historyInfoService.delete(TABLE_NAME.com_type_info, comTypeInfoVO);
		
		codeMap.put("comTypeDelete", comTypeDelete);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	
}
