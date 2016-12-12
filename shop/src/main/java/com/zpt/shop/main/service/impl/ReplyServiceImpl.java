package com.zpt.shop.main.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zpt.shop.common.pojo.Page;
import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Reply;
import com.zpt.shop.main.mapper.ReplyMapper;
import com.zpt.shop.main.service.ReplyService;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyMapper replyMapper;

	@Override
	public Page<Reply> page(Query<Reply> query) {
		// TODO Auto-generated method stub
		Page<Reply> page = new Page<>();
		List<Reply> list = replyMapper.listReply(query);
		Integer count = replyMapper.countReply(query);
		page.setAaData(list);
		page.setiTotalDisplayRecords(count);
		page.setiTotalRecords(count);
		page.setDraw(query.getDraw());		
		return page;
	}

	@Override
	public boolean validate(Reply reply) {
		// TODO Auto-generated method stub
		List<Reply> list = replyMapper.validate(reply);
		if(list != null && list.size() > 0){
			return false;
		}
		return true;
	}

	@Override
	public void insertBrand(Reply reply) {
		// TODO Auto-generated method stub
		replyMapper.insertReply(reply);

	}

	@Override
	public void deleteBrand(String ids) {
		// TODO Auto-generated method stub
		replyMapper.deleteReply(ids);

	}

	@Override
	public void updateBrand(Reply reply) {
		// TODO Auto-generated method stub
		replyMapper.updateReply(reply);

	}

}
