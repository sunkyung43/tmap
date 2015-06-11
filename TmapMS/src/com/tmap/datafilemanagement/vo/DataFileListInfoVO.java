package com.tmap.datafilemanagement.vo;

import org.springframework.web.multipart.MultipartFile;

public class DataFileListInfoVO {
	private String fileListId;
	private String fileName;
	private String[] fileNames;
	private String fileSize;
	private String fileMd5;
	private String fileUpdate;
	private String fileState;
	private String fileSdate;
	private String fileVerId;
	private String fileVerName;
	private String dataFileId;
	private String dataFileName;
	private String[] fileListIds;
	private MultipartFile uploadFileObj;
	
	public String getFileListId() {
		return fileListId;
	}

	public void setFileListId(String fileListId) {
		this.fileListId = fileListId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getFileMd5() {
		return fileMd5;
	}

	public void setFileMd5(String fileMd5) {
		this.fileMd5 = fileMd5;
	}

	public String getFileUpdate() {
		return fileUpdate;
	}

	public void setFileUpdate(String fileUpdate) {
		this.fileUpdate = fileUpdate;
	}

	public String getFileState() {
		return fileState;
	}

	public void setFileState(String fileState) {
		this.fileState = fileState;
	}

	public String getFileSdate() {
		return fileSdate;
	}

	public void setFileSdate(String fileSdate) {
		this.fileSdate = fileSdate;
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

	public String[] getFileListIds() {
		return fileListIds;
	}

	public void setFileListIds(String[] fileListIds) {
		this.fileListIds = fileListIds;
	}

	public MultipartFile getUploadFileObj() {
		return uploadFileObj;
	}

	public void setUploadFileObj(MultipartFile uploadFileObj) {
		this.uploadFileObj = uploadFileObj;
	}

	public void setFileSize(long size) {
		fileSize = String.valueOf(size);
	}

  public String[] getFileNames() {
    return fileNames;
  }

  public void setFileNames(String[] fileNames) {
    this.fileNames = fileNames;
  }
}
