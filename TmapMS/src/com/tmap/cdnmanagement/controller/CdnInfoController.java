package com.tmap.cdnmanagement.controller;

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
import com.tmap.cdnmanagement.service.CdnInfoService;
import com.tmap.cdnmanagement.vo.CdnInfoListVO;
import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.service.AppMappingInfoService;
import com.tmap.dataservicemanagement.service.AppServiceInfoService;
import com.tmap.dataservicemanagement.service.DataFileServiceInfoService;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.AppServiceInfoVO;
import com.tmap.dataservicemanagement.vo.DataFileServiceInfoVO;
import com.tmap.sitemanagement.service.HistoryInfoService;

@Controller
public class CdnInfoController {

	@Autowired
	AppMappingInfoService appMappingInfoService;
	@Autowired
	AppServiceInfoService appServiceInfoService;
	@Autowired
	CdnInfoService cdnInfoService;
	@Autowired
	DataFileServiceInfoService dataFileServiceInfoService;
	@Autowired
	AppInfoService appInfoService;
	@Autowired
	HistoryInfoService historyInfoService;

	@ModelAttribute("fileServiceInfoForm")
	private DataFileServiceInfoVO readAdminListParamInit(
			DataFileServiceInfoVO dataFileServiceInfoVO) {

		if (dataFileServiceInfoVO.getDataFileName() == null) {
			dataFileServiceInfoVO.setDataFileName("");
		}

		return dataFileServiceInfoVO;
	}

	@RequestMapping("/cdnInfoList")
	public String cdnInfoList(HttpServletRequest request,
			@ModelAttribute("ContentsForm") CdnInfoListVO cdnInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		List<CdnInfoListVO> cdnInfoList = cdnInfoService
				.cdnInfoList(cdnInfoListVO);

		model.addAttribute("cdnInfoList", cdnInfoList);

		return "jsp/cdnmanagement/cdninfo/cdnInfoList";
	}

	@RequestMapping("/cdnInfoNew")
	public String cdnInfoNew(
			HttpServletRequest request,
			@ModelAttribute("ContentsForm") CdnInfoListVO cdnInfoListVO,
			@ModelAttribute("fileServiceInfoForm") DataFileServiceInfoVO dataFileServiceInfoVO,
			@ModelAttribute("AppMappingListForm") AppServiceInfoVO appServiceInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		// DataFileInfoList 조회
		List<DataFileServiceInfoVO> dataFileServiceList = cdnInfoService
				.cdnFileServiceList(dataFileServiceInfoVO);

		// AppInfoList 조회
		appServiceInfoVO.setAppMappingName("");
		List<AppMappingInfoVO> appServiceInfoList = cdnInfoService
				.cdnAppServiceInfoList(appServiceInfoVO);

		// 데이터 버전 정보
		List<FileVersionInfoVO> versionInfo = dataFileServiceInfoService
				.versionInfo(dataFileServiceInfoVO);
		
		String cdnPromoSdate = "";

		// 오늘 날짜
		if (cdnPromoSdate == null || "".equals(cdnPromoSdate)) {
			java.text.SimpleDateFormat format = new java.text.SimpleDateFormat(
					"yyyy-MM-dd");
			java.util.Calendar cal = java.util.Calendar
					.getInstance(java.util.Locale.KOREA);
			cdnPromoSdate = format.format(cal.getTime());
		}

		model.addAttribute("appServiceInfoList", appServiceInfoList);
		model.addAttribute("dataFileServiceList", dataFileServiceList);
		model.addAttribute("cdnInfo", cdnInfoListVO);
		model.addAttribute("versionInfo", versionInfo);

		return "jsp/cdnmanagement/cdninfo/cdnInfoNew";
	}

