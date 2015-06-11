package com.tmap.cdnmanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.cdnmanagement.dao.CdnInfoDAO;
import com.tmap.cdnmanagement.vo.CdnInfoListVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.AppServiceInfoVO;
import com.tmap.dataservicemanagement.vo.DataFileServiceInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;

@Service
public class CdnInfoService {

	@Autowired
	CdnInfoDAO cdnInfoDAO;

	// 테스트폰관리 리스트 출력
	public List<CdnInfoListVO> cdnInfoList(CdnInfoListVO cdnInfoListVO)
			throws Exception {

		// 리스트 수를 조회하여 설정
		int totalCount = cdnInfoDAO.countCdnInfoList(cdnInfoListVO);
		cdnInfoListVO.setTotalCount(totalCount);

		List<CdnInfoListVO> cdnInfoList = cdnInfoDAO
				.cdnInfoList(cdnInfoListVO, cdnInfoListVO.getStartRowNum(),
						cdnInfoListVO.getCountPerPage());

		return cdnInfoList;
	}

	public List<AppMappingInfoVO> cdnAppMappingDetailInfoList(
			String appMappingId) throws Exception {
		return cdnInfoDAO.cdnAppMappingDetailInfoList(appMappingId);
	}

	public List<AppMappingInfoVO> cdnAppMappingDetailId(String appVerId)
			throws Exception {
		return cdnInfoDAO.cdnAppMappingDetailId(appVerId);
	}

	// cdn 등록
	public boolean cdnInfoInsert(CdnInfoListVO cdnInfoListVO) throws Exception {

		return cdnInfoDAO.cdnInfoInsert(cdnInfoListVO) > 0;
	}
	
	// cdn detail 등록
	/*
	 * public List<CdnInfoListVO> cdnDetailInsert(CdnInfoListVO cdnInfoListVO)
	 * throws Exception {
	 * 
	 * return cdnInfoDAO.cdnDetailInsert(cdnInfoListVO); }
	 */

	public boolean cdnDetailInsert(CdnInfoListVO cdnInfoListVO)
			throws Exception {

		return cdnInfoDAO.cdnDetailInsert(cdnInfoListVO) > 0;
	}

	// 등록된 타입별 파일 정보
	public String cdnPromoId() throws Exception {

		return cdnInfoDAO.cdnPromoId();
	}

	// 파일서비스 배포 리스트(CDN)
	public List<DataFileServiceInfoVO> cdnFileServiceList(
			DataFileServiceInfoVO dataFileServiceInfoVO) throws Exception {

		if (dataFileServiceInfoVO.getDataTypeId() == null
				|| dataFileServiceInfoVO.getDataTypeId().equals("")) {

			// 리스트 수를 조회하여 설정
			int totalCount = cdnInfoDAO
					.countAllCdnDataFileServiceList(dataFileServiceInfoVO
							.getDataFileName());
			dataFileServiceInfoVO.setTotalCount(totalCount);

			// 파일서비스 배포 리스트
			return cdnInfoDAO.allCdnDataFileServiceList(dataFileServiceInfoVO,
					dataFileServiceInfoVO.getStartRowNum(),
					dataFileServiceInfoVO.getCountPerPage());

		} else {
			// 리스트 수를 조회하여 설정
			int totalCount = cdnInfoDAO
					.countCdnDataFileServiceList(dataFileServiceInfoVO);
			dataFileServiceInfoVO.setTotalCount(totalCount);

			// 파일서비스 배포 리스트
			return cdnInfoDAO.cdnFileServiceList(dataFileServiceInfoVO,
					dataFileServiceInfoVO.getStartRowNum(),
					dataFileServiceInfoVO.getCountPerPage());
		}
	}

	// 데이터 버전 정보
	public List<CdnInfoListVO> versionInfo(CdnInfoListVO cdnInfoListVO) throws Exception {

		return cdnInfoDAO.versionInfo(cdnInfoListVO);
	}
	
	// 데이터 버전 정보
		public List<AppMappingInfoVO> appVerInfo(AppMappingInfoVO appMappingInfoVO) throws Exception {

			return cdnInfoDAO.appVerInfo(appMappingInfoVO);
		}

	/*// 데이터 버전 정보
	public List<FileVersionInfoVO> verListInfo(
			DataFileServiceInfoVO dataFileServiceInfoVO) throws Exception {

		return cdnInfoDAO.verListInfo(dataFileServiceInfoVO);
	}
*/
	// 데이터 매핑 정보 리스트 출력
	public List<AppMappingInfoVO> cdnAppServiceInfoList(
			AppServiceInfoVO appServiceInfoVO) throws Exception {

		// 리스트 수를 조회하여 설정
		int totalCount = cdnInfoDAO.countCdnAppServiceInfoList(appServiceInfoVO
				.getAppMappingName());
		appServiceInfoVO.setTotalCount(totalCount);

		return cdnInfoDAO.cdnAppServiceInfoList(appServiceInfoVO,
				appServiceInfoVO.getStartRowNum(),
				appServiceInfoVO.getCountPerPage());
	}

	// cdn 수정폼
	public CdnInfoListVO cdnInfoEditList(String cdnPromoId) throws Exception {

		return cdnInfoDAO.cdnInfoEditList(cdnPromoId);
	}

	public DataFileServiceInfoVO dataFileList(String FileVerId)
			throws Exception {
		// 파일서비스 배포 리스트
		return cdnInfoDAO.dataFileList(FileVerId);
	}

	// cdn 수정
	public int cdnInfoUpdate(CdnInfoListVO cdnInfoListVO) throws Exception {

		return cdnInfoDAO.cdnInfoUpdate(cdnInfoListVO);

	}

	// cdn 삭제
	public int cdnInfoDelete(CdnInfoListVO cdnInfoListVO) throws Exception {

		return cdnInfoDAO.cdnInfoDelete(cdnInfoListVO);
	}
	
	//배포명 중복확인
	public String checkServiceName(String checkServiceName) throws Exception{
		
		String check = "";
		int result = cdnInfoDAO.checkServiceName(checkServiceName);
		
		if(result == 0){
			check = "success";
		}else{
			check = "failed";
		}
		
		return check;
	}
}
