package com.zpt.shop.common.weixin;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.Map;

import com.alibaba.fastjson.JSON;

public class WxMpTemplateMessage implements Serializable {

	private String touser;
	private String template_id;
	private String url;
	private String topcolor;
	private Map<String, WxMpTemplateData> data = new LinkedHashMap<>();
	
	public String getTouser() {
		return touser;
	}

	public void setTouser(String touser) {
		this.touser = touser;
	}

	public String getTemplate_id() {
		return template_id;
	}

	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTopcolor() {
		return topcolor;
	}
	
	public void setTopcolor(String topcolor) {
		this.topcolor = topcolor;
	}

	public Map<String, WxMpTemplateData> getData() {
		return data;
	}

	public void setData(Map<String, WxMpTemplateData> data) {
		this.data = data;
	}

	public String toJson() {
		return JSON.toJSONString(this);
	}
}
