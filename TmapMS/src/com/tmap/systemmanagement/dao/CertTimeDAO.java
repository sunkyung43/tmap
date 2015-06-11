/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.dao;


import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.tmap.systemmanagement.vo.CertTimeVO;



/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */

@Repository
public class CertTimeDAO {

	@Resource(name="sqlSessionTemplate")
	SqlSessionTemplate sqlSessionTemplate;
	
	/** 
	 * @param sqlSessionTemplate the sqlSessionTemplate to set 
	 */
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	
	//기존 인증 시간
	public CertTimeVO certTime() throws Exception{
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.certTimeSqlMap.certTime");
	}
	
	//기존 보안 코드
	public CertTimeVO securityCode() throws Exception{
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.certTimeSqlMap.securityCode");
	}
	
	//기존 인증 시간 삭제
	public void certTimeDelete(CertTimeVO certTimeVO) throws Exception{
		
		sqlSessionTemplate.update("com.tmap.sqlMap.certTimeSqlMap.certTimeDelete", certTimeVO);
	}
	
	//인증 시간 수정
	public void certTimeUpdate(CertTimeVO certTimeVO) throws Exception{
		
		sqlSessionTemplate.insert("com.tmap.sqlMap.certTimeSqlMap.certTimeUpdate", certTimeVO);
	}
	
	//기존 보안 코드 삭제
	public void securityCodeDelete(CertTimeVO certTimeVO) throws Exception{
		
		sqlSessionTemplate.update("com.tmap.sqlMap.certTimeSqlMap.securityCodeDelete", certTimeVO);
	}
	
	//보안 코드 수정
	public void securityCodeUpdate(CertTimeVO certTimeVO) throws Exception{
		
		sqlSessionTemplate.insert("com.tmap.sqlMap.certTimeSqlMap.securityCodeUpdate", certTimeVO);
	}
	
}
