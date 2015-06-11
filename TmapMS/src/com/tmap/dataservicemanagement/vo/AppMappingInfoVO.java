package com.tmap.dataservicemanagement.vo;

import com.tmap.common.PaginationVO;

public class AppMappingInfoVO extends PaginationVO {

	private long rowSpan;
	private String rownum;
	private String keywordTp;
	private String appMappingId;
	private String appMappingName;
	private String appMappingContent;
	private String appMappingState;
	private String appMappingSdate;
	private String appName;
	private String searchAppName;
	private String searchDataFileName;
	private String searchFileVerName;
	private String appInfoSeq;
	private String dataTypeId;
	private String dataFileId;
	private String dataTypeName;
	private String fileVerId;
	private String dataFileName;
	private String fileVerName;
	private String mapDetailId;
	private String[] dataFileIds;
	// 매핑DetailId관련
	private String appMapDetailId;
	private String appMapDetailState;
	private String appMapDetailSdate;
	private String appMapServiceId;

	// 매핑서비스 정보 관련
	private String appServiceType = "W";
	private String appServiceName = "";
	private String appServiceDistribute = "W";
	private String appServiceState = "W";
	private String appServiceId;
	private String appVerId;
	private String appVerName;
	private String appVerContent;
	private String appVerSdate;
	
	//CDN관련
	private String cdnPromoId;
	private String url;
	
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getCdnPromoId() {
		return cdnPromoId;
	}

	public void setCdnPromoId(String cdnPromoId) {
		this.cdnPromoId = cdnPromoId;
	}

	public String getAppVerContent() {
		return appVerContent;
	}

	public void setAppVerContent(String appVerContent) {
		this.appVerContent = appVerContent;
	}
	
	public String getAppVerSdate() {
		return appVerSdate;
	}

	public void setAppVerSdate(String appVerSdate) {
		this.appVerSdate = appVerSdate;
	}

	public String getAppVerState() {
		return appVerState;
	}

	public void setAppVerState(String appVerState) {
		this.appVerState = appVerState;
	}

	private String appVerState;
	
	// 버전 상세정보 관련
	private String file_name;
	private String file_size;
	private String file_state;
	private String file_sdate;
	private String file_update;

	/**
	 * @return the appServiceState
	 */

	public String getAppServiceState() {
		return appServiceState;
	}

	/**
	 * @param appServiceState
	 *            the appServiceState to set
	 */
	public void setAppServiceState(String appServiceState) {
		this.appServiceState = appServiceState;
	}

	/**
	 * @return the appServiceType
	 */

	public String getAppServiceType() {
		return appServiceType;
	}

	/**
	 * @param appServiceType
	 *            the appServiceType to set
	 */
	public void setAppServiceType(String appServiceType) {
		this.appServiceType = appServiceType;
	}

	/**
	 * @return the appServiceDistribute
	 */

	public String getAppServiceDistribute() {
		return appServiceDistribute;
	}

	/**
	 * @param appServiceDistribute
	 *            the appServiceDistribute to set
	 */
	public void setAppServiceDistribute(String appServiceDistribute) {
		this.appServiceDistribute = appServiceDistribute;
	}

	/**
	 * @return the rowSpan
	 */

	public long getRowSpan() {
		return rowSpan;
	}

