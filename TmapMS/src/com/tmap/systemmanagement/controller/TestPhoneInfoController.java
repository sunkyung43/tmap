package com.tmap.systemmanagement.controller;

import java.util.List;

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

import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.systemmanagement.service.TestPhoneInfoService;
import com.tmap.systemmanagement.vo.TestPhoneInfoListVO;


@Controller
public class TestPhoneInfoController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(TestPhoneInfoController.class);
	
	@Autowired
	TestPhoneInfoService testPhoneInfoService;

	@Autowired
	HistoryInfoService historyInfoService;
	
	//테스트폰관리 리스트 출력
	@RequestMapping("/testPhoneList")
	public String testPhoneInfoList(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid TestPhoneInfoListVO testPhoneInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
				
		if(testPhoneInfoListVO.getTestPhoneNumber() == null){
			testPhoneInfoListVO.setTestPhoneNumber("");
		}
		
		if(testPhoneInfoListVO.getUserName() == null){
			testPhoneInfoListVO.setUserName("");
		}
		
		List<TestPhoneInfoListVO> testPhoneList = testPhoneInfoService.testPhoneInfoList(testPhoneInfoListVO);
		
		model.addAttribute("testPhoneList", testPhoneList); 
		return "jsp/systemmanagement/testphone/testPhoneList";
	}
	
	//테스트폰관리 등록폼
	@RequestMapping("/testPhoneNewForm")
	public String testPhoneInfoNewForm(
			Model model) throws Exception{
		
		return "jsp/systemmanagement/testphone/testPhoneNewForm";
	}
	
	//테스트폰관리 등록
	@RequestMapping("/testPhoneInsert")
	public String testPhoneInfoInsert(
			@ModelAttribute("ContentsForm") @Valid TestPhoneInfoListVO testPhoneInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		testPhoneInfoService.testPhoneInfoInsert(testPhoneInfoListVO);
		
		historyInfoService.insert(TABLE_NAME.test_phone_info, testPhoneInfoListVO);
		
		return "redirect:testPhoneList.do";
	}
	
	//테스트폰관리 수정폼
	@RequestMapping("/testPhoneEditForm")
	public String testPhoneInfoEditForm(
			@ModelAttribute("ContentsForm") @Valid TestPhoneInfoListVO testPhoneInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Object testPhoneModifyList = testPhoneInfoService.testPhoneModifyList(testPhoneInfoListVO);
		
		model.addAttribute("modifyInfo", testPhoneModifyList);
		
		return "jsp/systemmanagement/testphone/testPhoneEditForm";
	}
	
	//테스트폰관리 수정
	@RequestMapping("/testPhoneUpdate")
	public String testPhoneInfoUpdate(
			@ModelAttribute("ContentsForm") @Valid TestPhoneInfoListVO testPhoneInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		testPhoneInfoService.testPhoneInfoUpdate(testPhoneInfoListVO);
		
		historyInfoService.update(TABLE_NAME.test_phone_info, testPhoneInfoListVO);
		
		return "redirect:testPhoneList.do";
	}
	
	//테스트폰관리 삭제
	@RequestMapping("/testPhoneDelete")
	public String testPhoneInfoDelete(
			@ModelAttribute("ContentsForm") @Valid TestPhoneInfoListVO testPhoneInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		testPhoneInfoService.testPhoneInfoDelete(testPhoneInfoListVO);
		
		historyInfoService.delete(TABLE_NAME.test_phone_info, testPhoneInfoListVO);
		
		return "redirect:testPhoneList.do";
	}
	
}
