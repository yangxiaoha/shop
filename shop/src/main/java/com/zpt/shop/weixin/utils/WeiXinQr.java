package com.zpt.shop.weixin.utils;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.alibaba.fastjson.JSONObject;
import com.zpt.shop.main.ctrler.home.MemberCtrler;

/**
 * 功能说明:
 * 
 * 带参数的二维码
 *
 * WeiXinQr.java
 *
 * Original Author: 林敏,2016年12月13日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class WeiXinQr {
	
	private static Logger logger = LogManager.getLogger(MemberCtrler.class.getName());
	
	//获取ticket	
	public static JSONObject getQr(String accessToken, String jsonMsg){  
        String requestUrl = " https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=TOKEN";  
        requestUrl = requestUrl.replace("TOKEN", accessToken);  
        JSONObject jsonObject = WeixinUtils.httpRequest(requestUrl, "POST", jsonMsg);  
        if(null != jsonObject){  
            System.out.println(jsonObject);  
            return jsonObject; 
        }else {
        	return null;
        }
    }  
	
    //用ticket获取二维码  
    public static boolean chageQr(String ticket){  
        boolean result = false;  
        String requestUrl = "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=TICKET";  
        requestUrl = requestUrl.replace("TICKET", ticket);  
        JSONObject jsonObject = WeixinUtils.httpRequest(requestUrl, "GET", null);  
        System.out.println(jsonObject+"");  
        if(null != jsonObject){  
            System.out.println(jsonObject);  
            int errorCode = jsonObject.getInteger("errcode");  
            String errorMsg = jsonObject.getString("errmsg");  
            if(0 == errorCode){  
                result = true;  
                logger.info("成功errorCode:{"+errorCode+"},errmsg:{"+errorMsg+"}");  
                System.out.println("成功errorCode:{"+errorCode+"},errmsg:{"+errorMsg+"}");  
            }else{  
                logger.info("失败errorCode:{"+errorCode+"},errmsg:{"+errorMsg+"}");  
                System.out.println("失败errorCode:{"+errorCode+"},errmsg:{"+errorMsg+"}");  
            }  
        }  
        return result;  
    } 
}