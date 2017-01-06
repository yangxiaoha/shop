package com.zpt.shop.main.service.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Arrays;
import java.util.Formatter;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONObject;
import com.zpt.shop.common.weixin.WxAccessToken;
import com.zpt.shop.common.weixin.WxError;
import com.zpt.shop.common.weixin.WxErrorException;
import com.zpt.shop.common.weixin.WxJsapiTicket;
import com.zpt.shop.common.weixin.WxMpConfigStorage;
import com.zpt.shop.common.weixin.WxMpTemplateMessage;
import com.zpt.shop.main.service.WxMpService;
import com.zpt.shop.weixin.utils.MD5Utils;
import com.zpt.shop.weixin.utils.StringUtil;
import com.zpt.shop.weixin.utils.WeixinUtils;
import com.zpt.shop.weixin.utils.WeixinUtils.RequestMethodEnum;


/**
 * 功能说明:
 *
 * WxMpServiceImpl.java
 *
 * Original Author: 林敏,2016年12月9日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Service
@Transactional
public class WxMpServiceImpl implements WxMpService {
	protected final org.slf4j.Logger log = LoggerFactory.getLogger(WxMpService.class);

	/**
	 * 全局的是否正在刷新access token的锁
	 */
	protected final Object globalAccessTokenRefreshLock = new Object();

	/**
	 * 全局的是否正在刷新jsapi_ticket的锁
	 */
	protected final Object globalJsapiTicketRefreshLock = new Object();
	
	@Autowired
	protected WxMpConfigStorage wxMpConfigStorage;

	private int retrySleepMillis = 1000;

	private int maxRetryTimes = 3;

	@Override
	public String templateSend(WxMpTemplateMessage templateMessage) throws WxErrorException {
		String url = "https://api.weixin.qq.com/cgi-bin/message/template/send";
		String json = templateMessage.toJson();
		// log.debug(json);
		String responseContent = execute(url, RequestMethodEnum.POST, json);
		JSONObject jsonObject = JSONObject.parseObject(responseContent);
		return jsonObject.getString("msgid");
	}

	@Override
	public String execute(String uri, RequestMethodEnum method, String data) throws WxErrorException {
		int retryTimes = 0;
		do {
			try {
				return executeInternal(uri, method, data);
			} catch (WxErrorException e) {
				WxError error = e.getError();
				/**
				 * -1 系统繁忙, 1000ms后重试
				 */
				if (error.getErrcode() == -1) {
					int sleepMillis = retrySleepMillis * (1 << retryTimes);
					try {
						log.debug("微信系统繁忙，{}ms 后重试(第{}次)", sleepMillis, retryTimes + 1);
						Thread.sleep(sleepMillis);
					} catch (InterruptedException e1) {
						throw new RuntimeException(e1);
					}
				} else {
					throw e;
				}
			}
		} while (++retryTimes < maxRetryTimes);

		throw new RuntimeException("微信服务端异常，超出重试次数");
	}

	/*
	 * public String executeInternal(String uri,File file) throws
	 * WxErrorException { String accessToken = getAccessToken(false);
	 * 
	 * String uriWithAccessToken = uri; uriWithAccessToken += uri.indexOf('?')
	 * == -1 ? "?access_token=" + accessToken : "&access_token=" + accessToken;
	 * 
	 * String resultContent = WeixinUtils.sendFile(uriWithAccessToken, file);
	 * WxError error = WxError.fromJson(resultContent); if (error.getErrcode()
	 * != 0) {
	 * 
	 * 发生以下情况时尝试刷新access_token 40001 获取access_token时AppSecret错误，或者access_token无效
	 * 42001 access_token超时
	 * 
	 * if (error.getErrcode() == 42001) { // 强制设置wxMpConfigStorage它的access
	 * token过期了，这样在下一次请求里就会刷新access token wxMpConfigStorage.expireAccessToken();
	 * return executeInternal(uri,file); }else{ throw new
	 * WxErrorException(error); } } return resultContent; }
	 */

	@Override
	public String getAccessToken(boolean forceRefresh) throws WxErrorException {
		if (forceRefresh) {
			wxMpConfigStorage.expireAccessToken();
		}
		if (wxMpConfigStorage.isAccessTokenExpired()) {
			synchronized (globalAccessTokenRefreshLock) {
				if (wxMpConfigStorage.isAccessTokenExpired()) {
					String url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential" + "&appid="
							+ wxMpConfigStorage.getAppId() + "&secret=" + wxMpConfigStorage.getSecret();
					String resultContent = WeixinUtils.httpRequest(url, RequestMethodEnum.GET, null);
					WxError error = WxError.fromJson(resultContent);
					if (error.getErrcode() != 0) {
						throw new WxErrorException(error);
					}
					WxAccessToken accessToken = WxAccessToken.fromJson(resultContent);
					wxMpConfigStorage.updateAccessToken(accessToken.getAccess_token(), accessToken.getExpires_in());
				}
			}
		}
		return wxMpConfigStorage.getAccessToken();
	}
	
	@Override
	public String getJsapiTicket(boolean forceRefresh) throws WxErrorException {
		if (forceRefresh) {
			wxMpConfigStorage.expireJsapiTicket();
		}
		if (wxMpConfigStorage.isJsapiTicketExpired()) {
			synchronized (globalJsapiTicketRefreshLock) {
				if (wxMpConfigStorage.isJsapiTicketExpired()) {
					String url = "https://api.weixin.qq.com/cgi-bin/ticket/getticket?access_token="+this.getAccessToken(false)+"&type=jsapi";
					String resultContent = WeixinUtils.httpRequest(url, RequestMethodEnum.GET, null);
					WxError error = WxError.fromJson(resultContent);
					if (error.getErrcode() != 0) {
						throw new WxErrorException(error);
					}
					WxJsapiTicket jsapiTicket = WxJsapiTicket.fromJson(resultContent);
					wxMpConfigStorage.updateJsapiTicket(jsapiTicket.getTicket(), jsapiTicket.getExpires_in());
				}
			}
		}
		return wxMpConfigStorage.getJsapiTicket();
	}
	
	private  String create_nonce_str() {
        return UUID.randomUUID().toString();
    }

    private  String create_timestamp() {
        return Long.toString(System.currentTimeMillis() / 1000);
    }
    
    private  String byteToHex(final byte[] hash) {
        Formatter formatter = new Formatter();
        for (byte b : hash)
        {
            formatter.format("%02x", b);
        }
        String result = formatter.toString();
        formatter.close();
        return result;
    }
	
    @Override
    public Map<String, String> sign(String url) throws WxErrorException {
        Map<String, String> ret = new HashMap<String, String>();
        String nonce_str = create_nonce_str();
        String timestamp = create_timestamp();
        String string1;
        String signature = "";
        String ticket = this.getJsapiTicket(false);
        //注意这里参数名必须全部小写，且必须有序
        string1 = "jsapi_ticket=" + ticket +
                  "&noncestr=" + nonce_str +
                  "&timestamp=" + timestamp +
                  "&url=" + url;
        try
        {
            MessageDigest crypt = MessageDigest.getInstance("SHA-1");
            crypt.reset();
            crypt.update(string1.getBytes("UTF-8"));
            signature = byteToHex(crypt.digest());
        }
        catch (NoSuchAlgorithmException e)
        {
            e.printStackTrace();
        }
        catch (UnsupportedEncodingException e)
        {
            e.printStackTrace();
        }

        ret.put("url", url);
        ret.put("jsapi_ticket", ticket);
        ret.put("nonceStr", nonce_str);
        ret.put("timestamp", timestamp);
        ret.put("signature", signature);
        ret.put("appId", wxMpConfigStorage.getAppId());
        return ret;
    }

	@Override
	public String executeInternal(String uri, RequestMethodEnum method, String data) throws WxErrorException {
		String accessToken = getAccessToken(false);

		String uriWithAccessToken = uri;
		uriWithAccessToken += uri.indexOf('?') == -1 ? "?access_token=" + accessToken : "&access_token=" + accessToken;
		if (method.equals(RequestMethodEnum.GET) && data != null) {
			if (uriWithAccessToken.indexOf('?') == -1) {
				uriWithAccessToken += '?';
			}
			uriWithAccessToken += uriWithAccessToken.endsWith("?") ? data : '&' + data;
		}
		String resultContent = WeixinUtils.httpRequest(uriWithAccessToken, method, data);
		log.debug("wx:{}", resultContent);
		WxError error = WxError.fromJson(resultContent);
		if (error.getErrcode() != 0) {
			/*
			 * 发生以下情况时尝试刷新access_token 40001
			 * 获取access_token时AppSecret错误，或者access_token无效 42001 access_token超时
			 */
			if (error.getErrcode() == 42001 || error.getErrcode() == 40001) {
				// 强制设置wxMpConfigStorage它的access token过期了，这样在下一次请求里就会刷新access
				// token
				wxMpConfigStorage.expireAccessToken();
				return execute(uri, method, data);
			} else {
				throw new WxErrorException(error);
			}
		}
		return resultContent;
	}
	
	public String getSign(Map<String, String> params, String paternerKey) throws UnsupportedEncodingException {
		return MD5Utils.getMD5(createSign(params, false) + "&key=" + paternerKey).toUpperCase();
	}
	
	/**
	 * 构造签名
	 * 
	 * @param params
	 * @param encode
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String createSign(Map<String, String> params, boolean encode) throws UnsupportedEncodingException {
		Set<String> keysSet = params.keySet();
		Object[] keys = keysSet.toArray();
		Arrays.sort(keys);
		StringBuffer temp = new StringBuffer();
		boolean first = true;
		for (Object key : keys) {
			if (key == null || StringUtil.isEmpty(params.get(key))) // 参数为空不参与签名
				continue;
			if (first) {
				first = false;
			} else {
				temp.append("&");
			}
			temp.append(key).append("=");
			Object value = params.get(key);
			String valueStr = "";
			if (null != value) {
				valueStr = value.toString();
			}
			if (encode) {
				temp.append(URLEncoder.encode(valueStr, "UTF-8"));
			} else {
				temp.append(valueStr);
			}
		}
		return temp.toString();
	}
}