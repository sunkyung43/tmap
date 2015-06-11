/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.sitemanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.sitemanagement.dao.AuthorityInfoDAO;
import com.tmap.sitemanagement.vo.AuthorityInfoListVO;
import com.tmap.sitemanagement.vo.MenuInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Service
public class AuthorityInfoService {

	@Autowired
	AuthorityInfoDAO authorityInfoDAO;

	//권한정보관리 리스트 출력
	public List<AuthorityInfoListVO> authorityInfoList(AuthorityInfoListVO authorityInfoListVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = authorityInfoDAO.countAuthorityInfoList(authorityInfoListVO);
		authorityInfoListVO.setTotalCount(totalCount);
		
		List<AuthorityInfoListVO> authorityList = authorityInfoDAO.authorityInfoList(authorityInfoListVO, authorityInfoListVO.getStartRowNum(), authorityInfoListVO.getCountPerPage());
		return authorityList;
	}
	
	//메뉴 리스트
	public List<MenuInfoListVO> menuList() throws Exception{
		
		List<MenuInfoListVO> menuList = authorityInfoDAO.menuList();
		return menuList;
	}
	
	//메뉴권한 등록
	public void menuAuthorityInsert(AuthorityInfoListVO authorityInfoListVO, String[] menuList) throws Exception{
		
		authorityInfoDAO.menuAuthorityInsert(authorityInfoListVO, menuList);
		
	}
	
	//권한정보관리 등록
	public String authorityInfoInsert(AuthorityInfoListVO authorityInfoListVO) throws Exception{
		
		int result = authorityInfoDAO.authorityInfoInsert(authorityInfoListVO);
		
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
		
	}
	
	//권한정보관리 수정폼
	public AuthorityInfoListVO authorityModifyList(AuthorityInfoListVO authorityInfoListVO) throws Exception{
		
		AuthorityInfoListVO authorityModifyList = authorityInfoDAO.authorityModifyList(authorityInfoListVO);
		
		return authorityModifyList;
		
	}
	
	public List<MenuInfoListVO> menuId(AuthorityInfoListVO authorityInfoListVO) throws Exception{
		
		List<MenuInfoListVO> menuId = authorityInfoDAO.menuId(authorityInfoListVO);
		
		return menuId;
	}
	
	//권한정보관리 수정
	public String authorityInfoUpdate(AuthorityInfoListVO authorityInfoListVO) throws Exception{
		
		int result = authorityInfoDAO.authorityInfoUpdate(authorityInfoListVO);
		
		if(result > 0){
			return "success";
		}else{
			return "failed";
		}
	}
	
	//메뉴권한 등록
	public void menuAuthorityDelete(AuthorityInfoListVO authorityInfoListVO) throws Exception{
		
		authorityInfoDAO.menuAuthorityDelete(authorityInfoListVO);
	}
	
	//권한정보관리 삭제
	public void authorityInfoDelete(AuthorityInfoListVO authorityInfoListVO) throws Exception{
		
		authorityInfoDAO.authorityInfoDelete(authorityInfoListVO);
	}
	
	//아이디중복확인
	public String processIdDuplication(String id) throws Exception {
		
		//동일 아이디 카운트
		int result = authorityInfoDAO.countSameId(id);

		if(result > 0){
			return "failed";
		}else{
			return "success";
		}
	}
	
}
