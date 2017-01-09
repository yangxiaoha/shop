<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
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
#loading{
	display: none;
	height: 100%;
	width: 100%;
	position: fixed;
	top: 0;
	left: 0;
	z-index: 999;
	background-color: rgba(0,0,0,.5);
}
#loading-center{
	width: 100%;
	height: 100%;
	position: relative;
}
#loading-center-absolute {
	position: absolute;
	left: 50%;
	top: 50%;
	height: 150px;
	width: 150px;
	margin-top: -75px;
	margin-left: -75px;
}
.object{
	width: 20px;
	height: 20px;
	background-color: #FFF;
	float: left;
	margin-right: 30px;
	margin-top: 65px;
	-moz-border-radius: 50% 50% 50% 50%;
	-webkit-border-radius: 50% 50% 50% 50%;
	border-radius: 50% 50% 50% 50%;
}
#object_one {	
	-webkit-animation: object_one 1.5s infinite;
	animation: object_one 1.5s infinite;
}
#object_two {
	-webkit-animation: object_two 1.5s infinite;
	animation: object_two 1.5s infinite;
	-webkit-animation-delay: 0.25s; 
    animation-delay: 0.25s;
}
#object_three {
    -webkit-animation: object_three 1.5s infinite;
	animation: object_three 1.5s infinite;
	-webkit-animation-delay: 0.5s;
    animation-delay: 0.5s;	
}
@-webkit-keyframes object_one {
	75% { -webkit-transform: scale(0); }
}
@keyframes object_one {
	75% { 
	  transform: scale(0);
	  -webkit-transform: scale(0);
	}
}
@-webkit-keyframes object_two {
	75% { -webkit-transform: scale(0); }
}
@keyframes object_two {
	75% { 
	  transform: scale(0);
	  -webkit-transform:  scale(0);
	}
}
@-webkit-keyframes object_three {
    75% { -webkit-transform: scale(0); }
}
@keyframes object_three {
	75% { 
	  transform: scale(0);
	  -webkit-transform: scale(0);
	} 
}
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
		<div class="go-shopping">
	  		<a href="<%=basePath%>home/mainindex/index" class="fl btn mr5 bc-c8161d">继续购买</a>
	  		<p class="fl go-shopping-title">购物车：立即结算，抢回还有货的商品</p>
		</div>
	    <div class="shopping-car mb80">	    	
	  		<!--无商品-->
	  		<c:if test="${empty cartsMsg}">
	  			<div class="no-shopping-car-show ta-center">
		  			<div><img src="<%=basePath%>assets/home/images/no-goods.png" /></div>
		  			<a href="<%=basePath%>home/mainindex/index" class="btn bc-c8161d" style="font-size: 1.4rem;">去逛逛</a>
	  			</div>
	  		</c:if>
		  	<!--有商品-->
		  	<c:if test="${!empty cartsMsg}"> 
		  	    <div class="have-data">
		  	    	<c:forEach items="${cartsMsg}" var="cartsList">
						<div class="shopping-car-show order-list clearfloat">
					        <img src="<%=basePath%>${cartsList.url}">
					        <ul class="shopping-car-detail ph5">
					          <li><a href="../mainindex/goodsDetail/${cartsList.goodsId}" class="fc-000 goodsName">${cartsList.name}</a></li>
					          <li>商品规格：<span class="goodsValue">${cartsList.value}</span></li>
					          <li>
					          	<span class="fl goodsPrice">￥${cartsList.price}</span>
					          	<span class="fr">x${cartsList.num}</span>
					          	<input type="hidden" class="goodsNum" value="${cartsList.num}" />
					          </li>
					        </ul>
					        <div class="shopping-car-edit">
					          <p class="modify">修改</p>
					          <p class="mt8 iconfont order-delete" style="font-size: 2.5rem;">&#xe649;</p>
					          <input class="cartId" type="hidden" value="${cartsList.id}">
					          <input class="goodsId" type="hidden" value="${cartsList.goodsId}">
					          <input class="goodsNameInput" type="hidden" value="${cartsList.name}">
					          <input class="goodsSkuNum" type="hidden" value="${cartsList.skuNum}">
					        </div>
				  	    </div>
					</c:forEach>
		  	    </div>				
	        </c:if>
	        <form id="buyGoodsForm" action="payment" method="post">
	        	<input type="hidden" name="cartIds" id="cartIds" value="" />
	        	<input type="hidden" name="totalMoney" id="totalMoney" value="${total}" />
	        </form>		  
	    </div>

	    <div class="tab-bar car-tab-bar">		
	  		<a class="btn fr bc-c8161d" id="submitOrder">结算（<span id="settlement">${totalNum}</span>）</a>
	  		<p class="fr mr10" id="total" style="font-size: 2rem;">合计：￥${total}</p>
	    </div>
	    
	    <!-- 商品属性的修改 -->	
		<div id="modifyAttr">
			<div class="goods-parameter-choice" id="goods-parameter-choice" style="display: none;">
				<div class="goods-parameter-show order-list clearfloat">
					<input id="eGoodsId" type="hidden">
					<input id="eCartId" type="hidden">
				    <img id="eGoodsImg" />
			        <ul class="shopping-car-detail p5">
			         	<li class="fc-c8161d mb5" id="eGoodsPrice"></li>
			            <li class="fc-9fa0a0 fs-1rem mb5">库存<span id="eGoodsNum"></span>件</li>
			            <li class="fc-595757 parameter-show" id="eGoodsSelect">请选择</li>
			        </ul>
			        <div class="shopping-car-edit">
		            	<i id="close"></i>
		          	</div>
		        </div>
		        <div class="goods-parameter-classify">
		        	<button class="clear-attr">清空</button>
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
		        	<a href="javascript:void(0)" class="purchase" id="purchase">确定</a>
		        </div>
			</div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
			    <div class="modal-content">
			        <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				        <h4 class="modal-title ta-center" id="myModalLabel">公告</h4>
			        </div>
			        <div class="modal-body">
			        	<p style="text-indent: 28px; word-wrap: break-word;">
			        		替换文字替换文字替换文字替换文字替换文字替换文字替换文字替换文字替换文字
			        	</p>		        	
			        </div>
			    </div>
		    </div>
		</div>
	    
	    <!-- 遮罩动画 -->
	    <div id="loading">
			<div id="loading-center">
				<div id="loading-center-absolute">
					<div class="object" id="object_one"></div>
					<div class="object" id="object_two"></div>
					<div class="object" id="object_three"></div>	
				</div>
			</div>
		 </div>
	  
    </div>

	<script type="text/javascript">
    	$(document).ready(function() {
    		//删除商品
    		$(".shopping-car").on("click", ".order-delete", function() {
    			var cartId = $(this).siblings(".cartId").val();
    			$.ajax({
    		   	    url: "<%=basePath%>home/purchase/deleteGoods",
    		   		type: "Post",
    		   	    data: {
    		   	    	cartId:cartId
    		   	    },
    		   	    dataType: "json",
    		        beforeSend : function(){//请求成功前触发的局部事件
    		        	$('#loading').show();
    		        },
    		   	    success: function(data) {
    		   	    	if(data.state){
    		   	    		$('#loading').hide();
    		   	    		$(".have-data").html("");
    		   	    		$.each(data.cartsMsg, function(i, cartsList) {   
    		   	    			$(".have-data").append( 
    		   	    				'<div class="shopping-car-show order-list clearfloat">'+
    		   	    				'<img src="<%=basePath%>'+cartsList.url+'">'+
       			          	  	    '<ul class="shopping-car-detail ph5">'+
       					            '<li><a href="../mainindex/goodsDetail/'+cartsList.goodsId+'"class="fc-000">'+cartsList.name+'</a></li>'+
       					            '<li>商品规格：<span class="goodsValue">'+cartsList.value+'</span></li>'+
       					            '<li><span class="fl">￥'+cartsList.price+'</span><span class="fr">x'+cartsList.num+'</span></li>'+
									'</ul>'+
									'<div class="shopping-car-edit">'+
									'<p class="modify">修改</p>'+
									'<p class="iconfont order-delete" style="font-size: 2.5rem;">&#xe649;</p>'+
									'<input class="cartId" type="hidden" value="'+cartsList.id+'">'+
									'<input class="goodsId" type="hidden" value="'+cartsList.goodsId+'">'+
									'<input class="goodsSkuNum" type="hidden" value="'+cartsList.skuNum+'">'+
									'</div>'+
									'</div>'
    		    				);
    	   		  			});
    		   	    		$("#total").text("合计：￥"+data.total);
    		   	    		$("#totalMoney").val(data.total);
    		   	    		$("#settlement").text(data.totalNum);
    		   			}
    		   	    }
    	        })
    		}); 
    	});
    </script>
    
    <script type="text/javascript">
  		//清空所选属性
	    function clear() {
			$(".classify-detail > li").removeClass("active");
			$(".classify-detail > li").removeClass("select-active");
			$(".classify-detail > li").addClass("select-no-active");
	    }
  		
	    //初始化
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
  		
	    //属性是否都选了
	    function checkAll(oldGoods, goodsStock) {
	    	var select = false;//属性是否已选
	    	var sub = 0;//数组下标
	    	var str = "";
	    	var parameter = "";//未选属性	  
	    	var judge = "";
	    	var myAttr = new Array();
	    	var liNum = $('.classify-detail').length;
	    	var checkNum = $('.active').length;
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
			        	$("#eGoodsImg").attr("src", '<%=basePath%>'+goodsStock[sub].url);
			        	$("#eGoodsPrice").text('￥'+goodsStock[sub].price);
			        	$("#eGoodsNum").text(goodsStock[sub].num);
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
	        	$("#eGoodsImg").attr("src", '<%=basePath%>'+oldGoods.url);
	        	if(oldGoods.price == oldGoods.highprice) {
	        		$("#eGoodsPrice").text('￥'+oldGoods.price);
	        	}else {
	        		$("#eGoodsPrice").text('￥'+oldGoods.price+' ~ '+oldGoods.highprice);
	        	}	
	        	$("#eGoodsNum").text(oldGoods.quantity);
	    	}
	    	judge = select + "," + sub;
			return judge;
	    }
  		
	    $(document).ready(function(){
	    	var state = 0;
	    	var oldGoods = new Array();//商品信息
	    	var goodsStock = new Array();//现货信息
	    	var goodsId = $("#goodsId").val();//商品id
	    	
	    	//关闭选择
	    	$("#close").click(function() {
				clear();
				Init(goodsStock);
				$("#modifyAttr").hide();
				$(".goods-parameter-choice").slideUp();
			});
	    	
	    	//清空
			$(".clear-attr").click(function() {
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
			
			//修改商品属性
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
	        			$.ajax({
					   	    url: "<%=basePath%>home/purchase/modifyCart",
					   		type: "Post",
					   		data: {
					   			cartId:$("#eCartId").val(),
					   	    	skuId:goodsStock[sub].id,
					   	    	goodsNum:$("#purchaseNum").text(),
					   	    	goodsPrice:goodsStock[sub].price
					   	    },
					   	    dataType: "json",
					   	    success: function(data) {
					   	    	if(data.state){
					   	    		$(".car-tab-bar").css("display", "block");					   	    										
									$("#modifyAttr").hide();
									$(".goods-parameter-choice").slideUp();	
									$(".have-data").html("");
		    		   	    		$.each(data.cartsMsg, function(i, cartsList) {   
		    		   	    			$(".have-data").append( 
		    		   	    				'<div class="shopping-car-show order-list clearfloat">'+
		    		   	    				'<img src="<%=basePath%>'+cartsList.url+'">'+
		       			          	  	    '<ul class="shopping-car-detail ph5">'+
		       					            '<li><a href="../mainindex/goodsDetail/'+cartsList.goodsId+'"class="fc-000">'+cartsList.name+'</a></li>'+    
		       					            '<li>商品规格：<span class="goodsValue">'+cartsList.value+'</span></li>'+
		       					            '<li><span class="fl">￥'+cartsList.price+'</span><span class="fr">x'+cartsList.num+'</span></li>'+
											'</ul>'+
											'<div class="shopping-car-edit">'+
											'<p class="modify">修改</p>'+
											'<p class="iconfont order-delete" style="font-size: 2.5rem;">&#xe649;</p>'+
											'<input class="cartId" type="hidden" value="'+cartsList.id+'">'+
											'<input class="goodsId" type="hidden" value="'+cartsList.goodsId+'">'+
											'<input class="goodsSkuNum" type="hidden" value="'+cartsList.skuNum+'">'+
											'</div>'+
											'</div>'
		    		    				);
		    	   		  			});
		    		   	    		$("#total").text("合计：￥"+data.total);
		    		   	    		$("#totalMoney").val(data.total);
		    		   	    		$("#settlement").text(data.totalNum);
					   			}
					   	    }
				        })
		        	}						
				}else {
					$(".parameter-prompt").fadeIn();
					setTimeout(function(){$(".parameter-prompt").fadeOut();},2000);
				}
			});

	    	//商品选择展开
	    	$(".shopping-car").on("click", ".modify", function() {
	    		var num = $(this).parent().siblings("ul").find("input.goodsNum").val();
	    		$("#purchaseNum").text(num);
				$(".car-tab-bar").css("display", "none");
				$("#modifyAttr").show();
				$(".goods-parameter-choice").slideDown();
				//商品信息
				var src = $(this).parents("div.shopping-car-show").children("img").attr("src");
				var spec = $(this).parents("div.shopping-car-show").find(".goodsValue").text();
				$("#eCartId").val($(this).siblings(".cartId").val());
				$("#eGoodsImg").attr("src", src);
				$("#eGoodsPrice").text($(this).parents("div.shopping-car-show").find(".goodsPrice").text());
				$("#eGoodsNum").text($(this).siblings(".goodsSkuNum").val());
		  		$("#eGoodsSelect").text("已选 "+spec);
				//获取库存信息(若库存为0，直接不可点击)
				$.ajax({
					url: '<%=basePath%>home/mainindex/getGoodsStockInfo/'+$(this).siblings(".goodsId").val(),
			   		type: "Post",
			   	    dataType: "json",
			   	 	success: function(data) {
			   	    	if(data.state){
			   	    		oldGoods = data.goodsMsg;
			   	    		goodsStock = data.goodsSkuMsg;
			   	    		$(".goods-parameter-classify").html('<button class="clear-attr">清空</button>');
			   	    		$(".classify-detail").html('');
			   	    		//动态加载属性
			   	    		$.each(data.proMsg, function(i, proList) { 
			   	    			var value = proList.value.split(",");
    		   	    			$(".goods-parameter-classify").append( 
    		   	    				'<div class="clearfloat">'+
    		   	    				'<p class="fc-595757 pv5">'+proList.name+'</p>'+
    		   	    				'<input type="hidden" value="'+proList.proId+'">'+
    		   			        	'<ul class="classify-detail clearfloat">'+
    		   			        	'</ul>'+
    		   			        	'</div>'
    		    				);
		   				        $.each(value, function(j, value) { 
	    		   	    			$(".classify-detail").eq(i).append( 	       	    					
	    		   	    				'<li class="select-no-active">'+value+'</li>'
           		    				);
	    	   		  			});	
    	   		  			});	
			   	    		
			   	    		Init(goodsStock);

			   	    	    //默认选中
			   		    	$(".classify-detail").each(function(e){		   		    		
			   		    		var val = spec.split(",");
			   		    		$(this).children().each(function(){
									if(val[e] == $(this).text()) {
										$(this).removeClass("select-no-active");
										$(this).addClass("select-active");									
										select($(this).text(), e, goodsStock);
										$(this).addClass("active");
									}	 
					        	});
							});	
			   	    		
			   			}
			   	    }
				})				
	    	});
	    	
	    	//商品属性选择
	    	$(".goods-parameter-classify").on("click", ".select-active", function() {
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
	    })
    </script>
    
    <script type="text/javascript">
    	$(document).ready(function() {
    		
    		var state = ${state};
    	    //结算
    	    $("#submitOrder").click(function() {
    			var str = "";
    	    	if($("#settlement").text() == 0) {
    	    		alert("暂无商品");
    	    	}else{
    	    		$(".shopping-car-show").each(function(){
    	    			var goodsNum = $(this).find(".goodsNum").val();   	    			
    	    			var goodsName = $(this).find(".goodsNameInput").val();
    	    			var skuNum = $(this).find(".goodsSkuNum").val();
    	    		    if(parseInt(goodsNum, 10) > parseInt(skuNum, 10)) {
    	    		    	str = str + goodsName + " ";
    	    		    }
    	    		});
    	    		if(str.length > 0){
    	    			alert("商品:\n"+str+"的购买数量已超过库存数，请修改购买数量！");
    	    		}else {
            	    	var ids = "";
            	    	$(".shopping-car-show").each(function() {
           		        	if(ids != ""){
           		            	ids+=","+$(this).find(".cartId").val();	
           		        	}else{
           		        		ids = $(this).find(".cartId").val();
           		        	}
            	    	});
            	    	if(ids != ""){
        					$("#cartIds").val(ids);
        					if(state == 1) {//从立即购买过来
        						$("#buyGoodsForm").attr("action", "<%=basePath%>home/purchase/payment");
        					}
        					$("#buyGoodsForm").submit();
        	        	}else{
        	        		$("#myModal").show();
        	        	}
    	    		}
    	    	}    	 
    	    });
    	});
    </script>	
</body>
</html>