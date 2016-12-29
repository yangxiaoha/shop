package com.zpt.shop.common.weixin;
/**
 * 功能说明:
 *
 * TextMessage.java
 *
 * Original Author: 林敏,2016年12月28日
 *
 * Copyright (C)2014－2016 智平台.All rights reserved. 
 */
public class TextMessage extends BaseResMsg {
    // 消息内容
    private String Content;

    public String getContent() {
        return Content;
    }

    public void setContent(String content) {
        Content = content;
    }
}