/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.appmanagement.vo;

import com.tmap.common.PaginationVO;

/**
 * <br/>
 * 
 * @author 김경민
 * @date 2012. 7. 19.
 */

public class AppServiceListVO extends PaginationVO {

	private String appInfoServiceSeq;
	private String appName;
	private String appInfoSeq;
	private String appUpName;
	private String appVerName;
	private String appVerId;
	private String appUpSeq;
	private String appUpVerId;
	private String appUpVerName;
	private String appDownUrl;
	private String appInfoServiceStoreDate;
	private String appInfoServiceRemark;
	private String appInfoServiceState;
	private String selectCurrentAppSeq;
	private String selectCurrentAppVerId;
	private String selectUpgradeAppSeq;
	private String selectUpgradeAppVerId;

	private String osPhInfoSeq;
	private String osVerInfoSeq;
	private String osVerName;
	private String phInfoSeq;
	private String phName;
	private String phModelInfoSeq;
	private String phModelName;
	private String stateColor;
	private String state;
	private String checkYn;
	private String upgrade_model_sdate;

	private String currentApp;
	private String rownum;
	private String keywordTp;
	private String duplicate;

	private String[] choiceCurrent;
	private String[] deleteOsPhs;
	
	
	private String introPopup;
	private String menuDisplay;
	private String mapDownload;
	private String upgradeComment;
	
	private String upgradeType;
	private String upgradeKey;
	
	//업그레이드 강제 구분 - F:강제 S:선택
	private String upgradeDivision;
	
	

	/**
	 * @return the upgrade_model_sdate
	 */

	public String getUpgrade_model_sdate() {
		return upgrade_model_sdate;
	}

	/**
	 * @param upgrade_model_sdate
	 *            the upgrade_model_sdate to set
	 */
	public void setUpgrade_model_sdate(String upgrade_model_sdate) {
		this.upgrade_model_sdate = upgrade_model_sdate;
	}

	/**
	 * @return the phModelName
	 */

	public String getPhModelName() {
		return phModelName;
	}

	/**
	 * @param phModelName
	 *            the phModelName to set
	 */
	public void setPhModelName(String phModelName) {
		this.phModelName = phModelName;
	}

	/**
	 * @return the state
	 */

	public String getState() {
		return state;
	}

	/**
	 * @param state
	 *            the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}

	/**
	 * @return the stateColor
	 */

	public String getStateColor() {
		return stateColor;
	}

	/**
	 * @param stateColor
	 *            the stateColor to set
	 */
	public void setStateColor(String stateColor) {
		this.stateColor = stateColor;
	}

	/**
	 * @return the choiceCurrent
	 */

	public String[] getChoiceCurrent() {
		return choiceCurrent;
	}

	/**
	 * @param choiceCurrent
	 *            the choiceCurrent to set
	 */
	public void setChoiceCurrent(String[] choiceCurrent) {
		this.choiceCurrent = choiceCurrent;
	}

	/**
	 * @return the deleteOsPhs
	 */

	public String[] getDeleteOsPhs() {
		return deleteOsPhs;
	}

	/**
	 * @param deleteOsPhs
	 *            the deleteOsPhs to set
	 */
	public void setDeleteOsPhs(String[] deleteOsPhs) {
		this.deleteOsPhs = deleteOsPhs;
	}

	/**
	 * @return the checkYn
	 */

	public String getCheckYn() {
		return checkYn;
	}

	/**
	 * @param checkYn
	 *            the checkYn to set
	 */
	public void setCheckYn(String checkYn) {
		this.checkYn = checkYn;
	}

	/**
	 * @return the osVerInfoSeq
	 */

	public String getOsVerInfoSeq() {
		return osVerInfoSeq;
	}

	/**
	 * @param osVerInfoSeq
	 *            the osVerInfoSeq to set
	 */
	public void setOsVerInfoSeq(String osVerInfoSeq) {
		this.osVerInfoSeq = osVerInfoSeq;
	}

	/**
	 * @return the phInfoSeq
	 */

	public String getPhInfoSeq() {
		return phInfoSeq;
	}

