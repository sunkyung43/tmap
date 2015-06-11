package com.tmap.datafilemanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.datafilemanagement.vo.DataTypeInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;

@Repository
public class DataTypeInfoDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<DataTypeInfoVO> dataTypeInfoList(DataTypeInfoVO dataTypeInfoVO, int skipResults, int maxResults){
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataTypeSqlMap.dataTypeInfoList", dataTypeInfoVO, rowBounds); 
	}
	
	public int countDataTypeInfoList(DataTypeInfoVO dataTypeInfoVO){
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataTypeSqlMap.countDataTypeInfoList", dataTypeInfoVO);
	}
	
	public List<DataTypeInfoVO> searchConditionDataTypeInfoList(){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataTypeSqlMap.searchConditionDataTypeInfoList"); 
	}
	
	public List<DataTypeInfoVO> dataTypeInfoListForSelectBox(){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataTypeSqlMap.dataTypeInfoListForSelectBox"); 
	}

	public DataTypeInfoVO dataTypeInfo(DataTypeInfoVO dataTypeInfoVO){
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataTypeSqlMap.dataTypeInfo", dataTypeInfoVO); 
	}
	
	public int dataTypeInfoUpdate(DataTypeInfoVO dataTypeInfoVO){
		return sqlSessionTemplate.update("com.tmap.sqlMap.dataTypeSqlMap.dataTypeInfoUpdate", dataTypeInfoVO);
	}
	
	public int dataTypeInfoDelete(DataTypeInfoVO dataTypeInfoVO){
		return sqlSessionTemplate.update("com.tmap.sqlMap.dataTypeSqlMap.dataTypeInfoDelete", dataTypeInfoVO);
	}
	
	public int dataTypeInfoInsert(DataTypeInfoVO dataTypeInfoVO){
		return sqlSessionTemplate.insert("com.tmap.sqlMap.dataTypeSqlMap.dataTypeInfoInsert", dataTypeInfoVO);
	}
}
