package com.zpt.shop.main.ctrler.home;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

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

import com.alibaba.fastjson.JSON;
import com.zpt.shop.common.pojo.MyTime;
import com.zpt.shop.common.pojo.RandomArray;
import com.zpt.shop.common.weixin.WxMpConfigStorage;
import com.zpt.shop.main.entities.Cart;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.service.CartService;
import com.zpt.shop.main.service.OrderService;
import com.zpt.shop.main.service.SkuService;
import com.zpt.shop.main.service.WxMpService;
import com.zpt.shop.weixin.utils.GetWxOrderno;
import com.zpt.shop.weixin.utils.PrepayUtil;
import com.zpt.shop.weixin.utils.Sha1Util;
import com.zpt.shop.weixin.utils.WeixinPayUtil;

/**
 * 功能说明:
 *
 * PurchaseCtrler.java
 *
 * Original Author: 林敏,2016年11月28日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Controller
@RequestMapping("home/purchase")
public class PurchaseCtrler {
	
	private static Logger logger = LogManager.getLogger(PurchaseCtrler.class.getName());
	
	@Autowired
	private SkuService skuService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
    private WxMpService wxMpService;
	
	@Autowired
	private WxMpConfigStorage weixin;
	
	//微信支付成功后通知地址 必须要求80端口并且地址不能带参数
	private static String notifyurl = "http://xz.zptmall.com/shop/goodsWsPay/result";
	
	//购物车页面
	@RequestMapping(value="/cart", method=RequestMethod.GET)
	public ModelAndView cart(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("home/cart");
		//int num = 0;
		//int totalNum = 0;
		BigDecimal total = new BigDecimal("0.0");
		User user = (User) request.getSession().getAttribute("user");
		Integer userId = user.getId();//先设置用户为1
		List<Cart> cartsList = cartService.getCartInfo(userId.toString());
		if(cartsList != null && cartsList.size() > 0) {
			for(int i=0; i<cartsList.size(); i++) {
				//num = cartsList.get(i).getNum();
				//totalNum += num;
				total= total.add(cartsList.get(i).getTotalprice());
			}
			mv.addObject("state", 0);
			mv.addObject("totalNum", cartsList.size());
			mv.addObject("total", total.toString());
			mv.addObject("cartsMsg", cartsList);	
		}else {
			mv.addObject("state", 0);
			mv.addObject("totalNum", "0");
			mv.addObject("total", "0.00");
			mv.addObject("cartsMsg", null);
		}
		return mv;
	}
	
	//添加购物车
	@ResponseBody
	@RequestMapping(value="/addCart", method=RequestMethod.POST)
	public Map<String,Object> addCart(HttpServletRequest request, String skuId, Integer num, String price) {
		Map<String,Object> map = new HashMap<String, Object>();
		User user = (User) request.getSession().getAttribute("user");
		String userId = user.getId().toString();//先设置用户为1
		Integer amount = cartService.addGoodsIntoCart(userId, skuId, num, price);
		map.put("state", true);
		map.put("amount", amount);
		return map;
	}
	
	//删除购物车里的商品
	@ResponseBody
	@RequestMapping(value="/deleteGoods", method=RequestMethod.POST)
	public Map<String,Object> deleteGoods(HttpServletRequest request, String cartId) {
		Map<String,Object> map = new HashMap<String, Object>();
		//int num = 0;
		//int totalNum = 0;
		BigDecimal total = new BigDecimal("0.0");
		User user = (User) request.getSession().getAttribute("user");
		String userId = user.getId().toString();//先设置用户为1
		List<Cart> cartsList = cartService.deleteCartInfo(userId, cartId);
		if(cartsList != null && cartsList.size() > 0) {
			for(int i=0; i<cartsList.size(); i++) {
				//num = cartsList.get(i).getNum();
				//totalNum += num;
				total= total.add(cartsList.get(i).getTotalprice());
			}
			map.put("state", true);
			map.put("totalNum", cartsList.size());
			map.put("total", total.toString());
			map.put("cartsMsg", cartsList);
		}else {
			map.put("state", true);
			map.put("totalNum", "0");
			map.put("total", "0.00");
			map.put("cartsMsg", null);
		}
		return map;
	}
	
	//修改购物车
	@ResponseBody
	@RequestMapping(value="/modifyCart", method=RequestMethod.POST)
	public Map<String,Object> modifyCart(HttpServletRequest request, String cartId, String skuId, Integer goodsNum, String goodsPrice) {
		Map<String,Object> map = new HashMap<String, Object>();
		//int num = 0;
		//int totalNum = 0;
		BigDecimal total = new BigDecimal("0.0");
		User user = (User) request.getSession().getAttribute("user");
		String userId = user.getId().toString();//先设置用户为1
		//判断购物车是否有此商品		
		List<Cart> cartsList = cartService.modifyGoodsIntoCart(userId, cartId, skuId, goodsNum, goodsPrice);
		if(cartsList != null && cartsList.size() > 0) {
			for(int i=0; i<cartsList.size(); i++) {
				//num = cartsList.get(i).getNum();
				//totalNum += num;
				total= total.add(cartsList.get(i).getTotalprice());
			}
			map.put("state", true);
			map.put("totalNum", cartsList.size());
			map.put("total", total.toString());
			map.put("cartsMsg", cartsList);	
		}else {
			map.put("state", true);
			map.put("totalNum", "0");
			map.put("total", "0.00");
			map.put("cartsMsg", null);
		}
		return map;
	}
	
	//立即购买
	@RequestMapping(value="/buyImmediately/{skuId}/{num}", method=RequestMethod.GET)
	public ModelAndView buyImmediately(HttpServletRequest request, @PathVariable("skuId")String skuId, @PathVariable("num")Integer goodsNum) {
		ModelAndView mv = new ModelAndView("home/cart");
		//立即购买的商品放入购物车内
		List<Sku> sku = skuService.getSkuInfoByIds(skuId);
		//int num = 0;
		//int totalNum = 0;
		String goodsPrice = sku.get(0).getPrice().toString();
		BigDecimal total = new BigDecimal("0.0");
		User user = (User) request.getSession().getAttribute("user");
		String userId = user.getId().toString();
		Integer amount = cartService.addGoodsIntoCart(userId, skuId, goodsNum, goodsPrice);
		List<Cart> cartsList = cartService.getCartInfo(userId);
		if(cartsList != null && cartsList.size() > 0) {
			for(int i=0; i<cartsList.size(); i++) {
				//num = cartsList.get(i).getNum();
				//totalNum += num;
				total= total.add(cartsList.get(i).getTotalprice());
			}
			mv.addObject("state", 1);
			mv.addObject("totalNum", cartsList.size());
			mv.addObject("total", total.toString());
			mv.addObject("cartsMsg", cartsList);	
		}else {
			mv.addObject("state", 1);
			mv.addObject("totalNum", "0");
			mv.addObject("total", "0.00");
			mv.addObject("cartsMsg", null);
		}	
		return mv;
	}
	
	//支付（从详细页过来的支付）
	@RequestMapping(value="/payment")
	public ModelAndView payment(HttpServletRequest request, HttpServletResponse response, Integer orderId, String orderNum, String cartIds, String totalMoney) throws Exception {
		ModelAndView mv = new ModelAndView("home/order-payment");

		String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() 
                + path;
        String url = basePath + "/home/purchase/payment";
        System.out.println("当前页面路径:"+url);
        
        User user = (User) request.getSession().getAttribute("user");  
        
        String ordercode = "";
        
        //下单金额
        String money = "";
        if(cartIds != null) {
        	money = totalMoney;
        	
            //订单号
            String code1 = RandomArray.randomArray(0, 9, 2);
            String code2 = RandomArray.randomArray(0, 9, 2);
            String myTime = MyTime.getNowFormatDate();
            ordercode = code1 + myTime + code2;
            
        	List<Cart> cartsList = cartService.getCartInfoById(cartIds);
            //订单数据
        	mv.addObject("state", 0);
        	mv.addObject("money", money);
        	mv.addObject("cartIds", cartIds);
            mv.addObject("cartsMsg", cartsList);
            mv.addObject("ordercode", ordercode);//订单号
        }else {
        	ordercode = orderNum;
            List<Order> orderList = orderService.getOrderByOrderId(orderId);
            money = String.valueOf(orderList.get(0).getTotalPrice());
            //订单数据
            mv.addObject("state", 1);
            mv.addObject("orderId", orderId);
            mv.addObject("orderMsg", orderList);
            mv.addObject("ordercode", ordercode);//订单号
        }
        
        String noncestr = Sha1Util.getNonceStr(); //随机字符串
        String timestamp = Sha1Util.getTimeStamp(); //当前时间
        
        System.out.println(ordercode);
        
        //config验证
        String JsapiTicket = wxMpService.getJsapiTicket(false);
        SortedMap<String, String> configParame = new TreeMap<String, String>();
        configParame.put("noncestr", noncestr);  
        configParame.put("jsapi_ticket", JsapiTicket);  
        configParame.put("timestamp", timestamp);  
        configParame.put("url", url);  
        String signature = Sha1Util.createSHA1Sign(configParame);
        
        //获取预支付标示 
        HashMap<String, String> map = new HashMap<String, String>();  
        map.put("appid", weixin.getAppId());  
        map.put("mch_id", weixin.getPartnerId());  
        map.put("attach", "一见喜商品购买");  
        //map.put("device_info", "WEB");  
        map.put("nonce_str", noncestr);  
        map.put("body", "一见喜-商品订单");  
        map.put("out_trade_no", ordercode);  
        map.put("total_fee", WeixinPayUtil.getMoney(money));  
        map.put("spbill_create_ip", "115.159.26.174");  
        map.put("trade_type", "JSAPI");  
        map.put("notify_url", notifyurl);  
        map.put("openid", user.getOpenid());  
        String sign = PrepayUtil.sign(map, weixin.getPartnerKey());//参数加密  
        System.out.println("支付签名:-----------"+sign);  
        map.put("sign", sign);  
        String content = PrepayUtil.MapToXml(map); 
        System.out.println("---------------------------------------");
        System.out.println(content);
        System.out.println("---------------------------------------");
        String preid = GetWxOrderno.getPayNo("https://api.mch.weixin.qq.com/pay/unifiedorder",  content);
        
        //组装map用于生成paySign 
        SortedMap<String, String> payParams = new TreeMap<String, String>();
        payParams.put("appId", weixin.getAppId());  
        payParams.put("timeStamp", timestamp);
        payParams.put("nonceStr", noncestr);  
        payParams.put("package", "prepay_id="+preid);  
        payParams.put("signType", "MD5");
        String paySign = PrepayUtil.sign(payParams, weixin.getPartnerKey());
        
        //组装map用于生成addrSign 
        String accessToken = wxMpService.getAccessToken(false);
        SortedMap<String, String> addrParams = new TreeMap<String, String>();
        addrParams.put("appid", weixin.getAppId());  
        addrParams.put("url", url);  
        addrParams.put("timestamp", timestamp);
        addrParams.put("noncestr", noncestr);  
        addrParams.put("accesstoken", accessToken);  
        String addrSign = Sha1Util.createSHA1Sign(addrParams);  
        
        //支付接口公用参数
        mv.addObject("appId", weixin.getAppId());//公众号id
        mv.addObject("timeStamp", timestamp);//当前的时间
        mv.addObject("nonceStr", noncestr);//随机字符串，不长于32位   
        
        mv.addObject("signature", signature);//config签名
        
        mv.addObject("prepay_id", "prepay_id="+preid);//统一下单接口返回的prepay_id参数值，提交格式如：prepay_id=***
        mv.addObject("paySign", paySign);//支付签名
        
        mv.addObject("addrSign", addrSign);//编辑地址签名
        
        return mv;
	}
	
	//提交订单
	//若未付款，跳到订单详细页
	@ResponseBody
	@RequestMapping(value="/submitOrder", method=RequestMethod.POST)
	public void submitOrder(HttpServletRequest request, HttpServletResponse response, String postData, Integer orderId, String cartIds, String state) {
		//ModelAndView mv = new ModelAndView("home/order-detail");		
		User user = (User) request.getSession().getAttribute("user");
		Order order = (Order) JSON.parseObject(postData, Order.class);
		System.out.println("订单地址:-----------"+order.getAddress()); 
		System.out.println("订单provinceName:-----------"+order.getProvinceName()); 
		System.out.println("订单cityName:-----------"+order.getCityName()); 
		System.out.println("订单countryName:-----------"+order.getCountryName()); 
		System.out.println("订单postalCode:-----------"+order.getPostalCode()); 
		if("0".equals(state)) {//从我的购物车过来的付款			
			//添加订单
			System.out.println("添加订单信息:-----------"); 
			orderService.addOrder(user.getId(), order, cartIds);
		}else if("1".equals(state)) {//从订单过来的付款
			//修改订单
			order.setUserId(user.getId());
			order.setId(orderId);
			System.out.println("修改订单信息:-----------"); 
			orderService.updateOrder(order);
		}
		//查询订单详情
		//List<Order> orderList = orderService.getOrderDetail(user.getId());
		//mv.addObject("orderMsg", orderList);
		
		//return mv;
	}
	
	//订单详细页
	@RequestMapping(value="/orderDetail", method=RequestMethod.GET)
	public ModelAndView orderDetail(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("home/order-detail");			
		User user = (User) request.getSession().getAttribute("user");
		//超过半小时还未支付的订单视为订单关闭
		try {
			orderService.closeOrder();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//查询订单详情
		List<Order> orderList = orderService.getOrderDetail(user.getId());
		mv.addObject("orderMsg", orderList);
		return mv;
	}
	
	//确认收货
	@RequestMapping(value="/receipt/{orderId}", method=RequestMethod.GET)
	public ModelAndView receipt(@PathVariable("orderId")Integer orderId) {
		ModelAndView mv = new ModelAndView("home/order-detail");
		Integer state = 4;
		List<Order> orderList = orderService.updateOrderStateByOrderId(orderId, state);
		mv.addObject("orderMsg", orderList);
		return mv;
	}
	
}