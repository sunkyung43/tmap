/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.servermanagement.vo;

import com.tmap.common.PaginationVO;

public class SettingAllInfoVO extends PaginationVO{

	private String ip;
	private String comTypeCode;
	private String comTypeName;

	private String comCountSet;
	private String[] comTypeCodes;
	private String comSetCnt;
	private String[] comSetCnts;
	private String comSetState;
	private String comSetStates;
	private String sessionMaxBandwidth;
	private String sessionMaxIdletime;
	private String totalMaxBandwidth;
	private String[] notAllowIpList;
	private String ipFilter;
	private String systemId;
	
	public String getSystemId() {
		return systemId;
	}

	public void setSystemId(String systemId) {
		this.systemId = systemId;
	}

	/** 
	 * @return the ipFilter 
	 */
	
	public String getIpFilter() {
		return ipFilter;
	}

	/** 
	 * @param ipFilter the ipFilter to set 
	 */
	public void setIpFilter(String ipFilter) {
		this.ipFilter = ipFilter;
	}

	/** 
	 * @return the notAllowIpList 
	 */
	
	public String[] getNotAllowIpList() {
		return notAllowIpList;
	}

	/** 
	 * @param notAllowIpList the notAllowIpList to set 
	 */
	public void setNotAllowIpList(String[] notAllowIpList) {
		this.notAllowIpList = notAllowIpList;
	}

	/** 
	 * @return the sessionMaxBandwidth 
	 */
	
	public String getSessionMaxBandwidth() {
		return sessionMaxBandwidth;
	}

	/** 
	 * @param sessionMaxBandwidth the sessionMaxBandwidth to set 
	 */
	public void setSessionMaxBandwidth(String sessionMaxBandwidth) {
		this.sessionMaxBandwidth = sessionMaxBandwidth;
	}

	/** 
	 * @return the sessionMaxIdletime 
	 */
	
	public String getSessionMaxIdletime() {
		return sessionMaxIdletime;
	}

	/** 
	 * @param sessionMaxIdletime the sessionMaxIdletime to set 
	 */
	public void setSessionMaxIdletime(String sessionMaxIdletime) {
		this.sessionMaxIdletime = sessionMaxIdletime;
	}

	/** 
	 * @return the totalMaxBandwidth 
	 */
	
	public String getTotalMaxBandwidth() {
		return totalMaxBandwidth;
	}

	/** 
	 * @param totalMaxBandwidth the totalMaxBandwidth to set 
	 */
	public void setTotalMaxBandwidth(String totalMaxBandwidth) {
		this.totalMaxBandwidth = totalMaxBandwidth;
	}

	/** 
	 * @return the comSetCnts 
	 */
	
	public String[] getComSetCnts() {
		return comSetCnts;
	}

	/** 
	 * @param comSetCnts the comSetCnts to set 
	 */
	public void setComSetCnts(String[] comSetCnts) {
		this.comSetCnts = comSetCnts;
	}

	/** 
	 * @return the comTypeIds 
	 */
	
	public String[] getComTypeCodes() {
		return comTypeCodes;
	}

	/** 
	 * @param comTypeIds the comTypeIds to set 
	 */
	public void setComTypeCodes(String[] comTypeCodes) {
		this.comTypeCodes = comTypeCodes;
	}

	/** 
	 * @return the comTypeId 
	 */
	
	public String getComTypeCode() {
		return comTypeCode;
	}

	/** 
	 * @param comTypeId the comTypeId to set 
	 */
	public void setComTypeCode(String comTypeCode) {
		this.comTypeCode = comTypeCode;
	}

	/** 
	 * @return the comTypeName 
	 */
	
	public String getComTypeName() {
		return comTypeName;
	}

	/** 
	 * @param comTypeName the comTypeName to set 
	 */
	public void setComTypeName(String comTypeName) {
		this.comTypeName = comTypeName;
	}

	/** 
	 * @return the comState 
	 */
	
	public String getComSetState() {
		return comSetState;
	}

	/** 
	 * @param comState the comState to set 
	 */
	public void setComSetState(String comSetState) {
		this.comSetState = comSetState;
	}

	/** 
	 * @return the comCountSet 
	 */
	
	public String getComCountSet() {
		return comCountSet;
	}

	/** 
	 * @param comCountSet the comCountSet to set 
	 */
	public void setComCountSet(String comCountSet) {
		this.comCountSet = comCountSet;
	}

	/** 
	 * @return the ip 
	 */
	
	public String getIp() {
		return ip;
	}

	/** 
	 * @param ip the ip to set 
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}

  public String getComSetCnt() {
    return comSetCnt;
  }

  public void setComSetCnt(String comSetCnt) {
    this.comSetCnt = comSetCnt;
  }

  public String getComSetStates() {
    return comSetStates;
  }

  public void setComSetStates(String comSetStates) {
    this.comSetStates = comSetStates;
  }
	
	
}
