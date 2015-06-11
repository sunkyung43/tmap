/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.sitemanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.sitemanagement.dao.MenuInfoDAO;
import com.tmap.sitemanagement.vo.MenuInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Service
public class MenuInfoService {

	@Autowired
	MenuInfoDAO menuInfoDAO;

	//메뉴관리 리스트 출력
	public List<MenuInfoListVO> menuInfoList(MenuInfoListVO menuInfoListVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = menuInfoDAO.countMenuInfoList(menuInfoListVO);
		menuInfoListVO.setTotalCount(totalCount);
		
		List<MenuInfoListVO> menuList = menuInfoDAO.menuInfoList(menuInfoListVO, menuInfoListVO.getStartRowNum(), menuInfoListVO.getCountPerPage());
		return menuList;
	}
	
	//상위메뉴 리스트 출력
	public List<MenuInfoListVO> hMenuList() throws Exception{
		
		List<MenuInfoListVO> hMenuList = menuInfoDAO.hMenuList();
		return hMenuList;
	}
	
	//메뉴관리 등록
	public void menuInfoInsert(MenuInfoListVO menuInfoListVO) throws Exception{
		
		if(menuInfoListVO.gethMenuId() == ""){
			menuInfoListVO.setMenuLevel("1");
		}else{
			menuInfoListVO.setMenuLevel("2");
		}

		menuInfoDAO.menuInfoInsert(menuInfoListVO);
	}
	
	//메뉴관리 수정폼
	public MenuInfoListVO menuModifyList(MenuInfoListVO menuInfoListVO) throws Exception{
		
		MenuInfoListVO menuModifyList = menuInfoDAO.menuModifyList(menuInfoListVO);
		
		return menuModifyList;
		
	}
	
	//메뉴관리 수정
	public int menuInfoUpdate(MenuInfoListVO menuInfoListVO) throws Exception{
		
		if(menuInfoListVO.gethMenuId() == ""){
			menuInfoListVO.setMenuLevel("1");
		}else{
			menuInfoListVO.setMenuLevel("2");
		}
		
		System.out.println(menuInfoListVO.getMenuId());
		System.out.println(menuInfoListVO.gethMenuId()); 
		System.out.println(menuInfoListVO.getMenuLevel());
		
		return menuInfoDAO.menuInfoUpdate(menuInfoListVO);
	}
	
	//메뉴관리 삭제
	public void menuInfoDelete(MenuInfoListVO menuInfoListVO) throws Exception{
		
		menuInfoDAO.menuInfoDelete(menuInfoListVO);
	}
	
	//아이디중복확인
	public String processIdDuplication(String id) throws Exception {
		
		//동일 아이디 카운트
		int result = menuInfoDAO.countSameId(id);

		if(result > 0){
			return "failed";
		}else{
			return "success";
		}
	}
	
}
