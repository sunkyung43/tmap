/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.appmanagement.vo.AppInfoListVO;
import com.tmap.appmanagement.vo.AppServiceListVO;

/**
 * <br/>
 * 
 * @author 김경민
 * @date 2012. 7. 19.
 */
@Repository
public class AppServiceDAO {

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	// App서비스관리 리스트 수
	public int countAppServiceList(AppServiceListVO appServiceListVO) {

		return sqlSessionTemplate
				.selectOne(
						"com.tmap.appmanagement.sqlmap.appServiceSqlMap.countAppServiceList",
						appServiceListVO);
	}

	// App서비스관리 리스트 출력
	public List<AppServiceListVO> appServiceList(
			AppServiceListVO appServiceListVO, int skipResults, int maxResults) {

		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate
				.selectList(
						"com.tmap.appmanagement.sqlmap.appServiceSqlMap.appServiceList",
						appServiceListVO, rowBounds);
	}

	// 현재 App 리스트
	public List<AppInfoListVO> currentAppList() {

		return sqlSessionTemplate
				.selectList("com.tmap.appmanagement.sqlmap.appServiceSqlMap.currentAppList");
	}

	// 현재 App Version 리스트
	public List<AppInfoListVO> currentAppVerList(String selectCurrentAppSeq) {

		return sqlSessionTemplate
				.selectList(
						"com.tmap.appmanagement.sqlmap.appServiceSqlMap.currentAppVerList",
						selectCurrentAppSeq);
	}

	// 업데이트 App 리스트
	public List<AppInfoListVO> upgradeAppList() {

		return sqlSessionTemplate
				.selectList("com.tmap.appmanagement.sqlmap.appServiceSqlMap.upgradeAppList");
	}

	public List<AppInfoListVO> upgradeAppVerList(AppServiceListVO appServiceListVO) {

		return sqlSessionTemplate
				.selectList("com.tmap.appmanagement.sqlmap.appServiceSqlMap.upgradeAppVerList", appServiceListVO);
	}

	public List<AppServiceListVO> getCurrentOsPhList(String selectAppSeq) {

		return sqlSessionTemplate
				.selectList(
						"com.tmap.appmanagement.sqlmap.appServiceSqlMap.getCurrentOsPhList",
						selectAppSeq);
	}

	public String getAppDownUrl(String selectAppSeq) {

		return sqlSessionTemplate.selectOne(
				"com.tmap.appmanagement.sqlmap.appServiceSqlMap.getAppDownUrl",
				selectAppSeq);
	}

	public List<AppServiceListVO> getUpgradeOsPhList(String selectAppVerId) {

		return sqlSessionTemplate
				.selectList(
						"com.tmap.appmanagement.sqlmap.appServiceSqlMap.getCurrentOsPhList",
						selectAppVerId);
	}

	// App서비스관리 등록
	public int newAppService(AppServiceListVO appServiceListVO) {

		int updateCount = 0;

		String[] checkedOsPh = appServiceListVO.getChoiceCurrent();

		if (checkedOsPh != null) {

			// upgrade_app_info
			sqlSessionTemplate
					.insert("com.tmap.appmanagement.sqlmap.appServiceSqlMap.appInfoInsert",
							appServiceListVO);

			// upgrade_app_info 가장 최근 등록 id
			String appInfoServiceSeq = sqlSessionTemplate
					.selectOne("com.tmap.appmanagement.sqlmap.appServiceSqlMap.appInfoServiceSeq");

			for (int i = 0; i < checkedOsPh.length; i++) {

				String[] splitData = checkedOsPh[i].split("\\|");

				appServiceListVO.setUpgradeType("A");
				appServiceListVO.setPhModelInfoSeq(splitData[0]);
				appServiceListVO.setAppInfoServiceSeq(appInfoServiceSeq);

				updateCount = sqlSessionTemplate
						.insert("com.tmap.appmanagement.sqlmap.appServiceSqlMap.appServiceNew",
								appServiceListVO);

				if (updateCount < 1) {
					return 0;
				}
			}
		}
		return 1;
	}

	public List<AppServiceListVO> getOsPhList(AppServiceListVO editList) {

		return sqlSessionTemplate.selectList(
				"com.tmap.appmanagement.sqlmap.appServiceSqlMap.getOsPhList",
				editList);
	}

	public AppServiceListVO getOsPhAllList(String seq) {

		return sqlSessionTemplate
				.selectOne(
						"com.tmap.appmanagement.sqlmap.appServiceSqlMap.getOsPhAllList",
						seq);
	}

	public AppServiceListVO getAppInfoService(String selectedServiceSeq) {

		return sqlSessionTemplate.selectOne(
				"com.tmap.appmanagement.sqlmap.appServiceSqlMap.detail",
				selectedServiceSeq);
	}

	// App서비스관리 수정
	public boolean editAppService(AppServiceListVO appServiceListVO)
			throws Exception {

		int updateCount = 0;

		String[] choiceOsPhs = appServiceListVO.getChoiceCurrent();

		// 1. 사용여부, 비고, Down URL 수정
		updateCount = sqlSessionTemplate
				.update("com.tmap.appmanagement.sqlmap.appServiceSqlMap.appServiceEdit",
						appServiceListVO);
		if (updateCount < 1) {
			return false;
		}

		// 2. 기존에 등록 된 단말모델정보 삭제
		updateCount = sqlSessionTemplate
				.delete("com.tmap.appmanagement.sqlmap.appServiceSqlMap.appServiceDelete",
						appServiceListVO);
		/*if (updateCount < 1) {
			return false;
		}*/

		// 3. 새로운 단말모델정보 등록
		if (choiceOsPhs != null) {

			for (int i = 0; i < choiceOsPhs.length; i++) {
				if (choiceOsPhs[i] != null) {
					appServiceListVO.setPhModelInfoSeq(choiceOsPhs[i]);
					appServiceListVO.setUpgradeType("A");
					updateCount = sqlSessionTemplate
							.insert("com.tmap.appmanagement.sqlmap.appServiceSqlMap.appServiceNew",
									appServiceListVO);
					if (updateCount < 1) {
						return false;
					}
				}
			}
		}

		return true;

	}

	// App서비스관리 삭제
	public boolean deleteAppService(AppServiceListVO appServiceListVO)
			throws Exception {

		//service 삭제
		sqlSessionTemplate.delete("com.tmap.appmanagement.sqlmap.appServiceSqlMap.appServiceDelete", appServiceListVO);
		sqlSessionTemplate.delete("com.tmap.appmanagement.sqlmap.appServiceSqlMap.delete",appServiceListVO);
		return true;
	}
}
