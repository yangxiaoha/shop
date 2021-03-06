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
	.recharge-qr {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	}
	.recharge-qr > img {
		display: block;
		margin: 0 auto;
		text-align: center;
	    vertical-align: middle;
	}
</style>
</head>
<body style="background-color: #ECECF2 !important">
	<div id="wrap">
	  	<p class="nav-bar clearfloat"><span class="red-block"></span>我的二维码</p>
	
		<c:if test="${empty orderMsg}">
			<div class="recharge-qr">${msg}</div>
		</c:if>
		<c:if test="${!empty orderMsg}">
			<div class="recharge-qr"></div>
		</c:if>
	
	  	<ul class="tab-bar order-detail-tab-bar">
	        <li>
		        <a href="../mainindex/index">
		          <span class="tab-bar-bg home-page"></span>
		          <span>首页</span>
		        </a>
	        </li>
	        <li>
		        <a href="../purchase/orderDetail">
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
		        <a href="myQr">
		          <span class="tab-bar-bg qr-code"></span>
		          <span>我的二维码</span>
		        </a>
	        </li>
	    </ul>
	  	<input type="hidden" id="myQr" value="${myQr}">
	  	<input type="hidden" id="openId" value="${openId}">
    </div>
    
	<script src="<%=basePath%>assets/home/js/qrcode.js"></script>
	<script type="text/javascript">    	
		$(document).ready(function() { 
			var state = "${state}";
			if(state == "1") {
				qr();
			}					
		});
		
		function qr(){
	   		var url = $("#myQr").val()+"/"+$("#openId").val();
			//参数1表示图像大小，取值范围1-10；参数2表示质量，取值范围'L','M','Q','H'
			var qr = qrcode(10, 'M');
			qr.addData(url);
			qr.make();
			$(".recharge-qr").html(qr.createImgTag());
	        function GetQueryString(name) { 
	            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i"); 
	            var r = window.location.search.substr(1).match(reg);  //获取url中"?"符后的字符串并正则匹配
	            var context = ""; 
	            if(r != null) {
	                context = r[2]; 
	            }
	            reg = null; 
	            r = null; 
	            return context == null || context == "" || context == "undefined" ? "" : context; 
	        }	        
	   	}
	</script>

</body>
</html>