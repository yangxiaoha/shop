package com.zpt.shop.main.service.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.common.pojo.RandomArray;
import com.zpt.shop.common.weixin.EnterpriseToUserMsg;
import com.zpt.shop.common.weixin.WxMpConfigStorage;
import com.zpt.shop.main.entities.User;
import com.zpt.shop.main.entities.Withdraw;
import com.zpt.shop.main.mapper.DistributionMapper;
import com.zpt.shop.main.mapper.UserMapper;
import com.zpt.shop.main.mapper.WithdrawMapper;
import com.zpt.shop.main.service.WithdrawService;
import com.zpt.shop.main.service.WxMpService;
import com.zpt.shop.weixin.utils.CollectionUtil;
import com.zpt.shop.weixin.utils.WeixinUtils;
import com.zpt.shop.weixin.utils.WeixinUtils.RequestMethodEnum;
import com.zpt.shop.weixin.utils.XmlUtil;

@Service
public class WithdrawServiceImpl implements WithdrawService {

	@Autowired
	private WithdrawMapper withdrawMapper;
	
	@Autowired
	private DistributionMapper distributionMapper;
	
	@Autowired
	private WxMpConfigStorage wxMpConfigStorage;
	
	@Autowired
	private WxMpService wxMpService;
	
	@Autowired
	private UserMapper userMapper;



	/**
	 * 获取会员信息
	 * @param Integer userId 用户id
	 * */
	@Override
	public List<Withdraw> getMemberInfo(Integer userId) {
		// TODO Auto-generated method stub
		List<Withdraw> withdrawList = withdrawMapper.getMemberInfo(userId);
		if(withdrawList != null && withdrawList.size() > 0){
			return withdrawList;
		}
		return null;
	}

	/**
	 * 获取提现信息
	 * @param Integer userId 用户id
	 * */
	@Override
	public List<Withdraw> getWithdrawsInfo(Integer userId) {
		// TODO Auto-generated method stub
		List<Withdraw> withdrawList = withdrawMapper.getWithdrawsInfo(userId);
		if(withdrawList != null && withdrawList.size() > 0){
			return withdrawList;
		}
		return null;
	}

	/**
	 * 提现申请
	 * @param Integer userId 用户id
	 * @param String money 提现金额
	 * */
	@Override
	public List<Withdraw> addWithdrawsInfo(Integer userId, String userName, String money) {
		// TODO Auto-generated method stub
		// 生成编号
		long time = System.currentTimeMillis();
		String str = RandomArray.randomArray(0, 9, 2);
		String cashNum = str + Long.toString(time) + str;
		// 下单时间
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		Date cashTime = new Date();
		try {
			cashTime = df.parse(df.format(new Date()));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Withdraw withdraw = new Withdraw();
		BigDecimal cashMoney = new BigDecimal(money);
		withdraw.setUsername(userName);
		withdraw.setCashNum(cashNum);
		withdraw.setCashTime(cashTime);
		withdraw.setCashMoney(cashMoney);
		withdraw.setUserId(userId);
		withdraw.setState(1);
		withdrawMapper.addWithdrawsInfo(withdraw);
		List<Withdraw> withdrawList = withdrawMapper.getWithdrawsInfo(userId);
		if(withdrawList != null && withdrawList.size() > 0){
			return withdrawList;
		}
		return null;
	}

	@Override
	public Page<Withdraw> page(Query<Withdraw> query) {
		// TODO Auto-generated method stub
		if(query.getOrderName().equals("user.money")){
			query.setOrderName("userMoney");
		}else if(query.getOrderName().equals("cashMoney")){
			query.setOrderName("money");
		}
		Page<Withdraw> page = new Page<>();
		List<Withdraw> list = withdrawMapper.listCash(query);
		Integer count = withdrawMapper.countCash(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());
		return page;
	}

	@Override
	public boolean validate(Withdraw withdraw) {
		// TODO Auto-generated method stub
		List<Withdraw> list = withdrawMapper.validate(withdraw);
		if(list != null && list.size()>0){
			return false;
		}
		return true;
	}

	@Override
	public void updateState(Withdraw withdraw) {

		// TODO Auto-generated method stub		
		Map<String, String> restmap = null;
		try {
			String partner_trade_no = "pay"+System.currentTimeMillis();
			Map<String, String> parm = new HashMap<String, String>();
			parm.put("mch_appid", wxMpConfigStorage.getAppId()); //公众账号appid
			parm.put("mchid", wxMpConfigStorage.getPartnerId()); //商户号
			parm.put("nonce_str", System.currentTimeMillis()+""); //随机字符串
			parm.put("partner_trade_no", partner_trade_no); //商户订单号
			parm.put("openid", withdraw.getUser().getOpenid()); //用户openid	
			parm.put("check_name", "NO_CHECK"); //校验用户姓名选项 OPTION_CHECK
			//parm.put("re_user_name", "安迪"); //check_name设置为FORCE_CHECK或OPTION_CHECK，则必填
			parm.put("amount", withdraw.getCashMoney()); //转账金额
			parm.put("desc", "测试转账到个人"); //企业付款描述信息
			parm.put("spbill_create_ip", wxMpConfigStorage.getIp()); //Ip地址
			parm.put("sign", wxMpService.getSign(parm, wxMpConfigStorage.getAppId()));
			String restxml = WeixinUtils.httpRequest(wxMpConfigStorage.getSslPath(), wxMpConfigStorage.getPartnerId(), "https://api.mch.weixin.qq.com/mmpaymkttransfers/promotion/transfers",RequestMethodEnum.POST, XmlUtil.xmlFormat(parm, false));
			restmap = XmlUtil.xmlParse(restxml);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (CollectionUtil.isNotEmpty(restmap) && "SUCCESS".equals(restmap.get("result_code"))) {
			//LOG.info("转账成功：" + restmap.get("err_code") + ":" + restmap.get("err_code_des"));
			Map<String, String> transferMap = new HashMap<>();
			transferMap.put("partner_trade_no", restmap.get("partner_trade_no"));//商户转账订单号
			transferMap.put("payment_no", restmap.get("payment_no")); //微信订单号
			transferMap.put("payment_time", restmap.get("payment_time")); //微信支付成功时间			
			BigDecimal cashMoney = new BigDecimal(withdraw.getCashMoney());
			BigDecimal money = withdraw.getUser().getMoney().subtract(cashMoney);
			userMapper.updateStateMoney(withdraw.getUserId(), money);
			withdrawMapper.updateState(withdraw);
		}else {
			if (CollectionUtil.isNotEmpty(restmap)) {
				//LOG.info("转账失败：" + restmap.get("err_code") + ":" + restmap.get("err_code_des"));
			}

		}
		if(withdraw.getState() == 2){			
			withdrawMapper.updateState(withdraw);
		}
	}
}
