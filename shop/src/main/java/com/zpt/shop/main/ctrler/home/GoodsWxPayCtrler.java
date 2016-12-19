package com.zpt.shop.main.ctrler.home;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.PayCallback;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.service.GoodsService;
import com.zpt.shop.main.service.OrderService;
import com.zpt.shop.weixin.utils.WeixinUtils;
/**
 * 功能说明:
 * 
 * 微信支付回调地址
 *
 * GoodsWxPayCtrler.java
 *
 * Original Author: 林敏,2016年12月10日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
@Controller
@RequestMapping("/goodsWsPay")
public class GoodsWxPayCtrler {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private GoodsService goodsService;

	@ResponseBody
	@RequestMapping("/result")
    public String index(HttpServletRequest request){
        try {
            Map<String, String> map = getCallbackParams(request);
            if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
                String ordercode = map.get("out_trade_no");
                //这里写成功后的业务逻辑
                //付款状态改为1
     			orderService.updateOrderState(ordercode);
     			//增加购买人数
     			List<Sku> goodsidList = orderService.getOrderByOrderNum(ordercode);
     			for(int i=0; i<goodsidList.size(); i++) {
     				Goods goods = goodsService.getGoodsById(goodsidList.get(i).getGoodsId());
     				goodsService.updateNum(goodsidList.get(i).getGoodsId(), goods.getNum()+1);
     			}
             }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return getPayCallback(); 
    }
	
	/**
     * 获取请求参数
     * @Title: getCallbackParams
     * @Description: TODO
     * @param @param request
     * @param @return
     * @param @throws Exception    
     * @return Map<String,String>    
     * @throws
     */
    public Map<String, String> getCallbackParams(HttpServletRequest request)
            throws Exception {
    	System.out.println("~~~~~~~~~~~~~~~~付款成功~~~~~~~~~~~~~~~~");
        return WeixinUtils.parseXml(request);     
    }
    
    /**
     * 生成收到支付结果的确认信息
     * @Title: getPayCallback
     * @Description: TODO
     * @param @return    
     * @return String    
     * @throws
     */
    public String getPayCallback(){
    	PayCallback callback = new PayCallback();
    	String xml = WeixinUtils.payCallbackToXml(callback);
    	System.out.println("生成收到支付结果的确认信息" + xml);
        return xml;
    }
    
}