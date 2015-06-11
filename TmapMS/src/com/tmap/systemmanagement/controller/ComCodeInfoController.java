/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.systemmanagement.service.ComCodeInfoService;
import com.tmap.systemmanagement.vo.ComCodeInfoListVO;

/**
 * <br/>
 * 
 * @author 김경민
 * @date 2012. 7. 19.
 */

@Controller
public class ComCodeInfoController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory
			.getLogger(ComCodeInfoController.class);

	@Autowired
	ComCodeInfoService comCodeInfoService;

	@Autowired
	HistoryInfoService historyInfoService;

	// 공통코드관리 리스트 출력
	@RequestMapping("/comCodeInfoList")
	public String comCodeInfoList(
			@ModelAttribute("ContentsForm") @Valid ComCodeInfoListVO comCodeInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		comCodeInfoListVO.setComCode(comCodeInfoListVO.getsComCode());

		if (comCodeInfoListVO.getComCode() == null) {
			comCodeInfoListVO.setComCode("");
		}

		if (comCodeInfoListVO.getCodeName() == null) {
			comCodeInfoListVO.setCodeName("");
		}

		List<ComCodeInfoListVO> comCodeList = comCodeInfoService
				.comCodeInfoList(comCodeInfoListVO);
		model.addAttribute("comCodeList", comCodeList);
		return "jsp/systemmanagement/comcodeinfo/comCodeInfoList";
	}

	// 공통코드관리 등록폼
	@RequestMapping("/comCodeInfoNewForm")
	public String comCodeInfoNewForm(Model model) throws Exception {

		return "jsp/systemmanagement/comcodeinfo/comCodeInfoNewForm";
	}

	// 공통코드관리 등록
	@RequestMapping("/comCodeInfoInsert")
	public String comCodeInfoInsert(
			@ModelAttribute("ContentsForm") @Valid ComCodeInfoListVO comCodeInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		comCodeInfoService.comCodeInfoInsert(comCodeInfoListVO);

		historyInfoService.insert(TABLE_NAME.comcode_info, comCodeInfoListVO);

		
		// com_type일경우 code_upCode=ComType일경우 DS서버 통신방식 업데이트
		/*
		if (comCodeInfoListVO.getUpComCode().equals("ComType")) {
			List<ComCodeInfoListVO> comCodeCount = comCodeInfoService
					.comCodeCount(comCodeInfoListVO);
			for (int i = 0; i < comCodeCount.size(); i++) {
				comCodeInfoListVO
						.setSystemId(comCodeCount.get(i).getSystemId());
				comCodeInfoListVO.setMapdownManageId(comCodeCount.get(i)
						.getMapdownManageId());
				comCodeInfoService.comCodeInsert(comCodeInfoListVO);
			}
			model.addAttribute("comCodeCount", comCodeCount);
		}
	*/

		return "redirect:comCodeInfoList.do";
	}

	// 공통코드관리 상세정보
	@RequestMapping("/comCodeInfoDetail")
	public String comCodeInfoDetail(
			@ModelAttribute("ContentsForm") @Valid ComCodeInfoListVO comCodeInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Object comCodeInfoDetail = comCodeInfoService
				.comCodeInfoDetail(comCodeInfoListVO);
		List<ComCodeInfoListVO> comCodeDetail = comCodeInfoService
				.comCodeDetail(comCodeInfoListVO);

		model.addAttribute("comCodeInfoDetail", comCodeInfoDetail);
		model.addAttribute("comCodeDetail", comCodeDetail);

		return "jsp/systemmanagement/comcodeinfo/comCodeInfoDetail";
	}

	// 공통코드관리 수정폼
	@RequestMapping("/comCodeInfoEditForm")
	public String comCodeInfoEditForm(
			@ModelAttribute("ContentsForm") @Valid ComCodeInfoListVO comCodeInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Object comCodeInfoDetail = comCodeInfoService
				.comCodeInfoDetail(comCodeInfoListVO);

		model.addAttribute("comCodeInfoDetail", comCodeInfoDetail);

		return "jsp/systemmanagement/comcodeinfo/comCodeInfoEditForm";
	}

	// 공통코드관리 수정
	@RequestMapping("/comCodeInfoUpdate")
	public String comCodeInfoUpdate(
			@ModelAttribute("ContentsForm") @Valid ComCodeInfoListVO comCodeInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		comCodeInfoService.comCodeInfoUpdate(comCodeInfoListVO);

		historyInfoService.update(TABLE_NAME.comcode_info, comCodeInfoListVO);

		return "redirect:comCodeInfoList.do";
	}

	// 공통코드관리 삭제
	@RequestMapping("/comCodeInfoDelete")
	public String comCodeInfoDelete(
			@ModelAttribute("ContentsForm") @Valid ComCodeInfoListVO comCodeInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		comCodeInfoService.comCodeInfoDelete(comCodeInfoListVO);

		historyInfoService.delete(TABLE_NAME.comcode_info, comCodeInfoListVO);

		return "redirect:comCodeInfoList.do";
	}

	// 소분류코드 등록폼
	@RequestMapping("/comCodeInfoNew2Form")
	public String comCodeInfoNew2Form(@Param("upComCode") String upComCode,
			Model model) throws Exception {

		model.addAttribute("upComCode", upComCode);
		return "jsp/systemmanagement/comcodeinfo/comCodeInfoNew2Form";
	}

	// 소분류코드 사용유무 변경
	@RequestMapping("/comCodeInfoUseState")
	public String comCodeInfoUseState(
			@ModelAttribute("ContentsForm") @Valid ComCodeInfoListVO comCodeInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		comCodeInfoListVO.setComCode(comCodeInfoListVO.getsComCode());

		String check = comCodeInfoService
				.comCodeInfoUseState(comCodeInfoListVO);

		historyInfoService.update(TABLE_NAME.comcode_info, comCodeInfoListVO);

		codeMap.put("check", check);

		model.addAttribute("json", codeMap);

		return "jsonView";
	}

	// 아이디 중복체크
	@RequestMapping("/processCodeIdDuplication")
	public String processCodeIdDuplication(
			@RequestParam("checkId") String checkId, Model model)
			throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		String check = comCodeInfoService.processIdDuplication(checkId);

		codeMap.put("check", check);

		model.addAttribute("json", codeMap);

		return "jsonView";

	}

}
