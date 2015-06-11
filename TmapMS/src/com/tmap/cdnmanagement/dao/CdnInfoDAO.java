package com.tmap.cdnmanagement.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.tmap.cdnmanagement.vo.CdnInfoListVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.AppServiceInfoVO;
import com.tmap.dataservicemanagement.vo.DataFileServiceInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;

@Repository
public class CdnInfoDAO {

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	// cdn 리스트 출력
	public List<CdnInfoListVO> cdnInfoList(CdnInfoListVO cdnInfoListVO,
			int skipResults, int maxResults) throws Exception {

		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.cdnInfoSqlMap.cdnInfoList", cdnInfoListVO,
				rowBounds);
	}

	// cdn 리스트 수
	public int countCdnInfoList(CdnInfoListVO cdnInfoListVO) {

		return sqlSessionTemplate
				.selectOne("com.tmap.sqlMap.cdnInfoSqlMap.countCdnInfoList",
						cdnInfoListVO);
	}

	public int cdnDetailInsert(CdnInfoListVO cdnInfoListVO) {
		return sqlSessionTemplate.insert(
				"com.tmap.sqlMap.cdnInfoSqlMap.cdnDetailInsert", cdnInfoListVO);
	}

	// 매핑 상세정보 리스트
	public List<AppMappingInfoVO> cdnAppMappingDetailInfoList(
			String appMappingId) throws Exception {
		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.cdnInfoSqlMap.cdnAppMappingDetailInfoList",
				appMappingId);
	}

	public List<AppMappingInfoVO> cdnAppMappingDetailId(String appVerId)
			throws Exception {
		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.cdnInfoSqlMap.cdnAppMappingDetailInfoList",
				appVerId);
	}

	// 데이터 버전 정보
