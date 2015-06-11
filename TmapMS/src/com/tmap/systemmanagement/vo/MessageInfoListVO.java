package com.tmap.systemmanagement.vo;

import com.tmap.common.PaginationVO;

public class MessageInfoListVO extends PaginationVO{
	
	private String rownum;
	private String keywordTp;
	private String messageSeq;
	private String messageType;
	private String messageCode;
	private String messageCodeValue;
	private String messageContent;
	private String useState;
	
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

	/** 
	 * @return the messageSeq 
	 */
	
	public String getMessageSeq() {
		return messageSeq;
	}

	/** 
	 * @param messageSeq the messageSeq to set 
	 */
	public void setMessageSeq(String messageSeq) {
		this.messageSeq = messageSeq;
	}

	/** 
	 * @return the messageType 
	 */
	
	public String getMessageType() {
		return messageType;
	}

	/** 
	 * @param messageType the messageType to set 
	 */
	public void setMessageType(String messageType) {
		this.messageType = messageType;
	}

	/** 
	 * @return the messageCode 
	 */
	
	public String getMessageCode() {
		return messageCode;
	}

	/** 
	 * @param messageCode the messageCode to set 
	 */
	public void setMessageCode(String messageCode) {
		this.messageCode = messageCode;
	}

	/** 
	 * @return the messageCodeValue 
	 */
	
	public String getMessageCodeValue() {
		return messageCodeValue;
	}

	/** 
	 * @param messageCodeValue the messageCodeValue to set 
	 */
	public void setMessageCodeValue(String messageCodeValue) {
		this.messageCodeValue = messageCodeValue;
	}

	/** 
	 * @return the messageContent 
	 */
	
	public String getMessageContent() {
		return messageContent;
	}

	/** 
	 * @param messageContent the messageContent to set 
	 */
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	/** 
	 * @return the useState 
	 */
	
	public String getUseState() {
		return useState;
	}

	/** 
	 * @param useState the useState to set 
	 */
	public void setUseState(String useState) {
		this.useState = useState;
	}
	
	
}