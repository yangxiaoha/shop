package com.zpt.shop.common.pojo;

import java.util.List;

/**
 * 功能说明:
 *
 * PageQuery.java
 *
 * Original Author: 林敏,2016年12月2日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class PageQuery<T> {
	
	//每页展示4个
	private Integer num = 4;
	//开始下标
	private Integer pageStart = 0;
	//排序方式
	private String orderDir;
	//返回的数据
	private List<T> list;
	
	public PageQuery() {
	}

}