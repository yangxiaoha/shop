package com.zpt.shop.main.entities;

import java.math.BigDecimal;
import java.util.List;

public class Goods {
	
	//主键id
	private Integer id;
	
	//商品名称
	private String name;
	
	//商品扩充名称
	private String exp_name;
	
	//类目id
	private Integer typeId;
	
	//类目id
	private String typename;
	
	//商品总量
	private Integer quantity;
	
	//描述信息
	private String content;
	
	//商品编码
	private String code;
	
	//商品搜索属性
	private String searchval;
	
	//商品品牌
	private Integer brandId;
	
	//所属门店
	private String store;
	
	//品牌名称
	private String brandName;

	private List<Pro> pros;
	
	public List<Pro> getPros() {
		return pros;
	}

	public void setPros(List<Pro> pros) {
		this.pros = pros;
	}

	private long top;
	
	private String ids;
	
	private List<String> idstemp;

	public List<String> getIdstemp() {
		return idstemp;
	}

	public void setIdstemp(List<String> idstemp) {
		this.idstemp = idstemp;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getExp_name() {
		return exp_name;
	}

	public void setExp_name(String exp_name) {
		this.exp_name = exp_name;
	}

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getSearchval() {
		return searchval;
	}

	public void setSearchval(String searchval) {
		this.searchval = searchval;
	}

	public Integer getBrandId() {
		return brandId;
	}

	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}

	public String getStore() {
		return store;
	}

	public void setStore(String store) {
		this.store = store;
	}

	public String getBrandName() {
		return brandName;
	}

	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}

	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	public long getTop() {
		return top;
	}

	public void setTop(long top) {
		this.top = top;
	}	
	
	//商品购买人数
	private Long num;
	
	//商品的最低价格
	private BigDecimal price;
	
	//商品的最高价格
	private BigDecimal highprice;
	
	//商品图片路径
	private String url;
	
	public Long getNum() {
		return num;
	}

	public void setNum(Long num) {
		this.num = num;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getHighprice() {
		return highprice;
	}

	public void setHighprice(BigDecimal highprice) {
		this.highprice = highprice;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
}
