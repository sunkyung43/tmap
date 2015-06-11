/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.servermanagement.vo.ComTypeInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 9. 6. 
 */
@Repository
public class ComTypeInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//통신방식 정보 리스트
	public int countComTypeInfoList(ComTypeInfoVO comTypeInfoVO){
		
		return sqlSessionTemplate.selectOne("comTypeInfoSqlMap.countComTypeInfoList", comTypeInfoVO);
	}
	
	//통신방식 정보 리스트
	public List<ComTypeInfoVO> comTypeInfoList(ComTypeInfoVO comTypeInfoVO, int skipResults, int maxResults) throws Exception{
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("comTypeInfoSqlMap.comTypeInfoList", comTypeInfoVO, rowBounds);
	}
	
	//통신방식명 중복체크
	public int checkName(String checkName){
		
		return sqlSessionTemplate.selectOne("comTypeInfoSqlMap.checkName", checkName);
	}
	
	//통신방식 등록
	public int comTypeInsert(ComTypeInfoVO comTypeInfoVO){
		
		return sqlSessionTemplate.insert("comTypeInfoSqlMap.comTypeInsert", comTypeInfoVO);
	}
	
	//ds_com_state 등록
	public void dsComInfoInsert(ComTypeInfoVO comTypeInfoVO){
		
		sqlSessionTemplate.insert("comTypeInfoSqlMap.dsComInfoInsert", comTypeInfoVO);
	}
	
	//comTypeId
	public int comTypeId(String comTypeName) throws Exception{
		
		return sqlSessionTemplate.selectOne("comTypeInfoSqlMap.comTypeId", comTypeName);
	}
	
	//통신방식 Detail
	public ComTypeInfoVO comTypeInfo(String comTypeId){
		
		return sqlSessionTemplate.selectOne("comTypeInfoSqlMap.comTypeInfo", comTypeId);
	}
	
	//통신방식 수정
	public int comTypeUpdate(ComTypeInfoVO comTypeInfoVO){
		
		return sqlSessionTemplate.update("comTypeInfoSqlMap.comTypeUpdate", comTypeInfoVO);
	}
	
	//통신방식 삭제
	public int comTypeDelete(String comTypeId){
		
		return sqlSessionTemplate.update("comTypeInfoSqlMap.comTypeDelete", comTypeId);
	}
}
