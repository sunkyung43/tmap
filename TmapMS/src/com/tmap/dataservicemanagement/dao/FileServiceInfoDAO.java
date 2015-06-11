/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.dataservicemanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.datafilemanagement.vo.DataFileInfoVO;
import com.tmap.datafilemanagement.vo.DataTypeInfoVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.FileServiceInfoVO;



@Repository
public class FileServiceInfoDAO {

	@Resource(name="sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;
	
	//파일 서비스 리스트 수
	public int countAllFileServiceList(String dataFileName){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.fileServiceInfoSqlMap.countAllFileServiceList", dataFileName);
	}
	
	public int countFileServiceList(FileServiceInfoVO fileServiceInfoVO){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.fileServiceInfoSqlMap.countFileServiceList", fileServiceInfoVO);
	}
	
	//파일 서비스 리스트
	public List<FileServiceInfoVO> allFileServiceList(FileServiceInfoVO fileServiceInfoVO, int skipResults, int maxResults) {
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.fileServiceInfoSqlMap.allFileServiceList", fileServiceInfoVO, rowBounds);
	}
	
	public List<FileServiceInfoVO> fileServiceList(FileServiceInfoVO fileServiceInfoVO, int skipResults, int maxResults) {
		
		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.fileServiceInfoSqlMap.fileServiceList", fileServiceInfoVO, rowBounds);
	}
	
	//데이터 타입 리스트
	public List<DataTypeInfoVO> typeList(){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.fileServiceInfoSqlMap.typeList");
	}
	
	//데이터 파일 리스트(등록)
	public List<DataFileInfoVO> fileInType(FileServiceInfoVO fileServiceInfoVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.fileServiceInfoSqlMap.fileInType", fileServiceInfoVO);
		
	}
	
	//데이터 파일 버전 리스트
	public List<FileVersionInfoVO> verInFile(FileServiceInfoVO fileServiceInfoVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.fileServiceInfoSqlMap.verInFile", fileServiceInfoVO);
		
	}
	
	//파일 상세 정보
	public List<DataFileInfoVO> fileDetail(FileServiceInfoVO fileServiceInfoVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.fileServiceInfoSqlMap.fileDetail", fileServiceInfoVO);
		
	}
	
	//버전 상세 정보
	public List<AppMappingInfoVO> verDetail(FileServiceInfoVO fileServiceInfoVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.fileServiceInfoSqlMap.verDetail", fileServiceInfoVO);
		
	}
	
	//파일 서비스 등록 
	public int serviceInsert(FileServiceInfoVO fileServiceInfoVO){
		
		return sqlSessionTemplate.insert("com.tmap.sqlMap.fileServiceInfoSqlMap.serviceInsert", fileServiceInfoVO);
	}
	
	//last file_serv_id
	public int fileServId(String dataFileId){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.fileServiceInfoSqlMap.lastSeq_fileServiceInfo", dataFileId); 
	}
	
	//file_service_detail_info 등록
	public void fileServiceDetailInfo(FileServiceInfoVO fileServiceInfoVO){
		
		String[] fileVerId = fileServiceInfoVO.getDataFileIds();
		
		for(int i = 0; i < fileVerId.length; i++){
			
			fileServiceInfoVO.setFileVerId(fileVerId[i]);
			
			sqlSessionTemplate.insert("com.tmap.sqlMap.fileServiceInfoSqlMap.fileServiceDetailInfo", fileServiceInfoVO);
		}
	}
	
	//file_service_detail_info 등록2
	public void fileServiceDetailInfo2(FileServiceInfoVO fileServiceInfoVO){
		
		String[] fileVerId = fileServiceInfoVO.getDataFileIds();
		
		for(int i = 0; i < fileVerId.length; i++){
			
			fileServiceInfoVO.setFileVerId(fileVerId[i]);
			
			sqlSessionTemplate.insert("com.tmap.sqlMap.fileServiceInfoSqlMap.fileServiceDetailInfo", fileServiceInfoVO);
		
		}
	}
	
	//파일 서비스 정보
	public FileServiceInfoVO fileServiceInfo(String fileServId){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.fileServiceInfoSqlMap.fileServiceInfo", fileServId);
	}
	
	//데이터 버전 정보
	public List<FileVersionInfoVO> versionInfo(FileServiceInfoVO fileServiceInfoVO){
		
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.fileServiceInfoSqlMap.versionInfo", fileServiceInfoVO);
	}
	
	//파일 서비스 수정 
	public int serviceUpdate(FileServiceInfoVO fileServiceInfoVO){
		
		return sqlSessionTemplate.update("com.tmap.sqlMap.fileServiceInfoSqlMap.serviceUpdate", fileServiceInfoVO);
	}
	
	//기존 등록된 file_service_detail_info 삭제
	public void fileServiceDetailDel(String fileServId){
		
		sqlSessionTemplate.update("com.tmap.sqlMap.fileServiceInfoSqlMap.fileServiceDetailDel", fileServId);
	}
	
	//파일 서비스 삭제
	public void fileServiceDelete(String fileServId) throws Exception{
		
		sqlSessionTemplate.update("com.tmap.sqlMap.fileServiceInfoSqlMap.fileServiceDelete", fileServId);
	}
		
	
}