	/**
	 * @param phInfoSeq
	 *            the phInfoSeq to set
	 */
	public void setPhInfoSeq(String phInfoSeq) {
		this.phInfoSeq = phInfoSeq;
	}

	/**
	 * @return the duplicate
	 */

	public String getDuplicate() {
		return duplicate;
	}

	/**
	 * @param duplicate
	 *            the duplicate to set
	 */
	public void setDuplicate(String duplicate) {
		this.duplicate = duplicate;
	}

	/**
	 * @return the osVerName
	 */

	public String getOsVerName() {
		return osVerName;
	}

	/**
	 * @param osVerName
	 *            the osVerName to set
	 */
	public void setOsVerName(String osVerName) {
		this.osVerName = osVerName;
	}

	/**
	 * @return the phName
	 */

	public String getPhName() {
		return phName;
	}

	/**
	 * @param phName
	 *            the phName to set
	 */
	public void setPhName(String phName) {
		this.phName = phName;
	}

	/**
	 * @return the osPhInfoSeq
	 */

	public String getOsPhInfoSeq() {
		return osPhInfoSeq;
	}

	/**
	 * @param osPhInfoSeq
	 *            the osPhInfoSeq to set
	 */
	public void setOsPhInfoSeq(String osPhInfoSeq) {
		this.osPhInfoSeq = osPhInfoSeq;
	}

	/**
	 * @return the phModelInfoSeq
	 */

	public String getPhModelInfoSeq() {
		return phModelInfoSeq;
	}

	/**
	 * @param phModelInfoSeq
	 *            the phModelInfoSeq to set
	 */
	public void setPhModelInfoSeq(String phModelInfoSeq) {
		this.phModelInfoSeq = phModelInfoSeq;
	}

	/**
	 * @return the selectUpgradeAppSeq
	 */

	public String getSelectUpgradeAppSeq() {
		return selectUpgradeAppSeq;
	}

	/**
	 * @param selectUpgradeAppSeq
	 *            the selectUpgradeAppSeq to set
	 */
	public void setSelectUpgradeAppSeq(String selectUpgradeAppSeq) {
		this.selectUpgradeAppSeq = selectUpgradeAppSeq;
	}

	/**
	 * @return the currentApp
	 */

	public String getCurrentApp() {
		return currentApp;
	}

	/**
	 * @param currentApp
	 *            the currentApp to set
	 */
	public void setCurrentApp(String currentApp) {
		this.currentApp = currentApp;
	}

	/**
	 * @return the selectCurrentAppSeq
	 */

	public String getSelectCurrentAppSeq() {
		return selectCurrentAppSeq;
	}

	/**
	 * @param selectCurrentAppSeq
	 *            the selectCurrentAppSeq to set
	 */
	public void setSelectCurrentAppSeq(String selectCurrentAppSeq) {
		this.selectCurrentAppSeq = selectCurrentAppSeq;
	}

	/**
	 * @return the appInfoServiceSeq
	 */

	public String getAppInfoServiceSeq() {
		return appInfoServiceSeq;
	}

	/**
	 * @param appInfoServiceSeq
	 *            the appInfoServiceSeq to set
	 */
	public void setAppInfoServiceSeq(String appInfoServiceSeq) {
		this.appInfoServiceSeq = appInfoServiceSeq;
	}

	/**
	 * @return the appName
	 */

	public String getAppName() {
		return appName;
	}

	/**
	 * @param appName
	 *            the appName to set
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
	 * @param appInfoSeq
	 *            the appInfoSeq to set
	 */
	public void setAppInfoSeq(String appInfoSeq) {
		this.appInfoSeq = appInfoSeq;
	}

	/**
	 * @return the appUpName
	 */

	public String getAppUpName() {
		return appUpName;
	}

	/**
	 * @param appUpName
	 *            the appUpName to set
	 */
	public void setAppUpName(String appUpName) {
		this.appUpName = appUpName;
	}

	/**
	 * @return the appUpSeq
	 */

	public String getAppUpSeq() {
		return appUpSeq;
	}

