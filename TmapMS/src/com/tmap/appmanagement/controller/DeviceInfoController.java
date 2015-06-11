
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

import com.tmap.appmanagement.service.DeviceInfoService;
import com.tmap.appmanagement.service.OsVerInfoService;
import com.tmap.appmanagement.service.PhInfoService;
import com.tmap.appmanagement.service.PhModelInfoService;
import com.tmap.appmanagement.vo.OsVerInfoListVO;
import com.tmap.appmanagement.vo.PhInfoListVO;
import com.tmap.appmanagement.vo.PhModelInfoListVO;
import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.systemmanagement.service.ComCodeInfoService;
import com.tmap.systemmanagement.vo.ComCodeInfoListVO;



@Controller
public class DeviceInfoController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(DeviceInfoController.class);
	
	@Autowired
	DeviceInfoService deviceInfoService;
	@Autowired
	OsVerInfoService osVerInfoService;
	@Autowired
	HistoryInfoService historyInfoService;

	@Autowired
	ComCodeInfoService comCodeInfoService;
	
	@Autowired
	PhModelInfoService phModelInfoService;
	
	@Autowired
	PhInfoService phInfoService;
	
	//단말관리
	@RequestMapping("/DeviceInfoFrame")
	public String menuInfoList(HttpServletRequest request,
			@ModelAttribute("ContentsForm") PhModelInfoListVO phModelInfoListVO, 
			OsVerInfoListVO osVerInfoListVO, PhInfoListVO phInfoListVO,  Model model) throws Exception{
		
		if(phInfoListVO.getPhName() == null || phInfoListVO.getPhName() == ","){
			phInfoListVO.setPhName("");
		}
		
		if(phInfoListVO.getPhMade() == null){
			phInfoListVO.setPhMade("");
		}
		
		//한 페이지에 출력될 갯수 설정
		//phInfoListVO.setCountPerPage(5);
		
		ComCodeInfoListVO osTypeVo = new ComCodeInfoListVO();
		osTypeVo.setComCode("OSTYPE");
		List<ComCodeInfoListVO> osTypeList = comCodeInfoService.comCodeDetail(osTypeVo);
		if (osVerInfoListVO.getOsDivision() == null) {
			osVerInfoListVO.setOsDivision("AND");
			osVerInfoListVO.setActiveId("0");
		}
		
		List<PhInfoListVO> phInfoList = phInfoService.phOsInfo(phInfoListVO);
		
		List<PhInfoListVO> phMadeList = phInfoService.phMadeList(phInfoListVO);
		
		model.addAttribute("phInfoList", phInfoList);
		model.addAttribute("phMadeList", phMadeList);
		model.addAttribute("osTypeList", osTypeList);
		
		return "jsp/appmanagement/deviceinfo/DeviceInfoFrame";
	}
	
	//OS리스트 획득
	@RequestMapping("/OSModelInfoList")
	public String osModelInfoList(HttpServletRequest request,@ModelAttribute("ContentsForm") 
	PhModelInfoListVO phModelInfoListVO, OsVerInfoListVO osVerInfoListVO, BindingResult result, Model model) throws Exception{
		
		/*OsVerInfoListVO osVerInfoListVo = new OsVerInfoListVO();
		osVerInfoListVo.setOsDivision(phModelInfoListVO.getPhDivision());*/
		
		if(phModelInfoListVO.getPhDivision() == ""){
				osVerInfoListVO.setOsDivision("AND");
				osVerInfoListVO.setActiveId("0");
			}else{
			osVerInfoListVO.setOsDivision(phModelInfoListVO.getPhDivision());
		}
			
		List<OsVerInfoListVO> osVerInfoFrame = osVerInfoService.phOsVerInfo(osVerInfoListVO);
		model.addAttribute("osVerInfoFrame", osVerInfoFrame );
		
		return "jsp/appmanagement/deviceinfo/osModelInfoList";
	}
	
	//단말모델 등록
	@RequestMapping("/PhModelInfoNew")
	public String phModelInfoNew(HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid PhModelInfoListVO phModelInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
				
		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		String message = deviceInfoService.phModelInfoNew(phModelInfoListVO);
		
		/*historyInfoService.insert(TABLE_NAME.phone_model_info, phModelInfoListVO);*/
		codeMap.put("message", message);
		//request.setAttribute("message", message);
		//model.addAttribute("message", message);
		model.addAttribute("json", codeMap);
		/*return "redirect:DeviceOsVerInfo";*/
		
		return "jsonView";
	}
	
	//단말관리
		@RequestMapping("/DeviceOsVerInfo")
		public String menuOsVerInfoList(HttpServletRequest request,
				@ModelAttribute("ContentsForm") @Valid PhModelInfoListVO phModelInfoListVO, PhInfoListVO phInfoListVO,
				OsVerInfoListVO osVerInfoListVO, BindingResult bindingResult, Model model) throws Exception{
				
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
			}
			
			ComCodeInfoListVO osTypeVo = new ComCodeInfoListVO();
			osTypeVo.setComCode("OSTYPE");
			List<ComCodeInfoListVO> osTypeList = comCodeInfoService.comCodeDetail(osTypeVo);
			
			//한 페이지에 출력될 갯수 설정
			//phModelInfoListVO.setCountPerPage(7);
			
			List<PhInfoListVO> phMadeList = phInfoService.phMadeList(phInfoListVO);
			
			if(phModelInfoListVO.getPhMade() == null) {
				List<PhModelInfoListVO> phModelNameList = phModelInfoService.phModelNameList(phModelInfoListVO);
				model.addAttribute("phModelNameList", phModelNameList);
			} else {
				List<PhModelInfoListVO> phModelNameList = phModelInfoService.phModelNameList(phModelInfoListVO);
				model.addAttribute("phModelNameList", phModelNameList);
			}
			List<PhModelInfoListVO> phModelList = phModelInfoService.phModelInfoList(phModelInfoListVO);
			
			model.addAttribute("activeId", osVerInfoListVO.getActiveId());
			model.addAttribute("osTypeList", osTypeList);
			model.addAttribute("phModelList", phModelList); 
			model.addAttribute("phMadeList", phMadeList);
			
			return "jsp/appmanagement/deviceosverinfo/DeviceOsVerInfo";
		}
}
