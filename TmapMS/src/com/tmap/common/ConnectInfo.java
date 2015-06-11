package com.tmap.common;

public class ConnectInfo {
  private String address;
  private String port;
  private boolean resultState;
  
  public ConnectInfo() {}
  
  public ConnectInfo(String address, String port) {
    this.address = address;
    this.port = port;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public String getPort() {
    return port;
  }

  public void setPort(String port) {
    this.port = port;
  }

  @Override
  public String toString() {
    StringBuffer sb = new StringBuffer();
    if (!this.address.isEmpty()) {
      sb.append(this.address);
      if (!getPort().isEmpty()) sb.append(":").append(this.port);
    } else {
      sb.append("have no Address");
    }
    return sb.toString();
  }

  public boolean isResultState() {
    return resultState;
  }

  public void setResultState(boolean resultState) {
    this.resultState = resultState;
  }

}
