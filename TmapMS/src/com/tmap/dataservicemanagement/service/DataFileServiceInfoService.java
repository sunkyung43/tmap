/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.dataservicemanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tmap.datafilemanagement.vo.DataTypeInfoVO;
import com.tmap.datafilemanagement.vo.FileVersionInfoVO;
import com.tmap.dataservicemanagement.dao.DataFileServiceInfoDAO;
import com.tmap.dataservicemanagement.vo.AppMappingInfoVO;
import com.tmap.dataservicemanagement.vo.DataFileServiceInfoVO;
import com.tmap.dataservicemanagement.vo.FileServiceInfoVO;
import com.tmap.dataservicemanagement.vo.ForceReservationVO;

@Service
public class DataFileServiceInfoService {

	@Autowired
	DataFileServiceInfoDAO dataFileServiceInfoDAO;

	// 파일서비스 배포 리스트
	public List<DataFileServiceInfoVO> dataFileServiceList(
			DataFileServiceInfoVO dataFileServiceInfoVO) throws Exception {

		if (dataFileServiceInfoVO.getDataTypeId() == null
				|| dataFileServiceInfoVO.getDataTypeId().equals("")) {

			// 리스트 수를 조회하여 설정
			int totalCount = dataFileServiceInfoDAO
					.countAllDataFileServiceList(dataFileServiceInfoVO
							.getDataFileName());
			dataFileServiceInfoVO.setTotalCount(totalCount);

			// 파일서비스 배포 리스트
			return dataFileServiceInfoDAO.allDataFileServiceList(
					dataFileServiceInfoVO,
					dataFileServiceInfoVO.getStartRowNum(),
					dataFileServiceInfoVO.getCountPerPage());

		} else {
			// 리스트 수를 조회하여 설정
			int totalCount = dataFileServiceInfoDAO
					.countDataFileServiceList(dataFileServiceInfoVO);
			dataFileServiceInfoVO.setTotalCount(totalCount);

			// 파일서비스 배포 리스트
			return dataFileServiceInfoDAO.dataFileServiceList(
					dataFileServiceInfoVO,
					dataFileServiceInfoVO.getStartRowNum(),
					dataFileServiceInfoVO.getCountPerPage());
		}
	}

	// 데이터 타입 리스트
	public List<DataTypeInfoVO> typeList() throws Exception {

		return dataFileServiceInfoDAO.typeList();
	}

	// 파일서비스 배포 정보
	public FileServiceInfoVO dataFileServiceInfo(String fileServId)
			throws Exception {

		return dataFileServiceInfoDAO.dataFileServiceInfo(fileServId);
	}

	// 배포 정보
	public DataFileServiceInfoVO serviceDetail(String fileServId)
			throws Exception {

		return dataFileServiceInfoDAO.serviceDetail(fileServId);
	}

	// 데이터 버전 정보
	public List<FileVersionInfoVO> versionInfo(
			DataFileServiceInfoVO dataFileServiceInfoVO) throws Exception {

		return dataFileServiceInfoDAO.versionInfo(dataFileServiceInfoVO);
	}

	// 버전 상세 정보
	public List<AppMappingInfoVO> verDetail(
			DataFileServiceInfoVO dataFileServiceInfoVO) throws Exception {
		return dataFileServiceInfoDAO.verDetail(dataFileServiceInfoVO);
	}

	// 배포 정보 수정
	public void dataFileServiceUpdate(
			DataFileServiceInfoVO dataFileServiceInfoVO) throws Exception {

		if (dataFileServiceInfoVO.getFileServiceState().equals("N")) {

			dataFileServiceInfoVO.setFileServiceType("F");
			dataFileServiceInfoVO.setFileServiceDistribute("F");

		}

		if (dataFileServiceInfoVO.getDataFileServiceId() == "") {

			// 배포 정보 등록
			dataFileServiceInfoDAO.dataFileServiceInsert(dataFileServiceInfoVO);

		} else {

			// 배포 정보 수정
			dataFileServiceInfoDAO.dataFileServiceUpdate(dataFileServiceInfoVO);

		}
	}

