/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.dataservicemanagement.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.appmanagement.vo.AppInfoListVO;
import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.datafilemanagement.vo.DataTypeInfoVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.AppServiceInfoVO;

@Repository
public class AppMappingInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//데이터 매핑 정보 리스트 출력
	public List<AppMappingInfoVO> appMappingInfoList(AppMappingInfoVO appMappingInfoVO, int skipResults, int maxResults){
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.appMappingInfoList", appMappingInfoVO, rowBounds); 
	}
	
	//데이터 매핑 정보 리스트 수
	public int countAppMappingInfoList(String appMappingName){
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appMappingInfoSqlMap.countAppMappingInfoList", appMappingName);
	}
	
	//사용가능 App정보 리스트
	public List<AppInfoListVO> appList(AppMappingInfoVO appMappingInfoVO){
		//RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.appList", appMappingInfoVO); 
	}
	
	//용가능 App정보 리스트 수
	public int countAppList(String searchAppName){
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appMappingInfoSqlMap.countAppList", searchAppName);
	}
	
	//데이터 파일 리스트(등록)
	public List<DataFileInfoVO> fileInType(AppMappingInfoVO appMappingInfoVO){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.fileInType", appMappingInfoVO);
	}
	
	//데이터 파일 리스트(수정)
	public List<DataFileInfoVO> fileModify(AppMappingInfoVO appMappingInfoVO){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.fileModify", appMappingInfoVO);
	}
	
	//데이터 파일 버전 리스트
	public List<FileVersionInfoVO> verInFile(AppMappingInfoVO appMappingInfoVO){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.verInFile", appMappingInfoVO);
	}
	
	//파일 상세 정보
	public List<DataFileInfoVO> fileDetail(AppMappingInfoVO appMappingInfoVO) throws Exception{
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.fileDetail", appMappingInfoVO);
	}
	
	//버전 상세 정보
	public List<AppMappingInfoVO> verDetail(AppMappingInfoVO appMappingInfoVO){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.verDetail", appMappingInfoVO);
	}
	
	//데이터 타입 정보
	public List<DataTypeInfoVO> dataTypeInfo(){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.dataTypeList"); 
	}
	
	//데이터 매핑 정보 입력 
	public int mappingInsert(AppMappingInfoVO appMappingInfoVO){
		return sqlSessionTemplate.insert("com.tmap.sqlMap.appMappingInfoSqlMap.mappingInsert", appMappingInfoVO);
	}
	
	//appMapping정보 입력
	public int appMappingInfoInsert(AppMappingInfoVO appMappingInfoVo){
	  return sqlSessionTemplate.insert("com.tmap.sqlMap.appMappingInfoSqlMap.appMappingInsert", appMappingInfoVo);
	}
	
	 //배포 정보 등록
  public int appMappingServiceInfoInsert(AppMappingInfoVO appMappingInfoVo){
    return sqlSessionTemplate.insert("com.tmap.sqlMap.appMappingInfoSqlMap.appMappingServiceInfoInsert", appMappingInfoVo);
  }
  
  //last app_map_service_id
  public int appMapServiceId(){
    return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appMappingInfoSqlMap.appMapServiceId");
  }
  
	
	//last app_mapping_id
	public String appMappingId(String appMappingName){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appMappingInfoSqlMap.appMappingId", appMappingName); 
	
	}
	public int appMappingNameCheck(AppMappingInfoVO appMappingInfoVO){
	  return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appMappingInfoSqlMap.appMappingNameCheck", appMappingInfoVO);
	}
	
	
	//app_mapping_detail_service 등록
	public int appMappingServiceInfo(AppMappingInfoVO appMappingInfoVO){

	  return sqlSessionTemplate.insert("", appMappingInfoVO);
	}
	//app_mapping_detail_info 등록
	public int appMappingDetailInfo(AppMappingInfoVO appMappingInfoVO){
		
		return sqlSessionTemplate.insert("com.tmap.sqlMap.appMappingInfoSqlMap.appMappingDetailInfo", appMappingInfoVO);
	}
	
	//last map_detail_id
	public int mapDetailId(){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appMappingInfoSqlMap.mapDetailId");
	
	}
	
	//app_file_detail_info 등록
	public void appFileDetailInfo(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		String[] fileVerId = appMappingInfoVO.getDataFileIds();
		
		for(int i = 0; i < fileVerId.length; i++){
			
			appMappingInfoVO.setFileVerId(fileVerId[i]);
			
			sqlSessionTemplate.insert("com.tmap.sqlMap.appMappingInfoSqlMap.appFileDetailInfo", appMappingInfoVO);
		}
	}
	
	//매핑 정보
	public AppMappingInfoVO mappingDetail(String appMappingId) throws Exception{
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appMappingInfoSqlMap.mappingDetail", appMappingId);
	}
	
	//매핑 상세정보 리스트
	public List<AppMappingInfoVO> appMappingDetailInfoList(String appMappingId) throws Exception{
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.appMappingDetailInfoList", appMappingId);
	}
	
	//등록된 타입별 파일 정보
	public List<AppMappingInfoVO> typeAndFile(String appMappingId) throws Exception{
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.typeAndFile", appMappingId);
	}
	//등록된 버전 타입별 파일 정보
	public List<AppMappingInfoVO> verTypeAndFile(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.verTypeAndFile", appMappingInfoVO);
	}
	
	
	//rowSpan
	public List<Map<String, Object>> rowSpan(AppMappingInfoVO appMappingInfoVO) throws Exception{
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appMappingInfoSqlMap.rowSpan", appMappingInfoVO);
		
	}
	
	//데이터 매핑 정보 수정
	public void mappingUpdate(AppMappingInfoVO appMappingInfoVO){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.appMappingInfoSqlMap.mappingUpdate", appMappingInfoVO);
	}
	
	//등록여부확인
	public int confirm(AppMappingInfoVO appMappingInfoVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appMappingInfoSqlMap.confirm", appMappingInfoVO);
	}
	
	//매핑 데이터 수정 
	public void dataDelete(AppMappingInfoVO appMappingInfoVO){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.appMappingInfoSqlMap.mappingDetailDel", appMappingInfoVO);
		sqlSessionTemplate.update("com.tmap.sqlMap.appMappingInfoSqlMap.fileDetailDel", appMappingInfoVO);
	}
	
	//데이터 매핑 정보 삭제 
	public void mappingDelete(String appMappingId) throws Exception{
		
		sqlSessionTemplate.update("com.tmap.sqlMap.appMappingInfoSqlMap.mappingDelete",appMappingId);
		sqlSessionTemplate.update("com.tmap.sqlMap.appMappingInfoSqlMap.mappingDetailDelete",appMappingId);
		sqlSessionTemplate.update("com.tmap.sqlMap.appMappingInfoSqlMap.fileDetailDelete",appMappingId);
	}
}
