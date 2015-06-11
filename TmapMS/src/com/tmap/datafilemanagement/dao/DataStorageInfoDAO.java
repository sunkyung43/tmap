package com.tmap.datafilemanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.datafilemanagement.vo.DataStorageInfoVO;

@Repository
public class DataStorageInfoDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	public List<DataStorageInfoVO> dataStorageInfoList(DataStorageInfoVO dataStorageInfoVO, int skipResults, int maxResults){
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataStorageSqlMap.dataStorageInfoList", dataStorageInfoVO, rowBounds); 
	}
	
	public int countDataStorageInfoList(DataStorageInfoVO dataStorageInfoVO){
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataStorageSqlMap.countDataStorageInfoList", dataStorageInfoVO);
	}
	
	public List<DataStorageInfoVO> searchConditionDataStorageInfoList(){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataStorageSqlMap.searchConditionDataStorageInfoList"); 
	}

	public List<DataStorageInfoVO> dataStorageInfoListForSelectBox() {
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataStorageSqlMap.dataStorageInfoListForSelectBox"); 
	}
	
	public DataStorageInfoVO dataStorageInfo(DataStorageInfoVO dataStorageInfoVO){
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataStorageSqlMap.dataStorageInfo", dataStorageInfoVO); 
	}
	
	public int dataStorageInfoUpdate(DataStorageInfoVO dataStorageInfoVO){
		return sqlSessionTemplate.update("com.tmap.sqlMap.dataStorageSqlMap.dataStorageInfoUpdate", dataStorageInfoVO);
	}
	
	public int dataStorageInfoDelete(DataStorageInfoVO dataStorageInfoVO){
		return sqlSessionTemplate.update("com.tmap.sqlMap.dataStorageSqlMap.dataStorageInfoDelete", dataStorageInfoVO);
	}
	
	public int dataStorageInfoInsert(DataStorageInfoVO dataStorageInfoVO){
		return sqlSessionTemplate.insert("com.tmap.sqlMap.dataStorageSqlMap.dataStorageInfoInsert", dataStorageInfoVO);
	}
}
