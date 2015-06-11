package com.tmap.servermanagement.vo;

import com.tmap.common.PaginationVO;

public class DownloadInfoVO extends PaginationVO {

	private String rownum;
	private String keywordTp;
	private String serverId;
	private String serverUrl;
	private String serverContent;
	private String serverState;
	private String serverSdate;
	private String serverType;
	private String serverPort;
	
	public String getRownum() {
		return rownum;
	}

	public void setRownum(String rownum) {
		this.rownum = rownum;
	}

	public String getKeywordTp() {
		return keywordTp;
	}

	public void setKeywordTp(String keywordTp) {
		this.keywordTp = keywordTp;
	}

	public String getServerId() {
		return serverId;
	}

	public void setServerId(String serverId) {
		this.serverId = serverId;
	}

	public String getServerContent() {
		return serverContent;
	}
	
	public String getServerUrl() {
		return serverUrl;
	}

	public void setServerUrl(String serverUrl) {
		this.serverUrl = serverUrl;
	}

	public void setServerContent(String serverContent) {
		this.serverContent = serverContent;
	}

	public String getServerState() {
		return serverState;
	}

	public void setServerState(String serverState) {
		this.serverState = serverState;
	}

	public String getServerSdate() {
		return serverSdate;
	}

	public void setServerSdate(String serverSdate) {
		this.serverSdate = serverSdate;
	}

	public String getServerType() {
		return serverType;
	}

	public void setServerType(String serverType) {
		this.serverType = serverType;
	}

	public String getServerPort() {
		return serverPort;
	}

	public void setServerPort(String serverPort) {
		this.serverPort = serverPort;
	}

}
