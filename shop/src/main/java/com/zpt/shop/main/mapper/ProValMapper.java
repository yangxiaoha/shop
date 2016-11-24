package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.main.entities.ProVal;

public interface ProValMapper {
	
	public void insertProVal(List<ProVal> list);

	public List<ProVal> getProByTypeId(@Param("typeId")Integer typeId);

}
