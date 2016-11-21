package com.zpt.shop.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zpt.shop.common.pojo.Query;
import com.zpt.shop.main.entities.Pro;

public interface ProMapper {
	
	public void insertPro(Pro pro);
	
	public void deletePro(@Param("ids")String ids);
	
	public void updatePro(Pro pro);
	
	public Integer countPro(Query<Pro> query);
	
	public List<Pro> listPro(Query<Pro> query);
	
	public List<Pro> validate(Pro pro);
	
	public List<Pro> getAllPro(@Param("typeId")Integer typeId);

}
