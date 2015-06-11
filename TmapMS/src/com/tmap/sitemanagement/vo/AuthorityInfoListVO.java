package com.tmap.sitemanagement.vo;

import com.tmap.common.PaginationVO;

public class AuthorityInfoListVO extends PaginationVO{
	
	private String menuAuthorityId;
	private String authority;
	private String useState;
	private String etc;
	private String selMenuIds;
	private String menuId;
	private String rownum;
	private String keywordTp;
	
	/** 
	 * @return the menuAuthorityId 
	 */
	
	public String getMenuAuthorityId() {
		return menuAuthorityId;
	}
	/** 
	 * @param menuAuthorityId the menuAuthorityId to set 
	 */
	public void setMenuAuthorityId(String menuAuthorityId) {
		this.menuAuthorityId = menuAuthorityId;
	}
	/** 
	 * @return the authority 
	 */
	
	public String getAuthority() {
		return authority;
	}
	/** 
	 * @param authority the authority to set 
	 */
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	/** 
	 * @return the useState 
	 */
	
	public String getUseState() {
		return useState;
	}
	/** 
	 * @param useState the useState to set 
	 */
	public void setUseState(String useState) {
		this.useState = useState;
	}
	/** 
	 * @return the etc 
	 */
	
	public String getEtc() {
		return etc;
	}
	/** 
	 * @param etc the etc to set 
	 */
	public void setEtc(String etc) {
		this.etc = etc;
	}
	/** 
	 * @return the rownum 
	 */
	
	public String getRownum() {
		return rownum;
	}
	/** 
	 * @param rownum the rownum to set 
	 */
	public void setRownum(String rownum) {
		this.rownum = rownum;
	}
	/** 
	 * @return the keywordTp 
	 */
	
	public String getKeywordTp() {
		return keywordTp;
	}
	/** 
	 * @param keywordTp the keywordTp to set 
	 */
	public void setKeywordTp(String keywordTp) {
		this.keywordTp = keywordTp;
	}
	/** 
	 * @return the selMenuIds 
	 */
	
	public String getSelMenuIds() {
		return selMenuIds;
	}
	/** 
	 * @param selMenuIds the selMenuIds to set 
	 */
	public void setSelMenuIds(String selMenuIds) {
		this.selMenuIds = selMenuIds;
	}
	/** 
	 * @return the menuId 
	 */
	
	public String getMenuId() {
		return menuId;
	}
	/** 
	 * @param menuId the menuId to set 
	 */
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	
	
	
}