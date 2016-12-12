package com.zpt.shop.main.ctrler.management;

import java.util.List;

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
import com.zpt.shop.main.entities.Banner;
import com.zpt.shop.main.service.BannerService;

@Controller
@RequestMapping("/management/banner")
public class BannerCtrler {
	
	@Autowired
	private BannerService bannerService;
	
	@RequestMapping(value = "index",method = RequestMethod.GET)
	public ModelAndView index(){
		ModelAndView mv = new ModelAndView();
		List<Banner> bannerList = bannerService.getAllBanner();
		mv.setViewName("/management/banner/index");
		mv.addObject("bannerMsg", bannerList);
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/add",method = RequestMethod.POST)
	public Msg add(Banner banner,HttpServletRequest request, HttpSession session){
		Msg msg = new Msg();
		try {
			bannerService.insertBanner(banner,request,session);
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
	@RequestMapping(value = "/update",method = RequestMethod.POST)
	public Msg update(Banner banner,HttpServletRequest request, HttpSession session){
		Msg msg = new  Msg();
		try {
			bannerService.updateBanner(banner,request,session);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.UPDATE_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.RETURN_STRING_EXCEPTION_FAIL);			
			return msg;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete",method = RequestMethod.POST)
	public Msg delete(String ids){
		Msg msg = new Msg();
		try {
			bannerService.deleteBanner(ids);
			msg.setState(Contants.RETURN_INT_SUCCESS);
			msg.setMsg(Contants.DELETE_SUCCESS);
			return msg;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			msg.setState(Contants.RETURN_INT_FAIL);
			msg.setMsg(Contants.RETURN_STRING_EXCEPTION_FAIL);			
			return msg;	
		}
	}

}
