
package com.tmap.systemmanagement.controller;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.systemmanagement.service.RmVersionService;
import com.tmap.systemmanagement.vo.RmVersionVO;


@Controller
public class RmVersionController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(RmVersionController.class);
	
	@Autowired
	RmVersionService rmVersionService;
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	//맵 버전 긴급 운영설정
	@RequestMapping("/RmVersionList")
	public String rmVersionList(
			Model model) throws Exception{
		
		Object rmVersionList = rmVersionService.rmVersionList();
		
		model.addAttribute("rmVersionList", rmVersionList);
		
		return "jsp/systemmanagement/rmversion/RmVersionList";
	}
	
	@RequestMapping("/RmVersionNewCommit")
	public String securityCodeNewCommit(
			@ModelAttribute("ContentsForm") @Valid RmVersionVO rmVersionListVO,
			Model model) throws Exception{
		
		rmVersionService.rmVersionNewCommit(rmVersionListVO);
		
		historyInfoService.update(TABLE_NAME.rmversion_info, rmVersionListVO);
		
		return "redirect:RmVersionList.do";
	}
	
	
}
