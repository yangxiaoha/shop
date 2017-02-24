<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
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
		border-bottom: 3px solid #C8161D;
	}
	.shopping-car-edit button,
	.shopping-car-edit a {
		padding: 0 8px;
		margin-top: 10px;
		height: 24px;
		line-height: 24px;
		color: #fff;
		background-color: #c8161d;
	}
</style>
</head>
<body style="background-color: #ECECF2 !important">
	<div id="wrap">
	  	<p class="nav-bar clearfloat"><span class="red-block"></span>我的订单</p>
	  	
	  	<c:if test="${empty orderMsg}">
	  	  <div class="no-shopping-car-show ta-center">
		  	<div><img src="<%=basePath%>assets/home/images/no-order.png" /></div>
		  	<a href="../mainindex/index" class="btn bc-c8161d" style="font-size: 1.4rem;">去逛逛</a>
	  	  </div>
	  	</c:if>
	
		<c:if test="${!empty orderMsg}">
		  <ul class="detail-menu">
			<li class="menu-title active">全部<input type="hidden" value="0"></li>
			<li class="menu-title">待付款<input type="hidden" value="1"></li>
			<li class="menu-title">待发货<input type="hidden" value="2"></li>
			<li class="menu-title">待收货<input type="hidden" value="3"></li>
			<li class="menu-title">已完成<input type="hidden" value="4"></li>
	      </ul>
		  <div class="order-detail pv10 mt0">
	    	<c:forEach items="${orderMsg}" var="orderList">
	    	  <div class="order-state-detail">
		      	<div class="order-state clearfloat">
		  		  <p class="fl">下单时间：${orderList.ordertime}</p>
		  		  <c:if test="${orderList.state == 0}">
		  		  	<p class="fr fc-c8161d">订单关闭</p>
		  		  </c:if>
		  		  <c:if test="${orderList.state == 1}">
		  		  	<p class="fr fc-c8161d">等待买家付款</p>
		  		  </c:if>	
		  		  <c:if test="${orderList.state == 2}">
		  		  	<p class="fr fc-c8161d">待发货</p>
		  		  </c:if>	
		  		  <c:if test="${orderList.state == 3}">
		  		  	<p class="fr fc-c8161d">商品出库</p>
		  		  </c:if>  	
		  		  <c:if test="${orderList.state == 4}">
		  		  	<p class="fr fc-c8161d">完成</p>
		  		  </c:if>	  
		      	</div>
		      	<c:forEach items="${orderList.orderDetail}" var="orderDetailList">
		      	  <div class="order-detail-show order-list clearfloat">
		            <img src="<%=basePath%>${orderDetailList.url}">
		            <ul class="shopping-car-detail p5">
		              <li class="fc-595757 mb5">${orderDetailList.name}</li>
		              <li class="fc-9fa0a0 fs-1rem">商品属性：${orderDetailList.val}</li>
		            </ul>
		            <div class="shopping-car-edit">
		              <p class="pv5 font-price">￥<span class="unit-price">${orderDetailList.price}</span>x<span class="pur-num">${orderDetailList.num}</span></p>
		              <c:if test="${orderList.state == 4}">
		              	<c:set var="state" value="true"/>
		              	<c:forEach items="${evaluatesMsg}" var="evaluatesList">
		              		<c:if test="${evaluatesList.orderId == orderList.id && evaluatesList.skuId == orderDetailList.skuId}">
		              			<c:set var="state" value="false"/>
		              			<a href="javascript:void(0);" class="btn fr">已评价</a>
		              		</c:if>		              		 			
		  		  		</c:forEach>
		  		  		<c:if test="${state}">
	              			<a href="<%=basePath%>home/purchase/evaluate/${orderList.id}/${orderDetailList.skuId}" class="btn fr">评价</a>
	              		</c:if> 
		  		  	  </c:if>
		            </div>
		          </div> 
		    	</c:forEach>
		        <div class="order-total clearfloat">     
		          <c:if test="${orderList.state == 1}">
		  		  	<button class="btn fr goPayment">去支付</button>
		  		  	<input type="hidden" value="${orderList.id}" class="dOrderId">
		  		  	<input type="hidden" value="${orderList.ordernum}" class="dOrderNum">
		  		  </c:if> 
		  		  <c:if test="${orderList.state == 3}">
		  		  	<a href="<%=basePath%>home/purchase/receipt/${orderList.id}" class="btn fr">确认收货</a>
		  		  </c:if>	  
		      	  <p class="fr">合计：<span class="font-price">￥${orderList.totalPrice}</span></p>
		      	  <c:set var="string" value="${orderList.orderDetail}"/>
		      	  <p class="fr mr10">共<span class="pur-total">${fn:length(string)}</span>件商品</p>
		      	</div>
		      </div>
			</c:forEach>
	      </div>
		</c:if>	 
		
	    <form id="paymentForm" action="payment" method="post">
	      <input type="hidden" name="orderId" class="orderId" id="orderId" />
	      <input type="hidden" name="orderNum" class="orderNum" id="orderNum" />
	    </form> 
	
	  	<ul class="tab-bar order-detail-tab-bar">
	      <li>
	        <a href="<%=basePath%>home/mainindex/index">
	          <span class="tab-bar-bg home-page"></span>
	          <span>首页</span>
	        </a>
	      </li>
	      <li>
	        <a href="<%=basePath%>home/purchase/orderDetail">
	          <span class="tab-bar-bg order"></span>
	          <span>我的订单</span>
	        </a>
	      </li>
	      <li>
	        <a href="<%=basePath%>home/member/memberCenter">
	          <span class="tab-bar-bg member-center"></span>
	          <span>会员中心</span>
	        </a>
	      </li>
	      <li>
	        <a href="<%=basePath%>home/member/myQr">
	          <span class="tab-bar-bg qr-code"></span>
	          <span>我的二维码</span>
	        </a>
	      </li>
	    </ul>
	  	
    </div>
    
    <script>
	    $(document).ready(function(){
			$(".goPayment").click(function(){
				var id = $(this).siblings(".dOrderId").val();
				var ordernum = $(this).siblings(".dOrderNum").val();
				$("#orderId").val(id);	
				$("#orderNum").val(ordernum);
				$("#paymentForm").submit();
			});	

			//订单状态的选择
			$(".menu-title").click(function() {
				$(this).siblings().removeClass("active");
				$(this).addClass("active");
				var state = $(this).find("input[type=hidden]").val();
				if(state != "0") {
					$.ajax({
				   	    url: "orderState",
				   		type: "Get",
				   	    data: {
				   	    	state:state
				   	    },
				   	    dataType: "json",
				   	    success: function(data) {
				   	    	var state = true;
				   	    	var total = 0;
				   	    	var orderState = "";
				   	    	var goodsVal = "";
				   	    	var pay = "";
				   	    	var evaluates = "";
				   	    	var val = "";		   	    				   	    	
			   	    		$(".order-detail").html("");
			   	    		$.each(data.orderMsg, function(i1, orderList) {
			   	    			goodsVal = "";
			   	    			orderState = '<div class="order-state-detail">'+
					   	 			'<div class="order-state clearfloat">'+
					   	 			'<p class="fl">下单时间：'+orderList.ordertime+'</p>'+
					   	 			(orderList.state == 0?'<p class="fr fc-c8161d">订单关闭</p>':'')+
					   	 			(orderList.state == 1?'<p class="fr fc-c8161d">等待买家付款</p>':'')+
					   	 			(orderList.state == 2?'<p class="fr fc-c8161d">待发货</p>':'')+
					   	 			(orderList.state == 3?'<p class="fr fc-c8161d">商品出库</p>':'')+
					   	 			(orderList.state == 4?'<p class="fr fc-c8161d">完成</p>':'')+
					   	 			'</div>';
			   					$.each(orderList.orderDetail, function(i2, orderDetailList) { 
			   						total = i2+1;
			   						if(orderList.state == 4) {
			   							if(data.evaluatesMsg != null) {	
			   								state = true;
			   								goodsVal += '<div class="order-detail-show order-list clearfloat">'+
			   								'<img src="<%=basePath%>'+orderDetailList.url+'">'+
			   								'<ul class="shopping-car-detail p5">'+
			   								'<li class="fc-595757 mb5">'+orderDetailList.name+'</li>'+
			   								'<li class="fc-9fa0a0 fs-1rem">商品属性：'+orderDetailList.val+'</li></ul>'+
			   								'<div class="shopping-car-edit">'+
			   								'<p class="pv5 font-price">￥<span class="unit-price">'+orderDetailList.price+
			   								'</span>x<span class="pur-num">'+orderDetailList.num+'</span></p>'
			   								$.each(data.evaluatesMsg, function(i3, evaluatesList) { 	
			   									if(evaluatesList.orderId == orderList.id && evaluatesList.skuId == orderDetailList.skuId) {
			   										state = false;
			   										goodsVal += '<a href="javascript:void(0);" class="btn fr">已评价</a>';
			   									}	   								
			   								});
			   								if(state) {
			   									goodsVal += '<a href="evaluate/'+orderList.id+'/'+orderDetailList.skuId+'" class="btn fr">评价</a>';
			   								}
			   							}
			   							goodsVal += '</div></div>';
			   						}else {
			   							goodsVal += '<div class="order-detail-show order-list clearfloat">'+
				   						'<img src="<%=basePath%>'+orderDetailList.url+'">'+
				   						'<ul class="shopping-car-detail p5">'+
				   						'<li class="fc-595757 mb5">'+orderDetailList.name+'</li>'+
				   						'<li class="fc-9fa0a0 fs-1rem">商品属性:'+orderDetailList.val+'</li>'+
				   						'</ul>'+
				   						'<div class="shopping-car-edit">'+
				   						'<p class="pv5 font-price">￥<span class="unit-price">'+orderDetailList.price+
				   						'</span>x<span class="pur-num">'+orderDetailList.num+'</span></p>'+
				   						'</div></div>'
			   						}										
			   			  		});	
			   					pay = '<div class="order-total clearfloat">'+
	   							(orderList.state == 1?'<button class="btn fr goPayment">去支付</button>'+
	   							'<input type="hidden" value="'+orderList.id+'" class="dOrderId">'+
	   							'<input type="hidden" value="'+orderList.ordernum+'" class="dOrderNum">':'')+
	   							(orderList.state == 3?'<a href="<%=basePath%>home/purchase/receipt/'+orderList.id+'" class="btn fr">确认收货</a>':'')+
	   							'<p class="fr">合计：<span class="font-price">￥'+orderList.totalPrice+'</span></p>'+
	   							'<p class="fr mr10">共<span class="pur-total">'+total+'</span>件商品</p>'+
	   							'</div>'+
	   							'</div>';
				   	    		val = orderState + goodsVal + pay;
				   	    		$(val).appendTo(".order-detail");
			   		  		});
				   	    }
			        });
				}else {
					location.reload();
				}
			});
		});    	
    </script>

</body>
</html>