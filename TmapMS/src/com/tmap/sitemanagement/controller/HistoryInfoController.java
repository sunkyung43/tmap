
package com.tmap.sitemanagement.controller;

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

import com.tmap.sitemanagement.service.HistoryInfoService;
import com.tmap.sitemanagement.vo.HistoryInfoListVO;
import com.tmap.sitemanagement.vo.MenuInfoListVO;
import com.tmap.systemmanagement.vo.ComCodeInfoListVO;



@Controller
public class HistoryInfoController {

	/**
	 * Logger
	 */
	@SuppressWarnings("unused")
	private static Logger logger = LoggerFactory.getLogger(HistoryInfoController.class);
	
	@Autowired
	HistoryInfoService historyInfoService;
	
	//검색 조건 초기화
	@SuppressWarnings("unused")
	@ModelAttribute("ContentsForm")
	private HistoryInfoListVO readAdminListParamInit(HistoryInfoListVO historyInfoListVO) {

		if (historyInfoListVO.getWhereEVENTTYPE() == null) {
			historyInfoListVO.setWhereEVENTTYPE("");
		}
		
		if (historyInfoListVO.getWhereIP() == null) {
			historyInfoListVO.setWhereIP("");
		}
		
		if (historyInfoListVO.getWhereMENUID() == null) {
			historyInfoListVO.setWhereMENUID("");
		}
		
		if (historyInfoListVO.getWhereMOFIDYID() == null) {
			historyInfoListVO.setWhereMOFIDYID("");
		}

		return historyInfoListVO;
	}

	//히스토리관리 리스트 출력
	@RequestMapping("/historyInfoList")
	public String historyInfoList(
			HttpServletRequest request,
			@ModelAttribute("ContentsForm") @Valid HistoryInfoListVO historyInfoListVO,
			BindingResult bindingResult,
			Model model) throws Exception{
		
		String whereMODIFYDATEFR = "";
		
		//오늘 날짜
		if( whereMODIFYDATEFR == null || "".equals(whereMODIFYDATEFR) ) {
			java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.util.Calendar cal = java.util.Calendar.getInstance(java.util.Locale.KOREA);
			whereMODIFYDATEFR = format.format(cal.getTime());
		}
		
		//검색 조건 설정
		if(historyInfoListVO.getWhereMODIFYDATEFR() == null){
			historyInfoListVO.setWhereMODIFYDATEFR(whereMODIFYDATEFR);
		}
		if(historyInfoListVO.getWhereMODIFYDATETO() == null){
			historyInfoListVO.setWhereMODIFYDATETO(whereMODIFYDATEFR);
		}
		
		//메뉴 리스트
		List<MenuInfoListVO> menuList = historyInfoService.menuList();
		
		//코드 리스트
		List<ComCodeInfoListVO> codeList = historyInfoService.codeList();
		
		//히스토리 리스트
		List<HistoryInfoListVO> historyInfoList = historyInfoService.historyInfoList(historyInfoListVO);
		
		model.addAttribute("menuList", menuList);
		model.addAttribute("codeList", codeList);
		model.addAttribute("searchInfo", historyInfoListVO);
		model.addAttribute("historyInfoList", historyInfoList);
		
		return "jsp/sitemanagement/historyinfo/historyInfoList";
	}
	
}
