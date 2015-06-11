package com.tmap.common;

import java.util.ArrayList;
import java.util.List;


public class RemoveCacheInfo {
  private List<ConnectInfo> connectInfoList;
  private List<ConnectInfo> successList;
  private List<ConnectInfo> failList;
  private CacheType cacheType;
  
  public RemoveCacheInfo() {}
  
  public RemoveCacheInfo(List<ConnectInfo> connectInfoList, CacheType cacheType) {
    this.connectInfoList = connectInfoList;
    this.cacheType = cacheType;
    calculationResultList(connectInfoList);
  }
  
  private void calculationResultList(List<ConnectInfo> connectInfoList) {
    List<ConnectInfo> successList = new ArrayList<ConnectInfo>();
    List<ConnectInfo> failList = new ArrayList<ConnectInfo>();
    
    for (ConnectInfo connectInfo : connectInfoList) {
      if (connectInfo.isResultState()) {
        successList.add(connectInfo);
      } else {
        failList.add(connectInfo);
      }
    }
    
    setSuccessList(successList);
    setFailList(failList);
  }

  public List<ConnectInfo> getConnectInfoList() {
    return connectInfoList;
  }

  public List<ConnectInfo> getSuccessList() {
    return successList;
  }

  private void setSuccessList(List<ConnectInfo> successList) {
    this.successList = successList;
  }

  public List<ConnectInfo> getFailList() {
    return failList;
  }

  private void setFailList(List<ConnectInfo> failList) {
    this.failList = failList;
  }
  
  public CacheType getCacheType() {
    return cacheType;
  }

  public void setCacheType(CacheType cacheType) {
    this.cacheType = cacheType;
  }
  
  public boolean isSuccess() {
    return this.failList.isEmpty();
  }

}

