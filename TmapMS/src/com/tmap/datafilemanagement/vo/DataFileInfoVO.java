package com.tmap.datafilemanagement.vo;

import java.util.List;

import com.tmap.common.PaginationVO;

public class DataFileInfoVO extends PaginationVO {
	private String searchDataFileName;
	private String searchDataFileState;
	private String searchDataType;
	
	private String rownum;
	private String dataFileId;
	private String dataFileName;
	private String dataFileContent;
	private String dataFileStore;
	private String dataFileState;
	private String dataFileSdate;
	private String dataTypeId;
	private String dataTypeName;
	private String storageId;
	private String storageName;
	private String storageMount;
	private String useVersionCount;
	private String totalUseVersionCount;
	private List<DataTypeInfoVO> dataTypeInfoList;
	private List<DataStorageInfoVO> dataStorageInfoList;
	
	public String getSearchDataFileName() {
		return searchDataFileName;
	}

	public void setSearchDataFileName(String searchDataFileName) {
		this.searchDataFileName = searchDataFileName;
	}

	public String getSearchDataFileState() {
		return searchDataFileState;
	}

	public void setSearchDataFileState(String searchDataFileState) {
		this.searchDataFileState = searchDataFileState;
	}

	public String getSearchDataType() {
		return searchDataType;
	}

	public void setSearchDataType(String searchDataType) {
		this.searchDataType = searchDataType;
	}

	public String getRownum() {
		return rownum;
	}

	public void setRownum(String rownum) {
		this.rownum = rownum;
	}

	public String getDataFileId() {
		return dataFileId;
	}

	public void setDataFileId(String dataFileId) {
		this.dataFileId = dataFileId;
	}

	public String getDataFileName() {
		return dataFileName;
	}

	public void setDataFileName(String dataFileName) {
		this.dataFileName = dataFileName;
	}

	public String getDataFileContent() {
		return dataFileContent;
	}

	public void setDataFileContent(String dataFileContent) {
		this.dataFileContent = dataFileContent;
	}

	public String getDataFileStore() {
		return dataFileStore;
	}

	public void setDataFileStore(String dataFileStore) {
		this.dataFileStore = dataFileStore;
	}

	public String getDataFileState() {
		return dataFileState;
	}

	public void setDataFileState(String dataFileState) {
		this.dataFileState = dataFileState;
	}

	public String getDataFileSdate() {
		return dataFileSdate;
	}

	public void setDataFileSdate(String dataFileSdate) {
		this.dataFileSdate = dataFileSdate;
	}

	public String getDataTypeId() {
		return dataTypeId;
	}

	public void setDataTypeId(String dataTypeId) {
		this.dataTypeId = dataTypeId;
	}

	public String getDataTypeName() {
		return dataTypeName;
	}

	public void setDataTypeName(String dataTypeName) {
		this.dataTypeName = dataTypeName;
	}

	public String getStorageId() {
		return storageId;
	}

	public void setStorageId(String storageId) {
		this.storageId = storageId;
	}

	public String getStorageName() {
		return storageName;
	}

	public void setStorageName(String storageName) {
		this.storageName = storageName;
	}

	public String getStorageMount() {
		return storageMount;
	}

	public void setStorageMount(String storageMount) {
		this.storageMount = storageMount;
	}

	public String getUseVersionCount() {
		return useVersionCount;
	}

	public void setUseVersionCount(String useVersionCount) {
		this.useVersionCount = useVersionCount;
	}

	public String getTotalUseVersionCount() {
		return totalUseVersionCount;
	}

	public void setTotalUseVersionCount(String totalUseVersionCount) {
		this.totalUseVersionCount = totalUseVersionCount;
	}

	public List<DataTypeInfoVO> getDataTypeInfoList() {
		return dataTypeInfoList;
	}

	public void setDataTypeInfoList(List<DataTypeInfoVO> dataTypeInfoList) {
		this.dataTypeInfoList = dataTypeInfoList;
	}

	public List<DataStorageInfoVO> getDataStorageInfoList() {
		return dataStorageInfoList;
	}
	public void setDataStorageInfoList(List<DataStorageInfoVO> dataStorageInfoList) {
		this.dataStorageInfoList = dataStorageInfoList;
	}
}