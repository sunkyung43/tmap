/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.controller;

import java.util.ArrayList;
import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tmap.appmanagement.service.AppServiceService;
import com.tmap.appmanagement.vo.AppInfoListVO;
import com.tmap.appmanagement.vo.AppServiceListVO;
import com.tmap.sitemanagement.service.HistoryInfoService;

/**
 * <br/>
 * 
 * @author 김경민
 * @date 2012. 7. 19.
 */

@Controller
public class AppServiceController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory
			.getLogger(AppServiceController.class);

	@Autowired
	AppServiceService appServiceService;

	@Autowired
	HistoryInfoService historyInfoService;

	private List<AppServiceListVO> currentOsPhs;
	private List<AppServiceListVO> upgradeOsPhs;
	private int currentOsPhsSize = 0;
	private int upgreadOsPhsSize = 0;

	// App서비스관리 리스트 출력
	@RequestMapping("/appServiceList")
	public String appServiceList(
			@ModelAttribute("ContentsForm") @Valid AppServiceListVO appServiceListVO,
			BindingResult bindingResult, Model model) throws Exception {

		if (appServiceListVO.getAppName() == null) {
			appServiceListVO.setAppName("");
		}

		if (appServiceListVO.getAppUpName() == null) {
			appServiceListVO.setAppUpName("");
		}

		List<AppServiceListVO> appServiceList = appServiceService
				.appServiceList(appServiceListVO);
		model.addAttribute("appServiceList", appServiceList);
		return "jsp/appmanagement/appservice/appServiceList";
	}

	// App서비스관리 등록폼
	@RequestMapping("/appServiceNew")
	public String appServiceNew(
			@ModelAttribute("ContentsForm") @Valid AppServiceListVO appServiceListVO,
			BindingResult bindingResult, Model model) throws Exception {

		// 현재 App 리스트
		List<AppInfoListVO> currentAppList = appServiceService.currentAppList();
		// 업데이트 App 리스트
		List<AppInfoListVO> upgradeAppList = appServiceService.upgradeAppList();

		String selectCurrentAppSeq = "";
		String selectCurrentAppVerId = "";
		String selectUpgradeAppSeq = "";
		String selectUpgradeAppVerId = "";
		String appDownURL = "";

		if (appServiceListVO.getSelectUpgradeAppSeq() == null) {
			upgradeOsPhs = new ArrayList<AppServiceListVO>();

			if (appServiceListVO.getSelectCurrentAppSeq() == null) {
				currentOsPhs = new ArrayList<AppServiceListVO>();
			} else {
				selectCurrentAppSeq = appServiceListVO.getSelectCurrentAppSeq();
				selectCurrentAppVerId = appServiceListVO
						.getSelectCurrentAppVerId();
				currentOsPhs = appServiceService
						.getCurrentOsPhList(appServiceListVO
								.getSelectCurrentAppSeq());
			}
		} else {
			selectCurrentAppSeq = appServiceListVO.getSelectCurrentAppSeq();
			// 선택된 버전 리스트
			List<AppInfoListVO> currentAppVerList = appServiceService
					.currentAppVerList(selectCurrentAppSeq);
			selectCurrentAppVerId = appServiceListVO.getSelectCurrentAppVerId();
			// 업그레이드 앱 리스트
			selectUpgradeAppSeq = appServiceListVO.getSelectUpgradeAppSeq();
			selectUpgradeAppVerId = appServiceListVO.getSelectUpgradeAppVerId();
			List<AppInfoListVO> upgradeAppVerList = appServiceService
					.upgradeAppVerList(appServiceListVO);

			upgradeOsPhs = appServiceService
					.getUpgradeOsPhList(appServiceListVO
							.getSelectUpgradeAppVerId());
			currentOsPhs = makeOsPhsNewForm(
					appServiceService.getCurrentOsPhList(appServiceListVO
							.getSelectCurrentAppVerId()), upgradeOsPhs);
			appDownURL = appServiceService.getAppDownUrl(appServiceListVO
					.getSelectUpgradeAppSeq());
			model.addAttribute("currentAppVerList", currentAppVerList);
			model.addAttribute("upgradeAppVerList", upgradeAppVerList);
		}

		currentOsPhsSize = currentOsPhs.size();
		upgreadOsPhsSize = upgradeOsPhs.size();

		model.addAttribute("currentAppList", currentAppList);
		model.addAttribute("upgradeAppList", upgradeAppList);
		model.addAttribute("currentOsPhs", currentOsPhs);
		model.addAttribute("upgradeOsPhs", upgradeOsPhs);
		model.addAttribute("selectCurrentAppSeq", selectCurrentAppSeq);
		model.addAttribute("selectCurrentAppVerId", selectCurrentAppVerId);
		model.addAttribute("selectUpgradeAppSeq", selectUpgradeAppSeq);
		model.addAttribute("selectUpgradeAppVerId", selectUpgradeAppVerId);
		model.addAttribute("appDownURL", appDownURL);
		model.addAttribute("currentOsPhsSize", currentOsPhsSize);
		model.addAttribute("upgreadOsPhsSize", upgreadOsPhsSize);

		return "jsp/appmanagement/appservice/appServiceNew";
	}

	// 업데이트 App 변경시 현재 App 상태 변경 반환 메소드
	private List<AppServiceListVO> makeOsPhsNewForm(
			List<AppServiceListVO> currentOsPhs,
			List<AppServiceListVO> upgradeOsPhs) {

		ArrayList<AppServiceListVO> totalOsPhs = new ArrayList<AppServiceListVO>();

		for (AppServiceListVO currentApp : currentOsPhs) {

			boolean isCompare = false;

			for (AppServiceListVO upgradeApp : upgradeOsPhs) {

				isCompare = currentApp.getPhModelInfoSeq().equals(
						upgradeApp.getPhModelInfoSeq());

				if (isCompare) {
					currentApp.setPhInfoSeq(upgradeApp.getPhInfoSeq());
					currentApp.setOsVerInfoSeq(upgradeApp.getOsVerInfoSeq());
					currentApp.setDuplicate("Y");
					currentApp.setCheckYn("Y");
					break;

				} else {
					currentApp.setDuplicate("N");
					currentApp.setCheckYn("N");
				}

			}

			totalOsPhs.add(currentApp);
		}

		return totalOsPhs;
	}

	// App서비스관리 등록
	@RequestMapping("/appServiceInsert")
	public String appServiceInsert(
			@ModelAttribute("ContentsForm") @Valid AppServiceListVO appServiceListVO,
			BindingResult bindingResult, Model model) throws Exception {

		String message = appServiceService.newAppService(appServiceListVO);

		// model.addAttribute("message", message);

		return "redirect:appServiceList.do";
	}

	// App서비스관리 수정폼
	@RequestMapping("/appServiceEdit")
	public String appServiceEdit(
			@ModelAttribute("ContentsForm") @Valid AppServiceListVO appServiceListVO,
			BindingResult bindingResult, Model model) throws Exception {

		AppServiceListVO editList = appServiceService
				.getAppInfoService(appServiceListVO.getAppInfoServiceSeq());

		upgradeOsPhs = appServiceService.getUpgradeOsPhList(editList
				.getAppUpVerId());
		currentOsPhs = makeOsPhsEditForm(appServiceService
				.getOsPhList(editList));

		String selectCurrentAppSeq = "";
		String selectUpgradeAppSeq = "";

		selectCurrentAppSeq = editList.getAppInfoSeq();
		selectUpgradeAppSeq = editList.getAppUpSeq();

		model.addAttribute("upgradeOsPhs", upgradeOsPhs);
		model.addAttribute("currentOsPhs", currentOsPhs);
		model.addAttribute("selectCurrentAppSeq", selectCurrentAppSeq);
		model.addAttribute("selectUpgradeAppSeq", selectUpgradeAppSeq);
		model.addAttribute("editList", editList);
		return "jsp/appmanagement/appservice/appServiceEdit";
	}

	// App서비스관리 수정폼 출력 시 현재 App 상태 변경 반환 메소드
	private List<AppServiceListVO> makeOsPhsEditForm(
			List<AppServiceListVO> totalOsPhs) throws Exception {

		List<AppServiceListVO> makeOsPhs = new ArrayList<AppServiceListVO>();

		for (AppServiceListVO totalData : totalOsPhs) {
			AppServiceListVO getOsPhAllList = appServiceService
					.getOsPhAllList(totalData.getPhModelInfoSeq());
			if (getOsPhAllList != null) {
				totalData.setPhName(getOsPhAllList.getPhName());
				totalData.setOsVerName(getOsPhAllList.getOsVerName());
			}

			makeOsPhs.add(totalData);
		}
		return makeOsPhs;
	}

	// App서비스관리 수정
	@RequestMapping("/appServiceUpdate")
	public String appServiceUpdate(
			@ModelAttribute("ContentsForm") @Valid AppServiceListVO appServiceListVO,
			BindingResult bindingResult, Model model) throws Exception {

		appServiceService.editAppService(appServiceListVO);

		return "redirect:appServiceList.do";
	}

	// App서비스관리 삭제
	@RequestMapping("/appServiceDelete")
	public String appServiceDelete(
			@ModelAttribute("ContentsForm") @Valid AppServiceListVO appServiceListVO,
			BindingResult bindingResult, Model model) throws Exception {

		appServiceService.deleteAppService(appServiceListVO);

		return "redirect:appServiceList.do";
	}
}
