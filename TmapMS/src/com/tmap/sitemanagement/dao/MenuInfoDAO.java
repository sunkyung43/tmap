/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.sitemanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.tmap.sitemanagement.vo.MenuInfoListVO;


/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Repository
public class MenuInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//메뉴관리 리스트 출력
	public List<MenuInfoListVO> menuInfoList(MenuInfoListVO menuInfoListVO, int skipResults, int maxResults){
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.menuSqlMap.menuInfoList", menuInfoListVO, rowBounds); 
	}
	
	//메뉴관리 리스트 수
	public int countMenuInfoList(MenuInfoListVO menuInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.menuSqlMap.countMenuInfoList", menuInfoListVO);
	}
	
	//상위메뉴 리스트 출력
	public List<MenuInfoListVO> hMenuList(){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.menuSqlMap.hMenuList");
	}
	
	//메뉴관리 등록
	public void menuInfoInsert(MenuInfoListVO menuInfoListVO){
		
		sqlSessionTemplate.insert("com.tmap.sqlMap.menuSqlMap.menuInfoInsert", menuInfoListVO);
	}
	
	//메뉴관리 수정 정보 출력
	public MenuInfoListVO menuModifyList(MenuInfoListVO menuInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.menuSqlMap.menuModifyInfo", menuInfoListVO);
	}
	
	//메뉴관리 수정
	public int menuInfoUpdate(MenuInfoListVO menuInfoListVO){
		
		return sqlSessionTemplate.update("com.tmap.sqlMap.menuSqlMap.menuInfoUpdate", menuInfoListVO);
	}
	
	//메뉴관리 삭제
	public void menuInfoDelete(MenuInfoListVO menuInfoListVO){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.menuSqlMap.menuInfoDelete", menuInfoListVO);
	}
	
	public int countSameId(String id) throws Exception {
	
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.menuSqlMap.countSameId", id);
	}
	
	
}
