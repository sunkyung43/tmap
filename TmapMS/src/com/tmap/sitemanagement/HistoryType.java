package com.tmap.sitemanagement;

public enum HistoryType {

	 INSERT("insert")
	,UPDATE("update")
	,DELETE("delete")
	;
	
	private String type;
	
	private HistoryType(String type) {
		this.type = type;
	}
	
	public String getType() {return type;}
	
	@Override
	public String toString(){
		return type;
	}
}
