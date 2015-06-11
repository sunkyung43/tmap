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

import com.tmap.appmanagement.service.PhInfoService;
import com.tmap.appmanagement.vo.PhInfoListVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.systemmanagement.service.ComCodeInfoService;
import com.tmap.systemmanagement.vo.ComCodeInfoListVO;

@Controller
public class PhInfoController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory
			.getLogger(PhInfoController.class);

	@Autowired
	PhInfoService phInfoService;

	@Autowired
	HistoryInfoService historyInfoService;

	@Autowired
	ComCodeInfoService comCodeInfoService;

	// 단말정보 리스트 출력 ------------------------------------------------
	@RequestMapping("/PhInfoFrame")
	public String phInfoFrame(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid PhInfoListVO phInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		List<PhInfoListVO> phMadeList = phInfoService.phMadeList(phInfoListVO);

		if (phInfoListVO.getActiveId() == null) {
			phInfoListVO.setActiveId("0");
			if (phMadeList.size() > 0) {
				phInfoListVO.setPhMade(phMadeList.get(0).getPhMade());
			}
		}

		List<PhInfoListVO> phInfoList = phInfoService.phInfoList(phInfoListVO);

		model.addAttribute("phInfoList", phInfoList);
		model.addAttribute("phMadeList", phMadeList);

		return "jsp/appmanagement/phinfo/PhInfoFrame";
	}

	// 단말정보 등록폼
	@RequestMapping("/PhInfoNewForm")
	public String phInfoNewForm(Model model) throws Exception {

		ComCodeInfoListVO osTypeVo = new ComCodeInfoListVO();
		osTypeVo.setComCode("OSTYPE");
		List<ComCodeInfoListVO> osTypeList = comCodeInfoService
				.comCodeDetail(osTypeVo);
		model.addAttribute("osTypeList", osTypeList);
		return "jsp/appmanagement/phinfo/PhInfoNewForm";
	}

	// 단말정보 등록
	@RequestMapping("/PhInfoInsert")
	public String phInfoInsert(
			@ModelAttribute("ContentsForm") @Valid PhInfoListVO phInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		phInfoService.phInfoInsert(phInfoListVO);

		historyInfoService.insert(TABLE_NAME.phone_info, phInfoListVO);

		return "redirect:PhInfoFrame.do";
	}

	// 단말정보 수정폼
	@RequestMapping("/PhInfoEditForm")
	public String phInfoEditForm(
			@ModelAttribute("ContentsForm") @Valid PhInfoListVO phInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Object phModifyList = phInfoService.phModifyList(phInfoListVO);

		ComCodeInfoListVO osTypeVo = new ComCodeInfoListVO();
		osTypeVo.setComCode("OSTYPE");
		List<ComCodeInfoListVO> osTypeList = comCodeInfoService
				.comCodeDetail(osTypeVo);
		model.addAttribute("osTypeList", osTypeList);
		model.addAttribute("modifyInfo", phModifyList);

		return "jsp/appmanagement/phinfo/PhInfoEditForm";
	}

	// 단말정보 수정
	@RequestMapping("/PhInfoUpdate")
	public String phInfoUpdate(
			@ModelAttribute("ContentsForm") @Valid PhInfoListVO phInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		int result = phInfoService.phInfoUpdate(phInfoListVO);

		codeMap.put("result", result);
		model.addAttribute("json", codeMap);

		// historyInfoService.update(TABLE_NAME.phone_info, phInfoListVO);

		return "jsonView";
	}

	// 단말정보 삭제
	@RequestMapping("/PhInfoDelete")
	public String phInfoDelete(
			@ModelAttribute("ContentsForm") @Valid PhInfoListVO phInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {
		Map<String, Object> codeMap = new HashMap<String, Object>();

		int result = phInfoService.phInfoDelete(phInfoListVO);

		// historyInfoService.delete(TABLE_NAME.phone_info, phInfoListVO);

		return "jsonView";
	}

}
