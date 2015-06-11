/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.dataservicemanagement.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.appmanagement.vo.AppInfoListVO;
import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.datafilemanagement.vo.DataTypeInfoVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.dao.AppMappingInfoDAO;
import com.tmap.dataservicemanagement.dao.AppServiceInfoDAO;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.AppServiceInfoVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 13. 
 */

@Service
public class AppMappingInfoService {

	@Autowired
	AppMappingInfoDAO appMappingInfoDAO;
	@Autowired
	AppServiceInfoDAO appServiceInfoDAO;

	//데이터 매핑 정보 리스트 출력
	public List<AppMappingInfoVO> appMappingInfoList(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = appMappingInfoDAO.countAppMappingInfoList(appMappingInfoVO.getAppMappingName());
		appMappingInfoVO.setTotalCount(totalCount);
		
		return appMappingInfoDAO.appMappingInfoList(appMappingInfoVO, appMappingInfoVO.getStartRowNum(), appMappingInfoVO.getCountPerPage());
		
	}
	//AppMappingName 중복체크
  public int appMappingNameCheck(AppMappingInfoVO appMappingInfoVO) throws Exception{
    return appMappingInfoDAO.appMappingNameCheck(appMappingInfoVO); 
  }
	
	
	//사용가능 App정보 리스트
	public List<AppInfoListVO> appList(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		//리스트 수를 조회하여 설정
		int totalCount = appMappingInfoDAO.countAppList(appMappingInfoVO.getSearchAppName());
		appMappingInfoVO.setTotalCount(totalCount);
		
		return appMappingInfoDAO.appList(appMappingInfoVO);
		
	}

	//데이터 파일 리스트(등록)
	public List<DataFileInfoVO> fileInType(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		return appMappingInfoDAO.fileInType(appMappingInfoVO);
		
	}
	
	//데이터 파일 리스트(수정)
	public List<DataFileInfoVO> fileModify(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		return appMappingInfoDAO.fileModify(appMappingInfoVO);
		
	}
	
	//데이터 파일 버전 리스트
	public List<FileVersionInfoVO> verInFile(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		return appMappingInfoDAO.verInFile(appMappingInfoVO);
		
	}
	
	//파일 상세 정보
	public List<DataFileInfoVO> fileDetail(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		return appMappingInfoDAO.fileDetail(appMappingInfoVO);
		
	}
	
	//버전 상세 정보
	public List<AppMappingInfoVO> verDetail(AppMappingInfoVO appMappingInfoVO) throws Exception{
		return appMappingInfoDAO.verDetail(appMappingInfoVO);
	}
	
	//데이터 타입 정보
	public List<DataTypeInfoVO> dataTypeInfo() throws Exception{
		return appMappingInfoDAO.dataTypeInfo();
	}

	
	
	
	
	
	
	
	
	//AppMappingInfo 입력
	public int appMappingInfoInsert(AppMappingInfoVO appMappingInfoVO) throws Exception{
	  int result = appMappingInfoDAO.appMappingInfoInsert(appMappingInfoVO);
	  if(result > 0){
	    //last app_mapping_id
      String appMappingId = appMappingInfoDAO.appMappingId(appMappingInfoVO.getAppMappingName());
      appMappingInfoVO.setAppMappingId(appMappingId);
	  }
	  return result; 
	}

//AppMappingServiceInfo 입력
	public int appMappingServiceInfoInsert(AppMappingInfoVO appMappingInfoVO) throws Exception{
	  int result = appMappingInfoDAO.appMappingServiceInfoInsert(appMappingInfoVO);
	  if (result > 0){
	    //app_map_service_id 획득
	    appMappingInfoVO.setAppServiceId(String.valueOf(appMappingInfoDAO.appMapServiceId()));
	  }else{
	    //디비저장 에러
	  }
	  return result;
	}
	
	//AppMappingDetailInfo등록
	public int appMappingDetailInfoInsert(AppMappingInfoVO appMappingInfoVO) throws Exception{
	 
	  int result = appMappingInfoDAO.appMappingDetailInfo(appMappingInfoVO);
	 	if(result > 0){
	 	 int mapDetailId = appMappingInfoDAO.mapDetailId();
     appMappingInfoVO.setMapDetailId(String.valueOf(mapDetailId));
     //app_file_detail_info 등록
     appMappingInfoDAO.appFileDetailInfo(appMappingInfoVO);
	 	}
	  return result;
	}
	
