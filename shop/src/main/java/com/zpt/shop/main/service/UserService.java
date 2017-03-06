package com.zpt.shop.main.service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.User;

public interface UserService {

	public Page<User> page(Query<User> query); 
	
	public User getUserId(Integer id);

	/****************************************************************************/
	/**
	 * 获取分销信息
	 * @param Integer userId 用户id
	 * */
	public List<User> getAgentInfoByMyId(Integer userId);

	/**
	 * 通过openId获取用户信息
	 * @param String openid openid
	 * */
	public User getUserByOpenId(String openid);
	
	/**
	 * 通过userId获取用户信息
	 * @param Integer userId 用户id
	 * */
	public User getUserByUserId(Integer userId);
	
	/**
	 * 添加用户
	 * @param String fromUserName 用户openId
	 * @param Date createTime 关注时间
	 * @param Integer pid 上级id
	 * @param String money 可提现金额
	 * */
	public void addUser(String fromUserName, String userName, String createTime, Integer pid, String money);
	
	/**
	 * 修改用户
	 * @param String fromUserName 用户openId
	 * @param Date createTime 关注时间
	 * @param Integer pid 上级id
	 * @param String money 可提现金额
	 * */
	public void updateUser(String fromUserName, String userName, String createTime, Integer fpid);

	/**
	 * 获取分销信息
	 * @param String ids 代理人id
	 * */
	public List<User> getAgentInfoByIds(String ids);

	/**
	 * 扫码修改绑定的上级
	 * @param User userInfo 用户信息
	 * */
	public void updateUserByScan(User userInfo);

	/**
	 * 扫码绑定上级
	 * @param User userInfo 用户信息
	 * */
	public void addUserByScan(User userInfo);

	/**
	 * 修改可提现金额
	 * @param Integer id 用户id
	 * @param BigDecimal money 可提现金额
	 * */
	public void updateMoney(Integer id, BigDecimal money);

	/**
	 * 修改用户名
	 * @param String openid 用户openid
	 * @param String userName 用户名
	 * */
	public void updateUsername(String openid, String userName);

}
