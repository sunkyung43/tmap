/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.dataservicemanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.datafilemanagement.vo.DataTypeInfoVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.DataFileServiceInfoVO;
import com.tmap.dataservicemanagement.vo.FileServiceInfoVO;
import com.tmap.dataservicemanagement.vo.ForceReservationVO;


@Repository
public class DataFileServiceInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//파일서비스 배포 리스트 수
	public int countAllDataFileServiceList(String dataFileName){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataFileServiceInfoSqlMap.countAllDataFileServiceList", dataFileName);
	}
	
	public int countDataFileServiceList(DataFileServiceInfoVO dataFileServiceInfoVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataFileServiceInfoSqlMap.countDataFileServiceList", dataFileServiceInfoVO);
	}
	
	//파일서비스 배포 리스트
	public List<DataFileServiceInfoVO> allDataFileServiceList(DataFileServiceInfoVO dataFileServiceInfoVO, int skipResults, int maxResults) {
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileServiceInfoSqlMap.allDataFileServiceList", dataFileServiceInfoVO, rowBounds);
	}
	
	public List<DataFileServiceInfoVO> dataFileServiceList(DataFileServiceInfoVO dataFileServiceInfoVO, int skipResults, int maxResults) {
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileServiceInfoSqlMap.dataFileServiceList", dataFileServiceInfoVO, rowBounds);
	}
	
	//데이터 타입 리스트
	public List<DataTypeInfoVO> typeList(){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileServiceInfoSqlMap.typeList");
	}
	
	//파일 서비스 정보
	public FileServiceInfoVO dataFileServiceInfo(String fileServId){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataFileServiceInfoSqlMap.dataFileServiceInfo", fileServId);
	}
	
	//배포 정보
	public DataFileServiceInfoVO serviceDetail(String fileServId){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataFileServiceInfoSqlMap.serviceDetail", fileServId);
	}
	
	//데이터 버전 정보
	public List<FileVersionInfoVO> versionInfo(DataFileServiceInfoVO dataFileServiceInfoVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileServiceInfoSqlMap.versionInfo", dataFileServiceInfoVO);
	}
	
	//버전 상세 정보
	public List<AppMappingInfoVO> verDetail(DataFileServiceInfoVO dataFileServiceInfoVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileServiceInfoSqlMap.verDetail", dataFileServiceInfoVO);
		
	}
	
	//배포 정보 등록
	public void dataFileServiceInsert(DataFileServiceInfoVO dataFileServiceInfoVO){
		
		sqlSessionTemplate.insert("com.tmap.sqlMap.dataFileServiceInfoSqlMap.dataFileServiceInsert", dataFileServiceInfoVO);
	}
	
	//배포 정보 수정
	public void dataFileServiceUpdate(DataFileServiceInfoVO dataFileServiceInfoVO){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.dataFileServiceInfoSqlMap.dataFileServiceUpdate", dataFileServiceInfoVO);
	}
	
	//배포 ID 검색
	public int dataFileServiceId(String fileServId) throws Exception{
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataFileServiceInfoSqlMap.lastSeq", fileServId);
	}
	
	//배포 정보 삭제 
	public void dataFileServiceDelete(String dataFileServiceId) throws Exception{
		
		sqlSessionTemplate.update("com.tmap.sqlMap.dataFileServiceInfoSqlMap.dataFileServiceDelete",dataFileServiceId);
	}
	
	//서비스명 중복확인
	public int checkServiceName(String checkServiceName){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataFileServiceInfoSqlMap.checkServiceName", checkServiceName);
	}
	//서비스명 중복확인
	public List<ForceReservationVO> forceReservationList(ForceReservationVO forceReservationVO){
			
			return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileServiceInfoSqlMap.forceReservationList", forceReservationVO);
	}
	
	public List<ForceReservationVO> targetAppList(){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileServiceInfoSqlMap.targetAppList");
	}

	public List<ForceReservationVO> targetVersionList(String selectTargetAppId){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileServiceInfoSqlMap.targetVersionList", selectTargetAppId);
	}
	
	public List<ForceReservationVO> targetDataFileServiceList(ForceReservationVO forceReservationVO){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileServiceInfoSqlMap.targetDataFileServiceList", forceReservationVO);
	}
	
	public void upgradeDataInfoInsert(ForceReservationVO forceReservationVO){
		sqlSessionTemplate.insert("com.tmap.sqlMap.dataFileServiceInfoSqlMap.upgradeDataInfoInsert", forceReservationVO);
	}
	public void upgradePhModelInfoInsert(ForceReservationVO forceReservationVO){
		sqlSessionTemplate.insert("com.tmap.sqlMap.dataFileServiceInfoSqlMap.upgradePhModelInfoInsert", forceReservationVO);
	}
	public String lastUpgradeDataId(){
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataFileServiceInfoSqlMap.lastUpgradeDataId");
	}
	public ForceReservationVO dataforceReservationDetail(ForceReservationVO forceReservationVO){
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.dataFileServiceInfoSqlMap.dataforceReservationDetail", forceReservationVO);
	}
	public List<ForceReservationVO> phList(ForceReservationVO forceReservationVO){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileServiceInfoSqlMap.phList", forceReservationVO);
	}
	public List<ForceReservationVO> verInPhList(ForceReservationVO forceReservationVO){
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.dataFileServiceInfoSqlMap.verInPhList", forceReservationVO);
	}
	public int dataForceReservationUpdate(ForceReservationVO forceReservationVO){
		return sqlSessionTemplate.update("com.tmap.sqlMap.dataFileServiceInfoSqlMap.dataForceReservationUpdate", forceReservationVO);
	}
	public void upgradePhModelInfoDelete(ForceReservationVO forceReservationVO){
		sqlSessionTemplate.delete("com.tmap.sqlMap.dataFileServiceInfoSqlMap.upgradePhModelInfoDelete", forceReservationVO);
	}
	public int dataForceReservationDelete(ForceReservationVO forceReservationVO){
		return sqlSessionTemplate.delete("com.tmap.sqlMap.dataFileServiceInfoSqlMap.dataForceReservationDelete", forceReservationVO);
	}
}
