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

import com.tmap.datafilemanagement.vo.DataTypeInfoVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.service.DataFileServiceInfoService;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.DataFileServiceInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;




@Controller
public class DataFileServiceInfoController {

	@Autowired
	DataFileServiceInfoService dataFileServiceInfoService;
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(DataFileServiceInfoController.class);
	
	//검색 조건 초기화
	@SuppressWarnings("unused")
	@ModelAttribute("ContentsForm")
	private DataFileServiceInfoVO readAdminListParamInit(DataFileServiceInfoVO dataFileServiceInfoVO) {
		
		if(dataFileServiceInfoVO.getDataFileName() == null){
			dataFileServiceInfoVO.setDataFileName("");
		}
		
		return dataFileServiceInfoVO;
	}
	
	//파일서비스 배포 리스트
	@RequestMapping("/dataFileServiceInfoList")
	public String dataFileServiceInfoList(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid DataFileServiceInfoVO dataFileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		//파일서비스 배포 리스트
		List<DataFileServiceInfoVO> dataFileServiceList = dataFileServiceInfoService.dataFileServiceList(dataFileServiceInfoVO);
		
		//데이터 타입 리스트
		List<DataTypeInfoVO> typeList = dataFileServiceInfoService.typeList();
		
		model.addAttribute("typeList", typeList);
		model.addAttribute("dataFileServiceList", dataFileServiceList);
		
		return "jsp/dataservicemanagement/datafileserviceinfo/dataFileServiceInfoList";
	}
	
	//파일서비스 배포 등록폼
	@RequestMapping("/dataFileServiceInfoEdit")
	public String dataFileServiceInfoEdit(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid DataFileServiceInfoVO dataFileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		//배포정보
		Object serviceDetail = dataFileServiceInfoService.serviceDetail(dataFileServiceInfoVO.getFileServId());
		
		if(serviceDetail == null){
			model.addAttribute("serviceDetail", dataFileServiceInfoVO);
		}else{
			model.addAttribute("serviceDetail", serviceDetail);
		}
		
		//파일서비스 배포 정보
		Object dataFileServiceInfo = dataFileServiceInfoService.dataFileServiceInfo(dataFileServiceInfoVO.getFileServId());
		
		//데이터 버전 정보
		List<FileVersionInfoVO> versionInfo = dataFileServiceInfoService.versionInfo(dataFileServiceInfoVO);
		
		model.addAttribute("dataFileServiceInfo", dataFileServiceInfo);
		model.addAttribute("versionInfo", versionInfo);
		
		return "jsp/dataservicemanagement/datafileserviceinfo/dataFileServiceInfoEdit";
	}
	
	//버전 상세 정보
	@RequestMapping("/verDetail")
	public String verDetail(
			@ModelAttribute("ContentsForm") @Valid DataFileServiceInfoVO dataFileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		List<AppMappingInfoVO> verDetail = dataFileServiceInfoService.verDetail(dataFileServiceInfoVO);
		
		codeMap.put("verDetail", verDetail);	
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//배포 정보 수정
	@RequestMapping("/dataFileServiceUpdate")
	public String dataFileServiceUpdate(
			@ModelAttribute("ContentsForm") @Valid DataFileServiceInfoVO dataFileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		dataFileServiceInfoService.dataFileServiceUpdate(dataFileServiceInfoVO);
		
		historyInfoService.update(TABLE_NAME.data_file_service_info, dataFileServiceInfoVO);
		
		//배포 ID 검색
		int dataFileServiceId = dataFileServiceInfoService.dataFileServiceId(dataFileServiceInfoVO.getFileServId());
		
		codeMap.put("dataFileServiceId", dataFileServiceId);
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//배포 정보 삭제
	@RequestMapping("/dataFileServiceDelete")
	public String dataFileServiceDelete(
			@ModelAttribute("ContentsForm") @Valid DataFileServiceInfoVO dataFileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		dataFileServiceInfoService.dataFileServiceDelete(dataFileServiceInfoVO.getDataFileServiceId());
		
		historyInfoService.delete(TABLE_NAME.data_file_service_info, dataFileServiceInfoVO);
		
		return "jsonView";
	}
	
}
