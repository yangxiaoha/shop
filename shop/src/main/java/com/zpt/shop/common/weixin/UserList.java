package com.zpt.shop.common.weixin;
/**
 * 功能说明:
 *
 * UserList.java
 *
 * Original Author: 林敏,2016年12月15日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class UserList {
	
	// 用户的标识
    private String openid;
    // 昵称
    private String lang;
    
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}

}