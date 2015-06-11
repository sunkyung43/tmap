
package com.tmap.appmanagement.controller;

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

import com.tmap.appmanagement.service.PhModelInfoService;
import com.tmap.appmanagement.vo.OsVerInfoListVO;
import com.tmap.appmanagement.vo.PhModelInfoListVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.systemmanagement.service.ComCodeInfoService;
import com.tmap.systemmanagement.vo.ComCodeInfoListVO;


@Controller
public class PhModelInfoController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(PhModelInfoController.class);
	
	@Autowired
	PhModelInfoService phModelInfoService;
	
	@Autowired
	HistoryInfoService historyInfoService;

	@Autowired
	ComCodeInfoService comCodeInfoService;
	
	//단말모델정보 리스트 출력
	@RequestMapping("/PhModelInfoList")
	public String phModelInfoList(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid PhModelInfoListVO phModelInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
				
		if(phModelInfoListVO.getPhName() == null){
			phModelInfoListVO.setPhName("");
		}
		
		if(phModelInfoListVO.getOsVerName() == null){
			phModelInfoListVO.setOsVerName("");
		}
		
		//한 페이지에 출력될 갯수 설정
		//phModelInfoListVO.setCountPerPage(10);
		
		List<PhModelInfoListVO> phModelList = phModelInfoService.phModelInfoList(phModelInfoListVO);
		
		model.addAttribute("phModelList", phModelList); 
		
		return "jsp/appmanagement/phmodelinfo/PhModelInfoList";
	}
	
	//단말모델정보 수정
	@RequestMapping("/PhModelChangeState")
	public String phModelChangeState(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid PhModelInfoListVO phModelInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
			
		if(phModelInfoListVO.getPhModelState().equals("D")){
			phModelInfoService.phModelDelete(phModelInfoListVO);
		} else{
			phModelInfoService.phModelChangeState(phModelInfoListVO);
		}
		
		/*historyInfoService.update(TABLE_NAME.phone_model_info, phModelInfoListVO);*/
		
		return "redirect:DeviceOsVerInfo.do";
	}
	
	//단말모델정보 상세
	@RequestMapping("/PhModelInfoDetail")
	public String phModelInfoDetail(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid PhModelInfoListVO phModelInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
			
		
		Object detail = phModelInfoService.phModelInfoDetail(phModelInfoListVO);
		
		model.addAttribute("detail", detail);
		
		return "jsp/appmanagement/phmodelinfo/PhModelInfoEditForm";
	}
	
}
