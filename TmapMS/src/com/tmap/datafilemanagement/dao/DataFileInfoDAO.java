package com.tmap.datafilemanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.datafilemanagement.vo.DataFileInfoVO;

@Repository
public class DataFileInfoDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	public List<DataFileInfoVO> dataFileInfoList(DataFileInfoVO dataFileInfoVO, int skipResults, int maxResults){
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileSqlMap.dataFileInfoList", dataFileInfoVO, rowBounds); 
	}
	
	public int countDataFileInfoList(DataFileInfoVO dataFileInfoVO){
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataFileSqlMap.countDataFileInfoList", dataFileInfoVO);
	}

	public DataFileInfoVO dataFileInfo(String dataFileId) {
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataFileSqlMap.dataFileInfo", dataFileId);
	}

	public int dataFileInfoInsert(DataFileInfoVO dataFileInfoVO) {
		return sqlSessionTemplate.insert("com.tmap.sqlMap.dataFileSqlMap.dataFileInfoInsert", dataFileInfoVO);
	}
	
	public int dataFileInfoUpdate(DataFileInfoVO dataFileInfoVO) {
		return sqlSessionTemplate.update("com.tmap.sqlMap.dataFileSqlMap.dataFileInfoUpdate", dataFileInfoVO);
	}
	
	public int dataFileInfoDelete(String dataFileId) {
		return sqlSessionTemplate.update("com.tmap.sqlMap.dataFileSqlMap.dataFileInfoDelete", dataFileId);
	}
}
