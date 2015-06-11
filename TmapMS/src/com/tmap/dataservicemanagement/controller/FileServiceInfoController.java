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
import com.tmap.datafilemanagement.vo.DataTypeInfoVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.service.FileServiceInfoService;
import com.tmap.dataservicemanagement.vo.FileServiceInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;

@Controller
public class FileServiceInfoController {

	@Autowired
	FileServiceInfoService fileServiceInfoService;
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(FileServiceInfoController.class);
	
	//검색 조건 초기화
	@SuppressWarnings("unused")
	@ModelAttribute("ContentsForm")
	private FileServiceInfoVO readAdminListParamInit(FileServiceInfoVO fileServiceInfoVO) {

		if(fileServiceInfoVO.getDataFileName() == null){
			fileServiceInfoVO.setDataFileName("");
		}
		
		if(fileServiceInfoVO.getSearchDataFileName() == null){
			fileServiceInfoVO.setSearchDataFileName("");
		}
		
		if(fileServiceInfoVO.getSearchFileVerName() == null){
			fileServiceInfoVO.setSearchFileVerName("");
		}
		
		return fileServiceInfoVO;
	}
	
	//파일 서비스 리스트
	@RequestMapping("/fileServiceInfoList")
	public String fileServiceInfoList(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid FileServiceInfoVO fileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		//파일 서비스 리스트
		List<FileServiceInfoVO> fileServiceList = fileServiceInfoService.fileServiceList(fileServiceInfoVO);
		
		//데이터 타입 리스트
		List<DataTypeInfoVO> typeList = fileServiceInfoService.typeList();
		
		model.addAttribute("typeList", typeList);
		model.addAttribute("fileServiceList", fileServiceList);
		
		return "jsp/dataservicemanagement/fileserviceinfo/fileServiceInfoList";
	}
	
	//파일 서비스 등록폼
	@RequestMapping("/fileServiceInfoNew")
	public String fileServiceInfoNew(
			@ModelAttribute("ContentsForm") @Valid FileServiceInfoVO fileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		//데이터 타입 정보
		List<DataTypeInfoVO> dataTypeInfo = fileServiceInfoService.typeList();
		
		model.addAttribute("dataTypeInfo", dataTypeInfo);
		
		return "jsp/dataservicemanagement/fileserviceinfo/fileServiceInfoNew";
	}
	
	//데이터 파일 리스트(등록)
	@RequestMapping("/fileInType")
	public String fileInType(
			@ModelAttribute("ContentsForm") @Valid FileServiceInfoVO fileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		List<DataFileInfoVO> fileInType = fileServiceInfoService.fileInType(fileServiceInfoVO);
		
		codeMap.put("fileInType", fileInType);	
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//데이터 파일 버전 리스트(등록)
	@RequestMapping("/fileSerVerInFile")
	public String verInFile(
			@ModelAttribute("ContentsForm") @Valid FileServiceInfoVO fileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		//버전 정보
		List<FileVersionInfoVO> verInFile = fileServiceInfoService.verInFile(fileServiceInfoVO);
		
		//파일 상세 정보
		List<DataFileInfoVO> fileDetail = fileServiceInfoService.fileDetail(fileServiceInfoVO);
		
		codeMap.put("fileDetail", fileDetail);
		codeMap.put("verInFile", verInFile);	
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//데이터 파일 버전 리스트(수정)
	@RequestMapping("/verInFile2")
	public String verInFile2(
			@ModelAttribute("ContentsForm") @Valid FileServiceInfoVO fileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		//버전 정보
		List<FileVersionInfoVO> verInFile = fileServiceInfoService.versionInfo(fileServiceInfoVO);
		
		codeMap.put("verInFile", verInFile);	
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//데이터 매핑 정보 등록
	@RequestMapping("/fileServiceInsert")
	public String fileServiceInsert(
			@ModelAttribute("ContentsForm") @Valid FileServiceInfoVO fileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		int insert = fileServiceInfoService.serviceInsert(fileServiceInfoVO);
		
		historyInfoService.insert(TABLE_NAME.file_service_info, fileServiceInfoVO);
		
		int fileServId = fileServiceInfoService.fileServId(fileServiceInfoVO.getDataFileId());
		
		String servId = String.valueOf(fileServId);
		
		codeMap.put("servId", servId);
		
		if(insert > 0){
			codeMap.put("SUCCESS", "SUCCESS");
		}else{
			codeMap.put("SUCCESS", "FAILED");
		}
			
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//파일 서비스 수정폼
	@RequestMapping("/fileServiceInfoEdit")
	public String fileServiceInfoEdit(
			@ModelAttribute("ContentsForm") @Valid FileServiceInfoVO fileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		//파일 서비스 정보
		Object fileServiceInfo = fileServiceInfoService.fileServiceInfo(fileServiceInfoVO.getFileServId());
		
		//데이터 버전 정보
		List<FileVersionInfoVO> versionInfo = fileServiceInfoService.versionInfo(fileServiceInfoVO);
		
		model.addAttribute("fileServiceInfo", fileServiceInfo);
		model.addAttribute("versionInfo", versionInfo);
		
		return "jsp/dataservicemanagement/fileserviceinfo/fileServiceInfoEdit";
	}
	
	//파일 서비스 수정
	@RequestMapping("/fileServiceUpdate")
	public String fileServiceUpdate(
			@ModelAttribute("ContentsForm") @Valid FileServiceInfoVO fileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		fileServiceInfoService.fileServiceUpdate(fileServiceInfoVO);
		
		historyInfoService.update(TABLE_NAME.file_service_info, fileServiceInfoVO);
		
		return "jsonView";
	}
	
	//파일 서비스 삭제
	@RequestMapping("/fileServiceDelete")
	public String fileServiceDelete(
			@ModelAttribute("ContentsForm") @Valid FileServiceInfoVO fileServiceInfoVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		fileServiceInfoService.fileServiceDelete(fileServiceInfoVO.getFileServId());
		
		historyInfoService.delete(TABLE_NAME.file_service_info, fileServiceInfoVO);
		
		return "jsonView";
	}
	
}
