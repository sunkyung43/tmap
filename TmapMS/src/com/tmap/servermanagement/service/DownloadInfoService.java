package com.tmap.servermanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.servermanagement.dao.DownloadInfoDAO;
import com.tmap.servermanagement.vo.DownloadInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;


@Service
public class DownloadInfoService {

	@Autowired
	DownloadInfoDAO downloadInfoDAO;

	
/*	// 다운로드 서버 정보
	public List<DownloadInfoVO> downloadInfoList(DownloadInfoVO downloadInfoVO)
			throws Exception {

		// 리스트 수를 조회하여 설정
		int totalCount = downloadInfoDAO.countDownloadInfoList(downloadInfoVO);
		downloadInfoVO.setTotalCount(totalCount);

		return downloadInfoDAO.downloadInfoList(downloadInfoVO,
				downloadInfoVO.getStartRowNum(),
				downloadInfoVO.getCountPerPage());
	}*/

	/*
	 * //통신방식명 중복체크 public String checkName(String checkName) throws Exception{
	 * 
	 * int result = downloadInfoDAO.checkName(checkName);
	 * 
	 * if(result > 0){ return "failed"; }else{ return "success"; }
	 * 
	 * }
	 */

	// 다운로드 서버 등록
	public String downloadInfoInsert(DownloadInfoVO downloadInfoVO)
			throws Exception {

		int result = downloadInfoDAO.downloadInfoInsert(downloadInfoVO);

		if (result > 0) {
			return "success";
		} else {
			return "failed";
		}
	}

	public String serverId() throws Exception {

		int result = downloadInfoDAO.serverId();

		return String.valueOf(result);
	}

	// 다운로드 서버 Detail
	public DownloadInfoVO downloadInfo(String type) throws Exception {

		return downloadInfoDAO.downloadInfo(type);
	}

	// 다운로드 서버 수정
	public String downloadUpdate(DownloadInfoVO downloadInfoVO)	throws Exception {

		
		int result = downloadInfoDAO.downloadUpdate(downloadInfoVO);

		if (result > 0) {
			return "success";
		} else {
			return "failed";
		}
	}
	public List<SystemInfoVO> rsServerList() throws Exception{
		
		return downloadInfoDAO.rsServerList();
	}
}
