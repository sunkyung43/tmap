package com.tmap.appmanagement.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tmap.appmanagement.service.AppInfoService;
import com.tmap.appmanagement.vo.AppInfoListVO;
import com.tmap.appmanagement.vo.TempletModelInfoListVO;
import com.tmap.sitemanagement.service.HistoryInfoService;

@Controller
public class AppInfoController {

	@Autowired
	AppInfoService appInfoService;

	@Autowired
	HistoryInfoService historyInfoService;

	// 검색 조건 초기화
	@SuppressWarnings("unused")
	@ModelAttribute("ContentsForm")
	private AppInfoListVO readAdminListParamInit(AppInfoListVO appInfoListVO) {

		if (appInfoListVO.getSearchAppName() == null) {
			appInfoListVO.setSearchAppName("");
		}

		if (appInfoListVO.getPhName() == null) {
			appInfoListVO.setPhName("");
		}

		if (appInfoListVO.getTempletModelName() == null) {
			appInfoListVO.setTempletModelName("");
		}

		return appInfoListVO;
	}

	// App관리 리스트 출력
	@RequestMapping("/appInfoList")
	public String appInfoList(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		// 한 페이지에 출력될 갯수 설정
		// appInfoListVO.setCountPerPage(10);

		// app관리 리스트
		List<AppInfoListVO> appInfoList = appInfoService
				.appInfoList(appInfoListVO);

		// rowSpan
		List<Map<String, Object>> rowSpan = appInfoService
				.rowSpan(appInfoListVO);
		Map<String, Long> rowInfo = new HashMap<String, Long>();
		for (Map<String, Object> map : rowSpan) {
			rowInfo.put((String) map.get("appName"), (Long) map.get("rowSpan"));
		}

		request.setAttribute("appInfoList", appInfoList);
		request.setAttribute("rowInfo", rowInfo);

		return "jsp/appmanagement/appinfo/appInfoList";
	}

	// App관리 등록폼
	@RequestMapping("/appInfoNew")
	public String appInfoNew(
			@ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		// 단말모델
		List<AppInfoListVO> appInfoNew = appInfoService
				.appInfoNew(appInfoListVO);

		// 단말조합
		List<TempletModelInfoListVO> templetModel = appInfoService
				.templetModel(appInfoListVO.getTempletModelName());

		model.addAttribute("appInfoNew", appInfoNew);
		model.addAttribute("templetModel", templetModel);

		return "jsp/appmanagement/appinfo/appInfoNew";
	}

	// App관리 등록
	@RequestMapping("/appInfoInsert")
	public String appInfoInsert(
			@ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		// App 정보 등록
		boolean appInfo = appInfoService.appInfoInsert(appInfoListVO);

		// 버전 정보 등록
		if (appInfo && !appInfoListVO.getAppVerName().equals("")) {
			appInfoService.appVerInsert(appInfoListVO);
		}
		return "redirect:appInfoList.do";
	}

	// App관리 수정폼
	@RequestMapping("/appInfoEdit")
	public String appInfoEdit(
			@ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		appInfoListVO.setCountPerPage(1000);
		appInfoListVO.setCurrentPage(0);
		// app정보
		Object appInfo = appInfoService.appInfo(appInfoListVO);

		// app버전정보
		List<AppInfoListVO> appVerInfoList = appInfoService.appVerInfoList(appInfoListVO);

		
		/*List<TempletModelInfoListVO> templetModel = appInfoService.templetModel(appInfoListVO.getTempletModelName());
		List<AppInfoListVO> allOsPhInfo = appInfoService .allOsPhInfo(appInfoListVO);*/
		
		model.addAttribute("appInfo", appInfo);
		model.addAttribute("appVerInfoList", appVerInfoList);
		return "jsp/appmanagement/appinfo/appInfoEdit";
	}

	// App관리 수정
	@RequestMapping("/appInfoUpdate")
	public String appInfoUpdate(
			@ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();
		int result = appInfoService.appInfoUpdate(appInfoListVO);
		codeMap.put("result", result);
		model.addAttribute("json", codeMap);
		return "jsonView";
	}

	// App관리 삭제
	@RequestMapping("/appInfoDelete")
	public String appInfoDelete(
			@ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		appInfoService.appInfoDelete(appInfoListVO);

		return "redirect:appInfoList.do";
	}

