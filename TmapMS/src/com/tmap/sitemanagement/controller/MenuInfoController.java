package com.tmap.sitemanagement.controller;

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
import org.springframework.web.bind.annotation.RequestParam;

import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.sitemanagement.service.MenuInfoService;
import com.tmap.sitemanagement.vo.MenuInfoListVO;

@Controller
public class MenuInfoController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory
			.getLogger(MenuInfoController.class);

	@Autowired
	MenuInfoService menuInfoService;

	@Autowired
	HistoryInfoService historyInfoService;

	// 메뉴관리 리스트 출력
	@RequestMapping("/menuInfoList")
	public String menuInfoList(
			HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid MenuInfoListVO menuInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		if (menuInfoListVO.getsMenuId() == null) {
			menuInfoListVO.setsMenuId("");
		}
		if (menuInfoListVO.getMenuName() == null) {
			menuInfoListVO.setMenuName("");
		}

		List<MenuInfoListVO> menuList = menuInfoService
				.menuInfoList(menuInfoListVO);

		model.addAttribute("menuList", menuList);
		return "jsp/sitemanagement/menuinfo/menuInfoList";
	}

	// 메뉴관리 등록폼
	@RequestMapping("/menuInfoNewForm")
	public String menuInfoNewForm(Model model) throws Exception {

		List<MenuInfoListVO> hMenuList = menuInfoService.hMenuList();
		model.addAttribute("hMenuList", hMenuList);
		return "jsp/sitemanagement/menuinfo/menuInfoNewForm";
	}

	// 메뉴관리 등록
	@RequestMapping("/menuInfoInsert")
	public String menuInfoInsert(
			@ModelAttribute("ContentsForm") @Valid MenuInfoListVO menuInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		menuInfoService.menuInfoInsert(menuInfoListVO);

		historyInfoService.insert(TABLE_NAME.menu_info, menuInfoListVO);

		return "redirect:menuInfoList.do";
	}

	// 메뉴관리 수정폼
	@RequestMapping("/menuInfoEditForm")
	public String menuInfoEditForm(
			@ModelAttribute("ContentsForm") @Valid MenuInfoListVO menuInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Object menuModifyList = menuInfoService.menuModifyList(menuInfoListVO);
		List<MenuInfoListVO> hMenuList = menuInfoService.hMenuList();

		model.addAttribute("hMenuList", hMenuList);
		model.addAttribute("modifyInfo", menuModifyList);

		return "jsp/sitemanagement/menuinfo/menuInfoEditForm";
	}

	// 메뉴관리 수정
	@RequestMapping("/menuInfoUpdate")
	public String menuInfoUpdate(
			@ModelAttribute("ContentsForm") @Valid MenuInfoListVO menuInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		int result = menuInfoService.menuInfoUpdate(menuInfoListVO);

		codeMap.put("result", result);

		model.addAttribute("json", codeMap);

		historyInfoService.update(TABLE_NAME.menu_info, menuInfoListVO);

		return "jsonView";
	}

	// 메뉴관리 삭제
	@RequestMapping("/menuInfoDelete")
	public String menuInfoDelete(
			@ModelAttribute("ContentsForm") @Valid MenuInfoListVO menuInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		menuInfoService.menuInfoDelete(menuInfoListVO);

		historyInfoService.delete(TABLE_NAME.menu_info, menuInfoListVO);

		return "redirect:menuInfoList.do";
	}

	// 아이디 중복체크
	@RequestMapping("/processMenuIdDuplication")
	public String processIdDuplication(@RequestParam("checkId") String checkId,
			Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		String checkName = menuInfoService.processIdDuplication(checkId);

		codeMap.put("checkName", checkName);

		model.addAttribute("json", codeMap);

		return "jsonView";
	}

}