/*	public List<FileVersionInfoVO> verListInfo(
			FileVersionInfoVO fileVersionInfoVO) {

		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.cdnInfoSqlMap..verListInfo",
				fileVersionInfoVO);
	}*/

	// 데이터 버전 정보
	public List<CdnInfoListVO> versionInfo(CdnInfoListVO cdnInfoListVO) {
		return sqlSessionTemplate.selectList("com.tmap.sqlMap.cdnInfoSqlMap.versionInfo", cdnInfoListVO);
	}
	
	public List<AppMappingInfoVO> appVerInfo(AppMappingInfoVO appMappingInfoVO) {

		return sqlSessionTemplate.selectList("com.tmap.sqlMap.cdnInfoSqlMap.appVerInfo",appMappingInfoVO);
	}

	// cdn 등록
	public int cdnInfoInsert(CdnInfoListVO cdnInfoListVO) {

		return sqlSessionTemplate.insert("com.tmap.sqlMap.cdnInfoSqlMap.cdnInfoInsert", cdnInfoListVO);
	}
	/*
	 * public List<CdnInfoListVO> cdnDetailInsert(CdnInfoListVO cdnInfoListVO) {
	 * 
	 * return sqlSessionTemplate.insert(
	 * "com.tmap.sqlMap.cdnInfoSqlMap.cdnDetailInsert", cdnInfoListVO); }
	 */
	// 등록된 타입별 파일 정보
	public String cdnPromoId() throws Exception {

		return sqlSessionTemplate
				.selectOne("com.tmap.sqlMap.cdnInfoSqlMap.cdnPromoId");
	}

	// 파일서비스 배포 리스트 수
	public int countAllCdnDataFileServiceList(String dataFileName) {

		return sqlSessionTemplate.selectOne(
				"com.tmap.sqlMap.cdnInfoSqlMap.countAllCdnDataFileServiceList",
				dataFileName);
	}

	// 파일서비스 배포 리스트수(검색)
	public int countCdnDataFileServiceList(
			DataFileServiceInfoVO dataFileServiceInfoVO) {

		return sqlSessionTemplate.selectOne(
				"com.tmap.sqlMap.cdnInfoSqlMap.countCdnDataFileServiceList",
				dataFileServiceInfoVO);
	}

	// 파일서비스 배포 리스트
	public List<DataFileServiceInfoVO> allCdnDataFileServiceList(
			DataFileServiceInfoVO dataFileServiceInfoVO, int skipResults,
			int maxResults) {

		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.cdnInfoSqlMap.allCdnDataFileServiceList",
				dataFileServiceInfoVO, rowBounds);
	}

	// 파일서비스 배포 리스트(조회)
	public List<DataFileServiceInfoVO> cdnFileServiceList(
			DataFileServiceInfoVO dataFileServiceInfoVO, int skipResults,
			int maxResults) {

		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.cdnInfoSqlMap.cdnFileServiceList",
				dataFileServiceInfoVO, rowBounds);
	}

	// 파일서비스 배포 리스트(조회)
	public DataFileServiceInfoVO dataFileList(String FileVerId) {

		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.cdnInfoSqlMap.dataFileList", FileVerId);
	}

	// 데이터 매핑 정보 리스트 출력
	public List<AppMappingInfoVO> cdnAppServiceInfoList(
			AppServiceInfoVO appServiceInfoVO, int skipResults, int maxResults) {

		/*
		 * if(appServiceInfoVO.getAppServiceType().equals("W")) { RowBounds
		 * rowBounds = new RowBounds(skipResults, maxResults); return
		 * sqlSessionTemplate
		 * .selectList("com.tmap.sqlMap.cdnInfoSqlMap.cdnAppServiceInfoListReady"
		 * , appServiceInfoVO, rowBounds); }else{RowBounds rowBounds = new
		 * RowBounds(skipResults, maxResults); return
		 * sqlSessionTemplate.selectList
		 * ("com.tmap.sqlMap.cdnInfoSqlMap.cdnAppServiceInfoList",
		 * appServiceInfoVO, rowBounds); }
		 */

		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.cdnInfoSqlMap.cdnAppServiceInfoList",
				appServiceInfoVO, rowBounds);
	}

	// 데이터 매핑 정보 리스트 수
	public int countCdnAppServiceInfoList(String appMappingName) {

		return sqlSessionTemplate.selectOne(
				"com.tmap.sqlMap.cdnInfoSqlMap.countCdnAppServiceInfoList",
				appMappingName);
	}

	// cdn 수정 폼 출력
	public CdnInfoListVO cdnInfoEditList(String cdnPromoId) {

		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.cdnInfoSqlMap.cdnInfoEditList", cdnPromoId);
	}

	// 데이터 버전 정보
	public List<FileVersionInfoVO> dataVersionInfo(
			DataFileServiceInfoVO dataFileServiceInfoVO) {

		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.cdnInfoSqlMap.dataVersionInfo",
				dataFileServiceInfoVO);
	}

	// 통식방식 상세정보
	public List<CdnInfoListVO> dataFile(String cdnPromoId) {

		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.cdnInfoSqlMap.dataFile", cdnPromoId);
	}

	// 서비스운영 상세정보
	public List<CdnInfoListVO> appVer(String cdnPromoId) {

		return sqlSessionTemplate.selectList(
				"com.tmap.sqlMap.cdnInfoSqlMap.appVer", cdnPromoId);
	}

	// cdn 수정
	public int cdnInfoUpdate(CdnInfoListVO cdnInfoListVO) {

		return sqlSessionTemplate.update(
				"com.tmap.sqlMap.cdnInfoSqlMap.cdnInfoUpdate", cdnInfoListVO);
	}

	// cdn 삭제
	public int cdnInfoDelete(CdnInfoListVO cdnInfoListVO) {

		return sqlSessionTemplate.delete(
				"com.tmap.sqlMap.cdnInfoSqlMap.cdnInfoDelete", cdnInfoListVO);
	}
	
	//배포명 중복확인
	public int checkServiceName(String checkServiceName){
		
		return sqlSessionTemplate.selectOne("com.tmap.sqlMap.cdnInfoSqlMap.checkServiceName", checkServiceName);
	}
}
