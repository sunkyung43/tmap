
package com.tmap.datafilemanagement.vo;

import com.tmap.common.PaginationVO;

public class FileVersionInfoVO extends PaginationVO {
	private String fileVerId;
	private String fileVerName;
	private String fileVerRank;
	private String fileVerState;
	private String fileVerSdate;
	private String etc;
	private String dataFileId;
	private String color;
	private String state;
	
	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getFileVerId() {
		return fileVerId;
	}

	public void setFileVerId(String fileVerId) {
		this.fileVerId = fileVerId;
	}
	
	public String getFileVerName() {
		return fileVerName;
	}
	
	public void setFileVerName(String fileVerName) {
		this.fileVerName = fileVerName;
	}
	
	public String getFileVerRank() {
		return fileVerRank;
	}
	
	public void setFileVerRank(String fileVerRank) {
		this.fileVerRank = fileVerRank;
	}
	
	public String getFileVerState() {
		return fileVerState;
	}
	
	public void setFileVerState(String fileVerState) {
		this.fileVerState = fileVerState;
	}
	
	public String getFileVerSdate() {
		return fileVerSdate;
	}
	
	public void setFileVerSdate(String fileVerSdate) {
		this.fileVerSdate = fileVerSdate;
	}
	
	public String getEtc() {
		return etc;
	}
	
	public void setEtc(String etc) {
		this.etc = etc;
	}

	public String getDataFileId() {
		return dataFileId;
	}

	public void setDataFileId(String dataFileId) {
		this.dataFileId = dataFileId;
	}
}
