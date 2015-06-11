package com.tmap.servermanagement.vo;

import com.tmap.common.PaginationVO;

public class ComCodeInfoVO extends PaginationVO{
  private String rownum;
  private String keywordTp;
  private String codeId;
  private String code;
  private String codeUpcode;
  private String codeLevel;
  private String codeName;
  private String codeContent;
  private String codeState;
  private String codeSdate;
  
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
  public String getCodeId() {
    return codeId;
  }
  public void setCodeId(String codeId) {
    this.codeId = codeId;
  }
  public String getCode() {
    return code;
  }
  public void setCode(String code) {
    this.code = code;
  }
  public String getCodeUpcode() {
    return codeUpcode;
  }
  public void setCodeUpcode(String codeUpcode) {
    this.codeUpcode = codeUpcode;
  }
  public String getCodeLevel() {
    return codeLevel;
  }
  public void setCodeLevel(String codeLevel) {
    this.codeLevel = codeLevel;
  }
  public String getCodeName() {
    return codeName;
  }
  public void setCodeName(String codeName) {
    this.codeName = codeName;
  }
  public String getCodeContent() {
    return codeContent;
  }
  public void setCodeContent(String codeContent) {
    this.codeContent = codeContent;
  }
  public String getCodeState() {
    return codeState;
  }
  public void setCodeState(String codeState) {
    this.codeState = codeState;
  }
  public String getCodeSdate() {
    return codeSdate;
  }
  public void setCodeSdate(String codeSdate) {
    this.codeSdate = codeSdate;
  }
}
