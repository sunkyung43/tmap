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

import com.tmap.appmanagement.vo.AppInfoListVO;
import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.datafilemanagement.vo.DataTypeInfoVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.service.AppMappingInfoService;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;

@Controller
public class AppMappingInfoController {

	@Autowired
	AppMappingInfoService appMappingInfoService;

	@Autowired
	HistoryInfoService historyInfoService;

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory
			.getLogger(AppMappingInfoController.class);

	// 검색 조건 초기화
	@SuppressWarnings("unused")
	@ModelAttribute("ContentsForm")
	private AppMappingInfoVO readAdminListParamInit(
			AppMappingInfoVO appMappingInfoVO) {

		if (appMappingInfoVO.getAppMappingName() == null) {
			appMappingInfoVO.setAppMappingName("");
		}

		if (appMappingInfoVO.getSearchAppName() == null) {
			appMappingInfoVO.setSearchAppName("");
		}

		if (appMappingInfoVO.getDataFileName() == null) {
			appMappingInfoVO.setDataFileName("");
		}

		if (appMappingInfoVO.getSearchDataFileName() == null) {
			appMappingInfoVO.setSearchDataFileName("");
		}

		if (appMappingInfoVO.getSearchFileVerName() == null) {
			appMappingInfoVO.setSearchFileVerName("");
		}

		return appMappingInfoVO;
	}

	// 데이터 매핑 정보 리스트 출력
	@RequestMapping("/appMappingInfoList")
	public String appMappingInfoList(
			HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		List<AppMappingInfoVO> appMappingInfoList = appMappingInfoService
				.appMappingInfoList(appMappingInfoVO);

		request.setAttribute("appMappingInfoList", appMappingInfoList);

		return "jsp/dataservicemanagement/appmappinginfo/appMappingInfoList";
	}

	// 데이터 매핑 정보 등록폼
	@RequestMapping("/appMappingInfoNew")
	public String appMappingInfoNew(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		// 데이터 타입 정보
		List<DataTypeInfoVO> dataTypeInfo = appMappingInfoService
				.dataTypeInfo();

		model.addAttribute("dataTypeInfo", dataTypeInfo);

		return "jsp/dataservicemanagement/appmappinginfo/appMappingInfoNew";
	}

	// 데이터 매핑 정보 수정폼
	@RequestMapping("/appMappingInfoEdit")
	public String appMappingInfoEdit(
			HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		// 매핑 정보
		Object mappingDetail = appMappingInfoService
				.mappingDetail(appMappingInfoVO.getAppMappingId());
		// 매핑 상세정보
		List<AppMappingInfoVO> appMappingDetailList = appMappingInfoService
				.appMappingDetailInfoList(appMappingInfoVO.getAppMappingId());

		// 데이터 타입 정보
		List<DataTypeInfoVO> dataTypeInfo = appMappingInfoService.dataTypeInfo();

		model.addAttribute("dataTypeInfo", dataTypeInfo);
		model.addAttribute("mappingDetail", mappingDetail);
		model.addAttribute("MappingDetailList", appMappingDetailList);
		// request.setAttribute("typeAndFile", typeAndFile);

		return "jsp/dataservicemanagement/appmappinginfo/appMappingInfoEdit";
	}

