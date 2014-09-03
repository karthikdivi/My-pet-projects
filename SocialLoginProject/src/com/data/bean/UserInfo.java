package com.data.bean;

import java.util.List;

public class UserInfo {

	List<String> userInfo;

	public UserInfo(List<String> userInfo) {
		super();
		this.userInfo = userInfo;
	}

	public List<String> getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(List<String> userInfo) {
		this.userInfo = userInfo;
	}
	
}
