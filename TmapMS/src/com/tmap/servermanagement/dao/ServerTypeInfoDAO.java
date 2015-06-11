/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import com.tmap.servermanagement.vo.ServerTypeInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Repository
public class ServerTypeInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//서버 구분 정보 리스트
	public int countServerTypeInfoList(ServerTypeInfoVO serverTypeInfoVO){
		
		return sqlSessionTemplate.selectOne("serverTypeInfoSqlMap.countServerTypeInfoList", serverTypeInfoVO);
	}
	
	//서버 구분 정보 리스트
	public List<ServerTypeInfoVO> serverTypeInfoList(ServerTypeInfoVO serverTypeInfoVO, int skipResults, int maxResults) throws Exception{
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("serverTypeInfoSqlMap.serverTypeInfoList", serverTypeInfoVO, rowBounds);
	}
	
	//타입명 중복체크
	public int checkType(String checkType){
		
		return sqlSessionTemplate.selectOne("serverTypeInfoSqlMap.checkType", checkType);
	}
	
	//코드명 중복체크
	public int checkCode(String checkCode){
		
		return sqlSessionTemplate.selectOne("serverTypeInfoSqlMap.checkCode", checkCode);
	}
	
	//서버 구분 등록
	public int serverTypeInsert(ServerTypeInfoVO serverTypeInfoVO){
		
		return sqlSessionTemplate.insert("serverTypeInfoSqlMap.serverTypeInsert", serverTypeInfoVO);
	}
	
	//serverTypeId
	public int serverTypeId(String serverTypeName) throws Exception{
		
		return sqlSessionTemplate.selectOne("serverTypeInfoSqlMap.serverTypeId", serverTypeName);
	}
	
	//서버 구분 Detail
	public ServerTypeInfoVO serverTypeInfo(String serverTypeId){
		
		return sqlSessionTemplate.selectOne("serverTypeInfoSqlMap.serverTypeInfo", serverTypeId);
	}
	
	//서버 구분 등록
	public int serverTypeUpdate(ServerTypeInfoVO serverTypeInfoVO){
		
		return sqlSessionTemplate.update("serverTypeInfoSqlMap.serverTypeUpdate", serverTypeInfoVO);
	}
	
	//서버 구분 삭제
	public int serverTypeDelete(String serverTypeId){
		
		return sqlSessionTemplate.update("serverTypeInfoSqlMap.serverTypeDelete", serverTypeId);
	}
}
