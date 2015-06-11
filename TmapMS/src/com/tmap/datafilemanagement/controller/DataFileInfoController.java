package com.tmap.datafilemanagement.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tmap.common.CommonUtil;
import com.tmap.datafilemanagement.service.DataFileInfoService;
import com.tmap.datafilemanagement.service.DataStorageInfoService;
import com.tmap.datafilemanagement.service.DataTypeInfoService;
import com.tmap.datafilemanagement.service.FileVersionInfoService;
import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.datafilemanagement.vo.DataFileListInfoVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;

@Controller
public class DataFileInfoController {
	@Autowired
	DataFileInfoService dataFileInfoService;
	@Autowired
	DataTypeInfoService dataTypeInfoService;
	@Autowired
	DataStorageInfoService dataStorageInfoService;
	@Autowired
	FileVersionInfoService fileVersionInfoService;
	@Autowired
	HistoryInfoService historyInfoService;

	/**
	 * Data File List 조회
	 * @param request
	 * @param dataFileInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataFileInfoList.do")
	public String dataFileInfoList(HttpServletRequest request, @ModelAttribute("ContentsForm") DataFileInfoVO dataFileInfoVO, Model model) throws Exception {
		// 초기진입 값 셋팅
		if (CommonUtil.isEmpty(dataFileInfoVO.getSearchDataFileState())) {
			dataFileInfoVO.setSearchDataFileState("ALL");
			dataFileInfoVO.setSearchDataType("ALL");
			dataFileInfoVO.setCurrentPage(1);
		}
		
		List<DataFileInfoVO> dataFileInfoList = dataFileInfoService.datafileInfoList(dataFileInfoVO);
		dataFileInfoVO.setTotalCount(dataFileInfoService.countDataFileInfoList(dataFileInfoVO));
	
		// 검색조건
		model.addAttribute("dataTypeInfoList", dataTypeInfoService.dataTypeInfoListForSelectBox());
		if(request.getRequestURI().equalsIgnoreCase("cdnInfoNew.do")){
		  Map<String, Object> codeMap = new HashMap<String, Object>();
		  codeMap.put("dataFileInfoList", dataFileInfoList);
		  model.addAttribute("json", codeMap);
		  
		  return "jsonView";
		}else{
		  model.addAttribute("dataFileInfoList", dataFileInfoList);
		  return "jsp/datafilemanagement/datafileinfo/dataFileInfoList";
		}
	}
	
	/**
	 * Data File 상세 조회
	 * @param request
	 * @param dataTypeInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataFileInfo.do")
	public String dataFileInfo(HttpServletRequest request, DataFileInfoVO dataFileInfoVO, Model model) throws Exception {
		dataFileInfoVO = dataFileInfoService.dataFileInfo(dataFileInfoVO);
		
		FileVersionInfoVO fileVersionInfo = new FileVersionInfoVO();
		fileVersionInfo.setDataFileId(dataFileInfoVO.getDataFileId());
		
		DataFileListInfoVO dataFileListInfo = new DataFileListInfoVO();
		dataFileListInfo.setDataFileId(dataFileInfoVO.getDataFileId());
		
		model.addAttribute("dataFileInfo", dataFileInfoVO);
		model.addAttribute("DataFileForm", dataFileInfoVO);
		model.addAttribute("fileVersionInfo", fileVersionInfo);
		model.addAttribute("FileVersionForm", fileVersionInfo);
		model.addAttribute("DataFileListForm", dataFileListInfo);
		model.addAttribute("fileVersionInfoList", fileVersionInfoService.fileVersionInfoList(dataFileInfoVO.getDataFileId()));
		return "jsp/datafilemanagement/datafileinfo/dataFileInfoEdit";
	}
	
	/**
	 * Data File 등록 화면
	 * @param request
	 * @param dataFileInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataFileInfoNew.do")
	public String dataFileInfoNew(HttpServletRequest request, DataFileInfoVO dataFileInfoVO, Model model) throws Exception {
		dataFileInfoVO.setDataTypeInfoList(dataTypeInfoService.dataTypeInfoListForSelectBox());
		dataFileInfoVO.setDataStorageInfoList(dataStorageInfoService.dataStorageInfoListForSelectBox());
		
		FileVersionInfoVO fileVersionInfo = new FileVersionInfoVO();
		DataFileListInfoVO dataFileListInfo = new DataFileListInfoVO();
		
		model.addAttribute("ContentsForm", dataFileInfoVO);
		model.addAttribute("FileVersionForm", fileVersionInfo);
		model.addAttribute("DataFileListForm", dataFileListInfo);
		
		return "jsp/datafilemanagement/datafileinfo/dataFileInfoNew";
//		 @ModelAttribute("ContentsForm")
	}
	
	/**
	 * Data File 상세 정보 등록
	 * @param request
	 * @param dataTypeInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataFileInfoInsert.do")
	public String dataFileInfoInsert(HttpServletRequest request, DataFileInfoVO dataFileInfoVO, Model model) throws Exception {
		
		boolean isSuccess = dataFileInfoService.dataFileInfoInsert(dataFileInfoVO);
		
		String message = null;
		if (isSuccess) {
			historyInfoService.insert(TABLE_NAME.data_file_info, dataFileInfoVO);
			message = "등록되었습니다.";
		} else {
			message = "등록이 실패되었습니다.";
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MESSAGE", message);
		result.put("dataFileId", dataFileInfoVO.getDataFileId());
		result.put("DataFileName", dataFileInfoVO.getDataFileName()); //getDataFileName
		result.put("DataFileState", dataFileInfoVO.getDataFileState()); //getDataFileState
		result.put("DataFileContent", dataFileInfoVO.getDataFileContent()); //getDataFileContent
		
		model.addAttribute("json", result);
		return "jsonView";
	}
	
	/**
	 * Data File 상세 정보 수정
	 * @param request
	 * @param dataTypeInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataFileInfoUpdate.do")
	public String dataFileInfoUpdate(HttpServletRequest request, @ModelAttribute("DataFileForm") DataFileInfoVO dataFileInfoVO, Model model) throws Exception {
		boolean isSuccess = dataFileInfoService.dataFileInfoUpdate(dataFileInfoVO);
		
		String message = null;
		if (isSuccess) {
			historyInfoService.update(TABLE_NAME.data_file_info, dataFileInfoVO);
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
	 * Data File 상세 정보 삭제
	 * @param request
	 * @param dataTypeInfoVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dataFileInfoDelete.do")
	public String dataFileInfoDelete(HttpServletRequest request, @ModelAttribute("DataFileForm") DataFileInfoVO dataFileInfoVO, Model model) throws Exception {
		boolean isSuccess = dataFileInfoService.dataFileInfoDelete(dataFileInfoVO.getDataFileId());
		
		String message = null;
		if (isSuccess) {
			historyInfoService.delete(TABLE_NAME.data_file_info, dataFileInfoVO);
			message = "삭제되었습니다.";
		} else {
			message = "삭제가 실패되었습니다.";
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("MESSAGE", message);
		
		model.addAttribute("json", result);
		return "jsonView";
	}
	
	@InitBinder(value="DataFileForm")
	public void dataFileInfoVOInitBinder() {
	}
}
