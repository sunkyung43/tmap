package com.tmap.servermanagement.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tmap.common.CacheRemoveUtil;
import com.tmap.common.ConnectInfo;
import com.tmap.servermanagement.service.DownloadInfoService;
import com.tmap.servermanagement.vo.DownloadInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;
import com.tmap.sitemanagement.service.HistoryInfoService;

@Controller
public class DownloadInfoController {

	@Autowired
	DownloadInfoService downloadInfoService;

	@Autowired
	private PlatformTransactionManager transactionManager;

	@Autowired
	HistoryInfoService historyInfoService;

	@RequestMapping("/downloadInfoUpdate")
	public String downloadInfoUpdate(@ModelAttribute("ContentsForm") DownloadInfoVO downloadInfoVO,	BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> codeMap = new HashMap<String, Object>();
		
		if (downloadInfoVO.getServerType().equals("DS")) {
			downloadInfoVO.setServerType("D");
		} else {
			downloadInfoVO.setServerType("C");
		}
		String downloadInfoUpdate = downloadInfoService.downloadUpdate(downloadInfoVO);
		//RS cache 삭제
		//rs정보 획득
		List<SystemInfoVO> rsServerList = downloadInfoService.rsServerList();
		
		for (SystemInfoVO systemInfoVO : rsServerList) {
			ConnectInfo info = new ConnectInfo(systemInfoVO.getSystemIpIn(), systemInfoVO.getSystemPortIn());
			System.out.println(systemInfoVO.getSystemIpIn());
			CacheRemoveUtil request = new CacheRemoveUtil();
			String result = request.requestCacheRemove("cacheType", "DownloadServer", info);
			if(!result.equals("0")){
				System.out.println("error");
			}
		}
		
		codeMap.put("downloadInfoResult", downloadInfoUpdate);

		model.addAttribute("json", codeMap);

		return "jsonView";
	}

	@RequestMapping("/downloadInfo")
	public String downloadInfoNew(@ModelAttribute("ContentsForm") DownloadInfoVO downloadInfoVO,BindingResult bindingResult, Model model) throws Exception {

		DownloadInfoVO dsInfo = downloadInfoService.downloadInfo("D");
		DownloadInfoVO cdnInfo = downloadInfoService.downloadInfo("C");
		model.addAttribute("cdnInfo", cdnInfo);
		model.addAttribute("dsInfo", dsInfo);
		return "jsp/servermanagement/downloadinfo/downloadInfo";
	}

	// 서버기기 등록
	@RequestMapping("/downloadInfoInsert")
	public String downloadInfoInsert(@ModelAttribute("ContentsForm") DownloadInfoVO downloadInfoVO,
			BindingResult bindingResult, Model model) throws Exception {

		Map<String, Object> downloadMap = new HashMap<String, Object>();

		if (downloadInfoVO.getServerType().equals("DS")) {
			downloadInfoVO.setServerType("D");
		} else {
			downloadInfoVO.setServerType("C");
		}
		// 등록
		String downloadInfoInsert = downloadInfoService.downloadInfoInsert(downloadInfoVO);

		// historyInfoService.insert(TABLE_NAME.system_info, systemInfoVO);

		String serverId = downloadInfoService.serverId();

		downloadMap.put("downloadInfoResult", downloadInfoInsert);
		downloadMap.put("serverId", serverId);

		model.addAttribute("json", downloadMap);

		return "jsonView";
	}

}