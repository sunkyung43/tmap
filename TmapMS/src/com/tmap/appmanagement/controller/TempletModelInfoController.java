
package com.tmap.appmanagement.controller;


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

import com.tmap.appmanagement.service.PhModelInfoService;
import com.tmap.appmanagement.service.TempletModelInfoService;
import com.tmap.appmanagement.vo.OsVerInfoListVO;
import com.tmap.appmanagement.vo.PhModelInfoListVO;
import com.tmap.appmanagement.vo.TempletModelInfoListVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.systemmanagement.service.ComCodeInfoService;
import com.tmap.systemmanagement.vo.ComCodeInfoListVO;




@Controller
public class TempletModelInfoController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(TempletModelInfoController.class);
	
	@Autowired
	TempletModelInfoService templetModelInfoService;
	
	@Autowired
	HistoryInfoService historyInfoService;

	@Autowired
	ComCodeInfoService comCodeInfoService;
	
	@Autowired
	PhModelInfoService phModelInfoService;
	
	//검색 조건 초기화
	@SuppressWarnings("unused")
	@ModelAttribute("ContentsForm")
	private TempletModelInfoListVO readAdminListParamInit(TempletModelInfoListVO templetModelInfoListVO) {

		if (templetModelInfoListVO.getTempletModelName() == null) {
			templetModelInfoListVO.setTempletModelName("");
		}
		
		if(templetModelInfoListVO.getPhName() == null){
			templetModelInfoListVO.setPhName("");
		}
		
		return templetModelInfoListVO;
	}
	
	//단말조합 리스트 출력
	@RequestMapping("/templetModelInfoList")
	public String templetModelInfoList(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid TempletModelInfoListVO templetModelInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		List<TempletModelInfoListVO> templetModelInfoList = templetModelInfoService.templetModelInfoList(templetModelInfoListVO);
		
		request.setAttribute("templetModelInfoList", templetModelInfoList);
		
		return "jsp/appmanagement/templetmodelinfo/templetModelInfoList";
	}
	
	//단말조합 등록폼
	@RequestMapping("/templetModelInfoNew")
	public String templetModelInfoNew(
			@ModelAttribute("ContentsForm") @Valid TempletModelInfoListVO templetModelInfoListVO,
			OsVerInfoListVO osVerInfoListVO, PhModelInfoListVO phModelInfoListVO, BindingResult bindingResult,
			Model model) throws Exception{
		
		if(phModelInfoListVO.getPhName() == null){
			phModelInfoListVO.setPhName("");
		}
		
		if(phModelInfoListVO.getOsVerName() == null){
			phModelInfoListVO.setOsVerName("");
		}
		
		if(phModelInfoListVO.getPhMade() == null){
			phModelInfoListVO.setPhMade("");
		}
		
		if (phModelInfoListVO.getPhDivision() == null) {
			phModelInfoListVO.setPhDivision("AND");
			phModelInfoListVO.setActiveId("0");
			templetModelInfoListVO.setPhDivision("AND");
		}
		
		ComCodeInfoListVO osTypeVo = new ComCodeInfoListVO();
		osTypeVo.setComCode("OSTYPE");
		List<ComCodeInfoListVO> osTypeList = comCodeInfoService.comCodeDetail(osTypeVo);
		
		List<TempletModelInfoListVO> templetModelInfoNew = templetModelInfoService.templetModelInfoNew(templetModelInfoListVO);
		
		List<PhModelInfoListVO> phModelNameList = phModelInfoService.phModelNameList(phModelInfoListVO);
		
		model.addAttribute("templetModelInfoNew", templetModelInfoNew);
		model.addAttribute("osTypeList", osTypeList);
		model.addAttribute("phModelNameList", phModelNameList);
		model.addAttribute("activeId", osVerInfoListVO.getActiveId());
		
		return "jsp/appmanagement/templetmodelinfo/templetModelInfoNew";
	}
	
	//단말조합 등록폼(검색)
	@RequestMapping("/searchPhModel")
	public String searchPhModel(
			@ModelAttribute("ContentsForm") @Valid TempletModelInfoListVO templetModelInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		List<TempletModelInfoListVO> searchPhModel = templetModelInfoService.templetModelInfoNew(templetModelInfoListVO);
		
		codeMap.put("searchPhModel", searchPhModel);	
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//단말조합 등록
	@RequestMapping("/templetModelInfoInsert")
	public String templetModelInfoInsert(
			@ModelAttribute("ContentsForm") @Valid TempletModelInfoListVO templetModelInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		//단말조합 정보 등록
		templetModelInfoService.templetModelInfoInsert(templetModelInfoListVO);
		
		historyInfoService.insert(TABLE_NAME.templet_model_info, templetModelInfoListVO);
		
		//단말모델 정보 등록 
		if(templetModelInfoListVO.getCheckboxPhModelInfos() != null){
			
			templetModelInfoService.osPhInfoInsert(templetModelInfoListVO);
			
			historyInfoService.insert(TABLE_NAME.templet_model_list_info, templetModelInfoListVO);
		}
		
		return "redirect:templetModelInfoList.do";
	}
	
	//단말조합 수정폼
	@RequestMapping("/templetModelInfoEdit")
	public String templetModelInfoEditForm(
			@ModelAttribute("ContentsForm") @Valid TempletModelInfoListVO templetModelInfoListVO, PhModelInfoListVO phModelInfoListVO,
			OsVerInfoListVO osVerInfoListVO, BindingResult bindingResult,
			Model model) throws Exception{
		
		if(phModelInfoListVO.getPhName() == null){
			phModelInfoListVO.setPhName("");
		}
		
		if(phModelInfoListVO.getOsVerName() == null){
			phModelInfoListVO.setOsVerName("");
		}
		
		if(phModelInfoListVO.getPhMade() == null){
			phModelInfoListVO.setPhMade("");
		}
		
		if (phModelInfoListVO.getPhDivision() == null) {
			phModelInfoListVO.setPhDivision("AND");
			templetModelInfoListVO.setPhDivision("AND");
			phModelInfoListVO.setActiveId("0");
		}
		
		ComCodeInfoListVO osTypeVo = new ComCodeInfoListVO();
		osTypeVo.setComCode("OSTYPE");
		List<ComCodeInfoListVO> osTypeList = comCodeInfoService.comCodeDetail(osTypeVo);
		
		//단말조합 정보
		Object templetModelInfo = templetModelInfoService.templetModelInfo(templetModelInfoListVO.getTempletModelId());
		
		//단말조합에 등록된 단말모델
		List<TempletModelInfoListVO> appUseOsPh = templetModelInfoService.appUseOsPh(templetModelInfoListVO.getTempletModelId());
		
		//단말조합에 등록되지 않은 단말모델
		List<TempletModelInfoListVO> allOsPhInfo = templetModelInfoService.allOsPhInfo(templetModelInfoListVO);
		
		List<PhModelInfoListVO> phModelNameList = phModelInfoService.phModelNameList(phModelInfoListVO);
		
		model.addAttribute("templetModelInfo", templetModelInfo);
		model.addAttribute("appUseOsPh", appUseOsPh);
		model.addAttribute("allOsPhInfo", allOsPhInfo);
		model.addAttribute("osTypeList", osTypeList);
		model.addAttribute("phModelNameList", phModelNameList);
		model.addAttribute("activeId", osVerInfoListVO.getActiveId());
		
		return "jsp/appmanagement/templetmodelinfo/templetModelInfoEdit";
	}
	
	//단말조합 수정폼(검색)
	@RequestMapping("/searchModifyPhModel")
	public String searchModifyPhModel(
			@ModelAttribute("ContentsForm") @Valid TempletModelInfoListVO templetModelInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		if(templetModelInfoListVO.getTempletModelId() == null){
			templetModelInfoListVO.setTempletModelId("");
			templetModelInfoListVO.setPhDivision("");
		}
		
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		List<TempletModelInfoListVO> searchModifyPhModel = templetModelInfoService.allOsPhInfo(templetModelInfoListVO);
		
		codeMap.put("searchModifyPhModel", searchModifyPhModel);	
		
		model.addAttribute("json", codeMap);
		
		return "jsonView";
	}
	
	//단말조합 수정
	@RequestMapping("/templetModelInfoUpdate")
	public String templetModelInfoUpdate(
			@ModelAttribute("ContentsForm") @Valid TempletModelInfoListVO templetModelInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		//단말조합 정보 수정
		templetModelInfoService.templetModelInfoUpdate(templetModelInfoListVO);
		
		historyInfoService.update(TABLE_NAME.templet_model_info, templetModelInfoListVO);
		
		//단말모델 수정
		templetModelInfoService.osPhInfoUpdate(templetModelInfoListVO);
		
		historyInfoService.update(TABLE_NAME.templet_model_list_info, templetModelInfoListVO);
		
		return "redirect:templetModelInfoList.do";
	}
	
	//단말조합 삭제
	@RequestMapping("/templetModelInfoDelete")
	public String templetModelInfoDelete(
			@ModelAttribute("ContentsForm") @Valid TempletModelInfoListVO templetModelInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		templetModelInfoService.templetModelInfoDelete(templetModelInfoListVO.getTempletModelId());
		
		historyInfoService.delete(TABLE_NAME.templet_model_info, templetModelInfoListVO);
		historyInfoService.delete(TABLE_NAME.templet_model_list_info, templetModelInfoListVO);
		
		return "redirect:templetModelInfoList.do";
	}
	
}
