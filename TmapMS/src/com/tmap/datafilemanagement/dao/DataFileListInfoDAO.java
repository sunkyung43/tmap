package com.tmap.datafilemanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.datafilemanagement.vo.DataFileListInfoVO;

@Repository
public class DataFileListInfoDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<DataFileListInfoVO> dataFileListInfoList(String fileVerId) {
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileListSqlMap.dataFileListInfoList", fileVerId);
	}
	
	public DataFileListInfoVO dataFileListInfo(String fileListId) {
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataFileListSqlMap.dataFileListInfo", fileListId);
	}
	
	public int fileInfoInsert(DataFileListInfoVO dataFileListInfoVO) {
		return sqlSessionTemplate.update("com.tmap.sqlMap.dataFileListSqlMap.fileInfoInsert", dataFileListInfoVO);
	}

	public int fileInfoDelete(DataFileListInfoVO dataFileListInfoVO) {
		return sqlSessionTemplate.update("com.tmap.sqlMap.dataFileListSqlMap.fileInfoDelete", dataFileListInfoVO);
	}

	public int fileInfoRequisiteUpdate(DataFileListInfoVO dataFileListInfoVO) {
		return sqlSessionTemplate.update("com.tmap.sqlMap.dataFileListSqlMap.fileInfoRequisiteUpdate", dataFileListInfoVO);
	}
}