	// 배포 ID 검색
	public int dataFileServiceId(String fileServId) throws Exception {

		return dataFileServiceInfoDAO.dataFileServiceId(fileServId);
	}

	// 배포 정보 삭제
	public void dataFileServiceDelete(String dataFileServiceId)
			throws Exception {

		dataFileServiceInfoDAO.dataFileServiceDelete(dataFileServiceId);
	}

	// 서비스명 중복확인
	public String checkServiceName(String checkServiceName) throws Exception {

		String check = "";
		int result = dataFileServiceInfoDAO.checkServiceName(checkServiceName);

		if (result > 0) {
			check = "success";
		} else {
			check = "failed";
		}

		return check;
	}

	// Data 강제 업데이트 서비스 리스트
	public List<ForceReservationVO> forceReservationList(
			ForceReservationVO forceReservationVO) throws Exception {
		return dataFileServiceInfoDAO.forceReservationList(forceReservationVO);
	}

	public List<ForceReservationVO> targetAppList() throws Exception {

		return dataFileServiceInfoDAO.targetAppList();
	}

	public List<ForceReservationVO> targetVersionList(String selectTargetAppId)
			throws Exception {

		return dataFileServiceInfoDAO.targetVersionList(selectTargetAppId);
	}

	// target service
	public List<ForceReservationVO> targetDataFileServiceList(
			ForceReservationVO forceReservationVO) throws Exception {

		return dataFileServiceInfoDAO
				.targetDataFileServiceList(forceReservationVO);
	}

	// target service
	public void dataForceReservationInsert(ForceReservationVO forceReservationVO)
			throws Exception {
		// upgrade Data Info
		// upgrade ph info
		// upgrade_key = upgrade_data_id
		dataFileServiceInfoDAO.upgradeDataInfoInsert(forceReservationVO);
		forceReservationVO.setUpgradeDataId(dataFileServiceInfoDAO
				.lastUpgradeDataId());
		if(forceReservationVO.getChoiceCurrent() != null){
			String[] phmodelIds = forceReservationVO.getChoiceCurrent();
			for (int i = 0; i < phmodelIds.length; i++) {
				forceReservationVO.setPhModelId(phmodelIds[i]);
				dataFileServiceInfoDAO.upgradePhModelInfoInsert(forceReservationVO);
			}
		}
	}

	public ForceReservationVO dataforceReservationDetail(
			ForceReservationVO forceReservationVO) throws Exception {

		return dataFileServiceInfoDAO
				.dataforceReservationDetail(forceReservationVO);
	}

	public List<ForceReservationVO> phList(ForceReservationVO forceReservationVO)
			throws Exception {

		return dataFileServiceInfoDAO.phList(forceReservationVO);
	}

	public List<ForceReservationVO> verInPhList(ForceReservationVO forceReservationVO)
			throws Exception {

		return dataFileServiceInfoDAO.verInPhList(forceReservationVO);
	}
	public int dataForceReservationUpdate(ForceReservationVO forceReservationVO)
			throws Exception {
		int result = dataFileServiceInfoDAO.dataForceReservationUpdate(forceReservationVO);
		
		//delete phModel
		dataFileServiceInfoDAO.upgradePhModelInfoDelete(forceReservationVO);
		
		String[] phModelIds = forceReservationVO.getChoiceCurrent();
		for (int i = 0; i < phModelIds.length; i++) {
			forceReservationVO.setPhModelId(phModelIds[i]);
			dataFileServiceInfoDAO.upgradePhModelInfoInsert(forceReservationVO);
		}
		
		return result; 
	}
	public void dataForceReservationDelete(ForceReservationVO forceReservationVO)
			throws Exception {
		//upgrade_data_info 삭제
		dataFileServiceInfoDAO.dataForceReservationDelete(forceReservationVO);
		//upgrade_ph_model_info 삭제
		dataFileServiceInfoDAO.upgradePhModelInfoDelete(forceReservationVO);
	}
}
