
package com.tmap.systemmanagement.controller;



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

import com.btb.mdcs.util.ResultCondition;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.systemmanagement.service.CertTimeService;
import com.tmap.systemmanagement.vo.CertTimeVO;



@Controller
public class CertTimeController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(CertTimeController.class);
	
	@Autowired
	CertTimeService certTimeService;

	@Autowired
	HistoryInfoService historyInfoService;
	
	//기본 페이지
	@RequestMapping("/CertTimeList")
	public String certTimeList(HttpServletRequest request, Model model) throws Exception{
				
		//기존 인증 시간
		Object certTime = certTimeService.certTime();
		
		//기존 보안 코드
		Object securityCode = certTimeService.securityCode();
		
		model.addAttribute("certTime", certTime);
		model.addAttribute("securityCode", securityCode);
		
		return "jsp/systemmanagement/certTime/CertTimeList";
	}
	
	//인증 시간 변경
	@RequestMapping("/certTimeNewCommit")
	public String certTimeNewCommit(HttpServletRequest request, @ModelAttribute("ContentsForm") @Valid CertTimeVO certTimeVO, BindingResult bindingResult, Model model) throws Exception{
		
		//기존 인증 시간 삭제
		certTimeService.certTimeDelete(certTimeVO);
		
		certTimeVO.setCertTime(certTimeVO.getCertTime() * 1000);
		
		//인증 시간 수정
		certTimeService.certTimeUpdate(certTimeVO);
		
		historyInfoService.update(TABLE_NAME.certtime_info, certTimeVO);
		
		return "redirect:CertTimeList.do";
	}
	
	//보안 코드 변경
	@RequestMapping("/securityCodeNewCommit")
	public String securityCodeNewCommit(HttpServletRequest request, @ModelAttribute("ContentsForm") @Valid CertTimeVO certTimeVO, BindingResult bindingResult, Model model) throws Exception{
		
		//기존 보안 코드 삭제
		certTimeService.securityCodeDelete(certTimeVO);
		//보안 코드 수정
		certTimeService.securityCodeUpdate(certTimeVO);
		historyInfoService.update(TABLE_NAME.security_code_info, certTimeVO);
		//DS통신
		ResultCondition result = certTimeService.syncDssecurityCodeUpdate(certTimeVO);
		
		return "redirect:CertTimeList.do";
	}
}
