/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.dao;

import java.util.List;

import javax.annotation.Resource;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.servermanagement.vo.SystemInfoVO;


/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Repository
public class MapDownServiceDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//서버기기 정보
	public List<SystemInfoVO> systemInfo(){
		
		return sqlSessionTemplate.selectList("mapDownServiceSqlMap.systemInfo");
	}
	
	//상세 접속 정보(서버기기 정보)
	public SystemInfoVO systemDetailInfo(String systemId){
		
		return sqlSessionTemplate.selectOne("mapDownServiceSqlMap.systemDetailInfo", systemId);
	}
	
	//상세 접속 정보(통신방식 정보)
	public List<SystemInfoVO> comSetInfo(String systemId){
		
		return sqlSessionTemplate.selectList("mapDownServiceSqlMap.comSetInfo", systemId);
	}
	
	//상세 접속 정보(서비스 운영 정보)
	public SystemInfoVO mapManageInfo(String systemId){
		
		return sqlSessionTemplate.selectOne("mapDownServiceSqlMap.mapManageInfo", systemId);
	}
	
	//통신방식 정보 수정
	public int comSetUpdate(SystemInfoVO systemInfoVO){
		
		String[] cnt1 = systemInfoVO.getComSetCnts();
		String[] cnt2 = systemInfoVO.getComTypeCodes();
		
		int result = 0;
		
		for(int i = 0; i< cnt1.length; i++){
			
			systemInfoVO.setComSetCnt(cnt1[i]);
			systemInfoVO.setComTypeCode(cnt2[i]);
			
			result = sqlSessionTemplate.update("mapDownServiceSqlMap.comSetUpdate", systemInfoVO);
		}
		
		return result;
	}
	
	//서비스 운영 정보 수정
	public void mapManageUpdate(SystemInfoVO systemInfoVO){
		
		sqlSessionTemplate.update("mapDownServiceSqlMap.mapManageUpdate", systemInfoVO);
	}
}
