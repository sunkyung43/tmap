/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.sitemanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.sitemanagement.vo.AuthorityInfoListVO;
import com.tmap.sitemanagement.vo.MenuInfoListVO;


/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Repository
public class AuthorityInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//권한정보관리 리스트 출력
	public List<AuthorityInfoListVO> authorityInfoList(AuthorityInfoListVO authorityInfoListVO, int skipResults, int maxResults){
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.authoritySqlMap.authorityInfoList", authorityInfoListVO, rowBounds); 
	}
	
	//권한정보관리 리스트 수
	public int countAuthorityInfoList(AuthorityInfoListVO authorityInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.authoritySqlMap.countAuthorityInfoList", authorityInfoListVO);
	}
	
	//메뉴 리스트 출력
	public List<MenuInfoListVO> menuList(){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.authoritySqlMap.menuList");
	}
	
	//권한정보관리 등록
	public int authorityInfoInsert(AuthorityInfoListVO authorityInfoListVO){
		
		return sqlSessionTemplate.insert("com.tmap.sqlMap.authoritySqlMap.authorityInfoInsert", authorityInfoListVO);
	}
	
	//메뉴권한 등록
	public void menuAuthorityInsert(AuthorityInfoListVO authorityInfoListVO, String[] menuList){
		
		for(int i=0; i<menuList.length; i++){
			
			authorityInfoListVO.setMenuId(menuList[i]);
			
			sqlSessionTemplate.insert("com.tmap.sqlMap.authoritySqlMap.menuAuthorityInsert", authorityInfoListVO);
		}
	}
	
	//권한정보관리 수정 정보 출력
	public AuthorityInfoListVO authorityModifyList(AuthorityInfoListVO authorityInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.authoritySqlMap.authorityModifyInfo", authorityInfoListVO);
	}
	
	public List<MenuInfoListVO> menuId(AuthorityInfoListVO authorityInfoListVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.authoritySqlMap.menuId", authorityInfoListVO);
	}
	
	//권한정보관리 수정
	public int authorityInfoUpdate(AuthorityInfoListVO authorityInfoListVO){
		
		return sqlSessionTemplate.update("com.tmap.sqlMap.authoritySqlMap.authorityInfoUpdate", authorityInfoListVO);
	}
	
	//메뉴권한 수정
	public void menuAuthorityDelete(AuthorityInfoListVO authorityInfoListVO){
		
		sqlSessionTemplate.delete("com.tmap.sqlMap.authoritySqlMap.menuAuthorityDelete", authorityInfoListVO);
	}
	
	//권한정보관리 삭제
	public void authorityInfoDelete(AuthorityInfoListVO authorityInfoListVO){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.authoritySqlMap.authorityInfoDelete", authorityInfoListVO);
	}
	
	//아이디중복확인
	public int countSameId(String id){
	
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.authoritySqlMap.countSameId", id);
	}
	
}
