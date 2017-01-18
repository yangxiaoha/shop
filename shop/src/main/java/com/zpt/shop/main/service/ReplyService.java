package com.zpt.shop.main.service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Reply;

public interface ReplyService {
	
	public Page<Reply> page(Query<Reply> query);
	
	public boolean validate(Reply reply);
	
	public void insertReply(Reply reply);
	
	public void deleteReply(String ids);
	
	public void updateReply(Reply reply);
	
	public String getReply(String skey);

	public void addReply(String skey);

}
