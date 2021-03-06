package com.zpt.shop.main.ctrler.management;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.pojo.Msg;
import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Distribution;
import com.zpt.shop.main.entities.Withdraw;
import com.zpt.shop.main.service.DistributionService;
import com.zpt.shop.main.service.WithdrawService;

@Controller
@RequestMapping("/management/wdcash")
public class WdCashCtrler {
	
	@Autowired
	private WithdrawService withdrawService;
	
	@Autowired
	private DistributionService distributionService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public String index(){
		return "/management/wdcash/index";
	}
	
	@ResponseBody
	@RequestMapping(value = "listData",method = RequestMethod.POST)
	public Page<Withdraw> listData(Query<Withdraw> query){
		Page<Withdraw> page = withdrawService.page(query);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/validate",method = RequestMethod.POST)
	public boolean validate(Withdraw withdraw){
		boolean flag = false;
		try {
			flag = withdrawService.validate(withdraw);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value = "/updateState",method = RequestMethod.POST)
	public Msg update(Withdraw withdraw,BigDecimal usermoney,String openid){
		Msg msg = new Msg();
		try {
			String code_des = withdrawService.updateState(withdraw,usermoney,openid);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.UPDATE_SUCCESS);
			if(code_des!=null&&code_des!=""){
				msg.setCode_des(code_des);
			}
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
	@RequestMapping(value = "/seeWithdraw",method = RequestMethod.POST)
	public List<Distribution> see(Integer userId){
		List<Distribution> list = null;
		try {
			list = distributionService.seeWithdraw(userId);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
}
