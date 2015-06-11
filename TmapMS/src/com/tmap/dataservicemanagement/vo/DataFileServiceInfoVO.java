/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.dataservicemanagement.vo;

import com.tmap.common.PaginationVO;

public class DataFileServiceInfoVO extends PaginationVO{

	private String rownum;
	private String keywordTp;
	private String dataFileServiceId;
	private String fileServiceState;
	private String fileServiceDistribute;
	private String fileServiceType;
	private String fileServiceSdate;
	private String fileServiceName;
	private String fileServId;
	private String dataTypeId;
	private String dataFileId;
	private String dataTypeName;
	private String dataFileName;
	private String fileVerId;
	private String checkServiceName;
	private String url;
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	/** 
	 * @return the checkServiceName 
	 */
	
	public String getCheckServiceName() {
		return checkServiceName;
	}
	/** 
	 * @param checkServiceName the checkServiceName to set 
	 */
	public void setCheckServiceName(String checkServiceName) {
		this.checkServiceName = checkServiceName;
	}
	/** 
	 * @return the fileServiceName 
	 */
	
	public String getFileServiceName() {
		return fileServiceName;
	}
	/** 
	 * @param fileServiceName the fileServiceName to set 
	 */
	public void setFileServiceName(String fileServiceName) {
		this.fileServiceName = fileServiceName;
	}
	/** 
	 * @return the fileVerId 
	 */
	
	public String getFileVerId() {
		return fileVerId;
	}
	/** 
	 * @param fileVerId the fileVerId to set 
	 */
	public void setFileVerId(String fileVerId) {
		this.fileVerId = String.valueOf(Integer.parseInt(fileVerId));
	}
	/** 
	 * @return the dataFileId 
	 */
	
	public String getDataFileId() {
		return dataFileId;
	}
	/** 
	 * @param dataFileId the dataFileId to set 
	 */
	public void setDataFileId(String dataFileId) {
		this.dataFileId = dataFileId;
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
	 * @return the dataFileServiceId 
	 */
	
	public String getDataFileServiceId() {
		return dataFileServiceId;
	}
	/** 
	 * @param dataFileServiceId the dataFileServiceId to set 
	 */
	public void setDataFileServiceId(String dataFileServiceId) {
		this.dataFileServiceId = dataFileServiceId;
	}
	/** 
	 * @return the fileServiceState 
	 */
	
	public String getFileServiceState() {
		return fileServiceState;
	}
	/** 
	 * @param fileServiceState the fileServiceState to set 
	 */
	public void setFileServiceState(String fileServiceState) {
		this.fileServiceState = fileServiceState;
	}
	/** 
	 * @return the fileServiceDistribute 
	 */
	
	public String getFileServiceDistribute() {
		return fileServiceDistribute;
	}
	/** 
	 * @param fileServiceDistribute the fileServiceDistribute to set 
	 */
	public void setFileServiceDistribute(String fileServiceDistribute) {
		this.fileServiceDistribute = fileServiceDistribute;
	}
	/** 
	 * @return the fileServiceType 
	 */
	
	public String getFileServiceType() {
		return fileServiceType;
	}
	/** 
	 * @param fileServiceType the fileServiceType to set 
	 */
	public void setFileServiceType(String fileServiceType) {
		this.fileServiceType = fileServiceType;
	}
	/** 
	 * @return the fileServiceSdate 
	 */
	
	public String getFileServiceSdate() {
		return fileServiceSdate;
	}
	/** 
	 * @param fileServiceSdate the fileServiceSdate to set 
	 */
	public void setFileServiceSdate(String fileServiceSdate) {
		this.fileServiceSdate = fileServiceSdate;
	}
	/** 
	 * @return the fileServId 
	 */
	
	public String getFileServId() {
		return fileServId;
	}
	/** 
	 * @param fileServId the fileServId to set 
	 */
	public void setFileServId(String fileServId) {
		this.fileServId = fileServId;
	}
	/** 
	 * @return the dataTypeId 
	 */
	
	public String getDataTypeId() {
		return dataTypeId;
	}
	/** 
	 * @param dataTypeId the dataTypeId to set 
	 */
	public void setDataTypeId(String dataTypeId) {
		this.dataTypeId = dataTypeId;
	}
	/** 
	 * @return the dataTypeName 
	 */
	
	public String getDataTypeName() {
		return dataTypeName;
	}
	/** 
	 * @param dataTypeName the dataTypeName to set 
	 */
	public void setDataTypeName(String dataTypeName) {
		this.dataTypeName = dataTypeName;
	}
	/** 
	 * @return the dataFileName 
	 */
	
	public String getDataFileName() {
		return dataFileName;
	}
	/** 
	 * @param dataFileName the dataFileName to set 
	 */
	public void setDataFileName(String dataFileName) {
		this.dataFileName = dataFileName;
	}
		
}
