
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
import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Goods;
import com.zpt.shop.main.entities.Sku;
import com.zpt.shop.main.service.GoodsService;
import com.zpt.shop.main.service.SkuService;
import com.zpt.shop.main.service.StockService;

@Controller
@RequestMapping("/management/sku")
public class SkuCtrler {
	
	@Autowired
	private GoodsService goodsService;
	
	@Autowired
	private SkuService skuService;
	
	@Autowired
	private StockService stockService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public ModelAndView index(Integer goodsId,String pageinit){
		ModelAndView mv = new ModelAndView();
		Goods goods = goodsService.getGoodsId(goodsId);
		mv.setViewName("/management/sku/index");		
		mv.addObject("goodsM", goods);
		mv.addObject("pageinitM",pageinit);
		return mv;		
	}
	
	@ResponseBody
	@RequestMapping(value = "listData",method = RequestMethod.POST)
	public Page<Sku> listDate(Query<Sku> query,Integer goodsId){
		query.getObj().setGoodsId(goodsId);
		Page<Sku> page = skuService.page(query);
		return page;
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
	@RequestMapping(value = "/add",method = RequestMethod.POST)
	public Msg add(Sku sku,String proId,String value,HttpServletRequest request, HttpSession session){
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
//	
//	@ResponseBody
//	@RequestMapping(value ="/delete",method = RequestMethod.POST)
//	public Msg delete(String ids){
//		Msg msg = new Msg();
//		try {
//			skuService.deleteSku(ids);
//			msg.setState(Contants.RETURN_INT_SUCCESS);
//			msg.setMsg(Contants.RETURN_STRING_SUCCESS);
//			return msg;
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//			msg.setState(Contants.RETURN_INT_FAIL);
//			msg.setMsg(Contants.RETURN_STRING_EXCEPTION_FAIL);			
//			return msg;
//		}
//	}
	
	@ResponseBody
	@RequestMapping(value = "/updateAdd",method = RequestMethod.POST)
	public Msg updateAdd(Integer skuId,Integer num,String batch,Integer goodsId){
		Msg msg = new Msg();
		try {
			stockService.insertStock(skuId,num,batch,goodsId);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.UPDATE_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.UPDATE_LOST);			
			return msg;
		}
	}	
	
	@ResponseBody
	@RequestMapping(value = "/update",method = RequestMethod.POST)
	public Msg update(Sku sku, String proId,String value,HttpServletRequest request, HttpSession session){
		Msg msg = new Msg();
		try {
			String[] sproId = proId.split(",");
			Integer[] proIds = new Integer[sproId.length];
			for (int i = 0; i < sproId.length; i++) {
				proIds[i] = Integer.valueOf(sproId[i]);
			}
			String[] values = value.split(",");
			skuService.updateSku(sku, proIds, values, request, session);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.UPDATE_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.UPDATE_LOST);			
			return msg;
		}
	}
}