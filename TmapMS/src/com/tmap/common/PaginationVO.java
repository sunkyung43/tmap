/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.common;



/** 
 * <br/>
 * @author LSH 
 * @date 2012. 4. 16. 
 */

@SuppressWarnings("serial")
public class PaginationVO{

	/**
	 * 현재페이지
	 */
	private int currentPage = 0;
	
	/**
	 * 시작 데이터의 번호
	 */
	private int startRowNum = 0;
	
	/**
	 * 한 페이지에 출력될 갯수
	 */
	private int countPerPage = 10;
	
	/**
	 * 하단 페이지 목록에 출력될 갯수 (10 이라면 10 page씩,5라면 5 page씩 출력된다.)
	 */
	private int pageCount = 10;
	
	/**
	 * 해당 데이터의  총 갯수
	 */
	private int totalCount;

	/** 
	 * @return the currentPage 
	 */
	
	public int getCurrentPage() {
		return currentPage;
	}

	/** 
	 * @param currentPage the currentPage to set 
	 */
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	/** 
	 * @return the startRowNum 
	 */
	
	public int getStartRowNum() {
		return startRowNum;
	}

	/** 
	 * @param startRowNum the startRowNum to set 
	 */
	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	/** 
	 * @return the countPerPage 
	 */
	
	public int getCountPerPage() {
		return countPerPage;
	}

	/** 
	 * @param countPerPage the countPerPage to set 
	 */
	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}

	/** 
	 * @return the pageCount 
	 */
	
	public int getPageCount() {
		return pageCount;
	}

	/** 
	 * @param pageCount the pageCount to set 
	 */
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	/** 
	 * @return the totalCount 
	 */
	
	public int getTotalCount() {
		return totalCount;
	}

	/** 
	 * @param totalCount the totalCount to set 
	 */
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}





}