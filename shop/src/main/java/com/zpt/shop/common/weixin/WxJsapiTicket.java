package com.zpt.shop.common.weixin;

import java.io.Serializable;

import com.alibaba.fastjson.JSON;

public class WxJsapiTicket implements Serializable {

	private static final long serialVersionUID = -6321913289722474104L;

	private String ticket;

	private int expires_in = -1;

	public String getTicket() {
		return ticket;
	}

	public void setTicket(String ticket) {
		this.ticket = ticket;
	}

	public int getExpires_in() {
		return expires_in;
	}

	public void setExpires_in(int expires_in) {
		this.expires_in = expires_in;
	}

	public static WxJsapiTicket fromJson(String json) {
		return JSON.parseObject(json, WxJsapiTicket.class);
	}

}
