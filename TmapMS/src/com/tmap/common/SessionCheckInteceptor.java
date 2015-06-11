package com.tmap.common;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.tmap.login.vo.MenuInfoVO;

public class SessionCheckInteceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String requestURLMapping = (String) request.getAttribute("org.springframework.web.servlet.HandlerMapping.bestMatchingPattern");
		HttpSession session = request.getSession();
		
		String referer = request.getHeader(org.apache.http.HttpHeaders.REFERER);
		String uri = request.getRequestURI();
		
		if(referer == null || referer == "")
		{
			
			if(!uri.contains("loginForm.do"))
			{
				session.invalidate();
				response.sendRedirect("loginForm.do");
				return false;
			}
		}else{
			if(!referer.contains("172.19.112.31") && !referer.contains("172.19.106.121") &&!referer.contains("172.19.106.122"))			
			{
				response.sendRedirect("loginForm.do");
				return false;
			}
		}
		
		if (session == null) {
			response.sendRedirect("loginForm.do");
			return false;
		}else{
			
			String clientIp = request.getHeader("HTTP_X_FORWARDED_FOR");
			if(CommonUtil.isEmpty(clientIp))
			{
				clientIp = request.getRemoteAddr();
			}
			
			if(session.getAttribute("clientIP") != null && !session.getAttribute("clientIP").equals(clientIp)){
				//session.invalidate();
				response.sendRedirect("loginForm.do");
				return false;
			}			
			if (requestURLMapping.indexOf("login") > -1) {
				if (CommonUtil.isNotEmpty(session.getAttribute("userId"))) {
					response.sendRedirect("main.do");
					return false;
				}
				return true;
			}
			
			// 파일 업로드 임시 처리
			if (request instanceof DefaultMultipartHttpServletRequest) {
				return true;
			}
			
			if (CommonUtil.isEmpty(session.getAttribute("userId"))) {
				//세션 삭제
				response.sendRedirect("loginForm.do");
				return false;
			}
			
			setSessionMenuId(requestURLMapping, session);
			
			return true;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception excpetion) throws Exception {
	}
	
	private void setSessionMenuId(String requestURLMapping, HttpSession session) {
		requestURLMapping = requestURLMapping.substring(requestURLMapping.lastIndexOf("/")+1, requestURLMapping.indexOf("."));
		
		@SuppressWarnings("unchecked")
		List<MenuInfoVO> menuList = (List<MenuInfoVO>) session.getAttribute("menuList");
		if (CommonUtil.isNotEmpty(menuList)) {
			if (requestURLMapping.indexOf("main") > -1) {
				session.setAttribute("menuId", "main");
				session.setAttribute("hMenuId", "");
			} else {
				for (MenuInfoVO menuInfoVO : menuList) {
					if (menuInfoVO.getMenuUrl().indexOf(requestURLMapping) > -1 && CommonUtil.isNotEmpty(menuInfoVO.getMenuHiId())) {
						session.setAttribute("menuId", menuInfoVO.getMenuId());
						session.setAttribute("hMenuId", menuInfoVO.getMenuHiId());
						break;
					}
				}
			}
		}
	}

}
