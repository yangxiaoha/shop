package com.zpt.shop.common.weixin;

import java.io.Serializable;

import com.alibaba.fastjson.JSON;

public class WxError implements Serializable{
	private int errcode;

	private String errmsg;

	public int getErrcode() {
		return errcode;
	}

	public void setErrcode(int errcode) {
		this.errcode = errcode;
	}

	public String getErrmsg() {
		return errmsg;
	}

	public void setErrmsg(String errmsg) {
		this.errmsg = errmsg;
	}

	public static WxError fromJson(String json) {
		return JSON.parseObject(json, WxError.class);
	}

	@Override
	public String toString() {
		return "微信错误 errcode=" + errcode + ", errmsg=" + errmsg;
	}

}
