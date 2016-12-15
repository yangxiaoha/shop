package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.User;

public interface UserMapper {

	public List<User> listUser(Query<User> query);
	
	public Integer countUser(Query<User> query);
	
	public User gerUserId(@Param("id")Integer id);
	
	/****************************************************************************/
	/**
	 * 获取分销信息
	 * @param Integer userId 用户id
	 * */
	public List<User> getAgentInfoByMyId(@Param("userId")Integer userId);

	/**
	 * 通过openId获取用户信息
	 * @param String openid 用户openid
	 * */
	public User getUserByOpenId(@Param("openId")String openid);

	/**
	 * 添加用户
	 * @param String fromUserName 用户openId
	 * @param String createTime 用户openId
	 * */
	public void addUser(@Param("openId")String fromUserName, @Param("regtime")String createTime, @Param("pid")String ticket, @Param("money")String money);

	/**
	 * 获取分销信息
	 * @param String ids 代理人id
	 * */
	public List<User> getAgentInfoByIds(@Param("ids")String ids);

}
