package com.zpt.shop.main.ctrler.home;

import java.io.BufferedOutputStream;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.Order;
import com.zpt.shop.main.entities.OrderDetail;
import com.zpt.shop.main.entities.PayCallback;
import com.zpt.shop.main.entities.Percentage;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.service.DistributionService;
import com.zpt.shop.main.service.GoodsService;
import com.zpt.shop.main.service.OrderDetailService;
import com.zpt.shop.main.service.OrderService;
import com.zpt.shop.main.service.PercentageService;
import com.zpt.shop.main.service.UserService;
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
	private OrderDetailService orderDetailService;
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private DistributionService distributionService;
	
	@Autowired
	private PercentageService percentageService;

	@ResponseBody
	@RequestMapping("/result")
    public String index(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String resXml = "";
		
        try {
            Map<String, String> map = getCallbackParams(request);
            if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
            	
            	resXml = "<xml>" + "<return_code><![CDATA[SUCCESS]]></return_code>"
    					+ "<return_msg><![CDATA[OK]]></return_msg>" + "</xml> ";
            	
                String ordercode = map.get("out_trade_no");
                System.out.println(ordercode);
                //这里写成功后的业务逻辑
                //付款状态改为2(支付未发货)
                Integer state = 2;
     			orderService.updateOrderState(ordercode, state);
     			
     			//增加购买人数
     			//List<Sku> goodsidList = skuService.getOrderByOrderNum(ordercode);
     			List<OrderDetail> goodsidList = orderDetailService.getOrderByOrderNum(ordercode);
     			if(goodsidList != null && goodsidList.size() > 0) {
         			for(int i=0; i<goodsidList.size(); i++) {
         				Goods goods = goodsService.getGoodsById(goodsidList.get(i).getGoodsId());
         				goodsService.updateNum(goodsidList.get(i).getGoodsId(), goods.getNum()+1);        				
         			}
     			}
     			
     			//上级提现金额计算
     			Percentage percentage = percentageService.getPercentage();
     			Order order = orderService.getOrderInfoByCode(ordercode);
     			User user = userService.getUserByUserId(order.getUserId());
     			
     			Integer pid = 0;
     			BigDecimal orderMoney = order.getTotalPrice();//订单金额
     			
     			if(pid != user.getPid()) {//一级
     				User superior = userService.getUserByUserId(user.getPid());//上级信息
     				BigDecimal percentageMoney = orderMoney.multiply(percentage.getFirst().divide(new BigDecimal("100")));
     				BigDecimal money = superior.getMoney().add(percentageMoney);
     				userService.updateMoney(superior.getId(), money);
     				//添加分销信息
     				distributionService.addDistribution(superior.getId(), order.getId(), percentageMoney);
     				if(pid != superior.getPid()) {//二级
     					User superiorInfo = userService.getUserByUserId(superior.getPid());//上级的上级的信息
         				BigDecimal percentageMoneyInfo = orderMoney.multiply(percentage.getSecond().divide(new BigDecimal("100")));
         				BigDecimal moneyInfo = superiorInfo.getMoney().add(percentageMoneyInfo);
         				userService.updateMoney(superiorInfo.getId(), moneyInfo);
         				//添加分销信息
         				distributionService.addDistribution(superiorInfo.getId(), order.getId(), percentageMoneyInfo);
         				if(pid != superiorInfo.getPid()) {//三级
         					User superiorInfo2 = userService.getUserByUserId(superiorInfo.getPid());//上级的上级的上级的信息
         					BigDecimal percentageMoneyInfo2 = orderMoney.multiply(percentage.getThird().divide(new BigDecimal("100")));
         					BigDecimal moneyInfo2 = superiorInfo2.getMoney().add(percentageMoneyInfo2);
         					userService.updateMoney(superiorInfo2.getId(), moneyInfo2);
             				//添加分销信息
             				distributionService.addDistribution(superiorInfo2.getId(), order.getId(), percentageMoneyInfo2);
         				}
     				}
     			}
             }else {
     			resXml = "<xml>" + "<return_code><![CDATA[FAIL]]></return_code>"
    					+ "<return_msg><![CDATA[报文为空]]></return_msg>" + "</xml> ";
    		}
        } catch (Exception e) {
            e.printStackTrace();
        }
        /*return getPayCallback(); */
        BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
		out.write(resXml.getBytes());
		out.flush();
		out.close();
		// 更新数据库的状态
		return null;
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