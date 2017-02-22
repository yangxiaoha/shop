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
	  		<p class="fl">返回抢购更多欢喜，就在一见喜</p>
		</div>
	    <div class="shopping-car">	    	
	  		<!--无商品-->
	  		<c:if test="${empty cartsMsg}">
	  			<div class="no-shopping-car-show ta-center">
		  			<div><img src="<%=basePath%>assets/home/images/no-goods.png" /></div>
		  			<a href="<%=basePath%>home/mainindex/index" class="btn bc-c8161d" style="font-size: 1.4rem;">去逛逛</a>
	  			</div>
	  		</c:if>
		  	<!--有商品-->
		  	<c:if test="${!empty cartsMsg}"> 
		  		<div style="position: relative;">
		  		<div class="have-data">
		  	    	<c:forEach items="${cartsMsg}" var="cartsList">
						<div class="shopping-car-show order-list clearfloat">
					        <img src="<%=basePath%>${cartsList.url}">
					        <ul class="shopping-car-detail ph5">
					            <li><a href="../mainindex/goodsDetail/${cartsList.goodsId}" class="fc-000 goodsName">${cartsList.name}</a></li>
					            <li>商品规格：<span class="goodsValue">${cartsList.value}</span></li>
					            <li>
					          		<span class="fl goodsPrice">￥${cartsList.price}</span>
					          		<input type="hidden" class="goodsNum" value="${cartsList.num}" />
					            </li>
					        </ul>
					        <div class="shopping-car-edit">
					        	<input class="cartId" type="hidden" value="${cartsList.id}">
                                <input class="skuId" type="hidden" value="${cartsList.skuId}">
                             	<input class="goodsNameInput" type="hidden" value="${cartsList.name}">
                              	<input class="goodsSkuNum" type="hidden" value="${cartsList.skuNum}">
                              	<input class="goodsPrice" type="hidden" value="${cartsList.price}">
					          	<ul class="fl" style="width: 60px; height: 100%; margin-right: 10px;">
					          		<li class="fc-9fa0a0 fs-12">数量</li>
					          		<li class="edit-num mt18" style="overflow: hidden;">
					          			<span class="reduceNum">-</span>
					        			<span class="purchaseNum">${cartsList.num}</span>
					        			<span class="plusNum">+</span>	
					          		</li>					          						          		
								</ul>
					          	<ul class="fr" style="width: 30px; height: 100%;">
					          		<li class="fc-9fa0a0 fs-12">删除</li>
					          		<li>
					          			<p class="mt8 iconfont order-delete" style="font-size: 2.5rem; text-align: center;">&#xe649;</p>
					          		</li>
								</ul>					         
					        </div>
				  	    </div>
					</c:forEach>
		  	    </div>
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
    		var wHeight = $(window).height()-$(".go-shopping").innerHeight()-$(".tab-bar").innerHeight();
    		$(".have-data").css("height", wHeight);
    		
    		//修改数量
    		$(".shopping-car").on("click", ".reduceNum", function() {
    			var cartId = $(this).parents(".shopping-car-edit").find(".cartId").val();//购物车Id
    			var skuId = $(this).parents(".shopping-car-edit").find(".skuId").val();//库存Id
    			var goodsPrice = $(this).parents(".shopping-car-edit").find(".goodsPrice").val();//商品价格
    			var goodsNum = $(this).siblings(".purchaseNum").text();//商品数量		
    			if(parseInt(goodsNum) > 1) {
    				goodsNum = parseInt(goodsNum)-1;
    				$(this).siblings(".purchaseNum").text(goodsNum);
    				editNum(cartId, skuId, goodsNum, goodsPrice);
                }
    		});
			$(".shopping-car").on("click", ".plusNum", function() {
				var skuNum = $(this).parents(".shopping-car-edit").find(".goodsSkuNum").val();//库存数量
				var cartId = $(this).parents(".shopping-car-edit").find(".cartId").val();//购物车Id
    			var skuId = $(this).parents(".shopping-car-edit").find(".skuId").val();//库存Id
    			var goodsPrice = $(this).parents(".shopping-car-edit").find(".goodsPrice").val();//商品价格
    			var goodsNum = $(this).siblings(".purchaseNum").text();//商品数量	
				if(parseInt(goodsNum) > parseInt(skuNum)-1) {
		    		alert("所选商品数量不可超过库存数！");
		    	}else {
		    		goodsNum = parseInt(goodsNum)+1;
		    		$(this).siblings(".purchaseNum").text(goodsNum);
		    		editNum(cartId, skuId, goodsNum, goodsPrice);
		    	}			
    		});

    		//删除商品
    		$(".shopping-car").on("click", ".order-delete", function() {
    			var cartId = $(this).parents(".shopping-car-edit").find(".cartId").val();//购物车Id
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
    		   	    	$('#loading').hide();		   	    		
    		   	    	if(data.state){
    		   	    		if(data.cartsMsg == null) {
    		   	    			$(".shopping-car").html("");
    		   	    			$(".shopping-car").append(
    		   	    				'<div class="no-shopping-car-show ta-center">'+
    		   	    				'<div><img src="<%=basePath%>assets/home/images/no-goods.png" /></div>'+
    		   	    				'<a href="<%=basePath%>home/mainindex/index" class="btn bc-c8161d">去逛逛</a>'+
									'</div>'
    		   	    			);
    		   	    			$("#total").text("合计：￥0.00");
    	                        $("#totalMoney").val("0.00");
    	                        $("#settlement").text(0);
    		   	    		}else {   
    		   	    			$(".have-data").html("");
        		   	    		$.each(data.cartsMsg, function(i, cartsList) {   
        		   	    			$(".have-data").append( 
        		   	    				'<div class="shopping-car-show order-list clearfloat">'+
        		   	    				'<img src="<%=basePath%>'+cartsList.url+'">'+
           			          	  	    '<ul class="shopping-car-detail ph5">'+
           					            '<li><a href="../mainindex/goodsDetail/'+cartsList.goodsId+'"class="fc-000 goodsName">'+cartsList.name+'</a></li>'+
           					            '<li>商品规格：<span class="goodsValue">'+cartsList.value+'</span></li>'+
           					            '<li><span class="fl goodsPrice">￥'+cartsList.price.toFixed(2)+'</span><input type="hidden" class="goodsNum" value="'+cartsList.num+'" /></li>'+
    									'</ul>'+
    									'<div class="shopping-car-edit">'+
    									'<input class="cartId" type="hidden" value="'+cartsList.id+'">'+
    									'<input class="skuId" type="hidden" value="'+cartsList.skuId+'">'+
    									'<input class="goodsNameInput" type="hidden" value="'+cartsList.name+'">'+
    									'<input class="goodsSkuNum" type="hidden" value="'+cartsList.skuNum+'">'+
    									'<input class="goodsPrice" type="hidden" value="'+cartsList.price+'">'+
    									'<ul class="fl" style="width: 60px; height: 100%; margin-right: 10px;">'+
    									'<li class="fc-9fa0a0 fs-12">数量</li>'+
    									'<li class="edit-num mt18" style="overflow: hidden;">'+
    									'<span class="reduceNum">-</span>'+
    									'<span class="purchaseNum">'+cartsList.num+'</span>'+
    									'<span class="plusNum">+</span>'+
    									'</li></ul>'+
    									'<ul class="fr" style="width: 30px; height: 100%;">'+
    									'<li class="fc-9fa0a0 fs-12">删除</li>'+
    									'<li><p class="mt8 iconfont order-delete" style="font-size: 2.5rem; text-align: center;">&#xe649;</p></li>'+
    									'</ul></div>'+
    									'</div>'
        		    				);
        	   		  			});
        		   	    		$("#total").text("合计：￥"+data.total);
        		   	    		$("#totalMoney").val(data.total);
        		   	    		$("#settlement").text(data.totalNum);
    		   	    		}		  		   	    		
    		   			}
    		   	    }
    	        })
    		}); 
    	});
    	
    	function editNum(cartId, skuId, goodsNum, goodsPrice) {
    		$.ajax({
                url: "<%=basePath%>home/purchase/modifyCart",
                type: "Post",
                data: {
                    cartId:cartId,
                    skuId:skuId,
                    goodsNum:goodsNum,
                    goodsPrice:goodsPrice
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
      					            '<li><a href="../mainindex/goodsDetail/'+cartsList.goodsId+'"class="fc-000 goodsName">'+cartsList.name+'</a></li>'+
      					            '<li>商品规格：<span class="goodsValue">'+cartsList.value+'</span></li>'+
      					            '<li><span class="fl goodsPrice">￥'+cartsList.price.toFixed(2)+'</span><input type="hidden" class="goodsNum" value="'+cartsList.num+'" /></li>'+
								'</ul>'+
								'<div class="shopping-car-edit">'+
								'<input class="cartId" type="hidden" value="'+cartsList.id+'">'+
								'<input class="skuId" type="hidden" value="'+cartsList.skuId+'">'+
								'<input class="goodsNameInput" type="hidden" value="'+cartsList.name+'">'+
								'<input class="goodsSkuNum" type="hidden" value="'+cartsList.skuNum+'">'+
								'<input class="goodsPrice" type="hidden" value="'+cartsList.price+'">'+
								'<ul class="fl" style="width: 60px; height: 100%; margin-right: 10px;">'+
								'<li class="fc-9fa0a0 fs-12">数量</li>'+
								'<li class="edit-num mt18" style="overflow: hidden;">'+
								'<span class="reduceNum">-</span>'+
								'<span class="purchaseNum">'+cartsList.num+'</span>'+
								'<span class="plusNum">+</span>'+
								'</li></ul>'+
								'<ul class="fr" style="width: 30px; height: 100%;">'+
								'<li class="fc-9fa0a0 fs-12">删除</li>'+
								'<li><p class="mt8 iconfont order-delete" style="font-size: 2.5rem; text-align: center;">&#xe649;</p></li>'+
								'</ul></div>'+
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