	// dataFileDetail
	@RequestMapping("/fileVerInfo")
	public String fileVerInfo(
			HttpServletRequest request,
			@ModelAttribute("ContentsForm") CdnInfoListVO cdnInfoListVO,
			@ModelAttribute("fileServiceInfoForm") DataFileServiceInfoVO dataFileServiceInfoVO,
			DataFileInfoVO dataFileInfoVO, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();
		// 데이터 버전 정보
		List<FileVersionInfoVO> versionInfo = dataFileServiceInfoService
				.versionInfo(dataFileServiceInfoVO);

		codeMap.put("versionInfo", versionInfo);
		codeMap.put("dataFileId", dataFileInfoVO.getDataFileId());
		model.addAttribute("json", codeMap);

		return "jsonView";

	}
	
	// appMappingDetail
		@RequestMapping("/appMappingInfo")
		public String appMappingInfo(
				HttpServletRequest request,
				@ModelAttribute("ContentsForm") CdnInfoListVO cdnInfoListVO,
				@ModelAttribute("AppMappingListForm") AppMappingInfoVO appMappingInfoVO,
				DataFileInfoVO dataFileInfoVO, Model model) throws Exception {

			Map<String, Object> codeMap = new HashMap<String, Object>();
			
			// 매핑 상세정보
			List<AppMappingInfoVO> appMappingDetailList = appMappingInfoService.appMappingDetailInfoList(appMappingInfoVO.getAppMappingId());

			codeMap.put("appMappingDetailList", appMappingDetailList);
			codeMap.put("appMappingId", appMappingInfoVO.getAppMappingId());
			
			model.addAttribute("json", codeMap);

			return "jsonView";

		}

	/*
	 * // appVer
	 * 
	 * @RequestMapping("/appMappingVer") public String appMappingVer(
	 * HttpServletRequest request,
	 * 
	 * @ModelAttribute("ContentsForm") @Valid AppServiceInfoVO appServiceInfoVO,
	 * AppMappingInfoVO appMappingInfoVO, BindingResult bindingResult, Model
	 * model) throws Exception {
	 * 
	 * Map<String, Object> codeMap = new HashMap<String, Object>();
	 * 
	 * // 매핑 상세정보 List<AppMappingInfoVO> appMappingDetailList = cdnInfoService
	 * .cdnAppMappingDetailInfoList(appMappingInfoVO.getAppMappingId());
	 * 
	 * List<AppMappingInfoVO> appMappingDetailId = cdnInfoService
	 * .cdnAppMappingDetailId(appMappingInfoVO.getAppVerId());
	 * 
	 * // 배포정보 AppServiceInfoVO serviceDetail = appServiceInfoService
	 * .serviceDetail(appServiceInfoVO.getAppMappingId());
	 * 
	 * if (serviceDetail == null) { model.addAttribute("serviceDetail",
	 * appServiceInfoVO); } else { model.addAttribute("serviceDetail",
	 * serviceDetail); }
	 * 
	 * // 매핑 정보 Object mappingDetail = appServiceInfoService
	 * .mappingDetail(appServiceInfoVO.getAppMappingId());
	 * 
	 * // 등록된 타입별 파일 정보 List<AppMappingInfoVO> typeAndFile =
	 * appServiceInfoService .typeAndFile(appServiceInfoVO.getAppMappingId());
	 * 
	 * if (!typeAndFile.isEmpty()) { // rowSpan List<Map<String, Object>>
	 * rowSpan = appServiceInfoService
	 * .rowSpan(appServiceInfoVO.getAppMappingId());
	 * 
	 * Map<String, Long> rowInfo = new HashMap<String, Long>();
	 * 
	 * for (Map<String, Object> map : rowSpan) { rowInfo.put((String)
	 * map.get("dataTypeName"), (Long) map.get("rowSpan")); }
	 * 
	 * request.setAttribute("rowInfo", rowInfo); }
	 * 
	 * codeMap.put("mappingDetail", mappingDetail);
	 * codeMap.put("MappingDetailList", appMappingDetailList);
	 * codeMap.put("appMappingDetailId", appMappingDetailId);
	 * 
	 * request.setAttribute("typeAndFile", typeAndFile);
	 * model.addAttribute("json", codeMap);
	 * 
	 * return "jsonView"; }
	 */
	// FileServiceInfoList 조회
	// @RequestMapping("/fileServiceInfoList")
	// public String fileServiceInfoList(@ModelAttribute("DataFileForm")
	// DataFileInfoVO dataFileInfoVO, BindingResult bindingResult, Model model)
	// throws Exception {
	//
	// Map<String, Object> codeMap = new HashMap<String, Object>();
	// // codeMap.put("fileVersionInfoList",
	// fileVersionInfoService.fileVersionInfoList(dataFileInfoVO.getDataFileId()));
	// model.addAttribute("json", codeMap);
	//
	// return "jsonView";
	// }

