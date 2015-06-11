/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.btb.mdcs.util.DSClient;
import com.btb.mdcs.util.ResultCondition;
import com.tmap.servermanagement.service.SystemInfoService;
import com.tmap.servermanagement.vo.ComCodeInfoVO;
import com.tmap.servermanagement.vo.ComTypeInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;
import com.tmap.sitemanagement.TABLE_NAME;
import com.tmap.sitemanagement.service.HistoryInfoService;

/**
 * <br/>
 * 
 * @author 김경민
 * @date 2012. 9. 6.
 */

@Controller
public class SystemInfoController {
  
  @Autowired
  SystemInfoService systemInfoService;
  
  @Autowired
  HistoryInfoService historyInfoService;
  
  /**
   * Logger
   */
  @SuppressWarnings("unused")
  private static Logger logger = LoggerFactory.getLogger(SystemInfoController.class);
  
  // 검색 조건 초기화
  @SuppressWarnings("unused")
  @ModelAttribute("ContentsForm")
  private SystemInfoVO readAdminListParamInit(SystemInfoVO systemInfoVO) {
    
    if (systemInfoVO.getSystemName() == null) {
      systemInfoVO.setSystemName("");
    }
    
    return systemInfoVO;
  }
  
  // 서버기기 리스트
  @RequestMapping("/systemInfoList")
  public String systemInfoList(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult, Model model) throws Exception {
    
    List<SystemInfoVO> systemInfoList = systemInfoService.systemInfoList(systemInfoVO);
    
    model.addAttribute("systemInfoList", systemInfoList);
    
    return "jsp/servermanagement/systeminfo/systemInfoList";
  }
  
  // 서버기기 등록폼
  @RequestMapping("/systemInfoNew")
  public String systemInfoNew(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult, Model model) throws Exception {
    
    List<SystemInfoVO> defaultComSet = systemInfoService.defaultComSetInfo();
    model.addAttribute("comSetInfo", defaultComSet);
    // 서버구분 리스트
    // List<SystemInfoVO> serverType = systemInfoService.serverType();
    List<ComCodeInfoVO> srvType = systemInfoService.srvType();
    
    // 통신방식 리스트
    // List<ComTypeInfoVO> comType = systemInfoService.comType();
    List<ComCodeInfoVO> comType = systemInfoService.comType();
    
    model.addAttribute("serverType", srvType);
    model.addAttribute("comType", comType);
    
    return "jsp/servermanagement/systeminfo/systemInfoNew";
  }
  
  // 서버기기명 중복체크
  @RequestMapping("/processNameDuplication")
  public String processNameDuplication(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult, Model model) throws Exception {
    
    Map<String, Object> codeMap = new HashMap<String, Object>();
    
    String checkName = systemInfoService.checkName(systemInfoVO.getSystemName());
    
    codeMap.put("checkName", checkName);
    
    model.addAttribute("json", codeMap);
    
    return "jsonView";
  }
  
  // 서버기기 등록
  @RequestMapping("/systemInfoInsert")
  public String systemInfoInsert(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult, Model model) throws Exception {
    
    Map<String, Object> codeMap = new HashMap<String, Object>();
    
    // 등록
    String systemInfoInsert = systemInfoService.systemInfoInsert(systemInfoVO);
    
//    historyInfoService.insert(TABLE_NAME.system_info, systemInfoVO);
    
    int systemId = systemInfoService.systemId(systemInfoVO.getSystemName());
    
    codeMap.put("systemInfoInsert", systemInfoInsert);
    codeMap.put("systemId", systemId);
    
    model.addAttribute("json", codeMap);
    
    return "jsonView";
  }
  
  // 서버기기 등록폼
  @RequestMapping("/systemInfoEdit")
  public String systemInfoEdit(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult, Model model) throws Exception {
    
	if (logger.isDebugEnabled()) {  
		logger.debug("SystemInfoVO : {0}", systemInfoVO);
	}
	
    // 서버기기 상세정보
    SystemInfoVO systemInfo = systemInfoService.systemInfo(systemInfoVO.getSystemId());
    
    if (systemInfo.getServerTypeCode().equals("1")) {
      // 통식방식 상세정보
      List<SystemInfoVO> comTypeInfo = systemInfoService.comTypeInfo(systemInfo.getSystemId());
      model.addAttribute("comTypeInfo", comTypeInfo);
      
      // 서비스운영 상세정보
      Object mapdownManageInfo = systemInfoService.mapdownManageInfo(systemInfo.getSystemId());
      model.addAttribute("mapdownManageInfo", mapdownManageInfo);
    }
    
    model.addAttribute("systemInfo", systemInfo);
    
    model.addAttribute("serverTypeName", systemInfo.getServerTypeName());
    
    return "jsp/servermanagement/systeminfo/systemInfoEdit";
  }
  
  // 서버기기 수정
  @RequestMapping("/systemInfoUpdate")
  public String systemInfoUpdate(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult, Model model) throws Exception {
    
    Map<String, Object> codeMap = new HashMap<String, Object>();
    
    // 수정
    String systemInfoUpdate = systemInfoService.systemInfoUpdate(systemInfoVO);
    
    historyInfoService.update(TABLE_NAME.system_info, systemInfoVO);
    
    codeMap.put("systemInfoUpdate", systemInfoUpdate);
    codeMap.put("systemId", systemInfoVO.getSystemId());
    
    model.addAttribute("json", codeMap);
    
    return "jsonView";
  }
  
  // 서버기기 삭제
  @RequestMapping("/systemInfoDelete")
  public String systemInfoDelete(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult, Model model) throws Exception {
    
    systemInfoService.systemInfoDelete(systemInfoVO);
    
    historyInfoService.delete(TABLE_NAME.system_info, systemInfoVO);
    
    return "jsonView";
  }
//서버기기 삭제
 @RequestMapping("/systemSync")
 public String systemSync(@ModelAttribute("ContentsForm") @Valid SystemInfoVO systemInfoVO, BindingResult bindingResult, Model model) throws Exception {
   
	 Map<String, Object> codeMap = new HashMap<String, Object>();
	 String syncResult = systemInfoService.systemSync(systemInfoVO.getSystemId());
	 codeMap.put("result", syncResult);
	 model.addAttribute("json", codeMap);
   return "jsonView";
 }
}
