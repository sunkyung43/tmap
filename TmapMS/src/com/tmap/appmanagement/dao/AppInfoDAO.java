/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.appmanagement.vo.AppInfoListVO;
import com.tmap.appmanagement.vo.TempletModelInfoListVO;

/**
 * <br/>
 * 
 * @author 김경민
 * @date 2012. 7. 13.
 */

@Repository
public class AppInfoDAO {

	@Resource(name = "sqlSessionTemplate")
	SqlSessionTemplate sqlSessionTemplate;

	// App관리 리스트 출력
	public List<AppInfoListVO> appInfoList(AppInfoListVO appInfoListVO,
			int skipResults, int maxResults) {

		// RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.appSqlMap.appInfoList", appInfoListVO);
	}

	// App관리 리스트 수
	public int countAppInfoList(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.selectOne(
				"com.tmap.sqlMap.appSqlMap.countAppInfoList", appInfoListVO);
	}

	public List<Map<String, Object>> rowSpan(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.appSqlMap.rowSpan", appInfoListVO);
	}

	// App관리 등록 - 단말조합 정보 리스트
	public List<TempletModelInfoListVO> searchTempletModel(
			AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.appSqlMap.searchTempletModel", appInfoListVO);
	}

	// App관리 등록 - 단말모델 정보 리스트
	public List<AppInfoListVO> appInfoNew(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.appSqlMap.appInfoNew", appInfoListVO);
	}

	// App관리 등록 - 단말조합 리스트
	public List<TempletModelInfoListVO> templetModel(String templetModelName) {

		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.appSqlMap.templetModel", templetModelName);

	}

	// App관리 등록 - app정보
	public int appInfoInsert(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.insert(
				"com.tmap.sqlMap.appSqlMap.appInfoInsert", appInfoListVO);
	}

	// app정보 마지막 등록된 appinfoseq 정보출력
	public String appInfoSeq(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.selectOne(
				"com.tmap.sqlMap.appSqlMap.appInfoSeq", appInfoListVO);
	}

	// App관리 등록 - 단말모델 등록
	public void osPhInfoInsert(AppInfoListVO appInfoListVO) {

		// 기존 등록된 단말모델 삭제
		sqlSessionTemplate.delete("com.tmap.sqlMap.appSqlMap.osPhInfoDelete",
				appInfoListVO);

		String[] cnt = appInfoListVO.getPhModelIds();
		if (cnt != null) {
			for (int i = 0; i < cnt.length; i++) {

				appInfoListVO.setPhModelId(cnt[i]);
				sqlSessionTemplate.insert(
						"com.tmap.sqlMap.appSqlMap.osPhInfoInsert",
						appInfoListVO);
			}
		}
	}

	// App관리 등록 - 단말모델 등록
	public void osPhInfoUpdate(AppInfoListVO appInfoListVO) {

		String[] cnt1 = appInfoListVO.getCheckboxPhModelInfos();
		String[] cnt2 = appInfoListVO.getOsVerIds();
		String[] cnt3 = appInfoListVO.getPhIds();
		for (int i = 0; i < cnt1.length; i++) {

			appInfoListVO.setPhModelInfoSeq(cnt1[i]);
			appInfoListVO.setOsVerId(cnt2[i]);
			appInfoListVO.setPhId(cnt3[i]);
			sqlSessionTemplate.insert(
					"com.tmap.sqlMap.appSqlMap.osPhInfoInsert", appInfoListVO);
		}
	}

	public int appVerInsert(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.insert(
				"com.tmap.sqlMap.appSqlMap.appVerInsert", appInfoListVO);
	}

	// app정보
	public AppInfoListVO appInfo(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.selectOne(
				"com.tmap.sqlMap.appSqlMap.appInfo", appInfoListVO);
	}

	// app사용 단말모델 정보
	public List<AppInfoListVO> verUseOsPh(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.appSqlMap.verUseOsPh", appInfoListVO);
	}

	// app사용 단말모델을 제외한 전체 단말모델
	public List<AppInfoListVO> allOsPhInfo(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.appSqlMap.allOsPhInfo", appInfoListVO);
	}

	// 버전정보 리스트 수
	public int countAppVerInfoList(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.selectOne(
				"com.tmap.sqlMap.appSqlMap.countAppVerInfoList", appInfoListVO);
	}

	// 버전정보 리스트 출력
	public List<AppInfoListVO> appVerInfoList(AppInfoListVO appInfoListVO,
			int skipResults, int maxResults) throws Exception {

		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.appSqlMap.appVerInfoList", appInfoListVO,
				rowBounds);

	}

	// 버전정보 수정폼
	public AppInfoListVO appVerInfo(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.selectOne(
				"com.tmap.sqlMap.appSqlMap.appVerInfo", appInfoListVO);
	}

	// 버전정보 수정
	public int appVerUpdate(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.update(
				"com.tmap.sqlMap.appSqlMap.appVerUpdate", appInfoListVO);
	}

	// 버전정보 삭제
	public int appVerDelete(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.update(
				"com.tmap.sqlMap.appSqlMap.appVerDelete", appInfoListVO);
	}

	// App관리 수정 - app정보
	public int appInfoUpdate(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.update(
				"com.tmap.sqlMap.appSqlMap.appInfoUpdate", appInfoListVO);
	}

	// 기존 등록된 단말모델 사용여부 변경
	public void osPhInfoDelete(AppInfoListVO appInfoListVO) {

		sqlSessionTemplate.update("com.tmap.sqlMap.appSqlMap.osPhInfoDelete",
				appInfoListVO);

	}

	// App관리 삭제
	public int appInfoDelete(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.delete(
				"com.tmap.sqlMap.appSqlMap.appInfoDelete", appInfoListVO);
	}

	// App Versions 삭제
	public int appVerInfoDeletes(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.delete(
				"com.tmap.sqlMap.appSqlMap.appVerInfoDeletes", appInfoListVO);
	}

	// App_ver_models 삭제
	public int appVerModelDeletes(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.delete(
				"com.tmap.sqlMap.appSqlMap.appVerModelDeletes", appInfoListVO);
	}

	// 버전 상세 정보
	public List<AppInfoListVO> appVerDetail(AppInfoListVO appInfoListVO) {

		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.appSqlMap.appVerDetail", appInfoListVO);
	}
}
