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
    .goods-no-active {
	   	color: #C9CACB !important;
	   	background-color: #F5F4F4 !important;	    	
	}
</style>
</head>
<body>
	<div id="wrap">
		<c:if test="${!empty goodsMsg}">
			<div class="goods-parameter-detail mb80">${goodsMsg.content}</div>
		</c:if>
	
		<ul class="tab-bar index-tab-bar">
			<li>
				<a href="../index">
					<span class="tab-bar-bg customer-service"></span>
					<span>在线客服</span>
				</a>
			</li>
			<li>
				<a href="<%=basePath%>home/mainindex/index">
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
	
		<div id="modifyAttr">
			<div class="goods-parameter-choice" id="goods-parameter-choice" style="display: none;">
				<div class="goods-parameter-show order-list clearfloat">
					<input id="goodsId" type="hidden" value="${goodsId}">
					<c:if test="${!empty goodsMsg}">
					     <img id="goodsImg" src="<%=basePath%>${goodsMsg.url}">
				         <ul class="shopping-car-detail p5">
				         	<c:if test="${goodsMsg.price != goodsMsg.highprice}">
				         		<li class="mb5 font-price" id="goodsPrice">￥${goodsMsg.price} ~ ${goodsMsg.highprice}</li>
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
		        	<a href="javascript:void(0)" class="purchase" id="purchase">立即购买</a>
		        </div>
			</div>
		</div>
	
		<a class="shopping-cart" href="<%=basePath%>home/purchase/cart">
	 		<span class="shopping-num" id="shopping-num">${amount}</span>
	    </a>
    </div>

    <script type="text/javascript">    
	    //清空所选属性
	    function clear() {
			$(".classify-detail > li").removeClass("active");
			$(".classify-detail > li").removeClass("select-active");
			$(".classify-detail > li").addClass("select-no-active");
	    }
	    
	    //属性是否都选了
	    function checkAll(oldGoods, goodsStock) {
	    	var select = false;//属性是否已选
	    	var sub = -1;//数组下标
	    	var str = "";
	    	var parameter = "";//未选属性	  
	    	var judge = "";
	    	var myAttr = new Array();
	    	var liNum = $('.classify-detail').length;
	    	var checkNum = $('.active').length;
	    	//是否有属性
	    	if(liNum > 0) {
	    		if(liNum == checkNum) {//全选
		    		//alert("全选");
		    		select = true;
		    		$(".active").each(function(e) {
		    			str+='"'+$(this).text()+'" ';
		    			myAttr[e] = $(this).text();
		    		});
	    			$(".parameter-show").text("已选:"+str); 
	    			for(var i=0; i<goodsStock.length; i++) {
	    				var a = 0;
						for(var j=0; j<myAttr.length; j++) {
							var value = goodsStock[i].value;
							var valueList = value.split(",");
							if(myAttr[j] == valueList[j]) {
								a++;
							}else {
								break;
							}
						}
						if(a == myAttr.length) {
				    		sub = i;
				        	$("#goodsImg").attr("src", '<%=basePath%>'+goodsStock[sub].url);
				        	$("#goodsPrice").text('￥'+goodsStock[sub].price);
				        	$("#goodsNum").text(goodsStock[sub].num);
			        		$(".parameter-prompt").text("请选择商品属性");       		
				        	break;
						}
					}
		    	}else {
		    		select = false;
		    		$(".classify-detail").each(function(){
		    			if(!($(this).children().hasClass('active'))) {
		    				parameter+='"'+$(this).siblings("p").text()+'" ';
						}
		    		});
		    		$(".parameter-show").text("请选择:"+parameter);
		        	$("#goodsImg").attr("src", '<%=basePath%>'+oldGoods.url);
		        	if(oldGoods.price == oldGoods.highprice) {
		        		$("#goodsPrice").text('￥'+oldGoods.price);
		        	}else {
		        		$("#goodsPrice").text('￥'+oldGoods.price+' ~ '+oldGoods.highprice);
		        	}	
		        	$("#goodsNum").text(oldGoods.quantity);
		    	}
	    		judge = select + "," + sub;
	    	}else {
	    		select = false;
	    		judge = select + "," + sub;
	    	}
			return judge;
	    }
	  
  		//库存为0的设置
  		function Init(goodsStock) {
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
  		
  		function select(attr, attrIndex, goodsStock) {
  			var list = "";//符合已选属性的库存数组id
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
  		
  		$(document).ready(function() {
  			var state = 0;//判断是加入购物车还是立即购买
  			var goodsId = $("#goodsId").val();//商品id
  			var oldGoods = new Array();//商品信息
	    	var goodsStock = new Array();//现货信息
	    	
	    	//关闭选择
	    	$("#close").click(function() {
				clear();
				Init(goodsStock);				
				$(".index-tab-bar").css("display", "block");
				$("#modifyAttr").hide();
				$(".goods-parameter-choice").slideUp();
			});
	    	
	    	//清空
	    	$(".goods-parameter-choice").on("click", ".clear-attr", function(){
				clear();
				Init(goodsStock);
			});
	    	
	    	//减少购买数量
			$("#reduceNum").click(function() {
				var purchaseNum = parseInt($("#purchaseNum").text(), 10);//购买数量
				if(purchaseNum > 1) {
					$("#purchaseNum").text(purchaseNum-1);
				}
			});
	    	
			//增加购买数量
			$("#plusNum").click(function() {
				var purchaseNum = parseInt($("#purchaseNum").text(), 10);//购买数量
				$("#purchaseNum").text(purchaseNum+1);
			});
			
	    	//商品选择展开
	    	$(".shopping").click(function() {
	    		$(".index-tab-bar").css("display", "none");
	    		$("#modifyAttr").show();
				$(".goods-parameter-choice").slideDown();
				if($(this).hasClass("shopping-state")) {
					state = 0;
					$("#purchase").text("加入购物车");
				}
				if($(this).hasClass("buy-state")) {
					state = 1;
					$("#purchase").text("立即购买");
				}
				//获取库存信息(若库存为0，直接不可点击)
				$.ajax({
					url: '<%=basePath%>home/mainindex/getGoodsStockInfo/'+goodsId,
			   		type: "Post",
			   	    dataType: "json",
			   	 	success: function(data) {
			   	    	if(data.state){
			   	    		oldGoods = data.goodsMsg;//商品属性
			   	    		goodsStock = data.goodsSkuMsg;//库存属性
			   	    		Init(goodsStock);
			   			}
			   	    }
				})				
	    	});

	    	//商品属性选择
	    	$(".classify-detail").on("click", ".select-active", function(){
	    		if($(this).hasClass('active')) {//原本被选中
	    			$(this).removeClass('active');
	    			
	    			//存储已选属性
	    			var myAttr1 = new Array();
	    			$(".classify-detail").each(function(e){
	    				if($(this).children().hasClass("active")) {
	    					myAttr1[e] = $(this).children(".active").text();
	    				}else {
	    					myAttr1[e] = "";
	    				}
	    			});	    			
	    			$(".classify-detail li").removeClass('select-active');
	    			$(".classify-detail li").addClass("select-no-active");	    			
	    			Init(goodsStock);
	    			
	    			for(var i=0; i<myAttr1.length; i++) {
	    				if(myAttr1[i] != null && myAttr1[i] != "") {
	    					select(myAttr1[i], i, goodsStock);
	    				}
	    			}
	    			
	    		}else if($(this).siblings().hasClass('active')) {//它的同胞被选中
	    			$(this).siblings().removeClass('active');
	    			$(this).addClass('active');
	    			//存储已选属性
	    			var myAttr1 = new Array();
	    			$(".classify-detail").each(function(e){
	    				if($(this).children().hasClass("active")) {
	    					myAttr1[e] = $(this).children(".active").text();
	    				}else {
	    					myAttr1[e] = "";
	    				}
	    			});
	    			$(".classify-detail li").removeClass('select-active');
	    			$(".classify-detail li").addClass("select-no-active");
	    			Init(goodsStock);
	    			for(var i=0; i<myAttr1.length; i++) {
	    				if(myAttr1[i] != null && myAttr1[i] != "") {
	    					select(myAttr1[i], i, goodsStock);
	    				}
	    			}
	    		}else {
	    			var attr = $(this).text();//点击选中的值			
					var attrIndex = $(this).parents("div").index()-1;//判断是哪个属性
					select(attr, attrIndex, goodsStock);
					$(this).siblings().removeClass('active');
		    		$(this).addClass('active');	
	    		}
	    		checkAll(oldGoods, goodsStock);
	    	});  
	    	
			//提交订单
			$("#purchase").click(function() {
				var judge = checkAll(oldGoods, goodsStock);
				var judgeList = judge.split(",");
				var select = judgeList[0];
				var sub = judgeList[1];
				var purchaseNum = parseInt($("#purchaseNum").text(), 10);//购买数量
				if(select == "true") {
					if(purchaseNum > goodsStock[sub].num) {
		        		$(".parameter-prompt").text("所选商品数不可超过库存数");
		        		$(".parameter-prompt").fadeIn();
						setTimeout(function(){$(".parameter-prompt").fadeOut();},2000);
		        	}else {
		        		if(state == 0) {
		        			$.ajax({
						   	    url: '<%=basePath%>home/purchase/addCart',
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
						   	    		$(".index-tab-bar").css("display", "block");
										$(".goods-parameter-choice").slideUp();
						   			}
						   	    	clear();
						   	    }
					        })
		        		}
						if(state == 1) {
							$("#purchase").attr('href','<%=basePath%>home/purchase/buyImmediately/'+goodsStock[sub].id+'/'+$("#purchaseNum").text());
		        		}
		        	}						
				}else {
					$(".parameter-prompt").text("请选择商品属性");
					$(".parameter-prompt").fadeIn();
					setTimeout(function(){$(".parameter-prompt").fadeOut();},2000);
				}
			});
  		});
    </script>
</body>
</html>