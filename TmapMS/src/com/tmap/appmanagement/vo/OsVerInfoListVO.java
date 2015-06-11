package com.tmap.appmanagement.vo;

import com.tmap.common.PaginationVO;

public class OsVerInfoListVO extends PaginationVO {

	private String osVerInfoSeq;
	private String osVerName;
	private String osVerContent;
	private String osVerStoreDate;
	private String osVerState;
	private String osDivision;
	private String rownum;
	private String keywordTp;
	private String activeId;

	public String getOsDivision() {
		return osDivision;
	}

	public String getActiveId() {
		return activeId;
	}

	public void setActiveId(String activeId) {
		this.activeId = activeId;
	}

	public void setOsDivision(String osDivision) {
		this.osDivision = osDivision;
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
	 * @return the osVerContent
	 */

	public String getOsVerContent() {
		return osVerContent;
	}

	/**
	 * @param osVerContent
	 *            the osVerContent to set
	 */
	public void setOsVerContent(String osVerContent) {
		this.osVerContent = osVerContent;
	}

	/**
	 * @return the osVerStoreDate
	 */

	public String getOsVerStoreDate() {
		return osVerStoreDate;
	}

	/**
	 * @param osVerStoreDate
	 *            the osVerStoreDate to set
	 */
	public void setOsVerStoreDate(String osVerStoreDate) {
		this.osVerStoreDate = osVerStoreDate;
	}

	/**
	 * @return the osVerState
	 */

	public String getOsVerState() {
		return osVerState;
	}

	/**
	 * @param osVerState
	 *            the osVerState to set
	 */
	public void setOsVerState(String osVerState) {
		this.osVerState = osVerState;
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

}