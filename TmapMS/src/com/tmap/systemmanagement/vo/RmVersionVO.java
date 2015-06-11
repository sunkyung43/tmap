package com.tmap.systemmanagement.vo;

import com.tmap.common.PaginationVO;

public class RmVersionVO extends PaginationVO{
	
	private String mapVerCheck;
	private String mapVerCheckDate;
	private String mapVerCheckSeq;
	
	/** 
	 * @return the mapVerCheckSeq 
	 */
	
	public String getMapVerCheckSeq() {
		return mapVerCheckSeq;
	}

	/** 
	 * @param mapVerCheckSeq the mapVerCheckSeq to set 
	 */
	public void setMapVerCheckSeq(String mapVerCheckSeq) {
		this.mapVerCheckSeq = mapVerCheckSeq;
	}

	/** 
	 * @return the mapVerCheck 
	 */
	public String getMapVerCheck() {
		return mapVerCheck;
	}
	
	/** 
	 * @param mapVerCheck the mapVerCheck to set 
	 */
	public void setMapVerCheck(String mapVerCheck) {
		this.mapVerCheck = mapVerCheck;
	}
	
	/** 
	 * @return the mapVerCheckDate 
	 */
	public String getMapVerCheckDate() {
		return mapVerCheckDate;
	}
	
	/** 
	 * @param mapVerCheckDate the mapVerCheckDate to set 
	 */
	public void setMapVerCheckDate(String mapVerCheckDate) {
		this.mapVerCheckDate = mapVerCheckDate;
	}

	
}