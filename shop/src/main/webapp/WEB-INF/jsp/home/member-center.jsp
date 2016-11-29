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
<body>
	<div id="wrap">
	    <div class="user-info">
	      <img src="images/carousel-img1.jpg">
	      <p style="color: #fff;">用户名</p>
	    </div>
	
	    <div class="present-info mb10">
	      <p class="pv10 fc-595757">您是由[商家名]推荐</p>
	      <ul class="clearfloat">
	        <li class="fl clearfloat">
	          <span class="fc-c8161d">0元</span>
	          <span class="fc-595757">可提现金额</span>
	        </li>
	        <li class="fl clearfloat">
	          <span class="fc-c8161d">0元</span>
	          <span class="fc-595757">已提现金额</span>
	        </li>
	      </ul>
	    </div>
	
	    <div class="user-power">
	      <ul>
	        <li class="user-power-show" id="user-power-show">
	          <div class="user-power-title clearfloat p10">
	            <span class="fl show-img">代理人推广</span>
	            <i class="fr agency-all-amount">0单(￥0.00)</i>
	          </div>         
	          <ul class="user-power-detail" style="display: none;">
	            <li>
	              <span>我的代理人</span>
	              <i class="fr fc-c8161d">0人</i>
	            </li>
	            <li>
	              <span>下单未购买</span>
	              <i class="fr fc-c8161d">0单(￥0.00)</i>
	            </li>
	            <li>
	              <span>下单已购买</span>
	              <i class="fr fc-c8161d">0单(￥0.00)</i>
	            </li>
	          </ul>
	        </li>
	        <li class="user-power-show">
	          <div class="user-power-title clearfloat p10">
	            <a href="withdrawals.html" class="fc-595757">
	              <span class="fl show-img">申请提现</span>
	              <i class="fr glyphicon glyphicon-chevron-right" style="line-height: 23px;"></i>
	            </a>           
	          </div>         
	          <ul></ul>
	        </li>
	      </ul>
	    </div>
	
	  	<ul class="tab-bar order-detail-tab-bar">
	      <li>
	        <a href="index.html">
	          <span class="tab-bar-bg home-page"></span>
	          <span>首页</span>
	        </a>
	      </li>
	      <li>
	        <a href="order.html">
	          <span class="tab-bar-bg order"></span>
	          <span>我的订单</span>
	        </a>
	      </li>
	      <li>
	        <a href="withdrawals.html">
	          <span class="tab-bar-bg member-center"></span>
	          <span>会员中心</span>
	        </a>
	      </li>
	      <li>
	        <a href="index.html">
	          <span class="tab-bar-bg qr-code"></span>
	          <span>我的二维码</span>
	        </a>
	      </li>
	    </ul>
    </div>

	<script type="text/javascript">
      $("#user-power-show").click(function() {        
        if($(this).find(".user-power-detail").css("display") == "none") {
          $(this).children("ul").show();
          $(this).find(".show-img").css("background-position", "0px 4px");
        }else {
          $(this).children("ul").hide();
          $(this).find(".show-img").css("background-position", "0px 34px");
        }       
      }); 
    </script>

</body>
</html>