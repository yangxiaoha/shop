package com.zpt.shop.main.interceptor;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.weixin.WxMpConfigStorage;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.service.UserService;
import com.zpt.shop.main.service.WxMpService;
import com.zpt.shop.weixin.utils.WeixinUtils;

/**
 * 功能说明:
 *
 * weixinInterceptor.java
 *
 * Original Author: 林敏,2016年12月8日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class WeixinInterceptor implements HandlerInterceptor {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private WxMpConfigStorage weixin;
	
	@Autowired
	private WxMpService wxMpService;

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
		System.out.println("w111");

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {
		System.out.println("w222");
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {
		System.out.println("w333"+request.getSession().getAttribute(Contants.SESSION_OPENID));
		request.getSession().setAttribute(Contants.SESSION_OPENID,
		"oWPBkwdzbtxJwOrBBz86j7rdxFB4");
		if (request.getSession().getAttribute(Contants.SESSION_OPENID) == null
				|| request.getSession().getAttribute(Contants.SESSION_OPENID) == "") {
			
			if (request.getParameterMap().get("code") != null
					&& !StringUtils.isEmpty(((String[]) request.getParameterMap().get("code"))[0])) {

				String[] code = (String[]) request.getParameterMap().get("code");
				String openidPath = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + weixin.getAppId()
						+ "&secret=" + weixin.getSecret().trim() + "&code=" + String.valueOf(code[0])
						+ "&grant_type=authorization_code";
				
				//通过code获取openid和accessToken
				JSONObject jsonObject = WeixinUtils.httpRequest(openidPath, "GET", null);
				String openid = jsonObject.getString("openid");			
				String accessToken = jsonObject.getString("access_token");
				request.getSession().setAttribute(Contants.SESSION_OPENID, openid);
				
				//通过openid和accessToken获取用户基本信息，并保存到session中
				String userPath = "https://api.weixin.qq.com/sns/userinfo?access_token=" + accessToken
						+ "&openid=" + openid + "&lang=zh_CN";
				JSONObject userInfoObject = WeixinUtils.httpRequest(userPath, "GET", null);
				if (null != userInfoObject) {
					request.getSession().setAttribute("userName", userInfoObject.getString("nickname"));
					request.getSession().setAttribute("userHeadImg", userInfoObject.getString("headimgurl"));
				}
				if (openid != null && openid != "") {
					
					//用户是否关注
                	String accessToken2 = wxMpService.getAccessToken(false);
                	JSONObject userInfo = WeixinUtils.getWeixinUserBaseInfo(openid, accessToken2);
                	String subscribe = userInfo.getString("subscribe");   
                	
                	if("1".equals(subscribe)) {
                		User user = userService.getUserByOpenId(openid);
    					if(user != null){
    						request.getSession().setAttribute("user", user);
    						userService.updateUsername(openid, userInfoObject.getString("nickname"));
    					}
                	}else {
                		System.out.println("http://weixin.591yjx.com/shop/home/member/follow");
                		response.sendRedirect("http://weixin.591yjx.com/shop/home/member/follow");
                		return false;
                	}

				}
			} else {
				String requestPath = URLEncoder.encode(request.getRequestURL().toString(), "UTF-8");
				String codePath = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + weixin.getAppId()
						+ "&redirect_uri=" + requestPath
						+ "&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect";
				System.out.println(codePath+"----------------------codepath");
				response.sendRedirect(codePath);
				return false;
			}
		}else{			
			User user = userService.getUserByOpenId(request.getSession().getAttribute(Contants.SESSION_OPENID)+"");
			if(user != null){
				String accessToken2 = wxMpService.getAccessToken(false);
            	JSONObject userInfo = WeixinUtils.getWeixinUserBaseInfo(user.getOpenid(), accessToken2);
            	String subscribe = userInfo.getString("subscribe");
				         	
            	if("1".equals(subscribe)) {
            		request.getSession().setAttribute("user", user);
            	}else {
            		response.sendRedirect("http://weixin.591yjx.com/shop/home/member/follow");
            	}
			}
		}
		return true;
	}
}