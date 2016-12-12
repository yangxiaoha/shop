package com.zpt.shop.common.weixin;

import java.io.Serializable;

public class WxMpTemplateData implements Serializable {
	
	  private String value;
	  private String color;

	  public WxMpTemplateData() {
	  }

	  public WxMpTemplateData(String value) {
	    this.value = value;
	  }

	  public WxMpTemplateData(String value, String color) {
	    this.value = value;
	    this.color = color;
	  }

	  public String getValue() {
	    return value;
	  }

	  public void setValue(String value) {
	    this.value = value;
	  }

	  public String getColor() {
	    return color;
	  }
	  
	  public void setColor(String color) {
	    this.color = color;
	  }

	}
