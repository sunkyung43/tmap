package com.tmap.dataservicemanagement.vo;

import com.tmap.common.PaginationVO;

public class FileServiceInfoVO extends PaginationVO {

	private String rownum;
	private String keywordTp;
	private String fileVerId;
	private String dataFileId;
	private String dataTypeId;
	private String dataTypeName;
	private String dataFileName;
	private String dataFileContent;
	private String dataFileStore;
	private String storageName;
	private String fileServId;
	private String fileServState;
	private String fileServSdate;
	private String etc;
	private String searchDataFileName;
	private String searchFileVerName;
	private String[] dataFileIds;

	/**
	 * @return the dataFileContent
	 */

	public String getDataFileContent() {
		return dataFileContent;
	}

	/**
	 * @param dataFileContent
	 *            the dataFileContent to set
	 */
	public void setDataFileContent(String dataFileContent) {
		this.dataFileContent = dataFileContent;
	}

	/**
	 * @return the dataFileStore
	 */

	public String getDataFileStore() {
		return dataFileStore;
	}

	/**
	 * @param dataFileStore
	 *            the dataFileStore to set
	 */
	public void setDataFileStore(String dataFileStore) {
		this.dataFileStore = dataFileStore;
	}

	/**
	 * @return the dataFileIds
	 */

	public String[] getDataFileIds() {
		return dataFileIds;
	}

	/**
	 * @param dataFileIds
	 *            the dataFileIds to set
	 */
	public void setDataFileIds(String[] dataFileIds) {
		this.dataFileIds = dataFileIds;
	}

	/**
	 * @return the searchFileVerName
	 */

	public String getSearchFileVerName() {
		return searchFileVerName;
	}

	/**
	 * @param searchFileVerName
	 *            the searchFileVerName to set
	 */
	public void setSearchFileVerName(String searchFileVerName) {
		this.searchFileVerName = searchFileVerName;
	}

	/**
	 * @return the searchDataFileName
	 */

	public String getSearchDataFileName() {
		return searchDataFileName;
	}

	/**
	 * @param searchDataFileName
	 *            the searchDataFileName to set
	 */
	public void setSearchDataFileName(String searchDataFileName) {
		this.searchDataFileName = searchDataFileName;
	}

	/**
	 * @return the fileVerId
	 */

	public String getFileVerId() {
		return fileVerId;
	}

	/**
	 * @param fileVerId
	 *            the fileVerId to set
	 */
	public void setFileVerId(String fileVerId) {
		if (fileVerId != "") {
			this.fileVerId = String.valueOf(Integer.parseInt(fileVerId));
		}
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
	 * @return the dataTypeName
	 */

	public String getDataTypeName() {
		return dataTypeName;
	}

	/**
	 * @param dataTypeName
	 *            the dataTypeName to set
	 */
	public void setDataTypeName(String dataTypeName) {
		this.dataTypeName = dataTypeName;
	}

	/**
	 * @return the dataTypeId
	 */

	public String getDataTypeId() {
		return dataTypeId;
	}

	/**
	 * @param dataTypeId
	 *            the dataTypeId to set
	 */
	public void setDataTypeId(String dataTypeId) {
		this.dataTypeId = dataTypeId;
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
	 * @return the dataFileName
	 */

	public String getDataFileName() {
		return dataFileName;
	}

	/**
	 * @param dataFileName
	 *            the dataFileName to set
	 */
	public void setDataFileName(String dataFileName) {
		this.dataFileName = dataFileName;
	}

	/**
	 * @return the storageName
	 */

	public String getStorageName() {
		return storageName;
	}

	/**
	 * @param storageName
	 *            the storageName to set
	 */
	public void setStorageName(String storageName) {
		this.storageName = storageName;
	}

	/**
	 * @return the fileServId
	 */

	public String getFileServId() {
		return fileServId;
	}

	/**
	 * @param fileServId
	 *            the fileServId to set
	 */
	public void setFileServId(String fileServId) {
		this.fileServId = fileServId;
	}

	/**
	 * @return the fileServState
	 */

	public String getFileServState() {
		return fileServState;
	}

	/**
	 * @param fileServState
	 *            the fileServState to set
	 */
	public void setFileServState(String fileServState) {
		this.fileServState = fileServState;
	}

	/**
	 * @return the fileServSdate
	 */

	public String getFileServSdate() {
		return fileServSdate;
	}

	/**
	 * @param fileServSdate
	 *            the fileServSdate to set
	 */
	public void setFileServSdate(String fileServSdate) {
		this.fileServSdate = fileServSdate;
	}

	/**
	 * @return the etc
	 */

	public String getEtc() {
		return etc;
	}

	/**
	 * @param etc
	 *            the etc to set
	 */
	public void setEtc(String etc) {
		this.etc = etc;
	}

}