	// AppMapping정보 조회
	// @RequestMapping("/appServiceInfoList")
	// public String appServiceInfoList(@ModelAttribute("AppMappingListForm")
	// AppMappingInfoVO appMappingInfoVO, BindingResult bindingResult, Model
	// model) throws Exception {
	//
	// Map<String, Object> codeMap = new HashMap<String, Object>();
	// // List<AppMappingInfoVO> appServiceInfoList =
	// appServiceInfoService.appServiceInfoList(appServiceInfoVO);
	// // codeMap.put("AppMappingInfoList", appMappingInfoList);
	// model.addAttribute("json", codeMap);
	//
	// return "jsonView";
	// }

	@RequestMapping("/cdnInfoInsert")
	public String cdnInfoInsert(
			@ModelAttribute("ContentsForm") CdnInfoListVO cdnInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		// id

		// cdn_promo_id
		String cdnPromoId = cdnInfoService.cdnPromoId();
		cdnInfoListVO.setCdnPromoId(String.valueOf(cdnPromoId));
		
		//String startdt = "";
		//String enddt = "";
		
		String cdnPromoSdate = String.format("%s %s:00:00", cdnInfoListVO.getCdnPromoSdate(), cdnInfoListVO.getStartdt());
		cdnInfoListVO.setCdnPromoSdate(String.valueOf(cdnPromoSdate));
		String cdnPromoEdate = String.format("%s %s:59:59", cdnInfoListVO.getCdnPromoEdate(), cdnInfoListVO.getEnddt());
		cdnInfoListVO.setCdnPromoEdate(String.valueOf(cdnPromoEdate));

		boolean isSuccess = cdnInfoService.cdnInfoInsert(cdnInfoListVO);
		
		/*
		 * List<CdnInfoListVO> cdnPromoId =
		 * cdnInfoService.cdnPromoId(cdnInfoListVO.getCdnPromoId());
		 */

		String message = null;

		if (isSuccess) {
			message = "등록되었습니다.";
		} else {
			message = "등록이 실패되었습니다.";
		}

		Map<String, Object> codeMap = new HashMap<String, Object>();

		codeMap.put("MESSAGE", message);
		/* codeMap.put("cdnDetailList", cdnDetailList); */
		codeMap.put("cdnPromoId", cdnPromoId);

		model.addAttribute("json", codeMap);

		return "jsonView";
	}

	@RequestMapping("/cdnDetailInsert.do")
	public String cdnDetailInsert(HttpServletRequest request,
			@ModelAttribute("ContentsForm") CdnInfoListVO cdnInfoListVO,
			DataFileInfoVO dataFileInfoVO, Model model) throws Exception {

		/*String cdnPromoSdate = String.format("%s %s:00:00", cdnInfoListVO.getCdnPromoSdate(), cdnInfoListVO.getStartdt());
		cdnInfoListVO.setCdnPromoSdate(String.valueOf(cdnPromoSdate));
		String cdnPromoEdate = String.format("%s %s:59:59", cdnInfoListVO.getCdnPromoEdate(), cdnInfoListVO.getEnddt());
		cdnInfoListVO.setCdnPromoEdate(String.valueOf(cdnPromoEdate));*/
		
		// cdn_promo_id
		String cdnPromoId = cdnInfoService.cdnPromoId();
		cdnInfoListVO.setCdnPromoId(String.valueOf(cdnPromoId));
				
		boolean isSuccess = cdnInfoService.cdnDetailInsert(cdnInfoListVO);

		String message = null;

		if (isSuccess) {
			message = "등록되었습니다.";
		} else {
			message = "등록이 실패되었습니다.";
		}

		Map<String, Object> result = new HashMap<String, Object>();

		result.put("MESSAGE", message);
		result.put("cdnPromoId", cdnInfoListVO.getCdnPromoId());
		result.put("dataFileId", dataFileInfoVO.getDataFileId());

		model.addAttribute("json", result);
		return "jsonView";
	}