	//데이터 매핑 정보 입력 
	public int mappingInsert(AppMappingInfoVO appMappingInfoVO) throws Exception{
		//매핑 정보 입력
		int result = appMappingInfoDAO.mappingInsert(appMappingInfoVO);
		
		if(result > 0 && appMappingInfoVO.getDataFileIds() != null){
			
			//last app_mapping_id
			String appMappingId = appMappingInfoDAO.appMappingId(appMappingInfoVO.getAppMappingName());
			appMappingInfoVO.setAppMappingId(appMappingId);
			
			//app_mapping_service_info 기본값 등록
			AppServiceInfoVO appServiceInfoVO = new AppServiceInfoVO();
			appServiceInfoVO.setAppId(appMappingInfoVO.getAppInfoSeq());
			appServiceInfoVO.setAppMappingId(appMappingInfoVO.getAppMappingId());
			appServiceInfoVO.setAppVerId(appMappingInfoVO.getAppVerId());
			appServiceInfoVO.setAppServiceName("");
			appServiceInfoVO.setAppServiceDistribute("W");
			appServiceInfoVO.setAppServiceState("W");
			appServiceInfoVO.setAppServiceType("W");
			appServiceInfoDAO.appServiceInsert(appServiceInfoVO);
			
			//last appMapServiceId
			int appServiceId = appServiceInfoDAO.getLastAppMapServiceId();
			appMappingInfoVO.setAppServiceId(String.valueOf(appServiceId));
			//app_mapping_detail_info 등록
			int result2 = appMappingInfoDAO.appMappingDetailInfo(appMappingInfoVO);
			
			if(result2 > 0){
				
				//last map_detail_id
				int mapDetailId = appMappingInfoDAO.mapDetailId();
				appMappingInfoVO.setMapDetailId(String.valueOf(mapDetailId));
				
				//app_file_detail_info 등록
				appMappingInfoDAO.appFileDetailInfo(appMappingInfoVO);
				
			}
		}
		
		return result;
	
	}
	
	//last app_mapping_id
	public String appMappingId(String appMappingId) throws Exception{
		
		return appMappingInfoDAO.appMappingId(appMappingId);
	}
	
	//매핑 정보
	public AppMappingInfoVO mappingDetail(String appMappingId) throws Exception{
		
		return appMappingInfoDAO.mappingDetail(appMappingId);
	}
	
	public List<AppMappingInfoVO> appMappingDetailInfoList(String appMappingId) throws Exception{
		return appMappingInfoDAO.appMappingDetailInfoList(appMappingId);
	}
	
	//등록된 타입별 파일 정보
	public List<AppMappingInfoVO> typeAndFile(String appMappingId) throws Exception{
		
		return appMappingInfoDAO.typeAndFile(appMappingId);
	}
	//등록된 버전 타입별 파일 정보
		public List<AppMappingInfoVO> verTypeAndFile(AppMappingInfoVO appMappingInfoVO) throws Exception{
			return appMappingInfoDAO.verTypeAndFile(appMappingInfoVO);
		}
	
	//rowSpan
	public List<Map<String, Object>> rowSpan(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		List<Map<String, Object>> rowSpan = appMappingInfoDAO.rowSpan(appMappingInfoVO);
		return rowSpan;
	}
	
	//데이터 정보 수정 
	public void mappingUpdate(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		//등록여부확인
		int result = appMappingInfoDAO.confirm(appMappingInfoVO);
		
		if(result > 0 && appMappingInfoVO.getDataFileIds() != null){
			
			//매핑 데이터 수정 
			appMappingInfoDAO.dataDelete(appMappingInfoVO);
			
			//app_mapping_detail_info 등록
			int result2 = appMappingInfoDAO.appMappingDetailInfo(appMappingInfoVO);
			
			if(result2 > 0){
				
				//last map_detail_id
				int mapDetailId = appMappingInfoDAO.mapDetailId();
				appMappingInfoVO.setMapDetailId(String.valueOf(mapDetailId));
				
				//app_file_detail_info 등록
				appMappingInfoDAO.appFileDetailInfo(appMappingInfoVO);
			}
		
		}else if(result <= 0 && appMappingInfoVO.getDataFileIds() != null){
		
			//app_mapping_detail_info 등록
			int result2 = appMappingInfoDAO.appMappingDetailInfo(appMappingInfoVO);
			
			if(result2 > 0){
				
				//last map_detail_id
				int mapDetailId = appMappingInfoDAO.mapDetailId();
				appMappingInfoVO.setMapDetailId(String.valueOf(mapDetailId));
				
				//app_file_detail_info 등록
				appMappingInfoDAO.appFileDetailInfo(appMappingInfoVO);
			}
		
		}else{
			
			//매핑 데이터 수정 
			appMappingInfoDAO.dataDelete(appMappingInfoVO);
		}
	}
	
	//매핑 정보 수정 
	public void mappingModify(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		//매핑 정보 입력
		appMappingInfoDAO.mappingUpdate(appMappingInfoVO);
	}
	
	//데이터 매핑 정보 삭제 
	public void mappingDelete(String appMappingId) throws Exception{
		
		appMappingInfoDAO.mappingDelete(appMappingId);
	}
	
}
