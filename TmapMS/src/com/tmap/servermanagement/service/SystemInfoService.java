/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.btb.mdcs.client.MDCSClient;
import com.btb.mdcs.model.DsInfoVo;
import com.btb.mdcs.util.DSClient;
import com.btb.mdcs.util.ResultCondition;
import com.tmap.servermanagement.dao.SystemInfoDAO;
import com.tmap.servermanagement.vo.ComCodeInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;

/**
 * <br/>
 * 
 * @author 김경민
 * @date 2012. 9. 6.
 */
@Service
public class SystemInfoService {

	@Autowired
	SystemInfoDAO systemInfoDAO;

	// 서버기기 리스트
	public List<SystemInfoVO> systemInfoList(SystemInfoVO systemInfoVO) throws Exception {

		// 리스트 수를 조회하여 설정
		int totalCount = systemInfoDAO.countSystemInfoList(systemInfoVO);
		systemInfoVO.setTotalCount(totalCount);

		return systemInfoDAO.systemInfoList(systemInfoVO, systemInfoVO.getStartRowNum(), systemInfoVO.getCountPerPage());
	}

	// 서버구분 리스트
	// public List<SystemInfoVO> serverType() throws Exception {
	//
	// return systemInfoDAO.serverType();
	// }

	// 서버구분
	public List<ComCodeInfoVO> srvType() throws Exception {
		return systemInfoDAO.srvType();
	}

	// 통신방식 리스트
	// public List<ComTypeInfoVO> comType() throws Exception {
	//
	// return systemInfoDAO.comType();
	// }


	// 통신타입
	public List<ComCodeInfoVO> comType() throws Exception {
		return systemInfoDAO.comType();
	}

	// 서버기기명 중복체크
	public String checkName(String checkName) throws Exception {

		int result = systemInfoDAO.checkName(checkName);

		if (result > 0) {
			return "failed";
		} else {
			return "success";
		}

	}


	//com_set_info dafault 값 획득
	public List<SystemInfoVO> defaultComSetInfo() throws Exception {

		return systemInfoDAO.getDefaultComSetInfo();
	}


	// 서버기기 등록
	public String systemInfoInsert(SystemInfoVO systemInfoVO) throws Exception {

		// last system_num
		systemInfoVO.setSystemNum(String.valueOf(systemInfoDAO.systemNum(systemInfoVO.getServerTypeCode()) + 1));
		if (systemInfoVO.getSystemIpIn().equals("")) {
			systemInfoVO.setSystemIpIn(null);
		}
		if (systemInfoVO.getSystemPortIn().equals("")) {
			systemInfoVO.setSystemPortIn(null);
		}
		int result;
		if (systemInfoVO.getServerTypeName().equals("DS")) {
			// 서버기기정보 등록
			if ((result = systemInfoDAO.systemInfoInsert(systemInfoVO)) > 0) {
				// system_id
				int id = systemInfoDAO.systemId(systemInfoVO.getSystemName());
				systemInfoVO.setSystemId(String.valueOf(id));
				// DS서버 설정정보 등록
				if (systemInfoDAO.mapdownManageInsert(systemInfoVO) > 0) {
					// mapdown_manage_id
					int manageId = systemInfoDAO.manageId(systemInfoVO.getSystemId());
					systemInfoVO.setMapdownManageId(String.valueOf(manageId));
					// 통신방식 등록 및 ds_connect_info등록
					systemInfoDAO.comSetInsert(systemInfoVO);
					
					 //DS통신
			        DsInfoVo dsInfoVo = new DsInfoVo(systemInfoVO.getSystemIpIn(), Integer.parseInt(systemInfoVO.getSystemPortIn()));
			        DSClient dsclient = new DSClient(dsInfoVo);
			        dsclient.updateServerInfo(Integer.parseInt(systemInfoVO.getSystemId()));
				}
				
			} 
		} else {
			// 서버기기정보 등록
			result = systemInfoDAO.systemInfoInsert(systemInfoVO);
		}

		if (result > 0) {
			return "success";
		} else {
			return "failed";
		}
	}

	// 서버기기 상세정보
	public SystemInfoVO systemInfo(String systemId) throws Exception {

		return systemInfoDAO.systemInfo(systemId);
	}

	// 통식방식 상세정보
	public List<SystemInfoVO> comTypeInfo(String systemId) throws Exception {

		return systemInfoDAO.comTypeInfo(systemId);
	}

	// 서비스운영 상세정보
	public SystemInfoVO mapdownManageInfo(String systemId) {

		return systemInfoDAO.mapdownManageInfo(systemId);
	}

	// 서버기기 수정
	public String systemInfoUpdate(SystemInfoVO systemInfoVO) throws Exception {

		if (systemInfoVO.getOldServerTypeName().equals("DS")) {

			// 기존 등록 서비스 운영정보 삭제
			systemInfoDAO.mapdownManageDelete(systemInfoVO);
		}

		if (!systemInfoVO.getOldServerTypeName().equals(systemInfoVO.getServerTypeName())) {

			// last system_num
			int num = systemInfoDAO.systemNum(systemInfoVO.getServerTypeId());
			String systemNum = String.valueOf(num + 1);
			systemInfoVO.setSystemNum(systemNum);

		}

		if (systemInfoVO.getSystemIpIn().equals("")) {
			systemInfoVO.setSystemIpIn(null);
		}

		if (systemInfoVO.getSystemPortIn().equals("")) {
			systemInfoVO.setSystemPortIn(null);
		}

		int result = 0;

		if (systemInfoVO.getServerTypeName().equals("DS")) {

			// 서버기기정보 수정
			result = systemInfoDAO.systemInfoUpdate(systemInfoVO);

			if (result > 0) {

				// DS서버 설정정보 수정
				int result2 = systemInfoDAO.mapdownManageUpdate(systemInfoVO);

				if (result2 > 0) {

					// mapdown_manage_id
					int manageId = systemInfoDAO.manageId(systemInfoVO.getSystemId());
					String mapdownManageId = String.valueOf(manageId);
					systemInfoVO.setMapdownManageId(mapdownManageId);

					// 통신방식 등록
					//systemInfoDAO.comSetUpdate(systemInfoVO);
				}
			}

		} else {

			// 서버기기정보 등록
			result = systemInfoDAO.systemInfoUpdate(systemInfoVO);
		}

		if (result > 0) {
			return "success";
		} else {
			return "failed";
		}
	}

	// 서버기기 삭제
	public void systemInfoDelete(SystemInfoVO systemInfoVO) throws Exception {

		// 서버기기정보 삭제
		int result = systemInfoDAO.systemInfoDelete(systemInfoVO);

		if (result > 0) {

			// 서비스 운영정보 삭제
			systemInfoDAO.mapdownManageDelete(systemInfoVO);

			// 통식방식 삭제
			systemInfoDAO.comSetDelete(systemInfoVO);
		}

	}

	public String systemSync(String systemId) throws Exception {
		ResultCondition result = new DSClient(systemInfoDAO.dsSystemInfo(systemId)).updateFileSync();
		
		if (result.getSuccessCount() > 0) {
			return "success";
		} else {
			return "failed";
		}
		
	}
	
	public int systemId(String systemId) throws Exception {

		return systemInfoDAO.systemId(systemId);
	}
	
	
	// DS 서버 정보 설정 요청
	public boolean syncDsUpdateServerInfo(DsInfoVo dsInfoVo, int serverID) {
		return new DSClient(dsInfoVo).updateServerInfo(serverID);
	}

}
