package com.tmap.datafilemanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.datafilemanagement.vo.FileVersionInfoVO;

@Repository
public class FileVersionInfoDAO {
	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	public List<FileVersionInfoVO> fileVersionInfoList(String dataFileId) {
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.fileVersionSqlMap.fileVersionInfoList", dataFileId); 
	}

	public FileVersionInfoVO fileVersionInfo(String fileVerId) {
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.fileVersionSqlMap.fileVersionInfo", fileVerId); 
	}

	public int fileVersionInfoUpdate(FileVersionInfoVO fileVersionInfoVO) {
		return sqlSessionTemplate.update("com.tmap.sqlMap.fileVersionSqlMap.fileVersionInfoUpdate", fileVersionInfoVO); 
	}

	public int fileVersionInfoInsert(FileVersionInfoVO fileVersionInfoVO) {
		return sqlSessionTemplate.insert("com.tmap.sqlMap.fileVersionSqlMap.fileVersionInfoInsert", fileVersionInfoVO); 
	}

	public int fileVersionInfoDelete(String fileVerId) {
		return sqlSessionTemplate.update("com.tmap.sqlMap.fileVersionSqlMap.fileVersionInfoDelete", fileVerId);
	}
}
