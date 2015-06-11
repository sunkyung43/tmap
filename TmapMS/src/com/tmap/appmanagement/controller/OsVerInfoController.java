package com.tmap.appmanagement.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tmap.appmanagement.service.OsVerInfoService;
import com.tmap.appmanagement.vo.OsVerInfoListVO;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.systemmanagement.service.ComCodeInfoService;
import com.tmap.systemmanagement.vo.ComCodeInfoListVO;

@Controller
public class OsVerInfoController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory
			.getLogger(OsVerInfoController.class);

	@Autowired
	OsVerInfoService osVerInfoService;

	@Autowired
	HistoryInfoService historyInfoService;

	@Autowired
	ComCodeInfoService comCodeInfoService;
	
	// OS버전정보 리스트 출력
	@RequestMapping("/OsVerInfoFrame")
	public String osVerInfoFrame(
			HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid OsVerInfoListVO osVerInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {
		
		ComCodeInfoListVO osTypeVo = new ComCodeInfoListVO();
		osTypeVo.setComCode("OSTYPE");
		List<ComCodeInfoListVO> osTypeList = comCodeInfoService.comCodeDetail(osTypeVo);
		if (osVerInfoListVO.getOsDivision() == null) {
			osVerInfoListVO.setOsDivision("AND");
			osVerInfoListVO.setActiveId("0");
		}
		
		List<OsVerInfoListVO> osVerInfoFrame = osVerInfoService.osVerInfoFrame(osVerInfoListVO);
		
		model.addAttribute("activeId", osVerInfoListVO.getActiveId());
		model.addAttribute("osVerInfoFrame", osVerInfoFrame);
		model.addAttribute("osTypeList", osTypeList);
		return "jsp/appmanagement/osverinfo/OsVerInfoFrame";
	}
	
	// OS버전정보 등록폼
	@RequestMapping("/OsVerInfoNewForm")
	public String osVerInfoNewForm(Model model) throws Exception {
		
		ComCodeInfoListVO osTypeVo = new ComCodeInfoListVO();
		osTypeVo.setComCode("OSTYPE");
		List<ComCodeInfoListVO> osTypeList = comCodeInfoService.comCodeDetail(osTypeVo);
		model.addAttribute("osTypeList", osTypeList);
		return "jsp/appmanagement/osverinfo/OsVerInfoNewForm";
	}

	// OS버전정보 등록
	@RequestMapping("/OsVerInfoInsert")
	public String osVerInfoInsert(
			@ModelAttribute("ContentsForm") @Valid OsVerInfoListVO osVerInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {
		
		Map<String, Object> codeMap = new HashMap<String, Object>();

		int result = osVerInfoService.osVerInfoInsert(osVerInfoListVO);

//		historyInfoService.insert(TABLE_NAME.os_ver_info, osVerInfoListVO);

		codeMap.put("result", result);
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}

	// OS버전정보 수정폼
	@RequestMapping("/OsVerInfoEditForm")
	public String osVerInfoEditForm(
			@ModelAttribute("ContentsForm") @Valid OsVerInfoListVO osVerInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Object osVerModifyList = osVerInfoService
				.osVerModifyList(osVerInfoListVO);

		ComCodeInfoListVO osTypeVo = new ComCodeInfoListVO();
		osTypeVo.setComCode("OSTYPE");
		List<ComCodeInfoListVO> osTypeList = comCodeInfoService.comCodeDetail(osTypeVo);
		model.addAttribute("osTypeList", osTypeList);
		model.addAttribute("modifyInfo", osVerModifyList);

		return "jsp/appmanagement/osverinfo/OsVerInfoEditForm";
	}

	// OS버전정보 수정
	@RequestMapping("/OsVerInfoUpdate")
	public String osVerInfoUpdate(
			@ModelAttribute("ContentsForm") @Valid OsVerInfoListVO osVerInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		int result = osVerInfoService.osVerInfoUpdate(osVerInfoListVO);

//		historyInfoService.update(TABLE_NAME.os_ver_info, osVerInfoListVO);

		codeMap.put("result", result);
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}

	// OS버전정보 삭제
	@RequestMapping("/OsVerInfoDelete")
	public String osVerInfoDelete(
			@ModelAttribute("ContentsForm") @Valid OsVerInfoListVO osVerInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		int result = osVerInfoService.osVerInfoDelete(osVerInfoListVO);

//		historyInfoService.delete(TABLE_NAME.os_ver_info, osVerInfoListVO);

		codeMap.put("result", result);
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}

}
