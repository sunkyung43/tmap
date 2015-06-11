package com.tmap.datafilemanagement.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tmap.common.CommonUtil;
import com.tmap.datafilemanagement.service.DataStorageInfoService;
import com.tmap.datafilemanagement.vo.DataStorageInfoVO;

@Controller
public class DataStorageInfoController {
	@Autowired
	DataStorageInfoService dataStorageInfoService;

	/**
	 * Data Storage List 조회
	 * @param request
	 * @param dataStorageInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataStorageInfoList.do")
	public String dataStorageInfoList(HttpServletRequest request, @ModelAttribute("ContentsForm") DataStorageInfoVO dataStorageInfoVO, Model model) throws Exception{

		// 초기진입 값 셋팅
		if (CommonUtil.isEmpty(dataStorageInfoVO.getSearchDataStorageState())) {
			dataStorageInfoVO.setSearchDataStorageState("Y");
			dataStorageInfoVO.setSearchDataStorageCurrent("C");
			dataStorageInfoVO.setCurrentPage(1);
		}
		
		List<DataStorageInfoVO> dataStorageInfoList = dataStorageInfoService.dataStorageInfoList(dataStorageInfoVO);
		dataStorageInfoVO.setTotalCount(dataStorageInfoService.countDataStorageInfoList(dataStorageInfoVO));
		
		model.addAttribute("dataStorageInfoList", dataStorageInfoList);
		return "jsp/datafilemanagement/datastorageinfo/dataStorageInfoList";
	}

	/**
	 * Data File 상세 조회
	 * @param request
	 * @param dataTypeInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataStorageInfo.do")
	public String dataStorageInfo(HttpServletRequest request, @ModelAttribute("ContentsForm") DataStorageInfoVO dataStorageInfoVO, Model model) throws Exception{
		model.addAttribute("dataStorageInfo", dataStorageInfoService.dataStorageInfo(dataStorageInfoVO));
		return "jsp/datafilemanagement/datastorageinfo/dataStorageInfoEdit";
	}
	
	/**
	 * Data File 정보 수정
	 * @param request
	 * @param dataStorageInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataStorageInfoUpdate.do")
	public String dataStorageInfoUpdate(HttpServletRequest request, @ModelAttribute("ContentsForm") DataStorageInfoVO dataStorageInfoVO, Model model) throws Exception{
		boolean isSuccess = dataStorageInfoService.dataStorageInfoUpdate(dataStorageInfoVO);
		
		String message = null;
		if (isSuccess) {
			// 히스토리 작업
			message = "수정되었습니다.";
		} else {
			message = "수정이 실패되었습니다.";
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MESSAGE", message);
		
		model.addAttribute("json", result);
		return "jsonView";
	}
	
	/**
	 * Data File 정보 삭제
	 * @param request
	 * @param dataStorageInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataStorageInfoDelete.do")
	public String dataStorageInfoDelete(HttpServletRequest request, @ModelAttribute("ContentsForm") DataStorageInfoVO dataStorageInfoVO, Model model) throws Exception{
		boolean isSuccess = dataStorageInfoService.dataStorageInfoDelete(dataStorageInfoVO);
		
		String message = null;
		if (isSuccess) {
			// 히스토리 작업
			message = "삭제되었습니다.";
		} else {
			message = "삭제가 실패되었습니다.";
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MESSAGE", message);
		
		model.addAttribute("json", result);
		return "jsonView";
	}

	/**
	 * Data File 정보 등록 화면으로 이동
	 * @param request
	 * @param dataStorageInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataStorageInfoNew.do")
	public String dataStorageInfoNew(HttpServletRequest request, @ModelAttribute("ContentsForm") DataStorageInfoVO dataStorageInfoVO, Model model) throws Exception{
		return "jsp/datafilemanagement/datastorageinfo/dataStorageInfoNew";
	}
	
	/**
	 * Data File 정보 등록
	 * @param request
	 * @param dataStorageInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataStorageInfoInsert.do")
	public String dataStorageInfoInsert(HttpServletRequest request, @ModelAttribute("ContentsForm") DataStorageInfoVO dataStorageInfoVO, Model model) throws Exception{
		boolean isSuccess = dataStorageInfoService.dataStorageInfoInsert(dataStorageInfoVO);
		
		String message = null;
		if (isSuccess) {
			// 히스토리 작업
			message = "등록되었습니다.";
		} else {
			message = "등록 실패되었습니다.";
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MESSAGE", message);
		result.put("storageId", dataStorageInfoVO.getStorageId());
		
		model.addAttribute("json", result);
		return "jsonView";
	}
}
