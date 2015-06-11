/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.dao;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.tmap.systemmanagement.vo.RmVersionVO;


/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Repository
public class RmVersionDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//맵 버전 긴급 운영설정
	public RmVersionVO rmVersionList(){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.rmVersionSqlMap.searchRmVersion");
	}
	
	public void rmVersionNewCommit(RmVersionVO rmVersionListVO){
		
		//이전 데이터 상태값 변경
		int result = sqlSessionTemplate.update("com.tmap.sqlMap.rmVersionSqlMap.rmVersionDelete", rmVersionListVO);
		
		if(result > 0){		
			
			//새로운 데이터 등록
			sqlSessionTemplate.insert("com.tmap.sqlMap.rmVersionSqlMap.rmVersionUpdate", rmVersionListVO);
		}
	}
	
}
