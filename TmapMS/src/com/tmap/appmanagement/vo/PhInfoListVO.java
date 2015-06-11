package com.tmap.appmanagement.vo;

import com.tmap.common.PaginationVO;

public class PhInfoListVO extends PaginationVO {

	private String phInfoSeq;
	private String phName;
	private String phContent;
	private String phStoreDate;
	private String phState;
	private String phMade;
	private String phDivision; // AN : 안드로이드, IO : IOS
	private String rownum;
	private String keywordTp;
	private String isMapping = "false";
	private String activeId;
	
	public String getActiveId() {
		return activeId;
	}

	public void setActiveId(String activeId) {
		this.activeId = activeId;
	}
	
	public String getIsMapping() {
		return isMapping;
	}

	public void setIsMapping(String isMapping) {
		this.isMapping = isMapping;
	}

	/**
	 * @return the phMade
	 */

	public String getPhMade() {
		return phMade;
	}

	/**
	 * @param phMade
	 *            the phMade to set
	 */
	public void setPhMade(String phMade) {
		this.phMade = phMade;
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
	 * @return the phContent
	 */

	public String getPhContent() {
		return phContent;
	}

	/**
	 * @param phContent
	 *            the phContent to set
	 */
	public void setPhContent(String phContent) {
		this.phContent = phContent;
	}

	/**
	 * @return the phStoreDate
	 */

	public String getPhStoreDate() {
		return phStoreDate;
	}

	/**
	 * @param phStoreDate
	 *            the phStoreDate to set
	 */
	public void setPhStoreDate(String phStoreDate) {
		this.phStoreDate = phStoreDate;
	}

	/**
	 * @return the phState
	 */

	public String getPhState() {
		return phState;
	}

	/**
	 * @param phState
	 *            the phState to set
	 */
	public void setPhState(String phState) {
		this.phState = phState;
	}

	/**
	 * @return the rownum
	 */
	public String getPhDivision() {
		return phDivision;
	}

	public void setPhDivision(String phDivision) {
		this.phDivision = phDivision;
	}

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