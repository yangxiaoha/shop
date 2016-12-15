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
	  	<div class="addr-detail p10">
			<div class="order-detail-addr">
		        <h4 class="mb5">姓名，15750845026</h4>
		        <p class="fc-9fa0a0 fs-12">福建省 福州市 仓山区 纵一号海峡科技园123456789</p>
		        <p class="icon-item addr-choice">
		        	<span></span>
		        </p>
		    </div>
		    <div class="order-detail-addr">
		        <h4 class="mb5">姓名，15750845026</h4>
		        <p class="fc-9fa0a0 fs-12">福建省 福州市 仓山区 纵一号海峡科技园123456789</p>
		        <p class="icon-item addr-choice">
		        	<span></span>
		        </p>
		    </div>
	    </div>
    </div>
    
    <script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script>   	
	    $(document).ready(function(){
	    	$(".order-detail-addr").click(function() {
	    		$('.addr-choice').hide();
	    		$(this).find('.addr-choice').show();
	    	});	
	    }); 
    </script>
</body>
</html>