	/**
	 * @param appUpSeq
	 *            the appUpSeq to set
	 */
	public void setAppUpSeq(String appUpSeq) {
		this.appUpSeq = appUpSeq;
	}

	/**
	 * @return the appDownUrl
	 */

	public String getAppDownUrl() {
		return appDownUrl;
	}

	/**
	 * @param appDownUrl
	 *            the appDownUrl to set
	 */
	public void setAppDownUrl(String appDownUrl) {
		this.appDownUrl = appDownUrl;
	}

	/**
	 * @return the appInfoServiceStoreDate
	 */

	public String getAppInfoServiceStoreDate() {
		return appInfoServiceStoreDate;
	}

	/**
	 * @param appInfoServiceStoreDate
	 *            the appInfoServiceStoreDate to set
	 */
	public void setAppInfoServiceStoreDate(String appInfoServiceStoreDate) {
		this.appInfoServiceStoreDate = appInfoServiceStoreDate;
	}

	/**
	 * @return the appInfoServiceRemark
	 */

	public String getAppInfoServiceRemark() {
		return appInfoServiceRemark;
	}

	/**
	 * @param appInfoServiceRemark
	 *            the appInfoServiceRemark to set
	 */
	public void setAppInfoServiceRemark(String appInfoServiceRemark) {
		this.appInfoServiceRemark = appInfoServiceRemark;
	}

	/**
	 * @return the appInfoServiceState
	 */

	public String getAppInfoServiceState() {
		return appInfoServiceState;
	}

	/**
	 * @param appInfoServiceState
	 *            the appInfoServiceState to set
	 */
	public void setAppInfoServiceState(String appInfoServiceState) {
		this.appInfoServiceState = appInfoServiceState;
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

	public String getSelectCurrentAppVerId() {
		return selectCurrentAppVerId;
	}

	public void setSelectCurrentAppVerId(String selectCurrentAppVerId) {
		this.selectCurrentAppVerId = selectCurrentAppVerId;
	}

	public String getSelectUpgradeAppVerId() {
		return selectUpgradeAppVerId;
	}

	public void setSelectUpgradeAppVerId(String selectUpgradeAppVerId) {
		this.selectUpgradeAppVerId = selectUpgradeAppVerId;
	}

	public String getIntroPopup() {
		return introPopup;
	}

	public void setIntroPopup(String introPopup) {
		this.introPopup = introPopup;
	}

	public String getMenuDisplay() {
		return menuDisplay;
	}

	public void setMenuDisplay(String menuDisplay) {
		this.menuDisplay = menuDisplay;
	}

	public String getMapDownload() {
		return mapDownload;
	}

	public void setMapDownload(String mapDownload) {
		this.mapDownload = mapDownload;
	}

	public String getUpgradeComment() {
		return upgradeComment;
	}

	public void setUpgradeComment(String upgradeComment) {
		this.upgradeComment = upgradeComment;
	}

	public String getUpgradeType() {
		return upgradeType;
	}

	public void setUpgradeType(String upgradeType) {
		this.upgradeType = upgradeType;
	}

	public String getUpgradeKey() {
		return upgradeKey;
	}

	public void setUpgradeKey(String upgradeKey) {
		this.upgradeKey = upgradeKey;
	}

	public String getUpgradeDivision() {
		return upgradeDivision;
	}

	public void setUpgradeDivision(String upgradeDivision) {
		this.upgradeDivision = upgradeDivision;
	}

	public String getAppUpVerId() {
		return appUpVerId;
	}

	public void setAppUpVerId(String appUpVerId) {
		this.appUpVerId = appUpVerId;
	}

	public String getAppUpVerName() {
		return appUpVerName;
	}

	public void setAppUpVerName(String appUpVerName) {
		this.appUpVerName = appUpVerName;
	}

	public String getAppVerName() {
		return appVerName;
	}

	public void setAppVerName(String appVerName) {
		this.appVerName = appVerName;
	}

	public String getAppVerId() {
		return appVerId;
	}

	public void setAppVerId(String appVerId) {
		this.appVerId = appVerId;
	}
}
