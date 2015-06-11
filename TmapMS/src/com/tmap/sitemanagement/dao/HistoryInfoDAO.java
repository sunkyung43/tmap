/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.sitemanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.sitemanagement.vo.HistoryInfoListVO;
import com.tmap.sitemanagement.vo.MenuInfoListVO;
import com.tmap.systemmanagement.vo.ComCodeInfoListVO;


/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */

@Repository
public class HistoryInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//메뉴 리스트
	public List<MenuInfoListVO> menuList() throws Exception{
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.historySqlMap.menuList");
	}
	
	//코드 리스트
	public List<ComCodeInfoListVO> codeList() throws Exception{
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.historySqlMap.codeList");
	}
	
	//히스토리 리스트 출력
	public List<HistoryInfoListVO> historyInfoList(HistoryInfoListVO historyInfoListVO, int skipResults, int maxResults){
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.historySqlMap.historyInfoList", historyInfoListVO, rowBounds); 
		
	}
	
	//히스토리 리스트 수
	public int countHistoryInfoList(HistoryInfoListVO historyInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.historySqlMap.countHistoryInfoList", historyInfoListVO);
		
	}

	//히스토리 입력
	public boolean insertHistory(HistoryInfoListVO historyInfoListVO) throws Exception{
		return sqlSessionTemplate.insert("com.tmap.sqlMap.historySqlMap.insert", historyInfoListVO) > 0;
	}
}
