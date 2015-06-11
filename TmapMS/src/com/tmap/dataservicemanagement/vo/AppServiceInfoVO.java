package com.tmap.dataservicemanagement.vo;

import com.tmap.common.PaginationVO;

public class AppServiceInfoVO extends PaginationVO {

	private long rowSpan;
	private String rownum;
	private String keywordTp;
	private String appMappingId;
	private String appMappingName;
	private String appServiceId;
	private String appServiceName;
	private String appServiceState;
	private String appServiceType;
	private String appServiceSdate;
	private String appServiceDistribute;
	private String dataFileId;
	private String checkServiceName;
	private String appVerId;
	private String appId;

	public String getAppVerId() {
		return appVerId;
	}

	public void setAppVerId(String appVerId) {
		this.appVerId = appVerId;
	}

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	/**
	 * @return the checkServiceName
	 */

	public String getCheckServiceName() {
		return checkServiceName;
	}

	/**
	 * @param checkServiceName
	 *            the checkServiceName to set
	 */
	public void setCheckServiceName(String checkServiceName) {
		this.checkServiceName = checkServiceName;
	}

	/**
	 * @return the appServiceName
	 */

	public String getAppServiceName() {
		return appServiceName;
	}

	/**
	 * @param appServiceName
	 *            the appServiceName to set
	 */
	public void setAppServiceName(String appServiceName) {
		this.appServiceName = appServiceName;
	}

	/**
	 * @return the dataFileId
	 */

	public String getDataFileId() {
		return dataFileId;
	}

	/**
	 * @param dataFileId
	 *            the dataFileId to set
	 */
	public void setDataFileId(String dataFileId) {
		this.dataFileId = dataFileId;
	}

	/**
	 * @return the appServiceDistribute
	 */

	public String getAppServiceDistribute() {
		return appServiceDistribute;
	}

	/**
	 * @param appServiceDistribute
	 *            the appServiceDistribute to set
	 */
	public void setAppServiceDistribute(String appServiceDistribute) {
		this.appServiceDistribute = appServiceDistribute;
	}

	/**
	 * @return the rowSpan
	 */

	public long getRowSpan() {
		return rowSpan;
	}

	/**
	 * @param rowSpan
	 *            the rowSpan to set
	 */
	public void setRowSpan(long rowSpan) {
		this.rowSpan = rowSpan;
	}

	/**
	 * @return the rownum
	 */

	public String getRownum() {
		return rownum;
	}

	/**
	 * @param rownum
	 *            the rownum to set
	 */
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}

	/**
	 * @return the keywordTp
	 */

	public String getKeywordTp() {
		return keywordTp;
	}

	/**
	 * @param keywordTp
	 *            the keywordTp to set
	 */
	public void setKeywordTp(String keywordTp) {
		this.keywordTp = keywordTp;
	}

	/**
	 * @return the appMappingId
	 */

	public String getAppMappingId() {
		return appMappingId;
	}

	/**
	 * @param appMappingId
	 *            the appMappingId to set
	 */
	public void setAppMappingId(String appMappingId) {
		this.appMappingId = appMappingId;
	}

	/**
	 * @return the appMappingName
	 */

	public String getAppMappingName() {
		return appMappingName;
	}

	/**
	 * @param appMappingName
	 *            the appMappingName to set
	 */
	public void setAppMappingName(String appMappingName) {
		this.appMappingName = appMappingName;
	}

	/**
	 * @return the appServiceId
	 */

	public String getAppServiceId() {
		return appServiceId;
	}

	/**
	 * @param appServiceId
	 *            the appServiceId to set
	 */
	public void setAppServiceId(String appServiceId) {
		this.appServiceId = appServiceId;
	}

	/**
	 * @return the appServiceState
	 */

	public String getAppServiceState() {
		return appServiceState;
	}

	/**
	 * @param appServiceState
	 *            the appServiceState to set
	 */
	public void setAppServiceState(String appServiceState) {
		this.appServiceState = appServiceState;
	}

	/**
	 * @return the appServiceType
	 */

	public String getAppServiceType() {
		return appServiceType;
	}

	/**
	 * @param appServiceType
	 *            the appServiceType to set
	 */
	public void setAppServiceType(String appServiceType) {
		this.appServiceType = appServiceType;
	}

	/**
	 * @return the appServiceSdate
	 */

	public String getAppServiceSdate() {
		return appServiceSdate;
	}

	/**
	 * @param appServiceSdate
	 *            the appServiceSdate to set
	 */
	public void setAppServiceSdate(String appServiceSdate) {
		this.appServiceSdate = appServiceSdate;
	}

}