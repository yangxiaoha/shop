package com.zpt.shop.common.weixin;

import java.util.ArrayList;
import java.util.List;

public class ArticleResMsg extends BaseResMsg {
	private int ArticleCount = 1;
	private List<Article> Articles = new ArrayList<Article>();
	private String MsgType = "news";

	public int getArticleCount() {
		return ArticleCount;
	}

	public void setArticleCount(int articleCount) {
		ArticleCount = articleCount;
	}

	public List<Article> getArticles() {
		return Articles;
	}

	public void setArticles(List<Article> articles) {
		Articles = articles;
	}

	public void addArticle(Article article){
		this.Articles.add(article);
	}

	public String getMsgType() {
		return MsgType;
	}

	public void setMsgType(String msgType) {
		MsgType = msgType;
	}
	
}
