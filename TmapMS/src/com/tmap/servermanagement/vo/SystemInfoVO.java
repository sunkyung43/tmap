/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.vo;

import java.util.ArrayList;
import java.util.List;

import com.btb.mdcs.model.LoginInfoVo;
import com.tmap.common.PaginationVO;

public class SystemInfoVO extends PaginationVO {

	private String rownum;
	private String keywordTp;
	// system_info
	private String systemId;
	private String systemName;
	private String systemNum;
	private String systemState;
	private String systemSdate;
	private String systemIpOut;
	private String systemPortOut;
	private String systemIpIn;
	private String systemPortIn;
	private String systemCpuCount;
	private String systemMemory;
	private String etc;
	// 서버 공통코드
	private String serverTypeId;

	// mapdown_manage_info
	private String mapdownManageId;
	private String sessionMaxIdletime;
	private String sessionMaxBandwidth;
	private String totalMaxBandwidth;

	// serverType

	// com_set_info
	private String comSetId;
	private String comSetCnt;
	private String comSetState;
	private String comTypeCode;
	private String[] comTypeCodes;
	private String[] comSetCnts;
	private String comTypeName;

	// ds_connect_info
	private String dsConnectId;
	private String dsConnectCnt;
	private String dsConnectState;

	private String serverTypeName;
	private String serverTypeCode;

	private String checkSystemName;
	private String oldServerTypeName;
	private String color;
	private int connect = 0;
	private String hpNum;
	private String connectTime;
	private int sessionMaxCount = 0;
	
	private int userCount;

	private int sumCount;
	private long currentBandWidth;
	
	private List<LoginInfoVo> loginInfoList;
	
	private String activeId = "0";
	
	public String getActiveId() {
		return activeId;
	}

	public void setActiveId(String activeId) {
		this.activeId = activeId;
	}

	public int getSumCount() {
		return sumCount;
	}

	public void setSumCount(int sumCount) {
		this.sumCount = sumCount;
	}

	public int getUserCount() {
		return userCount;
	}

	public void setUserCount(int userCount) {
		this.userCount = userCount;
	}

	public String getRownum() {
		return rownum;
	}

	public void setRownum(String rownum) {
		this.rownum = rownum;
	}

	public String getKeywordTp() {
		return keywordTp;
	}

	public void setKeywordTp(String keywordTp) {
		this.keywordTp = keywordTp;
	}

	public String getSystemId() {
		return systemId;
	}

	public void setSystemId(String systemId) {
		this.systemId = systemId;
	}

	public String getSystemName() {
		return systemName;
	}

	public void setSystemName(String systemName) {
		this.systemName = systemName;
	}

	public String getSystemNum() {
		return systemNum;
	}

	public void setSystemNum(String systemNum) {
		this.systemNum = systemNum;
	}

	public String getSystemState() {
		return systemState;
	}

	public void setSystemState(String systemState) {
		this.systemState = systemState;
	}

	public String getSystemSdate() {
		return systemSdate;
	}

	public void setSystemSdate(String systemSdate) {
		this.systemSdate = systemSdate;
	}

	public String getSystemIpOut() {
		return systemIpOut;
	}

	public void setSystemIpOut(String systemIpOut) {
		this.systemIpOut = systemIpOut;
	}

	public String getSystemPortOut() {
		return systemPortOut;
	}

	public void setSystemPortOut(String systemPortOut) {
		this.systemPortOut = systemPortOut;
	}

	public String getSystemIpIn() {
		return systemIpIn;
	}

	public void setSystemIpIn(String systemIpIn) {
		this.systemIpIn = systemIpIn;
	}

	public String getSystemPortIn() {
		return systemPortIn;
	}

	public void setSystemPortIn(String systemPortIn) {
		this.systemPortIn = systemPortIn;
	}

	public String getSystemCpuCount() {
		return systemCpuCount;
	}

	public void setSystemCpuCount(String systemCpuCount) {
		this.systemCpuCount = systemCpuCount;
	}

	public String getSystemMemory() {
		return systemMemory;
	}

