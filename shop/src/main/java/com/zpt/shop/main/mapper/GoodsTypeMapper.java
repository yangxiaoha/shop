package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.main.entities.GoodsType;

public interface GoodsTypeMapper {

	public List<GoodsType> selectTypeTree(@Param("pid")Integer pid);
}
