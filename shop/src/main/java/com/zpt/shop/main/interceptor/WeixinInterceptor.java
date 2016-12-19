package com.zpt.shop.main.interceptor;

import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.UsesSunHttpServer;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.weixin.WeixinUserInfo;
import com.zpt.shop.common.weixin.WxMpConfigStorage;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.service.UserService;
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
		if (request.getSession().getAttribute(Contants.SESSION_OPENID) == null
				|| request.getSession().getAttribute(Contants.SESSION_OPENID) == "") {
			if (request.getParameterMap().get("code") != null
					&& !StringUtils.isEmpty(((String[]) request.getParameterMap().get("code"))[0])) {
				
				String[] code = (String[]) request.getParameterMap().get("code");
				String openidPath = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + weixin.getAppId()
						+ "&secret=" + weixin.getSecret().trim() + "&code=" + String.valueOf(code[0])
						+ "&grant_type=authorization_code";
				System.out.println(openidPath + "openidPath");
				
				//通过code获取openid和accessToken
				JSONObject jsonObject = WeixinUtils.httpRequest(openidPath, "GET", null);
				System.out.println(jsonObject + "jsonObject");
				String openid = jsonObject.getString("openid");
				System.out.println("-----------------拦截openId"+jsonObject.getString("openid"));			
				String accessToken = jsonObject.getString("access_token");
				System.out.println("-----------------拦截accessToken"+jsonObject.getString("access_token"));
				
				//通过openid和accessToken获取用户基本信息，并保存到session中
				String userPath = "https://api.weixin.qq.com/sns/userinfo?access_token=" + accessToken
						+ "&openid=" + openid + "&lang=zh_CN";
				System.out.println(userPath + "userPath");
				JSONObject userInfoObject = WeixinUtils.httpRequest(userPath, "GET", null);
				if (null != userInfoObject) {
					System.out.println("-----------------nickname"+userInfoObject.getString("nickname"));
					System.out.println("-----------------headimgurl"+userInfoObject.getString("headimgurl"));
					request.getSession().setAttribute("userName", userInfoObject.getString("nickname"));
					request.getSession().setAttribute("userHeadImg", userInfoObject.getString("headimgurl"));
				}
				if (openid != null && openid != "") {
					User user = userService.getUserByOpenId(openid);
					if(user != null){
						request.getSession().setAttribute("user", user);
						
			    		//是否有上级
						Integer pid = 0;
			    		if(!(pid.equals(user.getPid()))) {
			    			User superior = userService.getUserId(user.getPid());
			    			String superiorPath = "https://api.weixin.qq.com/sns/userinfo?access_token=" + accessToken
									+ "&openid=" + superior.getOpenid() + "&lang=zh_CN";
			    			JSONObject superiorInfoObject = WeixinUtils.httpRequest(superiorPath, "GET", null);
			    			if (null != superiorInfoObject) {
								System.out.println("-----------------superiorName"+superiorInfoObject.getString("nickname"));
								request.getSession().setAttribute("superiorName", superiorInfoObject.getString("nickname"));		
							}
			    		}else {
			    			request.getSession().setAttribute("superiorName", "一见喜");
			    		}
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
				System.out.println(user.getOpenid()+"----------------------openId");
				request.getSession().setAttribute("user", user);
			}	
		}
		return true;
	}
}