package com.tmap.datafilemanagement.vo;

import com.tmap.common.PaginationVO;

public class DataStorageInfoVO extends PaginationVO {
	private String searchDataStorageName;
	private String searchDataStorageState;
	private String searchDataStorageCurrent;
	
	private String rownum;
	private String storageId;
	private String storageName;
	private String storageContent;
	private String storageMount;
	private String storageState;
	private String storageSdate;
	private String storageCurrent;
	private String useCount;
	private int newStorageId;

	public String getSearchDataStorageName() {
		return searchDataStorageName;
	}

	public void setSearchDataStorageName(String searchDataStorageName) {
		this.searchDataStorageName = searchDataStorageName;
	}

	public String getSearchDataStorageState() {
		return searchDataStorageState;
	}

	public void setSearchDataStorageState(String searchDataStorageState) {
		this.searchDataStorageState = searchDataStorageState;
	}

	public String getSearchDataStorageCurrent() {
		return searchDataStorageCurrent;
	}

	public void setSearchDataStorageCurrent(String searchDataStorageCurrent) {
		this.searchDataStorageCurrent = searchDataStorageCurrent;
	}

	public String getRownum() {
		return rownum;
	}

	public void setRownum(String rownum) {
		this.rownum = rownum;
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

	public String getStorageContent() {
		return storageContent;
	}

	public void setStorageContent(String storageContent) {
		this.storageContent = storageContent;
	}

	public String getStorageMount() {
		return storageMount;
	}

	public void setStorageMount(String storageMount) {
		this.storageMount = storageMount;
	}

	public String getStorageState() {
		return storageState;
	}

	public void setStorageState(String storageState) {
		this.storageState = storageState;
	}

	public String getStorageSdate() {
		return storageSdate;
	}

	public void setStorageSdate(String storageSdate) {
		this.storageSdate = storageSdate;
	}

	public String getStorageCurrent() {
		return storageCurrent;
	}

	public void setStorageCurrent(String storageCurrent) {
		this.storageCurrent = storageCurrent;
	}

	public String getUseCount() {
		return useCount;
	}

	public void setUseCount(String useCount) {
		this.useCount = useCount;
	}

	public int getNewStorageId() {
		return newStorageId;
	}

	public void setNewStorageId(int newStorageId) {
		this.newStorageId = newStorageId;
	}
}