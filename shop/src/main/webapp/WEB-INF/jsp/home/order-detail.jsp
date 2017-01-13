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
	  	
	  	<c:if test="${empty orderMsg}">
	  	  <div class="no-shopping-car-show ta-center">
		  	<div><img src="<%=basePath%>assets/home/images/no-order.png" /></div>
		  	<a href="../mainindex/index" class="btn bc-c8161d" style="font-size: 1.4rem;">去逛逛</a>
	  	  </div>
	  	</c:if>
	
		<c:if test="${!empty orderMsg}">
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
	              			<a href="evaluate/${orderList.id}/${orderDetailList.skuId}" class="btn fr">评价</a>
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
		  		  	<a href="receipt/${orderList.id}" class="btn fr">确认收货</a>
		  		  </c:if>	  
		      	  <p class="fr">合计：<span class="font-price">￥${orderList.totalPrice}</span></p>
		      	  <p class="fr mr10">共<span class="pur-total"></span>件商品</p>
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
				var id = $(this).siblings(".dOrderId").val();
				var ordernum = $(this).siblings(".dOrderNum").val();
				$("#orderId").val(id);	
				$("#orderNum").val(ordernum);
				$("#paymentForm").submit();
			});
			$(".order-state-detail").each(function(){
				/* var num = 0;
				var val = 0;
			    for(var i=0; i<$(this).find(".pur-num").length; i++) {
			    	val = parseInt($(this).find(".pur-num").eq(i).text(), 10);
			    	num += val;
			    }
			    $(this).find(".pur-total").text(num); */
			    var num = $(this).find(".order-detail-show").length;
				$(this).find(".pur-total").text(num); 
			});
		});    	
    </script>

</body>
</html>