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
</style>
</head>
<body style="background-color: #ECECF2 !important">
	<div id="wrap">
	  	<p class="nav-bar clearfloat"><span class="red-block"></span>订单详情</p>

	    <div class="order-detail pv10">
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
		  		  	<p class="fr fc-c8161d">未发货</p>
		  		  </c:if>	
		  		  <c:if test="${orderList.state == 3}">
		  		  	<p class="fr fc-c8161d">商品出库</p>
		  		  </c:if>  	
		  		  <c:if test="${orderList.state == 4}">
		  		  	<p class="fr fc-c8161d">交易完成</p>
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
		              <p class="pv5 font-price">￥${orderDetailList.price}x${orderDetailList.num}</p>
		            </div>
		          </div> 
		    	</c:forEach>
		        <div class="order-total clearfloat">     
		          <c:if test="${orderList.state == 1}">
		          	<input type="hidden" value="${orderList.id}" />
		  		  	<button class="btn fr goPayment">去支付</button>
		  		  </c:if> 
		  		  <c:if test="${orderList.state == 4}">
		  		  	<button class="btn fr">确认收货</button>
		  		  </c:if>	  
		      	  <p class="fr">合计：<span class="font-price">￥${orderList.totalPrice}</span></p>
		      	  <p class="fr mr10">共1件商品</p>
		      	</div>
		      </div>
			</c:forEach>
	    </div>
	    
	    <form id="paymentForm" action="payment" method="post">
	    	<input type="text" name="orderId" class="orderId" id="orderId" value="" />
	    </form>
	
	  	<ul class="tab-bar order-detail-tab-bar">
	      <li>
	        <a href="../mainindex/index">
	          <span class="tab-bar-bg home-page"></span>
	          <span>首页</span>
	        </a>
	      </li>
	      <li>
	        <a href="orderDetail">
	          <span class="tab-bar-bg order"></span>
	          <span>我的订单</span>
	        </a>
	      </li>
	      <li>
	        <a href="../member/memberCenter">
	          <span class="tab-bar-bg member-center"></span>
	          <span>会员中心</span>
	        </a>
	      </li>
	      <li>
	        <a href="../member/myQr">
	          <span class="tab-bar-bg qr-code"></span>
	          <span>我的二维码</span>
	        </a>
	      </li>
	    </ul>
	  	
    </div>
    
    <script>
	    $(document).ready(function(){
			$(".goPayment").click(function(){
				var id = $(this).siblings("input").val();
				$("#orderId").val(id);	
				$("#paymentForm").submit();
			});
		});    	
    </script>

</body>
</html>