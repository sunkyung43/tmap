package com.tmap.appmanagement.vo;

import com.tmap.common.PaginationVO;

public class AppInfoListVO extends PaginationVO{
	
	private long rowSpan;
	private String appName;
	private String appInfoSeq;
	private String appContent;
	private String appStoreDate;
	private String appState;
	private String appDownURL;
	private String appMade;
	private String osPhInfoSeq;
	private String osPhState;
	private String osPhInfoStoreDate;
	private String phId;
	private String phName = "";
	private String phName2 = "";
	private String phContent;
	private String osVerId;
	private String osVerName;
	private String osVerContent;
	private String phModelInfoSeq;
	private String rownum;
	private String keywordTp;
	private String searchAppName;
	private String[] checkboxPhModelInfos;
	private String[] phIds;
	private String[] osVerIds;
	private String appVerId;
	private String appVerName;
	private String appVerContent;
	private String appVerState;
	private String appVerSdate;
	private String templetModelName;
	private String templetModelId;
	private String isMapping = "false";
	private String phModelId;
	
	public String getPhModelId() {
		return phModelId;
	}
	public void setPhModelId(String phModelId) {
		this.phModelId = phModelId;
	}

	private String[] phModelIds;

	
	public String[] getPhModelIds() {
		return phModelIds;
	}
	public void setPhModelIds(String[] phModelIds) {
		this.phModelIds = phModelIds;
	}
	public String getIsMapping() {
    return isMapping;
  }
  public void setIsMapping(String isMapping) {
    this.isMapping = isMapping;
  }
  /** 
	 * @return the templetModelId 
	 */
	
	public String getTempletModelId() {
		return templetModelId;
	}

	/** 
	 * @param templetModelId the templetModelId to set 
	 */
	public void setTempletModelId(String templetModelId) {
		this.templetModelId = templetModelId;
	}

	/** 
	 * @return the templetModelName 
	 */
	
	public String getTempletModelName() {
		return templetModelName;
	}

	/** 
	 * @param templetModelName the templetModelName to set 
	 */
	public void setTempletModelName(String templetModelName) {
		this.templetModelName = templetModelName;
	}

	/** 
	 * @return the phName2 
	 */
	
	public String getPhName2() {
		return phName2;
	}

	/** 
	 * @param phName2 the phName2 to set 
	 */
	public void setPhName2(String phName2) {
		this.phName2 = phName2;
	}

	/** 
	 * @return the app_ver_id 
	 */
	
	public String getAppVerId() {
		return appVerId;
	}

	/** 
	 * @param app_ver_id the app_ver_id to set 
	 */
	public void setAppVerId(String appVerId) {
		this.appVerId = appVerId;
	}

	/** 
	 * @return the phIds 
	 */
	
	public String[] getPhIds() {
		return phIds;
	}

	/** 
	 * @param phIds the phIds to set 
	 */
	public void setPhIds(String[] phIds) {
		this.phIds = phIds;
	}

	/** 
	 * @return the osVerIds 
	 */
	
	public String[] getOsVerIds() {
		return osVerIds;
	}

	/** 
	 * @param osVerIds the osVerIds to set 
	 */
	public void setOsVerIds(String[] osVerIds) {
		this.osVerIds = osVerIds;
	}

	/** 
	 * @return the ph_id 
	 */
	
	public String getPhId() {
		return phId;
	}

	/** 
	 * @param ph_id the ph_id to set 
	 */
	public void setPhId(String phId) {
		this.phId = phId;
	}

	/** 
	 * @return the os_ver_id 
	 */
	
	public String getOsVerId() {
		return osVerId;
	}

	/** 
	 * @param os_ver_id the os_ver_id to set 
	 */
	public void setOsVerId(String osVerId) {
		this.osVerId = osVerId;
	}

	/** 
	 * @return the appMade 
	 */
	
	public String getAppMade() {
		return appMade;
	}

	/** 
	 * @param appMade the appMade to set 
	 */
	public void setAppMade(String appMade) {
		this.appMade = appMade;
	}

	/** 
	 * @return the app_ver_name 
	 */
	
	public String getAppVerName() {
		return appVerName;
	}

	/** 
	 * @param app_ver_name the app_ver_name to set 
	 */
	public void setAppVerName(String appVerName) {
		this.appVerName = appVerName;
	}

	/** 
	 * @return the app_ver_content 
	 */
	
	public String getAppVerContent() {
		return appVerContent;
	}

	/** 
	 * @param app_ver_content the app_ver_content to set 
	 */
	public void setAppVerContent(String appVerContent) {
		this.appVerContent = appVerContent;
	}

	/** 
	 * @return the app_ver_state 
	 */
	
	public String getAppVerState() {
		return appVerState;
	}

	/** 
	 * @param app_ver_state the app_ver_state to set 
	 */
	public void setAppVerState(String appVerState) {
		this.appVerState = appVerState;
	}

	/** 
	 * @return the app_ver_sdate 
	 */
	
	public String getAppVerSdate() {
		return appVerSdate;
	}

	/** 
	 * @param app_ver_sdate the app_ver_sdate to set 
	 */
	public void setAppVerSdate(String appVerSdate) {
		this.appVerSdate = appVerSdate;
	}

	/** 
	 * @return the checkboxPhModelInfos 
	 */
	
	public String[] getCheckboxPhModelInfos() {
		return checkboxPhModelInfos;
	}

