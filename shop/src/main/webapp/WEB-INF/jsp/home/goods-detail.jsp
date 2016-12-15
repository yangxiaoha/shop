<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>一见喜</title>
<style>
    .active {
    	color: #fff !important;
    	background-color: #C8171F !important;	    	
    }
    .select-no-active {
    	color: #C9CACB !important;
    	background-color: #F5F4F4 !important;	    	
    }
</style>
</head>
<body>
	<div id="wrap">
	    <div class="goods-parameter-detail mb80">
			<img src="<%=basePath%>assets/home/images/goods-detail.png">
			<img src="<%=basePath%>assets/home/images/goods-detail.png">
		</div>
	
		<ul class="tab-bar index-tab-bar">
			<li>
				<a href="index.html">
					<span class="tab-bar-bg customer-service"></span>
					<span>在线客服</span>
				</a>
			</li>
			<li>
				<a href="index.html">
					<span class="tab-bar-bg home-page"></span>
					<span>首页</span>
				</a>
			</li>
			<li class="shopping shopping-state">
				<span class="tab-bar-bg add-goods"></span>
				<span>添加购物车</span>
			</li>
			<li class="shopping buy-state">
				<span class="tab-bar-bg order"></span>
				<span>立即购买</span>
			</li>
		</ul>
	
		<div class="goods-parameter-choice" id="goods-parameter-choice" style="display: none;">
			<div class="goods-parameter-show order-list clearfloat">
				<input id="goodsId" type="hidden" value="${goodsId}">
				<c:if test="${!empty goodsMsg}">
				     <img id="goodsImg" src="<%=basePath%>${goodsMsg.url}">
			         <ul class="shopping-car-detail p5">
			         	<c:if test="${goodsMsg.price != goodsMsg.highprice}">
			         		<li class="mb5 font-price" id="goodsPrice">￥${goodsMsg.price} — ${goodsMsg.highprice}</li>
			         	</c:if>
			         	<c:if test="${goodsMsg.price == goodsMsg.highprice}">
			         		<li class="mb5 font-price">￥${goodsMsg.price}</li>
			         	</c:if>
			            <li class="fc-9fa0a0 fs-1rem mb5">库存<span id="goodsNum">${goodsMsg.quantity}</span>件</li>
			            <li class="fc-595757 parameter-show">请选择
				            <c:forEach items="${proMsg}" var="proList">
			            		<span>${proList.name}</span>
							</c:forEach>
			            </li>
			        </ul>
			        <div class="shopping-car-edit">
		            	<i id="close"></i>
		          	</div>
				</c:if>
	        </div>
	        <div class="goods-parameter-classify">
	        	<button class="clear-attr">清空</button>
	        	<c:forEach items="${proMsg}" var="proList">
				    <div class="clearfloat">
		        		<p class="fc-595757 pv5">${proList.name}</p>
		        		<input type="hidden" value="${proList.proId}">
			        	<ul class="classify-detail clearfloat">
			        		<c:forEach items="${fn:split(proList.value,',')}" var="option">
								<li class="select-no-active">${option}</li>
							</c:forEach>
			        	</ul>
		        	</div>
				</c:forEach>
	        </div>
	        <div class="goods-purchase-num">
	        	<div class="fl">购买数量</div>
	        	<div class="fr">
	        		<span id="reduceNum">-</span>
	        		<span class="bc-fff mh5" id="purchaseNum">1</span>
	        		<span id="plusNum">+</span>
	        	</div>
	        </div>
	        <div class="goods-purchase" style="position: relative; border-top: 1px solid #C7C3C5;">
	        	<p class="parameter-prompt">请选择商品属性</p>
	        	<a href="#" class="purchase" id="purchase">立即购买</a>
	        </div>
		</div>
	
		<a class="shopping-cart" href="../../purchase/cart">
	 		<span class="shopping-num" id="shopping-num">${amount}</span>
	    </a>
    </div>

    <script type="text/javascript">
	    $(document).ready(function(){	
	    	var num = 0; 
	    	var sub = 0;//数组下标
	    	var state = 0;
	    	var oldGoods = new Array();//商品信息
	    	var goodsStock = new Array();//现货信息
	    	var goodsId = $("#goodsId").val();//商品id
	    	var select = false;//属性是否已选
			$(".shopping").click(function() {
				$(".index-tab-bar").css("display", "none");
				$(".goods-parameter-choice").slideDown();
				if($(this).hasClass("shopping-state")) {
					state = 0;
					$("#purchase").text("加入购物车");
				}
				if($(this).hasClass("buy-state")) {
					state = 1;
					$("#purchase").text("立即购买");
				}
				//获取库存信息
		    	$.ajax({
			   	    url: "../../getGoodsStockInfo/"+goodsId,
			   		type: "Post",
			   	    dataType: "json",
			   	    success: function(data) {
			   	    	if(data.state){
			   	    		oldGoods = data.goodsMsg;
			   	    		goodsStock = data.goodsSkuMsg;
				   	 		$(".classify-detail").each(function(e){
								var liAttr = ""
									$(this).children().each(function(){
										if(liAttr != ""){
											liAttr+=","+$(this).text();	
						        	}else{
						        		liAttr = $(this).text();
						        	}
								})
								if(goodsStock != null) {
									for(var i=0; i<goodsStock.length; i++) {
										var val = goodsStock[i].value;
									    var valList = val.split(",");
									    var liAttrList = liAttr.split(",");
									    for(var j=0; j<liAttrList.length; j++) {
									    	if(liAttrList[j] == valList[e]) {
									    		$(this).children().eq(j).removeClass("select-no-active");
												$(this).children().eq(j).addClass("select-active");
											}
									    }
									}
								}
							});
			   			}
			   	    }
		        })
			});
			$("#close").click(function() {
				$(".index-tab-bar").css("display", "block");
				$(".goods-parameter-choice").slideUp();
			});
			$(".clear-attr").click(function() {
				$(".classify-detail > li").removeClass("active");
				$(".classify-detail > li").removeClass("select-no-active");
				$(".classify-detail > li").addClass("select-active");
			});
			$(".classify-detail > li").click(function() {
				num = 0;
				var flag = true;					
				var str = "";
				var parameter = "";
				var attr = $(this).text();//点击选中的值			
				var attrIndex = $(this).parents("div").index()-1;//判断是哪个属性
				if($(this).hasClass('active')) {//移除
					$(this).removeClass('active');	
					if(!($(this).hasClass('select-no-active'))) {	
						/* alert("返回点击"); */
						show(attr, attrIndex, goodsStock);
					}
				}else {//添加					
					if(!($(this).hasClass('select-no-active'))) {							
						if($(this).siblings().hasClass('active')) {
							/* alert("二次点击"); */				
							show(attr, attrIndex, goodsStock);
						}else {
							/* alert("一次点击"); */
							var list = "";//符合已选属性的库存数组id
							//是否还有此商品
							for(var i=0; i<goodsStock.length; i++) {
								var value = goodsStock[i].value;
								var valList = value.split(",");
								if(attr == valList[attrIndex]) {						
									if(list != ""){
										list+=","+i;	
						        	}else{
						        		list = i.toString();
						        	}
								}
							}
							var goodsList = list.split(",");
			 				$(".classify-detail").each(function(e){
							    $(this).children().each(function(){
									if(attrIndex != e) {
										if($(this).hasClass('select-active')) {
											var total = 0;
											for(var i=0; i<goodsList.length; i++) {
												var j = goodsList[i];
												var value = goodsStock[j].value;
												var valList = value.split(",");
												if($(this).text() == valList[e]) {
													break;
												}else {
													total++;
												}
											}
											if(total == goodsList.length) {
												$(this).removeClass('select-active');
												$(this).addClass('select-no-active');
											}
										}
									}
						        });			        
							});	
						}
						$(this).siblings().removeClass('active');
						$(this).addClass('active');	
					}					
				}
 				//属性是否都选了
				$(".classify-detail").each(function(){
					flag = true;
				    $(this).children().each(function(){
						if($(this).hasClass('active')) {
							num++;
							flag = false;							
							str+='"'+$(this).text()+'" ';	
						}
			        });
			        if(flag) {
			        	parameter+='"'+$(this).siblings("p").text()+'" ';
			        }	
			        if(num != $('.classify-detail').length) {
			        	select = false;
			        	$(".parameter-show").text("请选择:"+parameter);
			        	var src = '<%=basePath%>'+oldGoods.url;
			        	$("#goodsImg").attr("src", src);
			        	if(oldGoods.price == oldGoods.highprice) {
			        		$("#goodsPrice").text('￥'+oldGoods.price);
			        	}else {
			        		$("#goodsPrice").text('￥'+oldGoods.price+' — '+oldGoods.highprice);
			        	}	       	
			        	$("#goodsNum").text(oldGoods.num);
					}else {
						var val = "";
						var indexval = "";
						$(".parameter-show").text("已选:"+str);
						//获取商品的skuId
 						$(".classify-detail").each(function(e){
							//判断有几个active
						    $(this).children().each(function(){
						    	if($(this).hasClass('active')) {
						    		if(val != ""){
						    			val+=","+$(this).text();	
						        	}else{
						        		val = $(this).text();
						        	}
						    		if(indexval != ""){
						    			indexval+=","+e.toString();	
						        	}else{
						        		indexval = e.toString();
						        	}
						    	}
					        });	
						});
						var valList = val.split(",");
					    var indexList = indexval.split(",");
						for(var j=0; j<goodsStock.length; j++) {
							var a = 0;
							for(var i=0; i<valList.length; i++) {	
								var e = indexList[i];
								var value = goodsStock[j].value;
								var valueList = value.split(",");
								if(valList[i] == valueList[e]) {
									a++;
								}
							}
							if(a == valList.length) {
								sub = j;
								select = true;
					        	var src = '<%=basePath%>'+goodsStock[j].url;
					        	$("#goodsImg").attr("src", src);
					        	$("#goodsPrice").text('￥'+goodsStock[j].price);
					        	$("#goodsNum").text(goodsStock[j].num);
				        		$(".parameter-prompt").text("请选择商品属性");       		
					        	break;
							}
						}; 
					}			        
				});								
			});
			$("#reduceNum").click(function() {
				var purchaseNum = parseInt($("#purchaseNum").text(), 10);//购买数量
				if(purchaseNum > 1) {
					$("#purchaseNum").text(purchaseNum-1);
				}
			});
			$("#plusNum").click(function() {
				var purchaseNum = parseInt($("#purchaseNum").text(), 10);//购买数量
				$("#purchaseNum").text(purchaseNum+1);
			});
			$("#purchase").click(function() {//提交订单
				var purchaseNum = parseInt($("#purchaseNum").text(), 10);//购买数量
				if(select) {
					if(purchaseNum > goodsStock[sub].num) {
		        		$(".parameter-prompt").text("所选商品数不可超过库存数");
		        		$(".parameter-prompt").fadeIn();
						setTimeout(function(){$(".parameter-prompt").fadeOut();},2000);
		        	}else {
		        		if(state == 0) {
		        			$.ajax({
						   	    url: "../../purchase/addCart",
						   		type: "Post",
						   		data: {
						   	    	skuId:goodsStock[sub].id,
						   	    	num:$("#purchaseNum").text(),
						   	    	price:goodsStock[sub].price
						   	    },
						   	    dataType: "json",
						   	    success: function(data) {
						   	    	if(data.state){
						   	    		$("#shopping-num").text(data.amount);
						   			}else{
						   			    alert("网络故障，稍后重试");
						   			}
						   	    }
					        })
		        		}
						if(state == 1) {
							$("#purchase").attr('href','buyImmediately/'+goodsStock[sub].id+'/'+$("#purchaseNum").text()+'/'+goodsStock[sub].price);
		        		}
		        	}						
				}else {
					$(".parameter-prompt").text("请选择商品属性");
					$(".parameter-prompt").fadeIn();
					setTimeout(function(){$(".parameter-prompt").fadeOut();},2000);
				}
			});
		}); 
	    function show(attr, attrIndex, goodsStock) {
	    	$(".classify-detail").each(function(e){
				if(attrIndex != e){
					$(this).children().addClass('select-active');
					$(this).children().removeClass('select-no-active');
				}
			});
	    	$(".classify-detail").each(function(e){	
	    		var list="";//符合查询条件的数组id
	    		var index = 0;//用于匹配的下标
	    		var selectAttr = "";//用于匹配的值
	    		if($(this).children().hasClass('active')) {
	    			if(attrIndex != e) {
	    				index = e;
	    				selectAttr = $(this).children('.active').text();
	    			}else {
	    				index = attrIndex;
	    				selectAttr = attr;
	    			}
	    			for(var i=0; i<goodsStock.length; i++) {
	    				var value = goodsStock[i].value;
	    				var valList = value.split(",");
	    				if(selectAttr == valList[index]) {						
	    					if(list != ""){
	    						list+=","+i;	
	    		        	}else{
	    		        		list = i.toString();
	    		        	}
	    				}
	    			}
	    			var goodsList = list.split(",");
	    			$(".classify-detail").each(function(e){
	    			    $(this).children().each(function(){
	    					if(index != e) {
	    						if($(this).hasClass('select-active')) {
	    							var total = 0;
	    							for(var i=0; i<goodsList.length; i++) {
	    								var j = goodsList[i];
	    								var value = goodsStock[j].value;
	    								var valList = value.split(",");
	    								if($(this).text() == valList[e]) {
	    									break;
	    								}else {
	    									total++;
	    								}
	    							}
	    							if(total == goodsList.length) {
	    								$(this).removeClass('select-active');
	    								$(this).addClass('select-no-active');
	    							}
	    						}
	    					}
	    		        });			        
	    			});	
	    		}			        
	    	});
	    }
    </script>
</body>
</html>