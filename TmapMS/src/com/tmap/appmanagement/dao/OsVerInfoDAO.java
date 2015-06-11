/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.appmanagement.vo.OsVerInfoListVO;




/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */

@Repository
public class OsVerInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//OS버전정보 리스트 출력 (단말모델)
	public List<OsVerInfoListVO> phOsVerInfoList(OsVerInfoListVO osVerInfoListVO){
		
		//RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.osVerInfoSqlMap.phOsVerInfoList", osVerInfoListVO); 
	}
	
	//OS버전정보 리스트 출력
	public List<OsVerInfoListVO> osVerInfoFrame(OsVerInfoListVO osVerInfoListVO, int skipResults, int maxResults){
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.osVerInfoSqlMap.osVerInfoFrame", osVerInfoListVO, rowBounds); 
	}
	
	//OS버전정보 리스트 수
	public int countOsVerInfoList(OsVerInfoListVO osVerInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.osVerInfoSqlMap.countOsVerInfoList", osVerInfoListVO);
	}
	
	//OS버전정보 등록
	public int osVerInfoInsert(OsVerInfoListVO osVerInfoListVO){
		
		return sqlSessionTemplate.insert("com.tmap.sqlMap.osVerInfoSqlMap.osVerInfoInsert", osVerInfoListVO);
	}
	
	//OS버전정보 수정 정보 출력
	public OsVerInfoListVO osVerModifyList(OsVerInfoListVO osVerInfoListVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.osVerInfoSqlMap.osVerModifyList", osVerInfoListVO);
	}
	
	//OS버전정보 수정
	public int osVerInfoUpdate(OsVerInfoListVO osVerInfoListVO){
		
		return sqlSessionTemplate.update("com.tmap.sqlMap.osVerInfoSqlMap.osVerInfoUpdate", osVerInfoListVO);
	}
	
	//OS버전정보 삭제
	public int osVerInfoDelete(OsVerInfoListVO osVerInfoListVO){
		
		return sqlSessionTemplate.update("com.tmap.sqlMap.osVerInfoSqlMap.osVerInfoDelete", osVerInfoListVO);
	}
}