	// cdn 수정폼
	@RequestMapping("/cdnInfoEdit")
	public String cdnInfoEdit(HttpServletRequest request, @ModelAttribute("ContentsForm") CdnInfoListVO cdnInfoListVO, DataFileServiceInfoVO dataFileServiceInfoVO,
			FileVersionInfoVO fileVersionInfoVO, AppMappingInfoVO appMappingInfoVO, BindingResult bindingResult, Model model) throws Exception {

		CdnInfoListVO cdnInfoList = cdnInfoService.cdnInfoEditList(cdnInfoListVO.getCdnPromoId());

		// DataFileInfoList 조회
		List<DataFileServiceInfoVO> dataFileServiceList = cdnInfoService.cdnFileServiceList(dataFileServiceInfoVO);

		if (cdnInfoListVO.getCdnServiceType().equals("D")) {
			// 데이터 버전 정보
			cdnInfoListVO.setFileVerId(cdnInfoListVO.getCdnServiceId());
			List<CdnInfoListVO> versionInfo = cdnInfoService.versionInfo(cdnInfoListVO);
			model.addAttribute("versionInfo", versionInfo);
		} else {
			appMappingInfoVO.setAppVerId(cdnInfoListVO.getCdnServiceId());
			appMappingInfoVO.setCdnPromoId(cdnInfoListVO.getCdnPromoId());
			List<AppMappingInfoVO> appVerInfo = cdnInfoService.appVerInfo(appMappingInfoVO);
			model.addAttribute("appVerInfo", appVerInfo);
		}

		model.addAttribute("dataFileServiceList", dataFileServiceList);
		model.addAttribute("cdnInfo", cdnInfoList);

		return "jsp/cdnmanagement/cdninfo/cdnInfoEdit";
	}

	// cdn 수정
	@RequestMapping("/cdnInfoUpdate")
	public String cdnInfoUpdate(
			@ModelAttribute("ContentsForm") CdnInfoListVO cdnInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		String cdnPromoSdate = String.format("%s %s:00:00", cdnInfoListVO.getCdnPromoSdate(), cdnInfoListVO.getStartdt());
		cdnInfoListVO.setCdnPromoSdate(String.valueOf(cdnPromoSdate));
		String cdnPromoEdate = String.format("%s %s:59:59", cdnInfoListVO.getCdnPromoEdate(), cdnInfoListVO.getEnddt());
		cdnInfoListVO.setCdnPromoEdate(String.valueOf(cdnPromoEdate));
		
		int result = cdnInfoService.cdnInfoUpdate(cdnInfoListVO);

		if (result > 0) {
			codeMap.put("SUCCESS", "SUCCESS");
		} else {
			codeMap.put("SUCCESS", "FAILED");
		}

		model.addAttribute("json", codeMap);

		return "jsonView";
	}

	// cdn 삭제
	@RequestMapping("/cdnInfoDelete")
	public String cdnInfoDelete(
			@ModelAttribute("ContentsForm") CdnInfoListVO cdnInfoListVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		int result = cdnInfoService.cdnInfoDelete(cdnInfoListVO);

		if (result > 0) {
			codeMap.put("SUCCESS", "SUCCESS");
		} else {
			codeMap.put("SUCCESS", "FAILED");
		}
		model.addAttribute("json", codeMap);

		return "jsonView";
	}
	
	// 배포명 중복확인
	@RequestMapping("/processSerId")
	public String processId(@ModelAttribute("ContentsForm") @Valid CdnInfoListVO cdnInfoListVO, BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();

		String checkServiceName = cdnInfoService.checkServiceName(cdnInfoListVO.getCdnPromoContent());

		codeMap.put("check", checkServiceName);

		model.addAttribute("json", codeMap);

		return "jsonView";
	}
}
