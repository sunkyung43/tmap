package com.tmap.login.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.login.dao.MenuDAO;
import com.tmap.login.vo.MenuInfoVO;
import com.tmap.login.vo.UserInfoVO;

@Service
public class MainService {
	@Autowired
	MenuDAO menuDAO;

	public List<MenuInfoVO> setSessionUserMenuList(HttpServletRequest request) throws Exception {
		List<MenuInfoVO> menuList = menuDAO.userMenuList(((UserInfoVO) request.getSession().getAttribute("userInfo")).getAuthorityMenuId());
		request.getSession().setAttribute("menuList", menuList);
		return menuList;
	}
}