	/**
	 * @param rowSpan
	 *            the rowSpan to set
	 */
	public void setRowSpan(long rowSpan) {
		this.rowSpan = rowSpan;
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
	 * @return the file_update
	 */

	public String getFile_update() {
		return file_update;
	}

	/**
	 * @param file_update
	 *            the file_update to set
	 */
	public void setFile_update(String file_update) {
		this.file_update = file_update;
	}

	/**
	 * @return the mapDetailId
	 */

	public String getMapDetailId() {
		return mapDetailId;
	}

	/**
	 * @param mapDetailId
	 *            the mapDetailId to set
	 */
	public void setMapDetailId(String mapDetailId) {
		this.mapDetailId = mapDetailId;
	}

	/**
	 * @return the file_name
	 */

	public String getFile_name() {
		return file_name;
	}

	/**
	 * @param file_name
	 *            the file_name to set
	 */
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	/**
	 * @return the file_size
	 */

	public String getFile_size() {
		return file_size;
	}

	/**
	 * @param file_size
	 *            the file_size to set
	 */
	public void setFile_size(String file_size) {
		this.file_size = file_size;
	}

	/**
	 * @return the file_state
	 */

	public String getFile_state() {
		return file_state;
	}

	/**
	 * @param file_state
	 *            the file_state to set
	 */
	public void setFile_state(String file_state) {
		this.file_state = file_state;
	}

	/**
	 * @return the file_sdate
	 */

	public String getFile_sdate() {
		return file_sdate;
	}

	/**
	 * @param file_sdate
	 *            the file_sdate to set
	 */
	public void setFile_sdate(String file_sdate) {
		this.file_sdate = file_sdate;
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
		this.fileVerId = String.valueOf(Integer.parseInt(fileVerId));
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
	 * @return the fileVerName
	 */

	public String getFileVerName() {
		return fileVerName;
	}

	/**
	 * @param fileVerName
	 *            the fileVerName to set
	 */
	public void setFileVerName(String fileVerName) {
		this.fileVerName = fileVerName;
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
	 * @return the searchAppName
	 */

	public String getSearchAppName() {
		return searchAppName;
	}

	/**
	 * @param searchAppName
	 *            the searchAppName to set
	 */
	public void setSearchAppName(String searchAppName) {
		this.searchAppName = searchAppName;
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

	public String getAppMapDetailId() {
		return appMapDetailId;
	}

	public void setAppMapDetailId(String appMapDetailId) {
		this.appMapDetailId = appMapDetailId;
	}

	/**
	 * @return the appMappingId
	 */

	public String getAppMappingId() {
		return appMappingId;
	}

	/**
	 * @param appMappingId
	 *            the appMappingId to set
	 */
	public void setAppMappingId(String appMappingId) {
		this.appMappingId = appMappingId;
	}

	/**
	 * @return the appMappingName
	 */

	public String getAppMappingName() {
		return appMappingName;
	}

	/**
	 * @param appMappingName
	 *            the appMappingName to set
	 */
	public void setAppMappingName(String appMappingName) {
		this.appMappingName = appMappingName;
	}

	/**
	 * @return the appMappingContent
	 */

	public String getAppMappingContent() {
		return appMappingContent;
	}

	/**
	 * @param appMappingContent
	 *            the appMappingContent to set
	 */
	public void setAppMappingContent(String appMappingContent) {
		this.appMappingContent = appMappingContent;
	}

	/**
	 * @return the appMappingState
	 */

	public String getAppMappingState() {
		return appMappingState;
	}

	/**
	 * @param appMappingState
	 *            the appMappingState to set
	 */
	public void setAppMappingState(String appMappingState) {
		this.appMappingState = appMappingState;
	}

	/**
	 * @return the appMappingSdate
	 */

	public String getAppMappingSdate() {
		return appMappingSdate;
	}

	/**
	 * @param appMappingSdate
	 *            the appMappingSdate to set
	 */
	public void setAppMappingSdate(String appMappingSdate) {
		this.appMappingSdate = appMappingSdate;
	}

	public String getAppServiceId() {
		return appServiceId;
	}

	public void setAppServiceId(String appServiceId) {
		this.appServiceId = appServiceId;
	}

	public String getAppVerId() {
		return appVerId;
	}

	public void setAppVerId(String appVerId) {
		this.appVerId = appVerId;
	}

	public String getAppServiceName() {
		return appServiceName;
	}

	public void setAppServiceName(String appServiceName) {
		this.appServiceName = appServiceName;
	}

	public String getAppVerName() {
		return appVerName;
	}

	public void setAppVerName(String appVerName) {
		this.appVerName = appVerName;
	}

	public String getAppMapDetailState() {
		return appMapDetailState;
	}

	public void setAppMapDetailState(String appMapDetailState) {
		this.appMapDetailState = appMapDetailState;
	}

	public String getAppMapDetailSdate() {
		return appMapDetailSdate;
	}

	public void setAppMapDetailSdate(String appMapDetailSdate) {
		this.appMapDetailSdate = appMapDetailSdate;
	}

	public String getAppMapServiceId() {
		return appMapServiceId;
	}

	public void setAppMapServiceId(String appMapServiceId) {
		this.appMapServiceId = appMapServiceId;
	}

}