package com.tmap.appmanagement.vo;

import com.tmap.common.PaginationVO;

public class PhModelInfoListVO extends PaginationVO{
	
	private String osVerInfoSeq;
	private String osVerName;
	private String osVerMade;
	private String osVerContent;
	private String osVerStoreDate;
	private String osVerState;
	private String phInfoSeq;
	private String phName;
	private String phMade;
	private String phContent;
	private String phStoreDate;
	private String phState;
	private String phModelInfoSeq;
	private String phModelState;
	private String phModelStoreDate;
	private String phModelName;
	private String rownum;
	private String keywordTp;
	private String[] phModelInfoSeqs;
	private String phDivision; // AN : 안드로이드, IO : IOS
	private String activeId;
	private String phNameId;
	
	public String getPhNameId() {
		return phNameId;
	}

	public void setPhNameId(String phNameId) {
		this.phNameId = phNameId;
	}

	private String[] checkOsVerIds;
	private String osDivision;
	
	public String getOsDivision() {
		return osDivision;
	}

	public void setOsDivision(String osDivision) {
		this.osDivision = osDivision;
	}

	public String[] getCheckOsVerIds() {
		return checkOsVerIds;
	}

	public void setCheckOsVerIds(String[] checkOsVerIds) {
		this.checkOsVerIds = checkOsVerIds;
	}

	public String getActiveId() {
		return activeId;
	}

	public void setActiveId(String activeId) {
		this.activeId = activeId;
	}

	public String getPhDivision() {
		return phDivision;
	}

	public void setPhDivision(String phDivision) {
		this.phDivision = phDivision;
	}

	/** 
	 * @return the osVerMade 
	 */
	
	public String getOsVerMade() {
		return osVerMade;
	}

	/** 
	 * @param osVerMade the osVerMade to set 
	 */
	public void setOsVerMade(String osVerMade) {
		this.osVerMade = osVerMade;
	}

	/** 
	 * @return the phMade 
	 */
	
	public String getPhMade() {
		return phMade;
	}

	/** 
	 * @param phMade the phMade to set 
	 */
	public void setPhMade(String phMade) {
		this.phMade = phMade;
	}

	/** 
	 * @return the phModelInfoName 
	 */
	
	public String getPhModelName() {
		return phModelName;
	}

	/** 
	 * @param phModelInfoName the phModelInfoName to set 
	 */
	public void setPhModelName(String phModelName) {
		this.phModelName = phModelName;
	}

	/** 
	 * @return the phModelInfoSeqs 
	 */
	
	public String[] getPhModelInfoSeqs() {
		return phModelInfoSeqs;
	}

	/** 
	 * @param phModelInfoSeqs the phModelInfoSeqs to set 
	 */
	public void setPhModelInfoSeqs(String[] phModelInfoSeqs) {
		this.phModelInfoSeqs = phModelInfoSeqs;
	}

	/** 
	 * @return the osVerInfoSeq 
	 */
	
	public String getOsVerInfoSeq() {
		return osVerInfoSeq;
	}

	/** 
	 * @param osVerInfoSeq the osVerInfoSeq to set 
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
	 * @return the osVerStoreDate 
	 */
	
	public String getOsVerStoreDate() {
		return osVerStoreDate;
	}

	/** 
	 * @param osVerStoreDate the osVerStoreDate to set 
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
	 * @param osVerState the osVerState to set 
	 */
	public void setOsVerState(String osVerState) {
		this.osVerState = osVerState;
	}

	/** 
	 * @return the phInfoSeq 
	 */
	
	public String getPhInfoSeq() {
		return phInfoSeq;
	}

	/** 
	 * @param phInfoSeq the phInfoSeq to set 
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
	 * @return the phStoreDate 
	 */
	
	public String getPhStoreDate() {
		return phStoreDate;
	}

	/** 
	 * @param phStoreDate the phStoreDate to set 
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
	 * @param phState the phState to set 
	 */
	public void setPhState(String phState) {
		this.phState = phState;
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
	 * @return the phModelState 
	 */
	
	public String getPhModelState() {
		return phModelState;
	}

	/** 
	 * @param phModelState the phModelState to set 
	 */
	public void setPhModelState(String phModelState) {
		this.phModelState = phModelState;
	}

	/** 
	 * @return the phModelStoreDate 
	 */
	
	public String getPhModelStoreDate() {
		return phModelStoreDate;
	}

	/** 
	 * @param phModelStoreDate the phModelStoreDate to set 
	 */
	public void setPhModelStoreDate(String phModelStoreDate) {
		this.phModelStoreDate = phModelStoreDate;
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