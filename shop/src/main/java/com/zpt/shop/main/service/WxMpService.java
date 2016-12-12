package com.zpt.shop.main.service;

import java.util.Map;

import com.zpt.shop.common.weixin.WxErrorException;
import com.zpt.shop.common.weixin.WxMpTemplateMessage;
import com.zpt.shop.weixin.utils.WeixinUtils.RequestMethodEnum;


/**
 * 功能说明:
 *
 * WxMpService.java
 *
 * Original Author: 林敏,2016年12月9日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public interface WxMpService {
	/**
    * <pre>
    * 发送模板消息
    * 详情请见: http://mp.weixin.qq.com/wiki/index.php?title=模板消息接口
    * </pre>
    * @param templateMessage
    * @throws WxErrorException
    * @return msgid
    */
    public String templateSend(WxMpTemplateMessage templateMessage) throws WxErrorException;

    /**
    * 向微信端发送请求，在这里执行的策略是当发生access_token过期时才去刷新，然后重新执行请求，而不是全局定时请求
    * @param executor
    * @param uri
    * @param data
    * @return
    * @throws WxErrorException
    */
    public String execute(String uri, RequestMethodEnum method, String data) throws WxErrorException;

    // String executeInternal(String uri,File file) throws WxErrorException;

    /**
    * <pre>
    * 获取access_token，本方法线程安全
    * 且在多线程同时刷新时只刷新一次，避免超出2000次/日的调用次数上限
    * 
    * 另：本service的所有方法都会在access_token过期是调用此方法
    * 
    * 程序员在非必要情况下尽量不要主动调用此方法

    * 详情请见: http://mp.weixin.qq.com/wiki/index.php?title=获取access_token
    * </pre>
    * @param forceRefresh 强制刷新
    * @return
    * @throws me.chanjar.weixin.common.exception.WxErrorException
    */
    public String getAccessToken(boolean forceRefresh) throws WxErrorException ;
    
    public String executeInternal(String uri,RequestMethodEnum method, String data) throws WxErrorException ;

    public String getJsapiTicket(boolean forceRefresh) throws WxErrorException;

    public Map<String, String> sign(String url) throws WxErrorException;
}