	public void setSystemMemory(String systemMemory) {
		this.systemMemory = systemMemory;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getServerTypeId() {
		return serverTypeId;
	}

	public void setServerTypeId(String serverTypeId) {
		this.serverTypeId = serverTypeId;
	}

	public String getMapdownManageId() {
		return mapdownManageId;
	}

	public void setMapdownManageId(String mapdownManageId) {
		this.mapdownManageId = mapdownManageId;
	}

	public String getSessionMaxIdletime() {
		return sessionMaxIdletime;
	}

	public void setSessionMaxIdletime(String sessionMaxIdletime) {
		this.sessionMaxIdletime = sessionMaxIdletime;
	}

	public String getSessionMaxBandwidth() {
		return sessionMaxBandwidth;
	}

	public void setSessionMaxBandwidth(String sessionMaxBandwidth) {
		this.sessionMaxBandwidth = sessionMaxBandwidth;
	}

	public String getTotalMaxBandwidth() {
		return totalMaxBandwidth;
	}

	public void setTotalMaxBandwidth(String totalMaxBandwidth) {
		this.totalMaxBandwidth = totalMaxBandwidth;
	}

	public String getComSetId() {
		return comSetId;
	}

	public void setComSetId(String comSetId) {
		this.comSetId = comSetId;
	}

	public String getComSetCnt() {
		return comSetCnt;
	}

	public void setComSetCnt(String comSetCnt) {
		this.comSetCnt = comSetCnt;
	}

	public String getComSetState() {
		return comSetState;
	}

	public void setComSetState(String comSetState) {
		this.comSetState = comSetState;
	}

	public String getComTypeCode() {
		return comTypeCode;
	}

	public void setComTypeCode(String comTypeCode) {
		this.comTypeCode = comTypeCode;
	}

	public String getDsConnectId() {
		return dsConnectId;
	}

	public void setDsConnectId(String dsConnectId) {
		this.dsConnectId = dsConnectId;
	}

	public String getDsConnectCnt() {
		return dsConnectCnt;
	}

	public void setDsConnectCnt(String dsConnectCnt) {
		this.dsConnectCnt = dsConnectCnt;
	}

	public String getDsConnectState() {
		return dsConnectState;
	}

	public void setDsConnectState(String dsConnectState) {
		this.dsConnectState = dsConnectState;
	}

	public String[] getComTypeCodes() {
		return comTypeCodes;
	}

	public void setComTypeCodes(String[] comTypeCodes) {
		this.comTypeCodes = comTypeCodes;
	}

	public String[] getComSetCnts() {
		return comSetCnts;
	}

	public void setComSetCnts(String[] comSetCnts) {
		this.comSetCnts = comSetCnts;
	}

	public String getServerTypeName() {
		return serverTypeName;
	}

	public void setServerTypeName(String serverTypeName) {
		this.serverTypeName = serverTypeName;
	}

	public String getServerTypeCode() {
		return serverTypeCode;
	}

	public void setServerTypeCode(String serverTypeCode) {
		this.serverTypeCode = serverTypeCode;
	}

	public String getComTypeName() {
		return comTypeName;
	}

	public void setComTypeName(String comTypeName) {
		this.comTypeName = comTypeName;
	}

	public String getCheckSystemName() {
		return checkSystemName;
	}

	public void setCheckSystemName(String checkSystemName) {
		this.checkSystemName = checkSystemName;
	}

	public String getOldServerTypeName() {
		return oldServerTypeName;
	}

	public void setOldServerTypeName(String oldServerTypeName) {
		this.oldServerTypeName = oldServerTypeName;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public int getConnect() {
		return connect;
	}

	public void setConnect(int connect) {
		this.connect = connect;
	}

	public String getHpNum() {
		return hpNum;
	}

	public void setHpNum(String hpNum) {
		this.hpNum = hpNum;
	}

	public String getConnectTime() {
		return connectTime;
	}

	public void setConnectTime(String connectTime) {
		this.connectTime = connectTime;
	}

	public int getSessionMaxCount() {
		return sessionMaxCount;
	}

	public void setSessionMaxCount(int sessionMaxCount) {
		this.sessionMaxCount = sessionMaxCount;
	}
	
	public void addLoginInfoVO(LoginInfoVo loginInfoVo) {
		if (loginInfoList == null) {
			loginInfoList = new ArrayList<LoginInfoVo>();
		}
		loginInfoList.add(loginInfoVo);
		currentBandWidth += loginInfoVo.getDownloadThroughput();
	}

	public List<LoginInfoVo> getLoginInfoList() {
		return loginInfoList;
	}

	public long getCurrentBandWidth() {
		return currentBandWidth;
	}


}
