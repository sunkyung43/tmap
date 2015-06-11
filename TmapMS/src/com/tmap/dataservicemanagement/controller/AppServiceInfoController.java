/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.dataservicemanagement.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.dataservicemanagement.service.AppMappingInfoService;
import com.tmap.dataservicemanagement.service.AppServiceInfoService;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.AppServiceInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;

@Controller
public class AppServiceInfoController {

	@Autowired
	AppServiceInfoService appServiceInfoService;

	@Autowired
	AppMappingInfoService appMappingInfoService;

	@Autowired
	HistoryInfoService historyInfoService;

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory
			.getLogger(AppServiceInfoController.class);

	// 검색 조건 초기화
	@SuppressWarnings("unused")
	@ModelAttribute("ContentsForm")
	private AppServiceInfoVO readAdminListParamInit(AppServiceInfoVO appServiceInfoVO) {

		if (appServiceInfoVO.getAppMappingName() == null) {
			appServiceInfoVO.setAppMappingName("");
		}
		
		return appServiceInfoVO;
	}

	// 데이터 배포 정보 리스트 출력
	@RequestMapping("/appServiceInfoList")
	public String appServiceInfoList(HttpServletRequest request, @ModelAttribute("ContentsForm") @Valid AppServiceInfoVO appServiceInfoVO, BindingResult bindingResult, Model model) throws Exception {

		appServiceInfoVO.setAppServiceType("");
		List<AppMappingInfoVO> appServiceInfoList = appServiceInfoService.appServiceInfoList(appServiceInfoVO);

		appServiceInfoVO.setAppServiceType("W");
		List<AppMappingInfoVO> appServiceInfoListReady = appServiceInfoService.appServiceInfoList(appServiceInfoVO);

		request.setAttribute("appServiceInfoList", appServiceInfoList);
		request.setAttribute("appServiceInfoListReady", appServiceInfoListReady);

		return "jsp/dataservicemanagement/appserviceinfo/appServiceInfoList";

	}

	// 데이터 배포 정보 등록폼
	@RequestMapping("/appServiceInfoEdit")
	public String appServiceInfoEdit(HttpServletRequest request, @ModelAttribute("ContentsForm") @Valid AppServiceInfoVO appServiceInfoVO, AppMappingInfoVO appMappingInfoVO, BindingResult bindingResult, Model model) throws Exception {

		// 배포정보
		AppServiceInfoVO serviceDetail = appServiceInfoService.serviceDetail(appServiceInfoVO.getAppMappingId());

		if (serviceDetail == null) {
			model.addAttribute("serviceDetail", appServiceInfoVO);
		} else {
			model.addAttribute("serviceDetail", serviceDetail);
		}

		// 매핑 정보
		Object mappingDetail = appServiceInfoService.mappingDetail(appServiceInfoVO.getAppMappingId());

		// 등록된 타입별 파일 정보
		List<AppMappingInfoVO> typeAndFile = appServiceInfoService.typeAndFile(appServiceInfoVO.getAppMappingId());

		if (!typeAndFile.isEmpty()) {
			// rowSpan
			List<Map<String, Object>> rowSpan = appServiceInfoService.rowSpan(appServiceInfoVO.getAppMappingId());

			Map<String, Long> rowInfo = new HashMap<String, Long>();

			for (Map<String, Object> map : rowSpan) {
				rowInfo.put((String) map.get("dataTypeName"),(Long) map.get("rowSpan"));
			}

			request.setAttribute("rowInfo", rowInfo);
		}

		// 매핑 상세정보
		List<AppMappingInfoVO> appMappingDetailList = appMappingInfoService.appMappingDetailInfoList(appMappingInfoVO.getAppMappingId());

		model.addAttribute("mappingDetail", mappingDetail);
		request.setAttribute("typeAndFile", typeAndFile);
		model.addAttribute("MappingDetailList", appMappingDetailList);

		return "jsp/dataservicemanagement/appserviceinfo/appServiceInfoEdit";
	}

	// 매핑 데이터 상세 정보
	@RequestMapping("/verInFile")
	public String verInFile(@ModelAttribute("ContentsForm") @Valid AppServiceInfoVO appServiceInfoVO, BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		// 파일 상세 정보
		List<DataFileInfoVO> fileDetail = appServiceInfoService
				.fileDetail(appServiceInfoVO);

		codeMap.put("fileDetail", fileDetail);

		model.addAttribute("json", codeMap);

		return "jsonView";
	}

	// 배포 정보 수정
	@RequestMapping("/appServiceInfoUpdate")
	public String appServiceUpdate(@ModelAttribute("ContentsForm") @Valid AppServiceInfoVO appServiceInfoVO, BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		appServiceInfoService.appServiceUpdate(appServiceInfoVO);

		historyInfoService.update(TABLE_NAME.app_service_info, appServiceInfoVO);

		// 배포 ID 검색
		int appMappingId = appServiceInfoService.appMappingId(appServiceInfoVO.getAppServiceName());

		codeMap.put("appMappingId", appMappingId);

		model.addAttribute("json", codeMap);

		return "jsonView";
	}

	// 배포 정보 삭제
	@RequestMapping("/appServiceInfoDelete")
	public String appServiceDelete(@ModelAttribute("ContentsForm") @Valid AppServiceInfoVO appServiceInfoVO, BindingResult bindingResult, Model model) throws Exception {

		appServiceInfoService.serviceDelete(appServiceInfoVO.getAppServiceId());

		historyInfoService.delete(TABLE_NAME.app_service_info, appServiceInfoVO);

		return "jsonView";
	}

	// 배포명 중복확인
	@RequestMapping("/processSerIdDuplication")
	public String processIdDuplication(@ModelAttribute("ContentsForm") @Valid AppServiceInfoVO appServiceInfoVO, BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		String checkServiceName = appServiceInfoService.checkServiceName(appServiceInfoVO.getCheckServiceName());

		codeMap.put("check", checkServiceName);

		model.addAttribute("json", codeMap);

		return "jsonView";
	}

}
