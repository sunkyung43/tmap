/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.dao;

import java.util.List;
import javax.annotation.Resource;
import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.btb.mdcs.model.DsInfoVo;
import com.tmap.servermanagement.vo.ComCodeInfoVO;
import com.tmap.servermanagement.vo.SystemInfoVO;

/**
 * <br/>
 * 
 * @author 김경민
 * @date 2012. 9. 6.
 */
@Repository
public class SystemInfoDAO {

	@Resource(name = "sqlSessionTemplate")
	private SqlSessionTemplate sqlSessionTemplate;

	// 서버기기 리스트 수
	public int countSystemInfoList(SystemInfoVO systemInfoVO) {

		return sqlSessionTemplate.selectOne("systemInfoSqlMap.countSystemInfoList", systemInfoVO);
	}

	// 서버기기 리스트
	public List<SystemInfoVO> systemInfoList(SystemInfoVO systemInfoVO, int skipResults, int maxResults) throws Exception {

		RowBounds rowBounds = new RowBounds(skipResults, maxResults);
		return sqlSessionTemplate.selectList("systemInfoSqlMap.systemInfoList", systemInfoVO, rowBounds);
	}

	// 서버구분 리스트
	// public List<SystemInfoVO> serverType(){
	//
	// return sqlSessionTemplate.selectList("systemInfoSqlMap.serverType");
	// }
	// 서버구분 리스트
	public List<ComCodeInfoVO> srvType() {
		return sqlSessionTemplate.selectList("systemInfoSqlMap.srvType");
	}

	// 통신방식 리스트
	// public List<ComTypeInfoVO> comType(){
	//
	// return sqlSessionTemplate.selectList("systemInfoSqlMap.comType");
	// }
	public List<ComCodeInfoVO> comType() {
		return sqlSessionTemplate.selectList("systemInfoSqlMap.comType");
	}

	// 통신방식명 중복체크
	public int checkName(String checkName) {

		return sqlSessionTemplate.selectOne("systemInfoSqlMap.checkName", checkName);
	}

	// last system_num
	public int systemNum(String serverTypeId) {

		return sqlSessionTemplate.selectOne("systemInfoSqlMap.systemNum", serverTypeId);
	}

	// 서버기기정보 등록
	public int systemInfoInsert(SystemInfoVO systemInfoVO) {

		return sqlSessionTemplate.insert("systemInfoSqlMap.systemInfoInsert", systemInfoVO);
	}

	// system_id
	public int systemId(String systemName) {

		return sqlSessionTemplate.selectOne("systemInfoSqlMap.systemId", systemName);
	}
	
	// DS서버 설정정보 등록
	public int mapdownManageInsert(SystemInfoVO systemInfoVO) {

		return sqlSessionTemplate.insert("systemInfoSqlMap.mapdownManageInsert", systemInfoVO);
	}

	// mapdown_manage_id
	public int manageId(String systemId) {

		return sqlSessionTemplate.selectOne("systemInfoSqlMap.manageId", systemId);
	}

	//com_set_info default 값 획득
	public List<SystemInfoVO> getDefaultComSetInfo(){
		return sqlSessionTemplate.selectList("systemInfoSqlMap.defaultComSetList");
	}


	// 통신방식 등록
	public void comSetInsert(SystemInfoVO systemInfoVO) {

		String[] cnt1 = systemInfoVO.getComTypeCodes();
		for (int i = 0; i < cnt1.length; i++) {
			String[] cnt2 = systemInfoVO.getComSetCnts();
			systemInfoVO.setComTypeCode(cnt1[i]);
			if (!cnt2[i].equals("")) {
				systemInfoVO.setComSetCnt(cnt2[i]);
			}
			sqlSessionTemplate.insert("systemInfoSqlMap.comSetInsert", systemInfoVO);
			// com_set_id획득
			systemInfoVO.setComSetId(String.valueOf(sqlSessionTemplate.selectOne("systemInfoSqlMap.comSetId", systemInfoVO)));
			// ds_connect_info등록
			sqlSessionTemplate.insert("systemInfoSqlMap.dsConnectInsert", systemInfoVO);
		}
	}

	// 서버기기 상세정보
	public SystemInfoVO systemInfo(String systemId) {

		return sqlSessionTemplate.selectOne("systemInfoSqlMap.systemInfo", systemId);
	}

	// 통식방식 상세정보
	public List<SystemInfoVO> comTypeInfo(String systemId) {

		return sqlSessionTemplate.selectList("systemInfoSqlMap.comTypeInfo", systemId);
	}

	// 서비스운영 상세정보
	public SystemInfoVO mapdownManageInfo(String systemId) {

		return sqlSessionTemplate.selectOne("systemInfoSqlMap.mapdownManageInfo", systemId);
	}

	// 기존 등록 서비스 운영정보 삭제
	public void mapdownManageDelete(SystemInfoVO systemInfoVO) throws Exception {

		sqlSessionTemplate.delete("systemInfoSqlMap.mapdownManageDelete", systemInfoVO);
	}

	// 기존 등록 통식방식 삭제
	public void comSetDelete(SystemInfoVO systemInfoVO) throws Exception {

		sqlSessionTemplate.delete("systemInfoSqlMap.comSetDelete", systemInfoVO);
	}

	// 서버기기정보 수정
	public int systemInfoUpdate(SystemInfoVO systemInfoVO) {

		return sqlSessionTemplate.update("systemInfoSqlMap.systemInfoUpdate", systemInfoVO);
	}

	// DS서버 설정정보 수정
	public int mapdownManageUpdate(SystemInfoVO systemInfoVO) {

		return sqlSessionTemplate.insert("systemInfoSqlMap.mapdownManageInsert", systemInfoVO);
	}

	// 통신방식 수정
	public void comSetUpdate(SystemInfoVO systemInfoVO) {

		if (systemInfoVO.getComTypeCodes() != null && systemInfoVO.getComSetCnts() != null) {

			String[] cnt1 = systemInfoVO.getComTypeCodes();

			for (int i = 0; i < cnt1.length; i++) {
				String[] cnt2 = systemInfoVO.getComSetCnts();
				systemInfoVO.setComTypeCode(cnt1[i]);

				if (!cnt2[i].equals("")) {
					systemInfoVO.setComSetCnt(cnt2[i]);
				}

				sqlSessionTemplate.insert("systemInfoSqlMap.comSetInsert", systemInfoVO);
			}
		}
	}

	// 서버기기정보 삭제
	public int systemInfoDelete(SystemInfoVO systemInfoVO) {
		return sqlSessionTemplate.update("systemInfoSqlMap.systemInfoDelete", systemInfoVO);
	}


	
	// DS 서버기기정보 리스트 
	public List<DsInfoVo> dsSystemInfoSelect() {
		List<DsInfoVo> dsInfoList = null;
		try {
			dsInfoList = sqlSessionTemplate.selectList("systemInfoSqlMap.dsSystemInfoSelect");			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dsInfoList;
	}
	
	//DS 서버기기정보 
	public DsInfoVo dsSystemInfo(String systemId) {
	  DsInfoVo dsInfoVO = null;
	  try {
      dsInfoVO = sqlSessionTemplate.selectOne("systemInfoSqlMap.dsSystemInfo", systemId);
	  } catch (Exception e) {
      e.printStackTrace();
    }
	      
	  return dsInfoVO;
	}

}
