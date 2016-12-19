package com.zpt.shop.main.ctrler.home;

import java.math.BigDecimal;
import java.text.DecimalFormat;
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
import com.zpt.shop.common.weixin.UnifiedOrder;
import com.zpt.shop.common.weixin.WxMpConfigStorage;
import com.zpt.shop.main.entities.Cart;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.service.CartService;
import com.zpt.shop.main.service.OrderService;
import com.zpt.shop.main.service.WxMpService;
import com.zpt.shop.weixin.utils.GetWxOrderno;
import com.zpt.shop.weixin.utils.PrepayUtil;
import com.zpt.shop.weixin.utils.RequestHandler;
import com.zpt.shop.weixin.utils.Sha1Util;
import com.zpt.shop.weixin.utils.WeixinPayUtil;
import com.zpt.shop.weixin.utils.WeixinUtils;

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
	public ModelAndView cart() {
		ModelAndView mv = new ModelAndView("home/cart");
		int num = 0;
		BigDecimal price = new BigDecimal("0.0");
		int totalNum = 0;
		BigDecimal totalPrice = new BigDecimal("0.0");
		double total = 0.0d;
		String userId = "1";//先设置用户为1
		List<Cart> cartsList = cartService.getCartInfo(userId);
		if(cartsList != null && cartsList.size() > 0) {
			for(int i=0; i<cartsList.size(); i++) {
				num = cartsList.get(i).getNum();
				price = cartsList.get(i).getPrice();
				totalNum += num;
				totalPrice = price.multiply(new BigDecimal(num));
				total = totalPrice.add(new BigDecimal(total)).doubleValue();
			}
			DecimalFormat df = new DecimalFormat("#.00");  
			mv.addObject("totalNum", totalNum);
			mv.addObject("total", df.format(total));
			mv.addObject("cartsMsg", cartsList);	
		}else {
			mv.addObject("totalNum", "0");
			mv.addObject("total", "0.00");
			mv.addObject("cartsMsg", null);
		}
		return mv;
	}
	
	//添加购物车
	@ResponseBody
	@RequestMapping(value="/addCart", method=RequestMethod.POST)
	public Map<String,Object> addCart(String skuId, Integer num, String price) {
		Map<String,Object> map = new HashMap<String, Object>();
		String userId = "1";//先设置用户为1
		Integer amount = cartService.addGoodsIntoCart(userId, skuId, num, price);
		map.put("state", true);
		map.put("amount", amount);
		return map;
	}
	
	//删除购物车里的商品
	@ResponseBody
	@RequestMapping(value="/deleteGoods", method=RequestMethod.POST)
	public Map<String,Object> deleteGoods(String cartId) {
		Map<String,Object> map = new HashMap<String, Object>();
		int num = 0;
		BigDecimal price = new BigDecimal("0.0");
		int totalNum = 0;
		BigDecimal totalPrice = new BigDecimal("0.0");
		double total = 0.0d;
		String userId = "1";//先设置用户为1
		List<Cart> cartsList = cartService.deleteCartInfo(userId, cartId);
		if(cartsList != null && cartsList.size() > 0) {
			for(int i=0; i<cartsList.size(); i++) {
				num = cartsList.get(i).getNum();
				price = cartsList.get(i).getPrice();
				totalNum += num;
				totalPrice = price.multiply(new BigDecimal(num));
				total = totalPrice.add(new BigDecimal(total)).doubleValue();
			}
			DecimalFormat df = new DecimalFormat("#.00");  
			map.put("state", true);
			map.put("totalNum", totalNum);
			map.put("total", df.format(total));
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
	public Map<String,Object> modifyCart(String cartId, String skuId, Integer goodsNum, String goodsPrice) {
		Map<String,Object> map = new HashMap<String, Object>();
		int num = 0;
		BigDecimal price = new BigDecimal("0.0");
		int totalNum = 0;
		BigDecimal totalPrice = new BigDecimal("0.0");
		double total = 0.0d;
		String userId = "1";//先设置用户为1
		List<Cart> cartsList = cartService.modifyGoodsIntoCart(userId, cartId, skuId, goodsNum, goodsPrice);
		if(cartsList != null && cartsList.size() > 0) {
			for(int i=0; i<cartsList.size(); i++) {
				num = cartsList.get(i).getNum();
				price = cartsList.get(i).getPrice();
				totalNum += num;
				totalPrice = price.multiply(new BigDecimal(num));
				total = totalPrice.add(new BigDecimal(total)).doubleValue();
			}
			DecimalFormat df = new DecimalFormat("#.00"); 
			map.put("state", true);
			map.put("totalNum", totalNum);
			map.put("total", df.format(total));
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
	@RequestMapping(value="/buyImmediately/{skuId}/{num}/{price}", method=RequestMethod.POST)
	public ModelAndView buyImmediately(@PathVariable("skuId")Integer skuId, @PathVariable("num")Integer num, @PathVariable("price")String price) {
		ModelAndView mv = new ModelAndView("home/index");
		return mv;
	}
	
	//结算（从购物车过来的购买）
	@RequestMapping(value="/buyGoods", method=RequestMethod.POST)
	public ModelAndView buyGoods(HttpServletRequest request, HttpServletResponse response, String cartIds) throws Exception {
		ModelAndView mv = new ModelAndView("home/order");
		int num = 0;
		BigDecimal price = new BigDecimal("0.0");
		BigDecimal totalPrice = new BigDecimal("0.0");
		double total = 0.0d;
		User user = (User) request.getSession().getAttribute("user");
		List<Cart> cartsList = cartService.getCartByCartIds(user.getId().toString(), cartIds);
		for(int i=0; i<cartsList.size(); i++) {
			num = cartsList.get(i).getNum();
			price = cartsList.get(i).getPrice();
			totalPrice = price.multiply(new BigDecimal(num));
			total = totalPrice.add(new BigDecimal(total)).doubleValue();
		}
		DecimalFormat df = new DecimalFormat("#.00");
     
        //订单号
        String code1 = RandomArray.randomArray(0, 9, 2);
        String code2 = RandomArray.randomArray(0, 9, 2);
        String myTime = MyTime.getNowFormatDate();
		String ordercode = code1 + myTime + code2;
		
		RequestHandler reqHandler = new RequestHandler(request, response); 

		//初始化  
		reqHandler.init();  
		reqHandler.init(weixin.getAppId(), weixin.getSecret(), weixin.getPartnerKey());  
		
        //获取预支付标示 
        SortedMap<String, String> packageParams = new TreeMap<String, String>();
        packageParams.put("appId", weixin.getAppId());  
        packageParams.put("mch_id", "mch_id");//商户号   
        packageParams.put("nonce_str", WeixinPayUtil.getNonceStr());//随机字符串   
        packageParams.put("body", "一见喜-商品订单");//商品描述 
        packageParams.put("out_trade_no", ordercode);//商户订单号
        packageParams.put("total_fee", WeixinPayUtil.getMoney(String.valueOf(total)));//标价金额
        packageParams.put("spbill_create_ip", request.getRemoteAddr());//订单生成的机器IP，指用户浏览器端IP  
        packageParams.put("notify_url", notifyurl);//支付回调地址  
        packageParams.put("trade_type", "JSAPI");//交易类型 
        packageParams.put("openid", user.getOpenid()); 
		
        //获取package包  
        String packageValue = reqHandler.genPackage(packageParams);  
        String noncestr = Sha1Util.getNonceStr();  
        String timestamp = Sha1Util.getTimeStamp();  
        
        //组装map用于生成sign  
        SortedMap<String, String> signParams = new TreeMap<String, String>();
		signParams.put("appid", weixin.getAppId());  
		signParams.put("noncestr", noncestr);  
		signParams.put("package", packageValue);  
		signParams.put("timestamp", timestamp);  
		String sign = Sha1Util.createSHA1Sign(signParams);  
        
		//增加非参与签名的额外参数  
		signParams.put("paySign", sign);  
		signParams.put("signType", "SHA1");
        
        //支付接口所需的参数
		mv.addObject("appId", weixin.getAppId());//公众号id
		mv.addObject("timeStamp", System.currentTimeMillis());//当前的时间
		mv.addObject("nonceStr", WeixinPayUtil.getNonceStr());//随机字符串，不长于32位。
		mv.addObject("prepay_id", packageValue);//统一下单接口返回的prepay_id参数值，提交格式如：prepay_id=***
		System.out.println("packageValue"+packageValue);
		mv.addObject("paySign", sign);//签名
		
		//订单数据
		mv.addObject("cartIds", cartIds);
		mv.addObject("total", df.format(total));
		mv.addObject("cartsMsg", cartsList);
		mv.addObject("ordercode", ordercode);//订单号
		return mv;
	}
	
	//支付（从详细页过来的支付）
	@RequestMapping(value="/payment", method=RequestMethod.POST)
	public ModelAndView payment(HttpServletRequest request, HttpServletResponse response, Integer orderId) throws Exception {
		ModelAndView mv = new ModelAndView("home/order-payment");
        String url = request.getRequestURL().toString();//当前页面路径
        System.out.println("当前页面路径:"+url);
        System.out.println("orderId:"+orderId);
        User user = (User) request.getSession().getAttribute("user");
        List<Order> orderList = orderService.getOrderByOrderId(orderId);
        
        RequestHandler createSign = new RequestHandler(request, response);
	    //初始化  
        createSign.init();  
        createSign.init(weixin.getAppId(), weixin.getSecret(), "1234567890poiuytrewqasdfghjklmnb");  
    
        //订单号
        String code1 = RandomArray.randomArray(0, 9, 2);
        String code2 = RandomArray.randomArray(0, 9, 2);
        String myTime = MyTime.getNowFormatDate();
        String ordercode = code1 + myTime + code2;
        
        String noncestr = Sha1Util.getNonceStr();  //随机字符串
        String timestamp = Sha1Util.getTimeStamp(); //当前时间
        
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
        map.put("mch_id", "1237966102");  
        map.put("attach", "一见喜商品购买");  
        map.put("device_info", "WEB");  
        map.put("nonce_str", noncestr);  
        map.put("body", "一见喜-商品订单");  
        map.put("out_trade_no", ordercode);  
        map.put("total_fee", WeixinPayUtil.getMoney(String.valueOf(orderList.get(0).getTotalPrice())));  
        map.put("spbill_create_ip", "115.159.26.174");  
        map.put("trade_type", "JSAPI");  
        map.put("notify_url", notifyurl);  
        map.put("openid", user.getOpenid());  
        String sign = PrepayUtil.sign(map, "1234567890poiuytrewqasdfghjklmnb");//参数加密  
        System.out.println("支付签名:-----------"+sign);  
        map.put("sign", sign);  
        String content = PrepayUtil.MapToXml(map); 
        String preid = GetWxOrderno.getPayNo("https://api.mch.weixin.qq.com/pay/unifiedorder",  content);
        
        //组装map用于生成paySign 
        SortedMap<String, String> payParams = new TreeMap<String, String>();
        payParams.put("appId", weixin.getAppId());  
        payParams.put("timeStamp", timestamp);
        payParams.put("nonceStr", noncestr);  
        payParams.put("package", preid);  
        payParams.put("signType", "MD5");
        String paySign = createSign.createSign(payParams);  
        
        //组装map用于生成addrSign 
        String accessToken = wxMpService.getAccessToken(false);
        SortedMap<String, String> addrParams = new TreeMap<String, String>();
        addrParams.put("appId", weixin.getAppId());  
        addrParams.put("url", url);  
        addrParams.put("timeStamp", timestamp);
        addrParams.put("nonceStr", noncestr);  
        addrParams.put("accessToken", accessToken);  
        String addrSign = createSign.createSign(addrParams);  
        
        //支付接口公用参数
        mv.addObject("appId", weixin.getAppId());//公众号id
        mv.addObject("timeStamp", timestamp);//当前的时间
        mv.addObject("nonceStr", noncestr);//随机字符串，不长于32位   
        
        mv.addObject("signature", signature);//config签名
        
        mv.addObject("prepay_id", preid);//统一下单接口返回的prepay_id参数值，提交格式如：prepay_id=***
        mv.addObject("paySign", paySign);//支付签名
        
        mv.addObject("addrSign", addrSign);//编辑地址签名
        
        //订单数据
        mv.addObject("orderId", orderId);
        mv.addObject("orderMsg", orderList);
        mv.addObject("ordercode", ordercode);//订单号
        return mv;
	}
	
	//我的地址
	@ResponseBody
	@RequestMapping(value="/myAddr", method=RequestMethod.POST)
	public ModelAndView myAddr() throws Exception {
		ModelAndView mv = new ModelAndView("home/my-addr");
		return mv;
	}
	
	//提交订单
	//若未付款，跳到订单详细页
	@RequestMapping(value="/submitOrder", method=RequestMethod.POST)
	public ModelAndView submitOrder(HttpServletRequest request, HttpServletResponse response, String postData, String cartIds, String state) {
		ModelAndView mv = new ModelAndView("home/order-detail");		
		User user = (User) request.getSession().getAttribute("user");
		if("0".equals(state)) {//从我的订单过来的付款			
			//添加订单
			Order order = (Order) JSON.parseObject(postData, Order.class);
			orderService.addOrder(user.getId(), order, cartIds);
		}else if("1".equals(state)) {//从购物车过来的付款
			
		}
		//查询订单详情
		List<Order> orderList = orderService.getOrderDetail(user.getId());
		mv.addObject("orderMsg", orderList);
		
		return mv;
	}
	
	//订单详细页
	@RequestMapping(value="/orderDetail", method=RequestMethod.GET)
	public ModelAndView orderDetail(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("home/order-detail");			
		User user = (User) request.getSession().getAttribute("user");
		//查询订单详情
		List<Order> orderList = orderService.getOrderDetail(1);
		mv.addObject("orderMsg", orderList);
		return mv;
	}
	
}