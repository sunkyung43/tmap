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
import com.tmap.datafilemanagement.service.DataTypeInfoService;
import com.tmap.datafilemanagement.vo.DataTypeInfoVO;

@Controller
public class DataTypeInfoController {
	@Autowired
	DataTypeInfoService dataTypeInfoService;

	/**
	 * Data File List 조회
	 * @param request
	 * @param dataTypeInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataTypeInfoList.do")
	public String dataTypeInfoList(HttpServletRequest request, @ModelAttribute("ContentsForm") DataTypeInfoVO dataTypeInfoVO, Model model) throws Exception{

		// 초기진입 값 셋팅
		if (CommonUtil.isEmpty(dataTypeInfoVO.getSearchDataTypeState())) {
			dataTypeInfoVO.setSearchDataTypeState("Y");
			//dataTypeInfoVO.setCurrentPage(1);
		}
		
		List<DataTypeInfoVO> dataTypeInfoList = dataTypeInfoService.dataTypeInfoList(dataTypeInfoVO);
		//dataTypeInfoVO.setTotalCount(dataTypeInfoService.countDataTypeInfoList(dataTypeInfoVO));
		
		model.addAttribute("dataTypeInfoList", dataTypeInfoList);
		return "jsp/datafilemanagement/datatypeinfo/dataTypeInfoList";
	}
	
	/**
	 * Data File 상세 조회
	 * @param request
	 * @param dataTypeInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataTypeInfo.do")
	public String dataTypeInfo(HttpServletRequest request, @ModelAttribute("ContentsForm") DataTypeInfoVO dataTypeInfoVO, Model model) throws Exception{
		model.addAttribute("dataTypeInfo", dataTypeInfoService.dataTypeInfo(dataTypeInfoVO));
		return "jsp/datafilemanagement/datatypeinfo/dataTypeInfoEdit";
	}
	
	/**
	 * Data File 정보 수정
	 * @param request
	 * @param dataTypeInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataTypeInfoUpdate.do")
	public String dataTypeInfoUpdate(HttpServletRequest request, @ModelAttribute("ContentsForm") DataTypeInfoVO dataTypeInfoVO, Model model) throws Exception{
		boolean isSuccess = dataTypeInfoService.dataTypeInfoUpdate(dataTypeInfoVO);
		
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
	 * @param dataTypeInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataTypeInfoDelete.do")
	public String dataTypeInfoDelete(HttpServletRequest request, @ModelAttribute("ContentsForm") DataTypeInfoVO dataTypeInfoVO, Model model) throws Exception{
		
		boolean isSuccess = dataTypeInfoService.dataTypeInfoDelete(dataTypeInfoVO);
		
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
	 * @param dataTypeInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataTypeInfoNew.do")
	public String dataTypeInfoNew(HttpServletRequest request, @ModelAttribute("ContentsForm") DataTypeInfoVO dataTypeInfoVO, Model model) throws Exception{
		return "jsp/datafilemanagement/datatypeinfo/dataTypeInfoNew";
	}
	
	/**
	 * Data File 정보 등록
	 * @param request
	 * @param dataTypeInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataTypeInfoInsert.do")
	public String dataTypeInfoInsert(HttpServletRequest request, @ModelAttribute("ContentsForm") DataTypeInfoVO dataTypeInfoVO, Model model) throws Exception{
		boolean isSuccess = dataTypeInfoService.dataTypeInfoInsert(dataTypeInfoVO);
		
		String message = null;
		if (isSuccess) {
			// 히스토리 작업
			message = "등록되었습니다.";
		} else {
			message = "등록 실패되었습니다.";
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MESSAGE", message);
		result.put("dataTypeId", dataTypeInfoVO.getDataTypeId());
		
		model.addAttribute("json", result);
		return "jsonView";
	}
}
