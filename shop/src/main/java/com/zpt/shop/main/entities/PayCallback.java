package com.zpt.shop.main.entities;
/**
 * 功能说明:
 * 
 * 支付成功回复
 *
 * PayCallback.java
 *
 * Original Author: 林敏,2016年12月16日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class PayCallback {
    private String return_code;
    private String return_msg;

    public PayCallback() {
        this.return_code = "SUCCESS";
        this.return_msg = "OK";
    }

    public String getReturn_code() {
        return return_code;
    }

    public void setReturn_code(String return_code) {
        this.return_code = return_code;
    }

    public String getReturn_msg() {
        return return_msg;
    }

    public void setReturn_msg(String return_msg) {
        this.return_msg = return_msg;
    }

}