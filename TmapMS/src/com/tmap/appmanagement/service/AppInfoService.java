/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.appmanagement.dao.AppInfoDAO;
import com.tmap.appmanagement.vo.AppInfoListVO;
import com.tmap.appmanagement.vo.TempletModelInfoListVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */

@Service
public class AppInfoService {
	
	@Autowired
	AppInfoDAO appInfoDAO;

	//App관리 리스트 출력
	public List<AppInfoListVO> appInfoList(AppInfoListVO appInfoListVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = appInfoDAO.countAppInfoList(appInfoListVO);
		appInfoListVO.setTotalCount(totalCount);
		
		List<AppInfoListVO> appList = appInfoDAO.appInfoList(appInfoListVO, appInfoListVO.getStartRowNum(), appInfoListVO.getCountPerPage());
		return appList;
	}
	
	//App관리 rowSpan
	public List<Map<String, Object>> rowSpan(AppInfoListVO appInfoListVO) throws Exception{
		
		List<Map<String, Object>> rowSpan = appInfoDAO.rowSpan(appInfoListVO);
		return rowSpan;
	}
	
	//App관리 등록 - 단말조합 정보 리스트
	public List<TempletModelInfoListVO> searchTempletModel(AppInfoListVO appInfoListVO) throws Exception{
		
		List<TempletModelInfoListVO> searchTempletModel = appInfoDAO.searchTempletModel(appInfoListVO);
		return searchTempletModel;
		
	}
	
	//App관리 등록 - 단말모델 정보 리스트
	public List<AppInfoListVO> appInfoNew(AppInfoListVO appInfoListVO) throws Exception{
		
		List<AppInfoListVO> appInfoNew = appInfoDAO.appInfoNew(appInfoListVO);
		return appInfoNew;
		
	}
	
	//App관리 등록 - 단말조합 리스트
	public List<TempletModelInfoListVO> templetModel(String templetModelName) throws Exception{
		
		List<TempletModelInfoListVO> templetModel = appInfoDAO.templetModel(templetModelName);
		return templetModel;
		
	}
	
	//App관리 등록 - app정보등록
	public boolean appInfoInsert(AppInfoListVO appInfoListVO) throws Exception{
		
		int result = appInfoDAO.appInfoInsert(appInfoListVO);
		
		if(result > 0){
			return true;
		}
		
		return false;
	}
	
	//App관리 등록 - 단말모델등록
	public void osPhInfoInsert(AppInfoListVO appInfoListVO) throws Exception{
		
		appInfoDAO.osPhInfoInsert(appInfoListVO);
	}
	
	//App관리 등록 - 버전등록
	public int appVerInsert(AppInfoListVO appInfoListVO) throws Exception{
		
		if(appInfoListVO.getAppInfoSeq() == null){
			
			String seq = appInfoDAO.appInfoSeq(appInfoListVO);
			appInfoListVO.setAppInfoSeq(seq);
		
		}
		
		return appInfoDAO.appVerInsert(appInfoListVO);
	}
	
	//app정보
	public AppInfoListVO appInfo(AppInfoListVO appInfoListVO) throws Exception{
		
		AppInfoListVO appInfo = appInfoDAO.appInfo(appInfoListVO);
		
		return appInfo;
	}
	
	//app사용 단말모델 정보
	public List<AppInfoListVO> verUseOsPh(AppInfoListVO appInfoListVO) throws Exception{
		
		List<AppInfoListVO> appUseOsPh = appInfoDAO.verUseOsPh(appInfoListVO);
		
		return appUseOsPh;
	}
	
	//app사용 단말모델을 제외한 전체 단말모델
	public List<AppInfoListVO> allOsPhInfo(AppInfoListVO appInfoListVO) throws Exception{
		
		List<AppInfoListVO> allOsPhInfo = appInfoDAO.allOsPhInfo(appInfoListVO);
		
		return allOsPhInfo;
	}
	
	//버전정보 리스트 출력
	public List<AppInfoListVO> appVerInfoList(AppInfoListVO appInfoListVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = appInfoDAO.countAppVerInfoList(appInfoListVO);
		appInfoListVO.setTotalCount(totalCount);
		
		List<AppInfoListVO> appVerInfoList = appInfoDAO.appVerInfoList(appInfoListVO, 0, 1000);
		return appVerInfoList;
	}
	
	//버전정보 수정폼
	public AppInfoListVO appVerInfo(AppInfoListVO appInfoListVO) throws Exception{
		
		AppInfoListVO appVerInfo = appInfoDAO.appVerInfo(appInfoListVO);
		
		return appVerInfo;
	}
	
	//버전정보 수정
	public int appVerUpdate(AppInfoListVO appInfoListVO) throws Exception{
		
		return appInfoDAO.appVerUpdate(appInfoListVO);
	}
	
	//버전정보 삭제
	public int appVerDelete(AppInfoListVO appInfoListVO) throws Exception{
		
		return appInfoDAO.appVerDelete(appInfoListVO);
		
	}
	
	//App관리 수정 - app정보수정
	public int appInfoUpdate(AppInfoListVO appInfoListVO) throws Exception{
		
		return appInfoDAO.appInfoUpdate(appInfoListVO);
	}
	
	//App관리 수정 - 단말모델수정
	public void osPhInfoUpdate(AppInfoListVO appInfoListVO) throws Exception{
		
		if(appInfoListVO.getCheckboxPhModelInfos() != null){
			
			//기존 등록된 단말모델 사용여부 변경
			appInfoDAO.osPhInfoDelete(appInfoListVO);
			
			//단말모델 수정
			String seq = appInfoDAO.appInfoSeq(appInfoListVO);
		
			appInfoListVO.setAppInfoSeq(seq);
		
			appInfoDAO.osPhInfoUpdate(appInfoListVO);
		
		}else{
			
			//기존 등록된 단말모델 사용여부 변경
			appInfoDAO.osPhInfoDelete(appInfoListVO);
		}
	}
	
	//App관리 삭제
	public void appInfoDelete(AppInfoListVO appInfoListVO) throws Exception{
		//app_ver_model_info 삭제
		appInfoDAO.appVerModelDeletes(appInfoListVO);
		//app_ver_info 삭제
		appInfoDAO.appVerInfoDeletes(appInfoListVO);
		//app_info 삭제
		appInfoDAO.appInfoDelete(appInfoListVO);
	}
	
}
