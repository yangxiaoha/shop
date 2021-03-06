package com.zpt.shop.main.ctrler.home;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.zpt.shop.common.weixin.UserList;
import com.zpt.shop.common.weixin.WxErrorException;
import com.zpt.shop.common.weixin.WxMpConfigStorage;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.entities.Withdraw;
import com.zpt.shop.main.service.OrderService;
import com.zpt.shop.main.service.SystemService;
import com.zpt.shop.main.service.UserService;
import com.zpt.shop.main.service.WithdrawService;
import com.zpt.shop.main.service.WxMpService;
import com.zpt.shop.weixin.utils.WeixinUtils;

import net.sf.json.JSONArray;

/**
 * 功能说明:
 *
 * MemberCtrler.java
 *
 * Original Author: 林敏,2016年11月7日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Controller
@RequestMapping("home/member")
public class MemberCtrler {
	
	private static Logger logger = LogManager.getLogger(MemberCtrler.class.getName());
	
	@Autowired
	private SystemService systemService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private WithdrawService withdrawService;
	
	@Autowired
	private WxMpService wxMpService;
	
	@Autowired
	protected WxMpConfigStorage wxMpConfigStorage;
	
	//会员中心
	@RequestMapping(value="/memberCenter", method=RequestMethod.GET)
	public ModelAndView memberCenter(HttpServletRequest request, HttpServletResponse response) throws IOException, WxErrorException {
		ModelAndView mv = new ModelAndView("home/member-center");
		//获取用户信息
		User user = (User) request.getSession().getAttribute("user");
		User userMsg = userService.getUserId(user.getId());
		String superiorName = "";
		
		String state = "1";
		//判断用户是否拥有发展下级的权力（是否购买过商品）
		List<Order> orderList = orderService.getOrderDetailByUser(user.getId(), state);

		//是否有上级,有则获取上级名字
        Integer pid = 0;
        if(!(pid.equals(user.getPid()))) {
            User superior = userService.getUserId(user.getPid()); 
            List<UserList> list = new ArrayList<UserList>(); 
            UserList agent = new UserList();   
            agent.setOpenid(superior.getOpenid());  
            agent.setLang("zh-CN");                   
            list.add(agent);
                    
            System.out.println(list);
            JSONObject s = new JSONObject(); 
            s.put("user_list", list);
	        String accessToken = wxMpService.getAccessToken(false);
	        JSONObject jsonObject = WeixinUtils.getBatchWeixinUserInfo(s.toString(), accessToken);
	        System.out.println(jsonObject);

            if(null != jsonObject) {
    	        String userInfo = jsonObject.getString("user_info_list");	       
    	        JSONArray myJsonArray = JSONArray.fromObject(userInfo);
    	        net.sf.json.JSONObject ob = (net.sf.json.JSONObject) myJsonArray.get(0);
      		    superiorName = ob.getString("nickname");
            }
        }else {
        	superiorName = "一见喜";
        }
		
		String nickname = (String) request.getSession().getAttribute("userName");
		String headimgurl = (String) request.getSession().getAttribute("userHeadImg");
		mv.addObject("name", nickname);//用户名
		mv.addObject("headImg", headimgurl);//头像
		mv.addObject("superiorName", superiorName);//上级用户名
		
        //已提现金额
		BigDecimal totalPrice = new BigDecimal("0.0");		
		List<Withdraw> withdrawList = withdrawService.getMemberInfo(user.getId());
		if(withdrawList != null && withdrawList.size() > 0) {
			for(int i=0; i<withdrawList.size(); i++) {
				BigDecimal price = new BigDecimal(withdrawList.get(i).getCashMoney().toString());
				totalPrice = totalPrice.add(price);
			}
			mv.addObject("totalPrice", totalPrice);
		}else {
			mv.addObject("totalPrice", "0.00");
		}
		
		//代理人信息
		List<User> userList = userService.getAgentInfoByMyId(user.getId());
		String primary = "";//一级分销
		String second = "";//二级分销
		String third = "";//三级分销
		String ids = "";//分销
		int num = 0;
		BigDecimal payPrice = new BigDecimal("0.00");//下单购买金额
		BigDecimal noPayPrice = new BigDecimal("0.00");//下单未购买金额
		if(userList != null && userList.size() > 0) {
			for(int i=0; i<userList.size(); i++) {
				if(primary != null && !("".equals(primary))) {
					primary = primary + "," + userList.get(i).getId();
				}else {
					primary = userList.get(i).getId().toString();
				}
				if(userList.get(i).getPid() != null && !("".equals(userList.get(i).getPid()))) {
					if(second != null && !("".equals(second))) {
						second = second + "," + userList.get(i).getPid();
					}else {
						second = userList.get(i).getPid().toString();
					}
				}
			}
			if(second != null && !("".equals(second))) {
				third = userService.getThirdUser(second);
				if(third != null && !("".equals(third))) {
					ids = primary + "," + second + "," + third;
				}else {
					ids = primary + "," + second;
				}				
			}else {
				ids = primary;
			}
			String[] strArray = null;   
	        strArray = ids.split(","); //拆分字符为",",然后把结果交给数组strArray 
	        HashSet<String> h = new HashSet<String>();
	        for(int i = 0; i<strArray.length; i++) {
	        	h.add(strArray[i]);
	        }
			//下单已购买
			List<Order> orderPayList = orderService.getOrderInfoByPay(ids);
			//下单未购买
			List<Order> orderNoPayList = orderService.getOrderInfoByNoPay(ids);
			if(orderPayList != null && orderPayList.size() > 0) {
				for(int i=0; i<orderPayList.size(); i++) {
					payPrice = payPrice.add(orderPayList.get(i).getTotalPrice());
					num++;
				}
				mv.addObject("payNum", orderPayList.size());//下单支付订单数量
			}else {
				mv.addObject("payNum", "0");//下单支付订单数量
			}
			if(orderNoPayList != null && orderNoPayList.size() > 0) {
				for(int i=0; i<orderNoPayList.size(); i++) {
					noPayPrice = noPayPrice.add(orderNoPayList.get(i).getTotalPrice());
					num++;
				}
				mv.addObject("noPayNum", orderNoPayList.size());//下单未支付订单数量
			}else {
				mv.addObject("noPayNum", "0");//下单未支付订单数量
			}
			mv.addObject("peopleNum", h.size());//代理人数
			mv.addObject("num", num);//订单总数
			mv.addObject("payPrice", payPrice);//下单支付金额
			mv.addObject("noPayPrice", noPayPrice);//下单未支付金额
			mv.addObject("price", payPrice.add(noPayPrice));//总金额
		}else {
			mv.addObject("peopleNum", "0");//代理人数			
			mv.addObject("payNum", "0");//下单支付订单数量
			mv.addObject("noPayNum", "0");//下单未支付订单数量
			mv.addObject("num", "0");//订单总数
			mv.addObject("payPrice", "0.00");//下单支付金额
			mv.addObject("noPayPrice", "0.00");//下单未支付金额
			mv.addObject("price", "0.00");//总金额
		}		
		mv.addObject("userMsg", userMsg);
		mv.addObject("orderMsg", orderList);
		mv.addObject("withdrawMsg", withdrawList);
		return mv;
	}

	//提现
	@RequestMapping(value="/withdrawals", method=RequestMethod.GET)
	public ModelAndView withdrawals(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("home/withdrawals");
		User user = (User) request.getSession().getAttribute("user");
		String userName = (String) request.getSession().getAttribute("userName");
		String userHeadImg = (String) request.getSession().getAttribute("userHeadImg");
		List<Withdraw> withdrawsList = withdrawService.getWithdrawsInfo(user.getId());
		//获取用户信息
		User userInfo  = userService.getUserByUserId(user.getId());
		mv.addObject("name", userName);
		mv.addObject("headImg", userHeadImg);
		mv.addObject("money", userInfo.getMoney());//可提现金额
		mv.addObject("withdrawsMsg", withdrawsList);
		return mv;
	}
	
	//提现
	@ResponseBody
	@RequestMapping(value="/withdrawalsApply", method=RequestMethod.POST)
	public Map<String,Object> withdrawalsApply(HttpServletRequest request, String money) {
		Map<String,Object> map = new HashMap<String, Object>();
		User user = (User) request.getSession().getAttribute("user");
		Integer userId = user.getId();
		String userName = (String) request.getSession().getAttribute("userName");
		//提现申请
		List<Withdraw> withdrawsList = withdrawService.addWithdrawsInfo(userId, userName, money);
		map.put("state", true);
		map.put("withdrawsMsg", withdrawsList);
		return map;
	}
	
	//我的二维码
	@RequestMapping(value="/myQr", method=RequestMethod.GET)
	public ModelAndView myQr(HttpServletRequest request) throws WxErrorException {
		ModelAndView mv = new ModelAndView("home/my-qr");
		User user = (User) request.getSession().getAttribute("user");
		String state = "1";
		String openId = user.getOpenid();		
		/*String accessToken = wxMpService.getAccessToken(false);
		String jsonMsg1 = "{\"expire_seconds\": \"604800\", \"action_name\": \"QR_SCENE\", \"action_info\"：{\"scene\": {\"scene_id\": "+openId+"}}}";
		String jsonMsg = "{\"expire_seconds\": \"604800\", \"action_name\": \"QR_SCENE\", \"action_info\"：{\"scene\": {\"scene_id\": ozmycs6JuZxrpxDuNMluTyvyUDCY}}}";
		JSONObject jsonObject = WeiXinQr.getQr(accessToken, jsonMsg);
		System.out.println(jsonMsg1);
		System.out.println(jsonObject);
		String url = jsonObject.getString("url");*/
		
		//判断用户是否拥有发展下级的权力（是否购买过商品）
		List<Order> orderList = orderService.getOrderDetailByUser(user.getId(), state);
		if(orderList != null && orderList.size() > 0) {
			String url = request.getRequestURL().toString()+"/getSuperiorInfo";//二维码	
			mv.addObject("state", "1");
			mv.addObject("myQr", url);
			mv.addObject("openId", openId);
			mv.addObject("orderMsg", orderList);
		}else {
			mv.addObject("state", "0");
			mv.addObject("msg", "请先购买产品");
			mv.addObject("orderMsg", orderList);
		}

		return mv;
	}
	
	//绑定上级
	@RequestMapping(value="/myQr/getSuperiorInfo/{openId}", method=RequestMethod.GET)
	public String getSuperiorInfo(HttpServletRequest request, @PathVariable("openId")String openId) throws WxErrorException {
		/*String accessToken = wxMpService.getAccessToken(false);
		String jsonMsg1 = "{\"expire_seconds\": \"604800\", \"action_name\": \"QR_SCENE\", \"action_info\"：{\"scene\": {\"scene_id\": "+openId+"}}}";
		String jsonMsg = "{\"expire_seconds\": \"604800\", \"action_name\": \"QR_SCENE\", \"action_info\"：{\"scene\": {\"scene_id\": ozmycs6JuZxrpxDuNMluTyvyUDCY}}}";
		JSONObject jsonObject = WeiXinQr.getQr(accessToken, jsonMsg);
		System.out.println(jsonMsg1);
		System.out.println(jsonObject);
		String url = jsonObject.getString("url");*/

		/*String openid = (String) request.getSession().getAttribute("openid");//扫码用户的openId
		String[] superiorId = (String[]) request.getParameterMap().get("openId");//二维码持有者的openId
		System.out.println(superiorId);
		User superiorUser = userService.getUserByOpenId(String.valueOf(superiorId[0]));*/
		
		String openid = (String) request.getSession().getAttribute("openid");
		User superiorUser = userService.getUserByOpenId(openId);
		
		//判断此用户是否已经存在
		User user = userService.getUserByOpenId(openid);
		User userInfo = new User();
		userInfo.setOpenid(openid);
		userInfo.setFpid(superiorUser.getId());
		userInfo.setMoney(new BigDecimal(0));
		if(user != null) {	
			if(user.getPid() == null || ("").equals(user.getPid())) {
				userService.updateUserByScan(userInfo);
			}
			return "redirect:/home/member/follow";
		}else {
			userService.addUserByScan(userInfo);
			return "redirect:/home/member/follow";
		}
	}
	
	//我的代理人
	@RequestMapping(value="/myAgent", method=RequestMethod.GET)
	public ModelAndView myAgent(HttpServletRequest request) throws WxErrorException {
		ModelAndView mv = new ModelAndView("home/my-agent");
		//获取用户信息
		User user = (User) request.getSession().getAttribute("user");
		//代理人信息
		List<User> userList = userService.getAgentInfoByMyId(user.getId());
		String primary = "";//一级分销
		String second = "";//二级分销
		String third = "";//三级分销
		String ids = "";//分销
		if(userList != null && userList.size() > 0) {
			for(int i=0; i<userList.size(); i++) {
				if(primary != null && !("".equals(primary))) {
					primary = primary + "," + userList.get(i).getId();
				}else {
					primary = userList.get(i).getId().toString();
				}
				if(userList.get(i).getPid() != null && !("".equals(userList.get(i).getPid()))) {
					if(second != null && !("".equals(second))) {
						second = second + "," + userList.get(i).getPid();
					}else {
						second = userList.get(i).getPid().toString();
					}
				}
			}						
			if(second != null && !("".equals(second))) {
				third = userService.getThirdUser(second);
				if(third != null && !("".equals(third))) {
					ids = primary + "," + second + "," + third;
				}else {
					ids = primary + "," + second;
				}
			}else {
				ids = primary;
			}
		}
		//通过ids获取代理人信息
		if(ids.length() > 0) {
			List<User> agentList = userService.getAgentInfoByIds(ids);
			List<UserList> list = new ArrayList<UserList>();         
	        for(int i=0; i<agentList.size(); i++) {          
	            UserList agent = new UserList();   
	            agent.setOpenid(agentList.get(i).getOpenid());  
	            agent.setLang("zh-CN");                   
	            list.add(agent);
	        }
	        System.out.println(list);
	        JSONObject s = new JSONObject(); 
	        s.put("user_list", list);
	        System.out.println(s);
	        String accessToken = wxMpService.getAccessToken(false);
	        System.out.println("accesstoken"+accessToken);
	        JSONObject jsonObject = WeixinUtils.getBatchWeixinUserInfo(s.toString(), accessToken);
	        mv.addObject("agentMsg", jsonObject);
		}else {
			mv.addObject("agentMsg", null);
		}

		return mv;
	}

	//引导关注
	@RequestMapping(value="/follow", method=RequestMethod.GET)
	public String follow() {
		return "home/follow";
	}
	
	//引导客服
	@RequestMapping(value="/kefu", method=RequestMethod.GET)
	public String kefu() {
		return "home/kefu";
	}
	
	//爱棉人
	@RequestMapping(value="/system/lCotton", method=RequestMethod.GET)
	public ModelAndView lCotton() {
		ModelAndView mv = new ModelAndView("home/lCotton");
		String string = "lCotton";
		String sysvalue = systemService.getSystem(string);
		mv.addObject("sysvalue", sysvalue);
		return mv;
	}
	
	//致大地 致棉田
	@RequestMapping(value="/system/cottonField", method=RequestMethod.GET)
	public ModelAndView cottonField() {
		ModelAndView mv = new ModelAndView("home/cottonField");
		String string = "cottonField";
		String sysvalue = systemService.getSystem(string);
		mv.addObject("sysvalue", sysvalue);
		return mv;
	}
	
	//媒体报道
	@RequestMapping(value="/system/media", method=RequestMethod.GET)
	public ModelAndView media() {
		ModelAndView mv = new ModelAndView("home/media");
		String string = "media";
		String sysvalue = systemService.getSystem(string);
		mv.addObject("sysvalue", sysvalue);
		return mv;
	}
	
	//喜欢代理
	@RequestMapping(value="/system/likeAgent", method=RequestMethod.GET)
	public ModelAndView likeAgent() {
		ModelAndView mv = new ModelAndView("home/likeAgent");
		String string = "likeAgent";
		String sysvalue = systemService.getSystem(string);
		mv.addObject("sysvalue", sysvalue);
		return mv;
	}
	
	//联系棉花糖
	@RequestMapping(value="/system/contact", method=RequestMethod.GET)
	public ModelAndView contact() {
		ModelAndView mv = new ModelAndView("home/contact");
		String string = "contact";
		String sysvalue = systemService.getSystem(string);
		mv.addObject("sysvalue", sysvalue);
		return mv;
	}
	
	//常见问题
	@RequestMapping(value="/system/problem", method=RequestMethod.GET)
	public ModelAndView problem() {
		ModelAndView mv = new ModelAndView("home/problem");
		String string = "problem";
		String sysvalue = systemService.getSystem(string);
		mv.addObject("sysvalue", sysvalue);
		return mv;
	}
	
}