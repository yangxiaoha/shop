package com.zpt.shop.main.ctrler.home;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.weixin.TextMessage;
import com.zpt.shop.common.weixin.WxMpConfigStorage;
import com.zpt.shop.common.weixin.WxMpTemplateData;
import com.zpt.shop.common.weixin.WxMpTemplateMessage;
import com.zpt.shop.main.entities.Reply;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.service.ReplyService;
import com.zpt.shop.main.service.UserService;
import com.zpt.shop.main.service.WxMpService;
import com.zpt.shop.weixin.utils.WeixinUtils;

/**
 * 功能说明:
 *
 * WeixinCtrler.java
 *
 * Original Author: 林敏,2016年12月13日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Controller
@RequestMapping("/weixin")
public class WeixinCtrler {
	
	private static Logger logger = LogManager.getLogger(WeixinCtrler.class.getName());
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private WxMpService wxMpService;
	
    @ResponseBody
	@RequestMapping("/index")  
    public void weixinUrlSet(HttpServletRequest request,
                HttpServletResponse response) throws Exception {
        System.out.println("进入test,微信的访问会有2种方式post以及get,get只是做url验证。 ");
         
        boolean isGet = request.getMethod().toLowerCase().equals("get");
         
        if(isGet) {
            System.out.println("request:" + request.toString());        
            //get方法，一般用于微信服务器与本机服务器开发的基本配置（就是token验证，确定服务器是你的）
            response.setCharacterEncoding("UTF-8");
    		try {
    			PrintWriter out = response.getWriter();
    			logger.error("text");
    			out.print(request.getParameter("echostr"));
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
            /*String str = access(request, response);
            response.getWriter().write(str);*/
        }else {
            //post方法，一般是用户的事件处理（例如：关注/取消关注、点击按钮、发送消息....）
            try{
                //接收消息并返回消息
                String str = acceptMessage(request, response);                        
                response.getWriter().write(str);               
            }catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
	
    /**
     * 验证URL真实性
     *
     * @author morning
     * @date 2015年2月17日 上午10:53:07
     * @param request
     * @param response
     * @return String
     * @throws Exception 
     * @throws NoSuchAlgorithmException
     * @throws UnsupportedEncodingException
     */
/*    private String access(HttpServletRequest request ,
                 HttpServletResponse response) throws Exception {
          //验证URL真实性
          System.out.println("进入验证access");
          String signature = request.getParameter("signature");//微信加密签名
          String timestamp = request.getParameter("timestamp");//时间戳
          String nonce = request.getParameter("nonce");//随机数
          String echostr = request.getParameter("echostr");//随机字符串
          
          //sha1加密
          SortedMap<String, String> params = new TreeMap<String, String>();
          params.put("token", weixin.getToken());
          params.put("timestamp", timestamp);
          params.put("nonce", nonce);
          try {
              try {
              	  String sign = Sha1Util.createSHA1Sign(params);
                  if (sign.equals(signature)) {
                      System.out.println("成功返回 echostr：" + echostr);
                      return echostr;
                 } else {
                      System.out.println("失败认证" );
                 }
             } catch (UnsupportedEncodingException e1) {
                 // TODO Auto-generated catch block
                 e1.printStackTrace();
             }
	      } catch (NoSuchAlgorithmException e1) {
              // TODO Auto-generated catch block
              e1.printStackTrace();
	      }          
          return null ;
    }*/
    
    private String acceptMessage(HttpServletRequest request,
            HttpServletResponse response) {

    	//xml格式的消息数据
        String respXml = null;
    	
	    String respContent = "";
    	
    	try {
    		request.setCharacterEncoding("UTF-8");
    		response.setCharacterEncoding("UTF-8");
        	//解析微信发来的请求（XML）
        	Map<String, String> reqMap = WeixinUtils.parseXml2(request);

        	System.out.println("reqMap:" + reqMap.toString());
    		
    	    String fromUserName = reqMap.get("FromUserName");
    	    String toUserName = reqMap.get("ToUserName");
    	    String createTime = reqMap.get("CreateTime");
    	    String msgType = reqMap.get("MsgType");
    	    
    	    //回复文本消息
    	    TextMessage textMessage = new TextMessage();
            textMessage.setToUserName(fromUserName);
            textMessage.setFromUserName(toUserName);
            textMessage.setCreateTime(new Date().getTime());
            textMessage.setMsgType(WeixinUtils.EVENT_TYPE_TEXT);

            //事件推送
            if (msgType.equals(WeixinUtils.REQ_MSG_TYPE_EVENT)) {
                //事件类型
                String eventType = reqMap.get("Event");
                String eventKey = reqMap.get("EventKey");
                String ticket = reqMap.get("Ticket");
                String money = "0";
                //关注
                if (eventType.equals(WeixinUtils.EVENT_TYPE_SUBSCRIBE)) {

                	//获取用户名
                	String accessToken = wxMpService.getAccessToken(false);
                	JSONObject userInfo = WeixinUtils.getWeixinUserBaseInfo(fromUserName, accessToken);
                	String nickname = userInfo.getString("nickname");
  
                	User user = userService.getUserByOpenId(fromUserName);
                	
                	long msgCreateTime = Long.parseLong(createTime) * 1000L;  

                	DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  

                	String date = format.format(new Date(msgCreateTime));  
            		
            		if(user != null) {//扫过码
            			System.out.println("扫过码" + eventKey);
                    	if(user.getFpid() != null && !("".equals(user.getFpid()))) {//有上级
                    		System.out.println("有上级" + eventKey);                    		
                    		userService.updateUser(fromUserName, nickname, date, user.getFpid());
                    		User u = userService.getUserByUserId(user.getFpid());
                    		String fOpenId = u.getOpenid();

                        	JSONObject superUserInfo = WeixinUtils.getWeixinUserBaseInfo(fOpenId, accessToken);
                        	String superNickname = superUserInfo.getString("nickname");
                        	System.out.println("superNickname==========="+superNickname);
                    		
                    		//发送给关注用户
                    		WxMpTemplateMessage message = new WxMpTemplateMessage();
                    		message.setTouser(fromUserName);
            				message.setTopcolor("#FF0000");
            				message.setTemplate_id(Contants.WX_USER_SEND);
            				//跳转到会员中心
            				message.setUrl("http://weixin.591yjx.com/shop/home/member/memberCenter");        	
            				message.getData().put("first", new WxMpTemplateData(nickname+",您和"+superNickname+"已成为了朋友"));
            				message.getData().put("keyword1", new WxMpTemplateData(nickname));          			
            				message.getData().put("keyword2", new WxMpTemplateData(date));
            				message.getData().put("remark", new WxMpTemplateData("\n您已加入一见喜，成为"+superNickname+"的盟友，继续努力，喜事连连。","#FF0000"));
            				String re = wxMpService.templateSend(message);
            				System.err.println("result---" + re);
            				
            				//发送给上级用户
                    		WxMpTemplateMessage superMessage = new WxMpTemplateMessage();
                    		superMessage.setTouser(fOpenId);
                    		superMessage.setTopcolor("#FF0000");
                    		superMessage.setTemplate_id(Contants.WX_USER_SEND);
            				//跳转到会员中心
                    		superMessage.setUrl("http://weixin.591yjx.com/shop/home/member/memberCenter");        	
                    		superMessage.getData().put("first", new WxMpTemplateData(superNickname+"您有新的朋友："+nickname+"加入"));
                    		superMessage.getData().put("keyword1", new WxMpTemplateData(nickname));          			
                    		superMessage.getData().put("keyword2", new WxMpTemplateData(date));
                    		superMessage.getData().put("remark", new WxMpTemplateData("\n"+nickname+"，通过您的二维码关注了公众号，继续努力，喜事连连。","#FF0000"));
            				String sre = wxMpService.templateSend(superMessage);
            				System.err.println("result---" + sre);
                				
                    		
                    	}else {//无上级
                    		System.out.println("无上级" + eventKey);
                    		userService.updateUser(fromUserName, nickname, date, 0);
                    	}   
            		}else {
            			System.out.println("关注" + eventKey);
            			userService.addUser(fromUserName, nickname, date, 0, money);
            		}       	
                }
                //扫描带参数二维码
                else if (eventType.equals(WeixinUtils.EVENT_TYPE_SCAN)) {
                    // TODO 处理扫描带参数二维码事件
                	System.out.println("扫描带参数二维码事件");
                }
                //自定义菜单
                else if (eventType.equals(WeixinUtils.EVENT_TYPE_CLICK)) {
                    // TODO 处理菜单点击事件
                }

            } else {//接受普通消息    	 
        	    //文本消息
                if (msgType.equals(WeixinUtils.EVENT_TYPE_TEXT)) {
                    //String skey = new String(reqMap.get("Content").getBytes(), "UTF-8");
                	String str = new String(reqMap.get("Content").getBytes("UTF-8"),"ISO-8859-1"); 

                	String skey = new String(str.getBytes("ISO-8859-1"),"UTF-8");
                    System.out.println("输入的信息："+skey);
                    if(skey.matches("客服")) {
                    	System.out.println("kefu============");
                    	
                    	StringBuilder relayCustomMsg = new StringBuilder();  
                        relayCustomMsg.append("<xml>");  
                        relayCustomMsg.append("<ToUserName><![CDATA["+fromUserName+"]]></ToUserName>");  
                        relayCustomMsg.append("<FromUserName><![CDATA["+toUserName+"]]></FromUserName>");  
                        relayCustomMsg.append("<CreateTime>"+new Date().getTime()+"</CreateTime>");  
                        relayCustomMsg.append("<MsgType><![CDATA[transfer_customer_service]]></MsgType>");  
                        relayCustomMsg.append("</xml>");  
                        return relayCustomMsg.toString(); 
                        
                    }else {
                        Reply sreply = replyService.getReply(skey);
                        if(sreply != null) {
                        	respContent = sreply.getReply();
                        }else {
                        	respContent = "暂无此查询信息！";
                        }   
                    }                
                }
            } 
            //设置文本消息的内容
            textMessage.setContent(respContent);
            //将文本消息对象转换成xml
            respXml = WeixinUtils.messageToXml(textMessage);
        } catch (Exception e) {
        	logger.error(e.getMessage());
            e.printStackTrace();
        }
        return respXml;       
    }
}