
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
import com.tmap.sitemanagement.service.AuthorityInfoService;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.sitemanagement.vo.AuthorityInfoListVO;
import com.tmap.sitemanagement.vo.MenuInfoListVO;


@Controller
public class AuthorityInfoController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(AuthorityInfoController.class);
	
	@Autowired
	AuthorityInfoService authorityInfoService;
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	//검색 조건 초기화
	@SuppressWarnings("unused")
	@ModelAttribute("ContentsForm")
	private AuthorityInfoListVO readAdminListParamInit(AuthorityInfoListVO authorityInfoListVO) {
		
		if(authorityInfoListVO.getMenuAuthorityId() == null){
			authorityInfoListVO.setMenuAuthorityId("");
		}
		if(authorityInfoListVO.getAuthority() == null){
			authorityInfoListVO.setAuthority("");
		}
				
		return authorityInfoListVO;
	}
	
	
	//권한정보관리 리스트 출력
	@RequestMapping("/authorityInfoList")
	public String authorityInfoList(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid AuthorityInfoListVO authorityInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		
		List<AuthorityInfoListVO> authorityList = authorityInfoService.authorityInfoList(authorityInfoListVO);
		
		model.addAttribute("authorityList", authorityList); 
		return "jsp/sitemanagement/authorityinfo/authorityInfoList";
	}
	
	//권한정보관리 등록폼
	@RequestMapping("/authorityInfoNewForm")
	public String authorityInfoNewForm(
			Model model) throws Exception{
		
		List<MenuInfoListVO> menuList = authorityInfoService.menuList();
		
		model.addAttribute("menuList", menuList);
		
		return "jsp/sitemanagement/authorityinfo/authorityInfoNewForm";
	}
	
	//권한정보관리 등록
	@RequestMapping("/authorityInfoInsert")
	public String authorityInfoInsert(
			@ModelAttribute("ContentsForm") @Valid AuthorityInfoListVO authorityInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String[] menuList = authorityInfoListVO.getSelMenuIds().split(",");
		
		//권한정보
		String authorityInfoInsert = authorityInfoService.authorityInfoInsert(authorityInfoListVO);
		
		historyInfoService.insert(TABLE_NAME.authority_info, authorityInfoListVO);
		
		//메뉴권한
		authorityInfoService.menuAuthorityInsert(authorityInfoListVO, menuList);
		
		historyInfoService.insert(TABLE_NAME.authority_menu_info, authorityInfoListVO);
		
		codeMap.put("authorityInfoInsert", authorityInfoInsert);
		codeMap.put("menuAuthorityId", authorityInfoListVO.getMenuAuthorityId());
		
		model.addAttribute("json", codeMap);

		return "jsonView";
		
	}
	
	//권한정보관리 수정폼
	@RequestMapping("/authorityInfoEditForm")
	public String authorityInfoEditForm(
			@ModelAttribute("ContentsForm") @Valid AuthorityInfoListVO authorityInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Object authorityModifyList = authorityInfoService.authorityModifyList(authorityInfoListVO);
		List<MenuInfoListVO> menuIdList = authorityInfoService.menuId(authorityInfoListVO);
		
		model.addAttribute("modifyInfo", authorityModifyList);
		model.addAttribute("menuIdList", menuIdList);
		return "jsp/sitemanagement/authorityinfo/authorityInfoEditForm";
	}
	
	//권한정보관리 수정
	@RequestMapping("/authorityInfoUpdate")
	public String authorityInfoUpdate(
			@ModelAttribute("ContentsForm") @Valid AuthorityInfoListVO authorityInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String[] menuList = authorityInfoListVO.getSelMenuIds().split(",");
		
		//권한정보
		String authorityInfoUpdate = authorityInfoService.authorityInfoUpdate(authorityInfoListVO);
		
		historyInfoService.update(TABLE_NAME.authority_info, authorityInfoListVO);
		
		//메뉴권한 삭제
		authorityInfoService.menuAuthorityDelete(authorityInfoListVO);
		
		//메뉴권한 등록
		authorityInfoService.menuAuthorityInsert(authorityInfoListVO, menuList);
		
		historyInfoService.update(TABLE_NAME.authority_menu_info, authorityInfoListVO);
		
		codeMap.put("authorityInfoUpdate", authorityInfoUpdate);
		codeMap.put("menuAuthorityId", authorityInfoListVO.getMenuAuthorityId());
		
		model.addAttribute("json", codeMap);

		return "jsonView";
		
	}
	
	//권한정보관리 삭제
	@RequestMapping("/authorityInfoDelete")
	public String authorityInfoDelete(
			@ModelAttribute("ContentsForm") @Valid AuthorityInfoListVO authorityInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		authorityInfoService.authorityInfoDelete(authorityInfoListVO);
		
		historyInfoService.delete(TABLE_NAME.authority_info, authorityInfoListVO);
		
		return "redirect:authorityInfoList.do";
	}
	
	//아이디 중복체크
	@RequestMapping("/processAuIDuplication")
	public String processAuIDuplication(
			@RequestParam("checkId") String checkId,
			Model model) throws Exception {
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String checkName = authorityInfoService.processIdDuplication(checkId);
		
		codeMap.put("checkName", checkName);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
		
	}
	
}
