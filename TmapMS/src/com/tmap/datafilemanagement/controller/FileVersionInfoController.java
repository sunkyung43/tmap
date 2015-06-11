package com.tmap.datafilemanagement.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tmap.datafilemanagement.service.DataFileListInfoService;
import com.tmap.datafilemanagement.service.FileVersionInfoService;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;

@Controller
public class FileVersionInfoController {
	@Autowired
	FileVersionInfoService fileVersionInfoService;
	@Autowired
	DataFileListInfoService dataFileListInfoService;
	@Autowired
	HistoryInfoService historyInfoService;

	@RequestMapping("/fileVersionInfo.do")
	public String fileVersionInfo(HttpServletRequest request, String fileVersionInfoList, Model model) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("fileVersionInfo", fileVersionInfoService.fileVersionInfo(fileVersionInfoList));
		result.put("dataFileListInfoList", dataFileListInfoService.dataFileListInfoList(fileVersionInfoList));
		
		model.addAttribute("json", result);
		return "jsonView";
	}
	
	/**
	 * File Version 정보 등록
	 * @param request
	 * @param fileVersionInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/fileVersionInfoInsert.do")
	public String fileVersionInfoInsert(HttpServletRequest request, @ModelAttribute("FileVersionForm") FileVersionInfoVO fileVersionInfoVO, Model model) throws Exception{
		boolean isSuccess = fileVersionInfoService.fileVersionInfoInsert(fileVersionInfoVO);

		String message = null;
		if (isSuccess) {
			historyInfoService.insert(TABLE_NAME.file_version_info, fileVersionInfoVO);
			message = "등록되었습니다.";
		} else {
			message = "등록이 실패되었습니다.";
		}

		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MESSAGE", message);
		result.put("dataFileId", fileVersionInfoVO.getDataFileId());
		result.put("fileVerId", fileVersionInfoVO.getFileVerId());
		result.put("fileVerName", fileVersionInfoVO.getFileVerName());
		
		model.addAttribute("json", result);
		return "jsonView";
	}
	
	/**
	 * File Version 정보 수정
	 * @param request
	 * @param fileVersionInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/fileVersionInfoUpdate.do")
	public String fileVersionInfoUpdate(HttpServletRequest request, @ModelAttribute("FileVersionForm") FileVersionInfoVO fileVersionInfoVO, Model model) throws Exception{
		boolean isSuccess = fileVersionInfoService.fileVersionInfoUpdate(fileVersionInfoVO);
		
		String message = null;
		if (isSuccess) {
			historyInfoService.update(TABLE_NAME.file_version_info, fileVersionInfoVO);
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
	 * File Version 정보 삭제
	 * @param request
	 * @param fileVersionInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/fileVersionInfoDelete.do")
	public String fileVersionInfoDelete(HttpServletRequest request, @ModelAttribute("FileVersionForm") FileVersionInfoVO fileVersionInfoVO, Model model) throws Exception{
		boolean isSuccess = fileVersionInfoService.fileVersionInfoDelete(fileVersionInfoVO.getFileVerId());
		
		String message = null;
		if (isSuccess) {
			historyInfoService.delete(TABLE_NAME.file_version_info, fileVersionInfoVO);
			message = "삭제되었습니다.";
		} else {
			message = "삭제가 실패되었습니다.";
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MESSAGE", message);
		
		model.addAttribute("json", result);
		return "jsonView";
	}
}
