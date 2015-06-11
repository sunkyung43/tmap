/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.tmap.systemmanagement.vo.ComCodeInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 19. 
 */
@Repository
public class ComCodeInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//공통코드관리 리스트 수
	public int countComCodeInfoList(ComCodeInfoListVO comCodeInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.countComCodeInfoList", comCodeInfoListVO);
	}
	
	//공통코드관리 리스트 출력
	public List<ComCodeInfoListVO> comCodeInfoList(ComCodeInfoListVO comCodeInfoListVO, int skipResults, int maxResults){
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.comCodeInfoList", comCodeInfoListVO, rowBounds);
	}
	
	//공통코드관리 등록
	public void comCodeInfoInsert(ComCodeInfoListVO comCodeInfoListVO){
		
		sqlSessionTemplate.insert("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.comCodeInfoInsert", comCodeInfoListVO);
	}
	
	public void comCodeInsert(ComCodeInfoListVO comCodeInfoListVO){
		
		sqlSessionTemplate.insert("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.comCodeInsert", comCodeInfoListVO);
	}
	
	public List<ComCodeInfoListVO> comCodeCountList(ComCodeInfoListVO comCodeInfoListVO){
		
		return sqlSessionTemplate.selectList("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.comCodeCountList", comCodeInfoListVO);
	}
	
	//공통코드관리 상세정보
	public ComCodeInfoListVO comCodeInfoDetail(ComCodeInfoListVO comCodeInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.comCodeInfoDetail", comCodeInfoListVO);
	}
	
	//공통코드관리 상세정보2
	public List<ComCodeInfoListVO> comCodeDetail(ComCodeInfoListVO comCodeInfoListVO){
		
		return sqlSessionTemplate.selectList("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.comCodeDetail", comCodeInfoListVO);
	}
	
	//공통코드관리 수정
	public void comCodeInfoUpdate(ComCodeInfoListVO comCodeInfoListVO){
		
		sqlSessionTemplate.update("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.comCodeInfoUpdate", comCodeInfoListVO);
	}
	
	//공통코드관리 삭제
	public void comCodeInfoDelete(ComCodeInfoListVO comCodeInfoListVO){
		
		//상위코드 삭제
		sqlSessionTemplate.update("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.comCodeInfoDelete", comCodeInfoListVO);
		
		//하위코드 삭제
		sqlSessionTemplate.update("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.comCodeInfoDelete2", comCodeInfoListVO);
	}
	
	//소분류코드 사용유무 변경
	public int comCodeInfoUseState(ComCodeInfoListVO comCodeInfoListVO){
		
		return sqlSessionTemplate.update("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.comCodeInfoUseState", comCodeInfoListVO);
	}
	
	//아이디중복확인
	public int countSameId(String id) throws Exception {
		return sqlSessionTemplate.selectOne("com.tmap.systemmanagement.pkgsqlmap.comCodeSqlMap.countSameId", id);
	}
}
