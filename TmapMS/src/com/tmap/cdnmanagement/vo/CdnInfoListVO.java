package com.tmap.cdnmanagement.vo;

import com.tmap.common.PaginationVO;

public class CdnInfoListVO extends PaginationVO {
	private long rowSpan;

	// cdn_promotion
	private String rownum;
	
	public String getRownum() {
		return rownum;
	}

	public void setRownum(String rownum) {
		this.rownum = rownum;
	}

	private String cdnPromoId;
	private String cdnPromoSdate;
	private String cdnPromoEdate;
	private String cdnPromoState;
	private String cdnPromoContent;
	private String startdt;
	private String enddt;
	private String cdnStartHour;
	
	public String getCdnStartHour() {
		return cdnStartHour;
	}

	public void setCdnStartHour(String cdnStartHour) {
		this.cdnStartHour = cdnStartHour;
	}

	public String getCdnEndHour() {
		return cdnEndHour;
	}

	public void setCdnEndHour(String cdnEndHour) {
		this.cdnEndHour = cdnEndHour;
	}

	private String cdnEndHour;

	// cdn_promotion_detail
	private String cdnPromoDetailId;
	private String cdnServiceType; // CDN 서비스 타입 구분 'D' 데이터 버전 'A' App 버전
	private String cdnServiceSdate;
	private String cdnServiceId; // 데이터 및 App 버전 아이디
	private String cdnDataSycnState; // 대상 데이터에 대한 CDN 서버 동기화 상태 'Y' 동기 'N' 비동기

	
	//file_ver_info
	private String fileVerId;
	private String fileVerName;
	private String fileVerRank;
	private String fileVerState;
	private String dataFileName;
	
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

	public String getDataFileName() {
		return dataFileName;
	}

	public void setDataFileName(String dataFileName) {
		this.dataFileName = dataFileName;
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

	private String fileVerSdate;
	private String etc;
	
	public String getFileVerId() {
		return fileVerId;
	}

	public void setFileVerId(String fileVerId) {
		this.fileVerId = fileVerId;
	}

	private String keywordTp;

	public long getRowSpan() {
		return rowSpan;
	}

	public void setRowSpan(long rowSpan) {
		this.rowSpan = rowSpan;
	}

	public String getCdnPromoId() {
		return cdnPromoId;
	}

	public void setCdnPromoId(String cdnPromoId) {
		this.cdnPromoId = cdnPromoId;
	}

	public String getCdnPromoSdate() {
		return cdnPromoSdate;
	}

	public void setCdnPromoSdate(String cdnPromoSdate) {
		//this.setHour(cdnPromoSdate.substring(11, 13));
		this.cdnPromoSdate = cdnPromoSdate;
	}

	public String getCdnPromoEdate() {
		return cdnPromoEdate;
	}

	public void setCdnPromoEdate(String cdnPromoEdate) {
		this.cdnPromoEdate = cdnPromoEdate;
	}

	public String getCdnPromoState() {
		return cdnPromoState;
	}

	public void setCdnPromoState(String cdnPromoState) {
		this.cdnPromoState = cdnPromoState;
	}

	public String getCdnPromoContent() {
		return cdnPromoContent;
	}

	public void setCdnPromoContent(String cdnPromoContent) {
		this.cdnPromoContent = cdnPromoContent;
	}
	
	public String getStartdt() {
		return startdt;
	}

	public void setStartdt(String startdt) {
		this.startdt = startdt;
	}
	
	public String getEnddt() {
		return enddt;
	}

	public void setEnddt(String enddt) {
		this.enddt = enddt;
	}
	/*
	public String getHour() {
		return hour;
	}

	public void setHour(String hour) {
		this.hour = hour;
	}*/
	
	//Detail
	public String getCdnPromoDetailId() {
		return cdnPromoDetailId;
	}

	public void setCdnPromoDetailId(String cdnPromoDetailId) {
		this.cdnPromoDetailId = cdnPromoDetailId;
	}

	public String getCdnServiceType() {
		return cdnServiceType;
	}

	public void setCdnServiceType(String cdnServiceType) {
		this.cdnServiceType = cdnServiceType;
	}

	public String getCdnServiceSdate() {
		return cdnServiceSdate;
	}

	public void setCdnServiceSdate(String cdnServiceSdate) {
		this.cdnServiceSdate = cdnServiceSdate;
	}

	public String getCdnServiceId() {
		return cdnServiceId;
	}

	public void setCdnServiceId(String cdnServiceId) {
		this.cdnServiceId = cdnServiceId;
	}

	public String getCdnDataSycnState() {
		return cdnDataSycnState;
	}

	public void setCdnDataSycnState(String cdnDataSycnState) {
		this.cdnDataSycnState = cdnDataSycnState;
	}

	public String getKeywordTp() {
		return keywordTp;
	}

	public void setKeywordTp(String keywordTp) {
		this.keywordTp = keywordTp;
	}

}
