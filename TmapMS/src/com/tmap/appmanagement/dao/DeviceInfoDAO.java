/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.dao;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.appmanagement.vo.PhModelInfoListVO;



/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */
@Repository
public class DeviceInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	public int checkPhmodelInfo(PhModelInfoListVO phModelInfoListVO) throws Exception {
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.deviceInfoSqlMap.checkPhmodelInfo", phModelInfoListVO);
	}
	
	public void newPhModelInfo(PhModelInfoListVO phModelInfoListVO) throws Exception {
		
		String[] osVerInfoSeq = phModelInfoListVO.getCheckOsVerIds();
		
		for(int i = 0; i < osVerInfoSeq.length; i++){
			
			phModelInfoListVO.setOsVerInfoSeq(osVerInfoSeq[i]);
			
			sqlSessionTemplate.insert("com.tmap.sqlMap.deviceInfoSqlMap.newPhModelInfo", phModelInfoListVO);
		
		}
	}
	
	
}
