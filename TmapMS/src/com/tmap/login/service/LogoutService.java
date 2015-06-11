package com.tmap.login.service;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.tmap.common.CommonUtil;

@Service
public class LogoutService {

	public void logout(HttpServletRequest request, HttpServletResponse response) {
		HttpSession httpSession = request.getSession();
		Cookie[] c = request.getCookies();
		for(Cookie data : c){
		  data.setMaxAge(0);
		  response.addCookie(data);
		}
		while (httpSession.getAttributeNames().hasMoreElements()) {
			String attributeName = (String) httpSession.getAttributeNames().nextElement();
			if (CommonUtil.isNotEmpty(attributeName)) {
				httpSession.setAttribute(attributeName, null);
			}
		}
	}
}