	// 버전별 타입정보
	@RequestMapping("/verTypeAndFile")
	public String verTypeAndFile(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {
		
//		Map<String, Object> codeMap = new HashMap<String, Object>();
		// 등록된 타입별 파일 정보
		List<AppMappingInfoVO> typeAndFile = appMappingInfoService.verTypeAndFile(appMappingInfoVO);

		if (!typeAndFile.isEmpty()) {
			// rowSpan
			List<Map<String, Object>> rowSpan = appMappingInfoService
					.rowSpan(appMappingInfoVO);

			Map<String, Long> rowInfo = new HashMap<String, Long>();

			for (Map<String, Object> map : rowSpan) {
				rowInfo.put((String) map.get("dataTypeName"),
						(Long) map.get("rowSpan"));
			}

			model.addAttribute("rowInfo", rowInfo);
		}
//		codeMap.put("typeAndFile", typeAndFile);
		model.addAttribute("typeAndFile", typeAndFile);
		return "jsp/dataservicemanagement/appmappinginfo/edit/verTypeFile";
	};

	// 사용가능 App정보 리스트
	@RequestMapping("/appMappingList")
	public String appMappingList(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		// 한 페이지에 출력될 갯수 설정
		//appMappingInfoVO.setCountPerPage(5);

		// 사용가능 App정보 리스트
		List<AppInfoListVO> appList = appMappingInfoService
				.appList(appMappingInfoVO);

		model.addAttribute("appList", appList);

		return "jsp/dataservicemanagement/appmappinginfo/appMappingList";
	}

	// 데이터 파일 리스트(등록)
	@RequestMapping("/mappingFileInType")
	public String fileInType(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		List<DataFileInfoVO> fileInType = appMappingInfoService
				.fileInType(appMappingInfoVO);

		model.addAttribute("fileInType", fileInType);

		return "jsp/dataservicemanagement/appmappinginfo/fileInTypeList";
	}

	// 데이터 파일 리스트(수정)
	@RequestMapping("/fileModify")
	public String fileModify(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		List<DataFileInfoVO> fileInType = appMappingInfoService
				.fileModify(appMappingInfoVO);

		codeMap.put("fileInType", fileInType);

		model.addAttribute("json", codeMap);

		return "jsonView";
	}

	// 데이터 파일 버전 리스트
	@RequestMapping("/mappingVerInFile")
	public String verInFile(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		// 버전 정보
		List<FileVersionInfoVO> verInFile = appMappingInfoService
				.verInFile(appMappingInfoVO);

		model.addAttribute("verInFile", verInFile);
		return "jsp/dataservicemanagement/appmappinginfo/verInFile";
	}
	//데이터 파일 버전 리스트(수정)
	
	@RequestMapping("/appMappingVerInFile")
	public String appMappingVerInFile(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		//버전 정보
		List<FileVersionInfoVO> verInFile = appMappingInfoService.verInFile(appMappingInfoVO);
		
		//파일 상세 정보
		List<DataFileInfoVO> fileDetail = appMappingInfoService.fileDetail(appMappingInfoVO);
		
		codeMap.put("verInFile", verInFile);	
		codeMap.put("fileDetail", fileDetail);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	

	@RequestMapping("/mappingFileDetail")
	public String fileDetail(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {
		Map<String, Object> codeMap = new HashMap<String, Object>();
		// 파일 상세 정보
		List<DataFileInfoVO> fileDetail = appMappingInfoService
				.fileDetail(appMappingInfoVO);
		codeMap.put("fileDetail", fileDetail);
		model.addAttribute("json", codeMap);
		return "jsonView";
	}

	// 데이터 매핑 정보 등록
	// AppMappingInfo 등록
	@RequestMapping("/appMappingInfoInsert")
	public String appMappingInfoInsert(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult result, Model model) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();

		int insertResult = appMappingInfoService.appMappingInfoInsert(appMappingInfoVO);
		// MappingId 획득
		String appMappingId = appMappingInfoService.appMappingId(appMappingInfoVO.getAppMappingName());
		
		resultMap.put("appMappingId", appMappingId);
		if (insertResult > 0) {
			resultMap.put("SUCCESS", "SUCCESS");
		} else {
			resultMap.put("SUCCESS", "FAILED");
		}
		model.addAttribute("json", resultMap);
		return "jsonView";
	}
	@RequestMapping("/appMappingInNameCheck")
	public String appMappingInNameCheck(@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
      BindingResult result, Model model) throws Exception {
	  
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  
	  int Result = appMappingInfoService.appMappingNameCheck(appMappingInfoVO);
	  
	  
	  if (Result > 0) {
      resultMap.put("SUCCESS", "FAILED");
    } else {
      resultMap.put("SUCCESS", "SUCCESS");
    }
	  
	  model.addAttribute("json", resultMap);
	  return "jsonView";
	}
	// AppMappingServiceInfo 등록
	@RequestMapping("/appMappingServiceInfoInsert")
	public String appMappingServiceInfoInsert(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult result, Model model) throws Exception {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int insertResult = appMappingInfoService
				.appMappingServiceInfoInsert(appMappingInfoVO);
		historyInfoService.insert(TABLE_NAME.app_mapping_service_info,
				appMappingInfoVO);
		
		resultMap.put("appServiceId", appMappingInfoVO.getAppServiceId());

		if (insertResult > 0) {
			resultMap.put("SUCCESS", "SUCCESS");
		} else {
			resultMap.put("SUCCESS", "FAILED");
		}

		model.addAttribute("json", resultMap);
		return "jsonView";
	}

	@RequestMapping("/appMappingDetailInfoInsert")
	public String appMappingDetailInfoInsert(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult result, Model model) throws Exception {

		String returnType = "jsonView";
		Map<String, Object> resultMap = new HashMap<String, Object>();

		if (appMappingInfoVO.getDataFileIds() != null) {
			int insertResult = appMappingInfoService
					.appMappingDetailInfoInsert(appMappingInfoVO);
			historyInfoService.insert(TABLE_NAME.app_mapping_info,
					appMappingInfoVO);
			if (insertResult > 0) {
				List<AppMappingInfoVO> typeAndFile = appMappingInfoService
						.typeAndFile(appMappingInfoVO.getAppMappingId());
				model.addAttribute("typeAndFile", typeAndFile);
				model.addAttribute("appMappingInfo", appMappingInfoVO);
				returnType = "jsp/dataservicemanagement/appmappinginfo/appMappingInfoNewResult";
			} else {
				resultMap.put("SUCCESS", "FAILED");
				model.addAttribute("json", resultMap);
				returnType = "jsonView";
			}
		}
		return returnType;
	}

	@RequestMapping("/appMappingInsert")
	public String appMappingInsert(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		int insert = appMappingInfoService.mappingInsert(appMappingInfoVO);

		historyInfoService
				.insert(TABLE_NAME.app_mapping_info, appMappingInfoVO);

		String appMappingId = appMappingInfoService
				.appMappingId(appMappingInfoVO.getAppMappingName());

		codeMap.put("appMappingId", appMappingId);

		if (insert > 0) {
			codeMap.put("SUCCESS", "SUCCESS");
		} else {
			codeMap.put("SUCCESS", "FAILED");
		}

		model.addAttribute("json", codeMap);

		return "jsonView";
	}

	// 데이터 정보 수정
	@RequestMapping("/appMappingUpdate")
	public String appMappingUpdate(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		appMappingInfoService.mappingUpdate(appMappingInfoVO);
		historyInfoService
				.update(TABLE_NAME.app_mapping_info, appMappingInfoVO);

		return "jsonView";
	}

	// 매핑 정보 수정
	@RequestMapping("/mappingModify")
	public String mappingModify(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		appMappingInfoService.mappingModify(appMappingInfoVO);
		historyInfoService
				.update(TABLE_NAME.app_mapping_info, appMappingInfoVO);

		return "jsonView";
	}

	// 데이터 매핑 정보 삭제
	@RequestMapping("/appMappingDelete")
	public String appMappingDelete(
			@ModelAttribute("ContentsForm") @Valid AppMappingInfoVO appMappingInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		appMappingInfoService.mappingDelete(appMappingInfoVO.getAppMappingId());

		historyInfoService
				.delete(TABLE_NAME.app_mapping_info, appMappingInfoVO);

		return "jsonView";
	}

}
