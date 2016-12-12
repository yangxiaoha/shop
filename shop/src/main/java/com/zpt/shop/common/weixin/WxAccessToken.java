package com.zpt.shop.common.weixin;

import java.io.Serializable;

import com.alibaba.fastjson.JSON;

public class WxAccessToken implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6321913289722474104L;

	private String access_token;

	private int expires_in = -1;
	
	public String getAccess_token() {
		return access_token;
	}

	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}

	public int getExpires_in() {
		return expires_in;
	}

	public void setExpires_in(int expires_in) {
		this.expires_in = expires_in;
	}

	public static WxAccessToken fromJson(String json) {
		return JSON.parseObject(json, WxAccessToken.class);
	}

}
