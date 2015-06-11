package com.tmap.servermanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.servermanagement.vo.DownloadInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;

@Repository
public class DownloadInfoDAO {

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	//다운로드 서버 정보
	public DownloadInfoVO downloadInfo(String type){
		return sqlSessionTemplate.selectOne("downloadInfoSqlMap.downloadInfo", type);
	}
	

	// 다운로드 서버 리스트
	public List<DownloadInfoVO> downloadInfoList(DownloadInfoVO downloadInfoVO,
			int skipResults, int maxResults) throws Exception {

		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("downloadInfoSqlMap.downloadInfoList", downloadInfoVO,	rowBounds);
	}

	// serverId
	public int serverId() throws Exception {

		return sqlSessionTemplate.selectOne("downloadInfoSqlMap.getServerId");
	}

	// 다운로드 서버 등록
	public int downloadInfoInsert(DownloadInfoVO downloadInfoVO) {

		return sqlSessionTemplate.insert("downloadInfoSqlMap.downloadInfoInsert", downloadInfoVO);
	}


	// 다운로드 서버 수정
	public int downloadUpdate(DownloadInfoVO downloadInfoVO) {
	
		return sqlSessionTemplate.update("downloadInfoSqlMap.downloadUpdate", downloadInfoVO);
	}

	// 다운로드 서버 삭제
	public int downloadDelete(String serverId) {

		return sqlSessionTemplate.update("downloadInfoSqlMap.downloadDelete", serverId);
	}
	
	public List<SystemInfoVO> rsServerList(){
		return sqlSessionTemplate.selectList("downloadInfoSqlMap.rsServerList");
	}
}
