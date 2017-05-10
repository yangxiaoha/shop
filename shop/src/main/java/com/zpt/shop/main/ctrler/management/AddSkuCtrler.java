package com.zpt.shop.main.ctrler.management;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.pojo.Msg;
import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.service.GoodsService;
import com.zpt.shop.main.service.SkuService;

@Controller
@RequestMapping("/management/addSku")
public class AddSkuCtrler {
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private SkuService skuService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public ModelAndView index(Integer goodsId){
		ModelAndView mv = new ModelAndView();
		Goods goods = goodsService.getGoodsId(goodsId);
		mv.setViewName("/management/addSku/index");
		mv.addObject("goodsId", goodsId);
		mv.addObject("goodsM", goods);		
		return mv;		
	}
	
	@ResponseBody
	@RequestMapping(value = "/validate",method = RequestMethod.POST)
	public boolean validate(Sku sku){
		boolean flag = false;
		try {
			flag = skuService.validate(sku);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;		
	}
	
	@ResponseBody
	@RequestMapping(value = "/addSku",method = RequestMethod.POST)
	public Msg addSku(Sku sku,String proId,String value,HttpServletRequest request, HttpSession session){
		Msg msg = new Msg();
		try {
			String[] sproId = proId.split(",");
			Integer[] proIds = new Integer[sproId.length];
			for (int i = 0; i < sproId.length; i++) {
				proIds[i] = Integer.valueOf(sproId[i]);
			}
			String[] values = value.split(",");
			skuService.insertSku(sku,proIds, values, request, session);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.ADD_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.ADD_LOST);
			return msg;			
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateState",method = RequestMethod.POST)
	public Msg updateState(Integer id,Integer state){
		Msg msg = new Msg();
		try {
			goodsService.updateState(id, state);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.UPDATE_STATE_SUCCESS);
			return msg;
		} catch (Exception e) {
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.UPDATE_STATE_LOST);			
			return msg;
		}
	}
}
