package com.tmap.login.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tmap.common.CommonUtil;
import com.tmap.login.service.LoginService;
import com.tmap.login.service.LoginService.LOGIN_STATS;
import com.tmap.login.service.MainService;
import com.tmap.servermanagement.service.MapDownServiceService;
import com.tmap.servermanagement.vo.SystemInfoVO;
import com.tmap.sitemanagement.service.HistoryInfoService;

@Controller
public class LoginController {
	@Autowired
	LoginService loginService;
	@Autowired
	MainService mainService;
	
	@Autowired
	HistoryInfoService historyInfoService;

	@Autowired
	MapDownServiceService mapDownServiceService;

	@RequestMapping("/loginForm.do")
	public String loginForm(HttpServletRequest request, Model model) throws Exception {
		return "jsp/common/loginForm";
	}
	
	@RequestMapping("/login.do")
	public String login(HttpServletRequest request, Model model) throws Exception {
		LOGIN_STATS isSuccess = loginService.login(request);
		
		String code = null;
		String message = null;
		String action = null;
		
		
		
		switch (isSuccess) {
		case SUCCESS:
			code = "SUCCESS";
			action = "main.do";
			model.addAttribute("menuList", mainService.setSessionUserMenuList(request));
			String clientIp = request.getHeader("HTTP_X_FORWARDED_FOR");
			if(CommonUtil.isEmpty(clientIp))
			{
				clientIp = request.getRemoteAddr();
			}
			request.getSession().setAttribute("clientIP", clientIp);
			break;
		case FAIL:
		case STATSCHECK:
		case IDCHECK:
		case PWCHECK:
			code = "ERROR";
			message = "로그인 정보가 일치하지 않습니다.";
			break;
		}
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("CODE", code);
		result.put("MESSAGE", message);
		result.put("ACTION", action);
		
		model.addAttribute("json", result);
		return "jsonView";
	}
	
	@RequestMapping("/main.do")
	public String main(HttpServletRequest request, SystemInfoVO systemInfoVO, Model model) throws Exception {
		return "jsp/main";
	}
}
