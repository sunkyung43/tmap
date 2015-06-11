package com.tmap.login.vo;

public class UserInfoVO {
	private String userId;
	private String userPass;
	private String userName;
	private String userTel;
	private String Devision;
	private String userState;
	private String userSdate;
	private String companyId;
	private String authorityMenuId;
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getUserPass() {
		return userPass;
	}
	
	public void setUserPass(String userPass) {
		this.userPass = userPass;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserTel() {
		return userTel;
	}

	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}

	public String getDevision() {
		return Devision;
	}

	public void setDevision(String devision) {
		Devision = devision;
	}

	public String getUserState() {
		return userState;
	}

	public void setUserState(String userState) {
		this.userState = userState;
	}

	public String getUserSdate() {
		return userSdate;
	}

	public void setUserSdate(String userSdate) {
		this.userSdate = userSdate;
	}

	public String getCompany() {
		return companyId;
	}

	public void setCompany(String company) {
		this.companyId = company;
	}

	public String getAuthorityMenuId() {
		return authorityMenuId;
	}

	public void setAuthorityMenuId(String authorityMenuId) {
		this.authorityMenuId = authorityMenuId;
	}
}
