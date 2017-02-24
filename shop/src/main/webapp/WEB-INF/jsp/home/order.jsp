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
</head>
<body style="background-color: #ECECF2">
	<div id="wrap">
	  	<div class="nav-bar write-order ta-center clearfloat">
	      <p class="clearfloat">返回</p>填写订单
	    </div>
	
	    <div class="order-detail p10">
	      <div class="order-detail-addr">
	        <h4 class="mb5">姓名，15750845026</h4>
	        <p class="fc-9fa0a0 fs-12">福建省 福州市 仓山区 纵一号海峡科技园123456789</p>
	        <a href="javascript:void(0)" class="icon-item" id="getAddr" style="display: block; color: #231815;">
	          <span class="iconfont">&#xe7f7;</span>
	        </a>
	      </div>
	
	      <p class="order-detail-total p5 clearfloat">
	        <span class="fl">商品合计：</span>
	        <span class="fr font-price">￥${total}</span>
	      </p>
		
		  <div class="order-detail-goods p5">
		    <c:forEach items="${cartsMsg}" var="cartsList">
			  <div class="order-show order-list clearfloat">
	            <img src="<%=basePath%>${cartsList.url}">
                <ul class="shopping-car-detail ph5">
                  <li class="fc-595757 mb5">${cartsList.name}</li>
                  <li class="fc-9fa0a0 fs-1rem">已选 ${cartsList.value}</li>
          	    </ul>
	            <div class="shopping-car-edit">
	              <p class="font-price">￥${cartsList.price} x${cartsList.num}</p>
	            </div>
	          </div>
		    </c:forEach>	  	   	         
	        <form class="order-remarks" id="buyGoodsForm">
	          <div>
	            <label for="remarks" class="fc-9fa0a0">备注:</label>
	            <textarea id="remarks" name="memo"></textarea>
	          </div>
		      <input type="hidden" id="name" name="name" value="" />
		      <input type="hidden" id="phone" name="phone" value="" />
		      <input type="hidden" id="address" name="address" value="" />
		      <input type="hidden" id="ordercode" name="ordercode" value="${ordercode}" />
		      <input type="hidden" id="totalprice" name="totalprice" value="${total}" />
	        </form>
	        <form id="buyGoodsSubForm" action="submitOrder" method="post" style="width: 0; height: 0;">
	          <input type="hidden" id="postData" name="postData" />
		      <input type="hidden" id="cartIds" name="cartIds" value="${cartIds}" />
		      <input type="hidden" id="state" name="state" value="0" />
	        </form>
	      </div>
	    </div>
	
	  	<div class="tab-bar order-tab-bar">	
	  		<p class="fl">实付款</p>	 		
	  		<p class="fr payment">付款</p>
	      <p class="fr font-price">￥${total}</p>
	  	</div>
    </div>
    
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript">
	    var appId="${appId}";  
	    var timeStamp="${timeStamp}";  
	    var nonceStr="${nonceStr}";  
	    var prepay_id="${prepay_id}";
	    var sign="${paySign}"; 
	    wx.config({
	        debug: true,
	        appId: appId,
	        timestamp: timeStamp,
	        nonceStr: nonceStr,
	        signature: sign,
	        jsApiList: [
	        'checkJsApi',
	        'editAddress',
	        'chooseWXPay',
	        'getLatestAddress',
	        'openCard',
	        'getLocation'
	        ]
	    });
	    $(document).ready(function() {
	    	$(".payment").click(function() {
	  		    $("#name").val($("#oldName").text());
	  		    $("#phone").val($("#oldPhone").text());
	  		    $("#address").val($("#oldAddress").text());
	    		var queryArray = $("#buyGoodsForm").serializeArray();
	    		var jsonString= '{';  
	    		for (var i = 0; i < queryArray.length; i++) {  
	    		    jsonString+= JSON.stringify(queryArray[i].name) + ':' + JSON.stringify(queryArray[i].value) + ',';  
	    		}  
	    		jsonString= jsonString.substring(0, (jsonString.length - 1));  
	    		jsonString+= '}'; 
	    		$("#postData").val(jsonString);
	    		onBridgeReady();
	    	});
		    $("#getAddr").click(function() {
		    	getAddr();
		    });
	    });
	    //获取地址
	    function getAddr() {
	    	wx.openAddress({
	    	    success: function () { 
	    	        // 用户成功拉出地址 
	    	    },
	    	    cancel: function () { 
	    	        // 用户取消拉出地址
	    		}
	    	});
	    }
	    //付款
	    function onBridgeReady() {
    	    WeixinJSBridge.invoke(
    	        'getBrandWCPayRequest', {
    	           "appId":appId, //公众号名称，由商户传入     
    	           "timeStamp":timeStamp, //时间戳，自1970年以来的秒数     
    	           "nonceStr":nonceStr, //随机串     
    	           "package":prepay_id,     
    	           "signType":"MD5", //微信签名方式   
    	           "paySign":sign //微信签名 
    	        },
    	        function(res){     
    	        	if(res.err_msg == "get_brand_wcpay_request:ok"){  
    	                alert("微信支付成功"); 
    		    		$("#buyGoodsSubForm").submit();
    	            }else if(res.err_msg == "get_brand_wcpay_request:cancel"){  
    	                alert("用户取消支付"); 
    		    		$("#buyGoodsSubForm").submit();
    	            }else{  
    	                alert("支付失败"); 
    		    		$("#buyGoodsSubForm").submit();
    	            } 
    	        }
    	    ); 
    	 }
    	 if (typeof WeixinJSBridge == "undefined"){
    	    if( document.addEventListener ){
    	        document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
    	    }else if (document.attachEvent){
    	        document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
    	        document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
    	    }
    	 }else{
    	    onBridgeReady();
    	 }
    </script>
</body>
</html>