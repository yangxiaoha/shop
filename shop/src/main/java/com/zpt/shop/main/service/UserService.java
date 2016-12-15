package com.zpt.shop.main.service;

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
	 * @param Integer userId 用户id
	 * */
	public User getUserByOpenId(String openid);
	
	/**
	 * 添加用户
	 * @param String fromUserName 用户openId
	 * @param String createTime 用户openId
	 * */
	public void addUser(String fromUserName, String createTime, String ticket, String money);

	/**
	 * 获取分销信息
	 * @param String ids 代理人id
	 * */
	public List<User> getAgentInfoByIds(String ids);

}
