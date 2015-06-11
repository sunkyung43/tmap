package com.tmap.datafilemanagement.vo;

import com.tmap.common.PaginationVO;

public class DataTypeInfoVO extends PaginationVO {
	private String searchDataTypeName;
	private String searchDataTypeState;
	
	private String rowSpan;
	private String rownum;
	private String dataTypeId;
	private String dataTypeName;
	private String dataTypeContent;
	private String dataTypeState;
	private String dataTypeSdate;
	private String etc;
	private String useCount;
	private int newDataTypeId;
	
	public String getSearchDataTypeName() {
		return searchDataTypeName;
	}

	public void setSearchDataTypeName(String searchDataTypeName) {
		this.searchDataTypeName = searchDataTypeName;
	}

	public String getSearchDataTypeState() {
		return searchDataTypeState;
	}

	public void setSearchDataTypeState(String searchDataTypeState) {
		this.searchDataTypeState = searchDataTypeState;
	}
	
	public String getRowSpan() {
		return rowSpan;
	}

	public void setRowSpan(String rowSpan) {
		this.rowSpan = rowSpan;
	}

	public String getRownum() {
		return rownum;
	}

	public void setRownum(String rownum) {
		this.rownum = rownum;
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

	public String getDataTypeContent() {
		return dataTypeContent;
	}

	public void setDataTypeContent(String dataTypeContent) {
		this.dataTypeContent = dataTypeContent;
	}

	public String getDataTypeState() {
		return dataTypeState;
	}

	public void setDataTypeState(String dataTypeState) {
		this.dataTypeState = dataTypeState;
	}

	public String getDataTypeSdate() {
		return dataTypeSdate;
	}

	public void setDataTypeSdate(String dataTypeSdate) {
		this.dataTypeSdate = dataTypeSdate;
	}

	public String getEtc() {
		return etc;
	}

	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getUseCount() {
		return useCount;
	}

	public void setUseCount(String useCount) {
		this.useCount = useCount;
	}

	public int getNewDataTypeId() {
		return newDataTypeId;
	}

	public void setNewDataTypeId(int newDataTypeId) {
		this.newDataTypeId = newDataTypeId;
	}
}