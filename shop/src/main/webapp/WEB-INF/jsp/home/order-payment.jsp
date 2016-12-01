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
<body style="background-color: #ECECF2">
	<div id="wrap">
	  	<div class="nav-bar write-order ta-center clearfloat">
	      <p class="clearfloat">返回</p>填写订单
	    </div>
	
		<c:forEach items="${orderMsg}" var="orderList">
	      <div class="order-detail p10">      
	        <div class="order-detail-addr">
	          <h4 class="mb5"><span id="oldName">${orderList.name}</span>，<span id="oldPhone">${orderList.phone}</span></h4>
	          <p class="fc-9fa0a0 fs-12" id="oldAddress">${orderList.address}</p>
	          <a href="../myAddr" class="icon-item" style="display: block; color: #231815;">
	            <span class="iconfont">&#xe7f7;</span>
	          </a>
	        </div>
	        <p class="order-detail-total p5 clearfloat">
	          <span class="fl">商品合计：</span>
	          <span class="fr font-price">￥${orderList.totalprice}</span>
	        </p>
	        <div class="order-detail-goods p5">
	          <c:forEach items="${orderList.orderDetail}" var="orderDetailList">
	            <div class="order-show order-list clearfloat">
	              <img src="<%=basePath%>${orderDetailList.url}">
                  <ul class="shopping-car-detail pv5">
                    <li class="fc-595757 mb5">${orderDetailList.name}</li>
                    <li class="fc-9fa0a0 fs-1rem">已选 ${orderDetailList.val}</li>
          	      </ul>
	              <div class="shopping-car-edit pv5">
	                <p class="font-price">￥${orderDetailList.price} x${orderDetailList.num}</p>
	              </div>
	            </div>
	          </c:forEach>
	        </div>
	        <form class="order-remarks" id="buyGoodsForm">
		      <div>
		        <label for="remarks" class="fc-9fa0a0">备注:</label>
		        <textarea id="remarks" name="memo">${orderList.memo}</textarea>
		      </div>
		    </form> 
		    <form id="buyGoodsSubForm" action="../submitOrder" method="post" style="width: 0; height: 0;">
	          <input type="hidden" id="postData" name="postData" />
			  <input type="hidden" id="orderId" name="orderId" value="${orderId}" />
			  <input type="hidden" id="state" name="state" value="1" />
	        </form>     	  	   	        
	      </div>
	
	  	  <div class="tab-bar order-tab-bar">	
	  		<p class="fl">实付款</p>	 		
	  		<p class="fr payment">付款</p>
	      <p class="fr font-price">￥${orderList.totalprice}</p>
	  	  </div>
	  	</c:forEach>
    </div>
    
    <script type="text/javascript">
	    $(document).ready(function() {
	    	$(".payment").click(function() {    		
	    		$("#postData").val("");
	    		$("#buyGoodsSubForm").submit();
	    	});
	    });
    </script>
</body>
</html>