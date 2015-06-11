/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.appmanagement.dao.AppServiceDAO;
import com.tmap.appmanagement.vo.AppInfoListVO;
import com.tmap.appmanagement.vo.AppServiceListVO;

/**
 * <br/>
 * 
 * @author 김경민
 * @date 2012. 7. 19.
 */
@Service
public class AppServiceService {

	private boolean isSuccess;

	@Autowired
	AppServiceDAO appServiceDAO;

	// App서비스관리 리스트 출력
	public List<AppServiceListVO> appServiceList(
			AppServiceListVO appServiceListVO) throws Exception {

		// 리스트 수를 조회하여 설정
		int totalCount = appServiceDAO.countAppServiceList(appServiceListVO);
		appServiceListVO.setTotalCount(totalCount);

		List<AppServiceListVO> appServiceList = appServiceDAO.appServiceList(
				appServiceListVO, appServiceListVO.getStartRowNum(),
				appServiceListVO.getCountPerPage());

		return appServiceList;
	}

	// 현재 App 리스트
	public List<AppInfoListVO> currentAppList() throws Exception {

		List<AppInfoListVO> currentAppList = appServiceDAO.currentAppList();

		return currentAppList;
	}

	public List<AppInfoListVO> currentAppVerList(String selectCurrentAppSeq)
			throws Exception {

		List<AppInfoListVO> currentAppVerList = appServiceDAO
				.currentAppVerList(selectCurrentAppSeq);
		return currentAppVerList;
	}

	public List<AppServiceListVO> getCurrentOsPhList(String selectAppSeq)
			throws Exception {

		List<AppServiceListVO> getCurrentOsPhList = appServiceDAO
				.getCurrentOsPhList(selectAppSeq);
		return getCurrentOsPhList;
	}

	public String getAppDownUrl(String selectAppSeq) throws Exception {

		String getAppDownUrl = appServiceDAO.getAppDownUrl(selectAppSeq);
		return getAppDownUrl;
	}

	public List<AppServiceListVO> getUpgradeOsPhList(String selectAppVerId)
			throws Exception {

		List<AppServiceListVO> getUpgradeOsPhList = appServiceDAO
				.getUpgradeOsPhList(selectAppVerId);
		return getUpgradeOsPhList;
	}

	// 업데이트 App 리스트
	public List<AppInfoListVO> upgradeAppList() throws Exception {

		List<AppInfoListVO> upgradeAppList = appServiceDAO.upgradeAppList();

		return upgradeAppList;
	}

	public List<AppInfoListVO> upgradeAppVerList(AppServiceListVO appServiceListVO)
			throws Exception {

		List<AppInfoListVO> upgradeAppVerList = appServiceDAO
				.upgradeAppVerList(appServiceListVO);

		return upgradeAppVerList;
	}

	public String newAppService(AppServiceListVO appServiceListVO)
			throws Exception {
		String returnMessage = "";

		int reuslt = appServiceDAO.newAppService(appServiceListVO);

		if (reuslt > 0) {
			returnMessage = "등록 되었습니다.";
		} else {
			if (reuslt < 0) {
				returnMessage = "어플리케이션 [" + appServiceListVO.getAppName()
						+ "] → 업그레이드 어플리케이션 ["
						+ appServiceListVO.getAppUpName() + "]는\n" + "어플리케이션 ["
						+ appServiceListVO.getAppUpName()
						+ "] → 업그레이드 어플리케이션 [" + appServiceListVO.getAppName()
						+ "]\n 서비스 삭제 후에 등록할 수 있습니다.";
			} else {
				returnMessage = "등록 실패 되었습니다.";
			}
		}

		return returnMessage;
	}

	public List<AppServiceListVO> getOsPhList(AppServiceListVO editList)
			throws Exception {

		return appServiceDAO.getOsPhList(editList);
	}

	public AppServiceListVO getOsPhAllList(String seq) throws Exception {

		return appServiceDAO.getOsPhAllList(seq);
	}

	public AppServiceListVO getAppInfoService(String selectedServiceSeq)
			throws Exception {

		AppServiceListVO editList = appServiceDAO
				.getAppInfoService(selectedServiceSeq);
		return editList;
	}

	public String editAppService(AppServiceListVO appServiceListVO)
			throws Exception {
		String returnMessage = null;
		if (appServiceDAO.editAppService(appServiceListVO)) {
			returnMessage = "수정 되었습니다.";
			isSuccess = true;
		} else {
			returnMessage = "수정 실패 되었습니다.";
		}

		return returnMessage;
	}

	public String deleteAppService(AppServiceListVO appServiceListVO)
			throws Exception {

		String returnMessage = null;

		if (appServiceDAO.deleteAppService(appServiceListVO)) {
			returnMessage = "삭제 되었습니다.";
		} else {
			returnMessage = "삭제 실패 되었습니다.";
		}

		return returnMessage;
	}

	public boolean isSuccess() {
		return isSuccess;
	}
}
