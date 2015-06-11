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

import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.AppServiceInfoVO;


@Repository
public class AppServiceInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//데이터 매핑 정보 리스트 출력
	public List<AppMappingInfoVO> appServiceInfoList(AppServiceInfoVO appServiceInfoVO, int skipResults, int maxResults){
		
		
		if(appServiceInfoVO.getAppServiceType().equals("W")) {
			RowBounds rowBounds = new RowBounds(skipResults, maxResults);
			return sqlSessionTemplate.selectList("com.tmap.sqlMap.appServiceInfoSqlMap.appServiceInfoListReady", appServiceInfoVO, rowBounds); 
		}else{RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appServiceInfoSqlMap.appServiceInfoList", appServiceInfoVO, rowBounds); }
	}
	
	//데이터 매핑 정보 리스트 수
	public int countAppServiceInfoListReady(String appMappingName){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appServiceInfoSqlMap.countAppServiceInfoListReady", appMappingName);
	}
	
	//데이터 매핑 정보 리스트 수
	public int countAppServiceInfoList(String appMappingName){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appServiceInfoSqlMap.countAppServiceInfoList", appMappingName);
	}
	
	//배포 정보
	public AppServiceInfoVO serviceDetail(String appMappingId){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appServiceInfoSqlMap.serviceDetail", appMappingId);
	}
	
	//매핑 정보
	public AppMappingInfoVO mappingDetail(String appMappingId){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appServiceInfoSqlMap.mappingDetail", appMappingId);
	}
	
	//등록된 타입별 파일 정보
	public List<AppMappingInfoVO> typeAndFile(String appMappingId) throws Exception{
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appServiceInfoSqlMap.typeAndFile", appMappingId);
	}
	
	//rowSpan
	public List<Map<String, Object>> rowSpan(String appMappingId) throws Exception{
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appServiceInfoSqlMap.rowSpan", appMappingId);
		
	}
	
	//파일 상세 정보
	public List<DataFileInfoVO> fileDetail(AppServiceInfoVO appServiceInfoVO) throws Exception{
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.appServiceInfoSqlMap.fileDetail", appServiceInfoVO);
		
	}
	
	//배포 정보 등록
	public void appServiceInsert(AppServiceInfoVO appServiceInfoVO){
		
		sqlSessionTemplate.insert("com.tmap.sqlMap.appServiceInfoSqlMap.appServiceInsert", appServiceInfoVO);
	}
	
	//ServiceId 획득
	public int getLastAppMapServiceId(){
	  return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appServiceInfoSqlMap.appServiceId");
	}
	
	//배포 정보 수정
	public void appServiceUpdate(AppServiceInfoVO appServiceInfoVO){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.appServiceInfoSqlMap.appServiceUpdate", appServiceInfoVO);
	}
	
	//배포 ID 검색
	public int appMappingId(String appServiceName) throws Exception{
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appServiceInfoSqlMap.appMappingId", appServiceName);
	}
	
	//배포 정보 삭제 
	public void serviceDelete(String appServiceId) throws Exception{
		
		sqlSessionTemplate.update("com.tmap.sqlMap.appServiceInfoSqlMap.serviceDelete",appServiceId);
	}
	
	//배포명 중복확인
	public int checkServiceName(String checkServiceName){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.appServiceInfoSqlMap.checkServiceName", checkServiceName);
	}
	
}
