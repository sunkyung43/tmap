
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
import com.tmap.systemmanagement.service.MessageInfoService;
import com.tmap.systemmanagement.vo.MessageInfoListVO;


@Controller
public class MessageInfoController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(MessageInfoController.class);
	
	@Autowired
	MessageInfoService messageInfoService;
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	//공통메세지관리 리스트 출력
	@RequestMapping("/messageInfoList")
	public String messageInfoList(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid MessageInfoListVO messageInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		if(messageInfoListVO.getMessageCode() == null){
			messageInfoListVO.setMessageCode("");
		}
		if(messageInfoListVO.getMessageCodeValue() == null){
			messageInfoListVO.setMessageCodeValue("");
		}
		
		List<MessageInfoListVO> messageList = messageInfoService.messageInfoList(messageInfoListVO);
		
		model.addAttribute("messageList", messageList); 
		return "jsp/systemmanagement/messageinfo/messageInfoList";
	}
	
	//운영업체관리 등록폼
	@RequestMapping("/messageInfoNewForm")
	public String messageInfoNewForm(
			Model model) throws Exception{
		
		return "jsp/systemmanagement/messageinfo/messageInfoNewForm";
	}
	
	//공통메세지관리 등록
	@RequestMapping("/messageInfoInsert")
	public String messageInfoInsert(
			@ModelAttribute("ContentsForm") @Valid MessageInfoListVO messageInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		messageInfoService.messageInfoInsert(messageInfoListVO);
		
		historyInfoService.insert(TABLE_NAME.message_info, messageInfoListVO);
		
		return "redirect:messageInfoList.do";
	}
	
	//공통메세지관리 수정폼
	@RequestMapping("/messageInfoEditForm")
	public String messageInfoEditForm(
			@ModelAttribute("ContentsForm") @Valid MessageInfoListVO messageInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Object messageModifyList = messageInfoService.messageModifyList(messageInfoListVO);
		
		model.addAttribute("modifyInfo", messageModifyList);
		
		return "jsp/systemmanagement/messageinfo/messageInfoEditForm";
	}
	
	//공통메세지관리 수정
	@RequestMapping("/messageInfoUpdate")
	public String messageInfoUpdate(
			@ModelAttribute("ContentsForm") @Valid MessageInfoListVO messageInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		messageInfoService.messageInfoUpdate(messageInfoListVO);
		
		historyInfoService.update(TABLE_NAME.message_info, messageInfoListVO);
		
		return "redirect:messageInfoList.do";
	}
	
	//공통메세지관리 삭제
	@RequestMapping("/messageInfoDelete")
	public String messageInfoDelete(
			@ModelAttribute("ContentsForm") @Valid MessageInfoListVO messageInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		messageInfoService.messageInfoDelete(messageInfoListVO);
		
		historyInfoService.delete(TABLE_NAME.message_info, messageInfoListVO);
		
		return "redirect:messageInfoList.do";
	}
}
