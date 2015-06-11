package com.tmap.systemmanagement.vo;

import com.tmap.common.PaginationVO;

public class TestPhoneInfoListVO extends PaginationVO{
	
	private String testPhoneSeq;
	private String testPhoneStoreDate;
	private String testPhoneNumber;
	private String testPhoneState;
	private String userName;
	private String userId;
	private String etc;
	private String rownum;
	private String keywordTp;
	
	
	/** 
	 * @return the etc 
	 */
	
	public String getEtc() {
		return etc;
	}

	/** 
	 * @param etc the etc to set 
	 */
	public void setEtc(String etc) {
		this.etc = etc;
	}

	/** 
	 * @return the user_id 
	 */
	
	public String getUserId() {
		return userId;
	}

	/** 
	 * @param user_id the user_id to set 
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}

	/** 
	 * @return the userName 
	 */
	
	public String getUserName() {
		return userName;
	}

	/** 
	 * @param userName the userName to set 
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}

	/** 
	 * @return the testPhoneSeq 
	 */
	
	public String getTestPhoneSeq() {
		return testPhoneSeq;
	}

	/** 
	 * @param testPhoneSeq the testPhoneSeq to set 
	 */
	public void setTestPhoneSeq(String testPhoneSeq) {
		this.testPhoneSeq = testPhoneSeq;
	}

	/** 
	 * @return the testPhoneStoreDate 
	 */
	
	public String getTestPhoneStoreDate() {
		return testPhoneStoreDate;
	}

	/** 
	 * @param testPhoneStoreDate the testPhoneStoreDate to set 
	 */
	public void setTestPhoneStoreDate(String testPhoneStoreDate) {
		this.testPhoneStoreDate = testPhoneStoreDate;
	}

	/** 
	 * @return the testPhoneNumber 
	 */
	
	public String getTestPhoneNumber() {
		return testPhoneNumber;
	}

	/** 
	 * @param testPhoneNumber the testPhoneNumber to set 
	 */
	public void setTestPhoneNumber(String testPhoneNumber) {
		this.testPhoneNumber = testPhoneNumber;
	}

	/** 
	 * @return the testPhoneState 
	 */
	
	public String getTestPhoneState() {
		return testPhoneState;
	}

	/** 
	 * @param testPhoneState the testPhoneState to set 
	 */
	public void setTestPhoneState(String testPhoneState) {
		this.testPhoneState = testPhoneState;
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