	/** 
	 * @param checkboxPhModelInfos the checkboxPhModelInfos to set 
	 */
	public void setCheckboxPhModelInfos(String[] checkboxPhModelInfos) {
		this.checkboxPhModelInfos = checkboxPhModelInfos;
	}

	/** 
	 * @return the searchAppName 
	 */
	
	public String getSearchAppName() {
		return searchAppName;
	}

	/** 
	 * @param searchAppName the searchAppName to set 
	 */
	public void setSearchAppName(String searchAppName) {
		this.searchAppName = searchAppName;
	}

	/** 
	 * @return the phModelInfoSeq 
	 */
	
	public String getPhModelInfoSeq() {
		return phModelInfoSeq;
	}

	/** 
	 * @param phModelInfoSeq the phModelInfoSeq to set 
	 */
	public void setPhModelInfoSeq(String phModelInfoSeq) {
		this.phModelInfoSeq = phModelInfoSeq;
	}

	/** 
	 * @return the phName 
	 */
	
	public String getPhName() {
		return phName;
	}

	/** 
	 * @param phName the phName to set 
	 */
	public void setPhName(String phName) {
		this.phName = phName;
	}

	/** 
	 * @return the phContent 
	 */
	
	public String getPhContent() {
		return phContent;
	}

	/** 
	 * @param phContent the phContent to set 
	 */
	public void setPhContent(String phContent) {
		this.phContent = phContent;
	}

	/** 
	 * @return the osVerName 
	 */
	
	public String getOsVerName() {
		return osVerName;
	}

	/** 
	 * @param osVerName the osVerName to set 
	 */
	public void setOsVerName(String osVerName) {
		this.osVerName = osVerName;
	}

	/** 
	 * @return the osVerContent 
	 */
	
	public String getOsVerContent() {
		return osVerContent;
	}

	/** 
	 * @param osVerContent the osVerContent to set 
	 */
	public void setOsVerContent(String osVerContent) {
		this.osVerContent = osVerContent;
	}

	/** 
	 * @return the rowSpan 
	 */
	
	public long getRowSpan() {
		return rowSpan;
	}

	/** 
	 * @param rowSpan the rowSpan to set 
	 */
	public void setRowSpan(long rowSpan) {
		this.rowSpan = rowSpan;
	}

	/** 
	 * @return the appName 
	 */
	
	public String getAppName() {
		return appName;
	}

	/** 
	 * @param appName the appName to set 
	 */
	public void setAppName(String appName) {
		this.appName = appName;
	}

	/** 
	 * @return the appInfoSeq 
	 */
	
	public String getAppInfoSeq() {
		return appInfoSeq;
	}

	/** 
	 * @param appInfoSeq the appInfoSeq to set 
	 */
	public void setAppInfoSeq(String appInfoSeq) {
		this.appInfoSeq = appInfoSeq;
	}

	/** 
	 * @return the appContent 
	 */
	
	public String getAppContent() {
		return appContent;
	}

	/** 
	 * @param appContent the appContent to set 
	 */
	public void setAppContent(String appContent) {
		this.appContent = appContent;
	}

	/** 
	 * @return the appStoreDate 
	 */
	
	public String getAppStoreDate() {
		return appStoreDate;
	}

	/** 
	 * @param appStoreDate the appStoreDate to set 
	 */
	public void setAppStoreDate(String appStoreDate) {
		this.appStoreDate = appStoreDate;
	}

	/** 
	 * @return the appState 
	 */
	
	public String getAppState() {
		return appState;
	}

	/** 
	 * @param appState the appState to set 
	 */
	public void setAppState(String appState) {
		this.appState = appState;
	}

	/** 
	 * @return the appDownURL 
	 */
	
	public String getAppDownURL() {
		return appDownURL;
	}

	/** 
	 * @param appDownURL the appDownURL to set 
	 */
	public void setAppDownURL(String appDownURL) {
		this.appDownURL = appDownURL;
	}

	/** 
	 * @return the osPhInfoSeq 
	 */
	
	public String getOsPhInfoSeq() {
		return osPhInfoSeq;
	}

	/** 
	 * @param osPhInfoSeq the osPhInfoSeq to set 
	 */
	public void setOsPhInfoSeq(String osPhInfoSeq) {
		this.osPhInfoSeq = osPhInfoSeq;
	}

	/** 
	 * @return the osPhState 
	 */
	
	public String getOsPhState() {
		return osPhState;
	}

	/** 
	 * @param osPhState the osPhState to set 
	 */
	public void setOsPhState(String osPhState) {
		this.osPhState = osPhState;
	}

	/** 
	 * @return the osPhInfoStoreDate 
	 */
	
	public String getOsPhInfoStoreDate() {
		return osPhInfoStoreDate;
	}

	/** 
	 * @param osPhInfoStoreDate the osPhInfoStoreDate to set 
	 */
	public void setOsPhInfoStoreDate(String osPhInfoStoreDate) {
		this.osPhInfoStoreDate = osPhInfoStoreDate;
	}

	/** 
	 * @return the rownum 
	 */
	public String getRownum() {
		return rownum;
	}

	/** 
	 * @param rownum the rownum to set 
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
	 * @param keywordTp the keywordTp to set 
	 */
	public void setKeywordTp(String keywordTp) {
		this.keywordTp = keywordTp;
	}
	
}