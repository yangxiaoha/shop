package com.zpt.shop.main.entities;

public class GoodsImages {
	
	/** id */
	private Integer id;
	/** 商品id */
	private Integer goodsId;
	/** 图片地址 */
	private String url1;
	/** 图片地址 */
	private String url2;
	/** 图片地址 */
	private String url3;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(Integer goodsId) {
		this.goodsId = goodsId;
	}
	public String getUrl1() {
		return url1;
	}
	public void setUrl1(String url1) {
		this.url1 = url1;
	}
	public String getUrl2() {
		return url2;
	}
	public void setUrl2(String url2) {
		this.url2 = url2;
	}
	public String getUrl3() {
		return url3;
	}
	public void setUrl3(String url3) {
		this.url3 = url3;
	}
	
}
