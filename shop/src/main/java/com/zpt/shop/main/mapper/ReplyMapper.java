package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Reply;

public interface ReplyMapper {
	
	public List<Reply> listReply(Query<Reply> query);
	
	public Integer countReply(Query<Reply> query);
	
	public List<Reply> validate(Reply reply);
	
	public void insertReply(Reply reply);
	
	public void deleteReply(@Param("ids")String ids);
	
	public void updateReply(Reply reply);

	public Reply getReply(@Param("skey")String skey);

	public void addReply(@Param("reply")String reply);

}