	// 버전정보 등록
	@RequestMapping("/appVerInsert")
	public String appVerInsert(
			@ModelAttribute("VersionForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		int result = appInfoService.appVerInsert(appInfoListVO);

		codeMap.put("result", result);
		model.addAttribute("json", codeMap);

		return "jsonView";
	}

	// 버전정보 수정
	@RequestMapping("/appVerUpdate")
	public String appVerUpdate(
			@ModelAttribute("VerForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		int result = appInfoService.appVerUpdate(appInfoListVO);

		codeMap.put("result", result);
		model.addAttribute("json", codeMap);

		return "jsonView";
	}

	// 버전정보 삭제
	@RequestMapping("/appVerDelete")
	public String appVerDelete(
			@ModelAttribute("VerForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		int result = appInfoService.appVerDelete(appInfoListVO);
		codeMap.put("result", result);
		model.addAttribute("json", codeMap);
		return "jsonView";
	}

	
	@RequestMapping("/appVerInfoNew")
	public String appVerInfoNew(
			@ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		model.addAttribute("appInfoSeq", appInfoListVO.getAppInfoSeq());
		return "jsp/appmanagement/appinfo/appVerInfoNew";
	}
	
	@RequestMapping("/appVerMapping")
	public String appVerMapping(
			@ModelAttribute("PhModelForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {
		if(appInfoListVO.getTempletModelName() == null)
		{
			appInfoListVO.setTempletModelName("");
		}
		List<TempletModelInfoListVO> templetModel = appInfoService.templetModel(appInfoListVO.getTempletModelName());
		List<AppInfoListVO> allOsPhInfo = appInfoService.allOsPhInfo(appInfoListVO);
		List<AppInfoListVO> verUseOsPh = appInfoService.verUseOsPh(appInfoListVO);
		
		model.addAttribute("templetModel", templetModel);
		model.addAttribute("allOsPhInfo", allOsPhInfo);
		model.addAttribute("verUseOsPh", verUseOsPh);
		 

		return "jsp/appmanagement/appinfo/appMappingPhone";
	}
	
	
	@RequestMapping("/versionMappingInsert")
	public String versionMappingInsert(
			@ModelAttribute("PhModelForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {
		
		appInfoService.osPhInfoInsert(appInfoListVO); 

		return "jsonView";
	}
	
	@RequestMapping("/versionMappingUpdate")
	public String versionMappingUpdate(
			@ModelAttribute("PhModelForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {
		
		appInfoService.osPhInfoUpdate(appInfoListVO); 

		return "jsonView";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	

	// App관리 등록
	/*
	 * @RequestMapping("/appInfoInsert") public String appInfoInsert(
	 * 
	 * @ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
	 * BindingResult bindingResult, Model model) throws Exception {
	 * 
	 * // App 정보 등록 boolean appInfo =
	 * appInfoService.appInfoInsert(appInfoListVO);
	 * 
	 * // 버전 정보 등록 if (appInfo && !appInfoListVO.getAppVerName().equals("")) {
	 * appInfoService.appVerInsert(appInfoListVO); }
	 * 
	 * // 단말모델 정보 등록 if (appInfoListVO.getCheckboxPhModelInfos() != null) {
	 * appInfoService.osPhInfoInsert(appInfoListVO); //
	 * historyInfoService.insert(TABLE_NAME.app_model_info, // appInfoListVO); }
	 * 
	 * return "redirect:appInfoList.do"; }
	 */

	// App관리 등록폼(단말조합정보 검색)
	@RequestMapping("/searchTempletName")
	public String searchTempletName(
			@ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		List<TempletModelInfoListVO> searchTempletName = appInfoService
				.templetModel(appInfoListVO.getTempletModelName());

		codeMap.put("searchTempletName", searchTempletName);

		model.addAttribute("json", codeMap);

		return "jsonView";
	}

	// App관리 등록폼(단말조합 검색)
	@RequestMapping("/searchTempletModel")
	public String searchTempletModel(
			@ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		List<TempletModelInfoListVO> searchTempletModel = appInfoService
				.searchTempletModel(appInfoListVO);
		
		model.addAttribute("detailList", searchTempletModel);
		
		return "jsp/appmanagement/appinfo/templetDetail";
	}


	// 버전정보 리스트 출력
	@RequestMapping("/appVerInfoList")
	public String appVerInfoList(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		// 한 페이지에 출력될 갯수 설정
		// appInfoListVO.setCountPerPage(5);

		List<AppInfoListVO> appVerInfoList = appInfoService
				.appVerInfoList(appInfoListVO);

		if (appInfoListVO.getIsMapping().equalsIgnoreCase("true")) {
			// Map<Object, Object> jsonResult = new HashMap<Object, Object>();
			// jsonResult.put("appVerInfoList", appVerInfoList);
			model.addAttribute("appVerInfoList", appVerInfoList);
			return "jsp/dataservicemanagement/appmappinginfo/appVerList";
		} else {
			model.addAttribute("appInfoSeq", appInfoListVO.getAppInfoSeq());
			model.addAttribute("appVerInfoList", appVerInfoList);
			return "jsp/appmanagement/appinfo/appVerInfoList";
		}
	}

	// 버전정보 수정폼
	@RequestMapping("/appVerInfoEdit")
	public String appVerInfoEdit(
			@ModelAttribute("ContentsForm") @Valid AppInfoListVO appInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {
		Map<String, Object> codeMap = new HashMap<String, Object>();

		AppInfoListVO appVerInfo = appInfoService.appVerInfo(appInfoListVO);
		codeMap.put("appVerDetail", appVerInfo);
		model.addAttribute("appVerInfo", appVerInfo);
		model.addAttribute("json", codeMap);
		return "jsonView";
	}

}
