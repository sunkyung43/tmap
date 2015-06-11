package com.tmap.login.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.common.CommonUtil;
import com.tmap.login.dao.LoginDAO;
import com.tmap.login.vo.UserInfoVO;

@Service
public class LoginService {
	@Autowired
	LoginDAO loginDAO;

	public enum LOGIN_STATS {
		SUCCESS,
		IDCHECK,
		PWCHECK,
		STATSCHECK,
		FAIL
	}

	public LOGIN_STATS login(HttpServletRequest request) throws Exception {
		String userId = request.getParameter("userId");
		String userPass = request.getParameter("userPass");
		if (CommonUtil.isEmpty(userId) || CommonUtil.isEmpty(userPass) ) {
			return LOGIN_STATS.FAIL;
		}
		
		UserInfoVO userInfoVO = loginDAO.userInfo(userId);
		if (userInfoVO == null) {
			return LOGIN_STATS.IDCHECK;
		}
		
		if (!"Y".equals(userInfoVO.getUserState())) {
			return LOGIN_STATS.STATSCHECK;
		}
		
		
		if (userPass.equals(userInfoVO.getUserPass())) {
			HttpSession httpSession = request.getSession();
			// 초기화
			while (httpSession.getAttributeNames().hasMoreElements()) {
				String attributeName = (String) httpSession.getAttributeNames().nextElement();
				if (CommonUtil.isNotEmpty(attributeName)) {
					httpSession.setAttribute(attributeName, null);
				}
			}
			
			httpSession.setAttribute("userId", userId);
			httpSession.setAttribute("userInfo", userInfoVO);
			
			return LOGIN_STATS.SUCCESS;
		} else {
			return LOGIN_STATS.PWCHECK;
		}
	}

}
