package com.tmap.datafilemanagement.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.btb.mdcs.model.FileInfoVo;
import com.btb.mdcs.model.CodeVo.FileState;
import com.btb.mdcs.util.DSClient;
import com.tmap.datafilemanagement.service.DataFileInfoService;
import com.tmap.datafilemanagement.service.DataFileListInfoService;
import com.tmap.datafilemanagement.service.FileVersionInfoService;
import com.tmap.datafilemanagement.vo.DataFileListInfoVO;
import com.tmap.servermanagement.service.MapDownServiceService;
import com.tmap.servermanagement.vo.SystemInfoVO;

@Controller
public class DataFileListInfoController {
	@Autowired
	DataFileListInfoService dataFileListInfoService;
	@Autowired
	FileVersionInfoService fileVersionInfoService;
	@Autowired
	DataFileInfoService dataFileInfoService;

	/**
	 * Data File List 조회
	 * @param request
	 * @param fileVerId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataFileListInfoList.do")
	public String dataFileListInfoList(HttpServletRequest request, String dataFileId, String fileVerId, String fileVerName, String dataFileName, Model model) throws Exception {
		model.addAttribute("dataFileId", dataFileId);
		model.addAttribute("fileVerId", fileVerId);
		model.addAttribute("fileVerName", fileVerName);
		model.addAttribute("dataFileName", dataFileName);
		return "jsp/datafilemanagement/datafileinfo/dataFileListInfoUpload";
	}
	
	/**
	 * Data File 업로드
	 * @param request
	 * @param dataFileId
	 * @param fileVerId
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataFileListInfoUpload.do")
	public String dataFileListInfoUpload(HttpServletRequest request, @ModelAttribute("ContentsForm") DataFileListInfoVO dataFileListInfoVO, Model model) throws Exception {
		boolean isSuccess = dataFileListInfoService.fileInfoInsert(request, dataFileListInfoVO);

		String message = null;
		if (isSuccess) {
			// 히스토리 작업
			message = "파일이 저장되었습니다.";
		} else {
			message = "파일 저장이 실패되었습니다.";
		}
		
		dataFileListInfoVO.setUploadFileObj(null);
		List<DataFileListInfoVO> dataFileListInfoList = new ArrayList<DataFileListInfoVO>();
		dataFileListInfoList.add(dataFileListInfoVO);
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MESSAGE", message);
		result.put("dataFileListInfoList", dataFileListInfoList);
		
		model.addAttribute("json", result);
		return "jsonView";		
	}
	
	/**
	 * 파일 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/fileInfoDelete.do")
	public String fileInfoDelete(HttpServletRequest request, @ModelAttribute("ContentsForm") DataFileListInfoVO dataFileListInfoVO, Model model) throws Exception {
		boolean isSuccess = dataFileListInfoService.fileInfoDelete(dataFileListInfoVO);

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
	 * 필수 다운로드 파일로 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/fileInfoRequisite.do")
	public String fileInfoRequisite(HttpServletRequest request, @ModelAttribute("ContentsForm") DataFileListInfoVO dataFileListInfoVO, Model model) throws Exception {
		boolean isSuccess = dataFileListInfoService.fileInfoRequisiteState(dataFileListInfoVO);
		
		String message = null;
		if (isSuccess) {
			// 히스토리 작업
			message = "필수 다운로드 파일로 등록되었습니다.";
		} else {
			message = "필수 다운로드 파일로 등록이 실패되었습니다.";
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MESSAGE", message);
		
		model.addAttribute("json", result);
		return "jsonView";		
	}
	
	/**
	 * 필수 다운로드 파일을 해제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/fileInfoNonRequisite.do")
	public String fileInfoNonRequisite(HttpServletRequest request, @ModelAttribute("ContentsForm") DataFileListInfoVO dataFileListInfoVO, Model model) throws Exception {
		boolean isSuccess = dataFileListInfoService.fileInfoRequisiteState(dataFileListInfoVO);
		
		String message = null;
		if (isSuccess) {
			// 히스토리 작업
			message = "필수 다운로드 파일을 해제되었습니다.";
		} else {
			message = "필수 다운로드 파일을 해제가 실패되었습니다.";
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MESSAGE", message);
		
		model.addAttribute("json", result);
		return "jsonView";		
	}
	
}
