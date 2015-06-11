/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.systemmanagement.vo;

import com.tmap.common.PaginationVO;

/** 
 * <br/>
 * @author 김경민 
 * @date 2012. 7. 19. 
 */

public class ComCodeInfoListVO  extends PaginationVO{

	private String rownum;
	private String keywordTp;
	private String comCode;
	private String comId;
	private String sComCode;
	private String codeLevel;
	private String codeName;
	private String codeRemark;
	private String useState;
	private String upComCode;
	private String systemId;
	
	public String getSystemId() {
		return systemId;
	}
	public void setSystemId(String systemId) {
		this.systemId = systemId;
	}
	public String getMapdownManageId() {
		return mapdownManageId;
	}
	public void setMapdownManageId(String mapdownManageId) {
		this.mapdownManageId = mapdownManageId;
	}
	private String mapdownManageId;
	
	/** 
	 * @return the comId 
	 */
	
	public String getComId() {
		return comId;
	}
	/** 
	 * @param comId the comId to set 
	 */
	public void setComId(String comId) {
		this.comId = comId;
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
	/** 
	 * @return the comCode 
	 */
	
	public String getComCode() {
		return comCode;
	}
	/** 
	 * @param comCode the comCode to set 
	 */
	public void setComCode(String comCode) {
		this.comCode = comCode;
	}
	/** 
	 * @return the codeLevel 
	 */
	
	public String getCodeLevel() {
		return codeLevel;
	}
	/** 
	 * @param codeLevel the codeLevel to set 
	 */
	public void setCodeLevel(String codeLevel) {
		this.codeLevel = codeLevel;
	}
	/** 
	 * @return the codeName 
	 */
	
	public String getCodeName() {
		return codeName;
	}
	/** 
	 * @param codeName the codeName to set 
	 */
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	/** 
	 * @return the codeRemark 
	 */
	
	public String getCodeRemark() {
		return codeRemark;
	}
	/** 
	 * @param codeRemark the codeRemark to set 
	 */
	public void setCodeRemark(String codeRemark) {
		this.codeRemark = codeRemark;
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
	/** 
	 * @return the upComCode 
	 */
	
	public String getUpComCode() {
		return upComCode;
	}
	/** 
	 * @param upComCode the upComCode to set 
	 */
	public void setUpComCode(String upComCode) {
		this.upComCode = upComCode;
	}
	/** 
	 * @return the sComCode 
	 */
	
	public String getsComCode() {
		return sComCode;
	}
	/** 
	 * @param sComCode the sComCode to set 
	 */
	public void setsComCode(String sComCode) {
		this.sComCode = sComCode;
	}
	
}
