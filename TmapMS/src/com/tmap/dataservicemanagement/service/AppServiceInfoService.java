/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.dataservicemanagement.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.dataservicemanagement.dao.AppServiceInfoDAO;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.AppServiceInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */

@Service
public class AppServiceInfoService {

	@Autowired
	AppServiceInfoDAO appServiceInfoDAO;
	
	//데이터 매핑 정보 리스트 출력
	public List<AppMappingInfoVO> appServiceInfoList(AppServiceInfoVO appServiceInfoVO) throws Exception{
		if(appServiceInfoVO.getAppServiceType().equals("W")) {
			//리스트 수를 조회하여 설정
			int totalCount = appServiceInfoDAO.countAppServiceInfoListReady(appServiceInfoVO.getAppMappingName());
			appServiceInfoVO.setTotalCount(totalCount);
			
			return appServiceInfoDAO.appServiceInfoList(appServiceInfoVO, appServiceInfoVO.getStartRowNum(), appServiceInfoVO.getCountPerPage());
		}else{
			//리스트 수를 조회하여 설정
			int totalCount = appServiceInfoDAO.countAppServiceInfoList(appServiceInfoVO.getAppMappingName());
			appServiceInfoVO.setTotalCount(totalCount);
			
			return appServiceInfoDAO.appServiceInfoList(appServiceInfoVO, appServiceInfoVO.getStartRowNum(), appServiceInfoVO.getCountPerPage());
		}
		
	}
	
	//배포 정보
	public AppServiceInfoVO serviceDetail(String appMappingId) throws Exception{
		
		return appServiceInfoDAO.serviceDetail(appMappingId);
	}
	
	//매핑 정보
	public AppMappingInfoVO mappingDetail(String appMappingId) throws Exception{
		
		return appServiceInfoDAO.mappingDetail(appMappingId);
	}

	//등록된 타입별 파일 정보
	public List<AppMappingInfoVO> typeAndFile(String appMappingId) throws Exception{
		
		return appServiceInfoDAO.typeAndFile(appMappingId);
	}
	
	//rowSpan
	public List<Map<String, Object>> rowSpan(String appMappingId) throws Exception{
		
		List<Map<String, Object>> rowSpan = appServiceInfoDAO.rowSpan(appMappingId);
		return rowSpan;
	}
	
	//파일 상세 정보
	public List<DataFileInfoVO> fileDetail(AppServiceInfoVO appServiceInfoVO) throws Exception{
		
		return appServiceInfoDAO.fileDetail(appServiceInfoVO);
		
	}
	
	//배포 정보 수정
	public void appServiceUpdate(AppServiceInfoVO appServiceInfoVO) throws Exception{
		

		if(appServiceInfoVO.getAppServiceState().equals("N")){
			
			appServiceInfoVO.setAppServiceType("F");
			appServiceInfoVO.setAppServiceDistribute("F");
		
		}
		
		if(appServiceInfoVO.getAppServiceId() == ""){
			
			//배포 정보 등록
			appServiceInfoDAO.appServiceInsert(appServiceInfoVO);
		
		}else{
			
			//배포 정보 수정
			appServiceInfoDAO.appServiceUpdate(appServiceInfoVO);
		
		}
	}
	
	//배포 ID 검색
	public int appMappingId(String appServiceName) throws Exception{
		
		return appServiceInfoDAO.appMappingId(appServiceName);
	}
	
	//배포 정보 삭제 
	public void serviceDelete(String appServiceId) throws Exception{
		
		appServiceInfoDAO.serviceDelete(appServiceId);
	}
	
	//배포명 중복확인
	public String checkServiceName(String checkServiceName) throws Exception{
		
		String check = "";
		int result = appServiceInfoDAO.checkServiceName(checkServiceName);
		
		if(result > 0){
			check = "success";
		}else{
			check = "failed";
		}
		
		return check;
	}
	
	
	
}
