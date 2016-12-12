package com.zpt.shop.main.ctrler.management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zpt.shop.common.pojo.Contants;
import com.zpt.shop.common.pojo.Msg;
import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Reply;
import com.zpt.shop.main.service.ReplyService;

@Controller
@RequestMapping("/management/reply")
public class ReplyCtrler {
	
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public String index(){
		return "/management/reply/index";	
	}
	
	@ResponseBody
	@RequestMapping(value = "listData",method = RequestMethod.POST)
	public Page<Reply> listData(Query<Reply> query){
		Page<Reply> page = replyService.page(query);
		return page;
	}
	
	@ResponseBody
	@RequestMapping(value = "/validate",method = RequestMethod.POST)
	public boolean validate(Reply reply){
		boolean flag = false;
		try {
			flag = replyService.validate(reply);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return flag;
	}
	
	@ResponseBody
	@RequestMapping(value = "/add",method = RequestMethod.POST)
	public Msg add(Reply reply){
		Msg msg = new Msg();
		try {
			replyService.insertBrand(reply);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.ADD_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.ADD_LOST);
			return msg;
		}		
	}
	
	@ResponseBody
	@RequestMapping(value = "/update",method = RequestMethod.POST)
	public Msg update(Reply reply){
		Msg msg = new Msg();
		try {
			replyService.updateBrand(reply);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.UPDATE_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.UPDATE_LOST);	
			return msg;
		}		
	}
	@ResponseBody
	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	public Msg delete(String ids){
		Msg msg = new Msg();
		try {
			replyService.deleteBrand(ids);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.DELETE_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.DELTET_LOST);		
			return msg;
		}		
	}
}
