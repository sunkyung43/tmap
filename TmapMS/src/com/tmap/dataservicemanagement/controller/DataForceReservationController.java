package com.tmap.dataservicemanagement.controller;

import java.util.List;

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

import com.tmap.appmanagement.service.AppServiceService;
import com.tmap.appmanagement.vo.AppServiceListVO;
import com.tmap.dataservicemanagement.service.DataFileServiceInfoService;
import com.tmap.dataservicemanagement.vo.ForceReservationVO;

@Controller
public class DataForceReservationController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory
			.getLogger(DataForceReservationController.class);

	@Autowired
	DataFileServiceInfoService dataFileServiceInfoService;

	@Autowired
	AppServiceService appServiceService;

	private List<AppServiceListVO> currentOsPhs;

	// Data 강제배포 리스트
	@RequestMapping("/forceReservationList")
	public String forceReservationList(
			HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid ForceReservationVO forceReservationVO,
			BindingResult bindingResult, Model model) throws Exception {

		List<ForceReservationVO> ServiceList = dataFileServiceInfoService
				.forceReservationList(forceReservationVO);
		model.addAttribute("ServiceList", ServiceList);

		return "jsp/dataservicemanagement/dataForceReservation/dataForceReservationList";
	}

	// Data 강제배포
	@RequestMapping("/forceReservationNew")
	public String forceReservationNew(
			HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid ForceReservationVO forceReservationVO,
			BindingResult bindingResult, Model model) throws Exception {

		// 현재 App 리스트
		List<ForceReservationVO> targetAppList = dataFileServiceInfoService
				.targetAppList();
		String selectTargetAppId = forceReservationVO.getSelectTargetAppId();
		String selectTargetAppVerId = forceReservationVO
				.getSelectTargetAppVerId();
		if (selectTargetAppId != null) {
			// 버전정보
			List<ForceReservationVO> targetAppVerList = dataFileServiceInfoService
					.targetVersionList(selectTargetAppId);
			model.addAttribute("targetAppVerList", targetAppVerList);

			// 파일서비스 가져오기
			if (selectTargetAppVerId != null) {
				List<ForceReservationVO> targetDataFileServiceList = dataFileServiceInfoService
						.targetDataFileServiceList(forceReservationVO);
				model.addAttribute("targetDataFileServiceList",
						targetDataFileServiceList);
				currentOsPhs = appServiceService
						.getCurrentOsPhList(selectTargetAppVerId);
				model.addAttribute("currentOsPhs", currentOsPhs);
			}
		}

		model.addAttribute("selectTargetAppId", selectTargetAppId);
		model.addAttribute("selectTargetAppVerId", selectTargetAppVerId);
		model.addAttribute("targetAppList", targetAppList);

		return "jsp/dataservicemanagement/dataForceReservation/dataForceReservationNew";
	}

	// Data 강제배포 리스트
	@RequestMapping("/forceReservationInsert")
	public String forceReservationInsert(
			HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid ForceReservationVO forceReservationVO,
			BindingResult bindingResult, Model model) throws Exception {

		dataFileServiceInfoService.dataForceReservationInsert(forceReservationVO);

		return "redirect:forceReservationList.do";
	}

	// 
	@RequestMapping("/forceReservationEdit")
	public String forceReservationEdit(
			HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid ForceReservationVO forceReservationVO,
			BindingResult bindingResult, Model model) throws Exception {

		//DetailInfo
		ForceReservationVO detailInfo = dataFileServiceInfoService.dataforceReservationDetail(forceReservationVO);
		//Phone Info
		List<ForceReservationVO> phList = dataFileServiceInfoService.phList(forceReservationVO);
		List<ForceReservationVO> verInPhList = dataFileServiceInfoService.verInPhList(forceReservationVO);
		
		for (ForceReservationVO verData : verInPhList) {
			
			for (ForceReservationVO detailData : phList) {
				if(verData.getPhModelId().equals(detailData.getPhModelId())){
					verData.setCheckYn("Y");
					break;
				}
			}
		}
		
		model.addAttribute("detailInfo", detailInfo);
		model.addAttribute("phLIst", verInPhList);
		return "jsp/dataservicemanagement/dataForceReservation/dataForceReservationEdit";
	}
	// Data 강제배포 업데이트
		@RequestMapping("/forceReservationUpdate")
		public String forceReservationUpdate(
				HttpServletRequest request,
				@ModelAttribute("ContentsForm") @Valid ForceReservationVO forceReservationVO,
				BindingResult bindingResult, Model model) throws Exception {

			int result = dataFileServiceInfoService.dataForceReservationUpdate(forceReservationVO);

			return "redirect:forceReservationList.do";
		}
		
		@RequestMapping("/forceReservationDelete")
		public String forceReservationDelete(
				HttpServletRequest request,
				@ModelAttribute("ContentsForm") @Valid ForceReservationVO forceReservationVO,
				BindingResult bindingResult, Model model) throws Exception {

			dataFileServiceInfoService.dataForceReservationDelete(forceReservationVO);

			return "redirect:forceReservationList.do";
		}
}
