/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.appmanagement.vo.PhInfoListVO;
import com.tmap.servermanagement.vo.SystemInfoVO;

/**
 * <br/>
 * 
 * @author 김경민
 * @date 2012. 7. 13.
 */
@Repository
public class PhInfoDAO {

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	// 단말정보 리스트 수
	public int countPhInfoList(PhInfoListVO phInfoListVO) {

		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.phInfoSqlMap.countPhInfoList", phInfoListVO);
	}
		
	// 단말정보 리스트 출력 (단말 정보)
	public List<PhInfoListVO> phInfoList(PhInfoListVO phInfoListVO, int skipResults, int maxResults) {

		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.phInfoSqlMap.phInfoList", phInfoListVO, rowBounds);

	}

	public List<PhInfoListVO> phMadeList(PhInfoListVO phInfoListVO) {

		return sqlSessionTemplate.selectList("com.tmap.sqlMap.phInfoSqlMap.phMadeList", phInfoListVO);

	}
	
	// 리스트 출력 ----------------------------------------------------------
	public List<PhInfoListVO> phOsInfoList(PhInfoListVO phInfoListVO) throws Exception {

		//RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.phInfoSqlMap.phOsInfo", phInfoListVO);
		//return sqlSessionTemplate.selectList("com.tmap.sqlMap.phInfoSqlMap.phOsInfo", phInfoListVO, rowBounds);
	}

	// 단말정보 등록
	public void phInfoInsert(PhInfoListVO phInfoListVO) {

		sqlSessionTemplate.insert("com.tmap.sqlMap.phInfoSqlMap.phInfoInsert",
				phInfoListVO);
	}

	// 단말정보 수정 정보 출력
	public PhInfoListVO phModifyList(PhInfoListVO phInfoListVO) {

		return sqlSessionTemplate.selectOne(
				"com.tmap.sqlMap.phInfoSqlMap.phModifyList", phInfoListVO);

	}

	// 단말정보 수정
	public int phInfoUpdate(PhInfoListVO phInfoListVO) {

		return sqlSessionTemplate.update("com.tmap.sqlMap.phInfoSqlMap.phInfoUpdate",
				phInfoListVO);
	}

	// 단말정보 삭제
	public int phInfoDelete(PhInfoListVO phInfoListVO) {

		return sqlSessionTemplate.update("com.tmap.sqlMap.phInfoSqlMap.phInfoDelete",
				phInfoListVO);
	}
}