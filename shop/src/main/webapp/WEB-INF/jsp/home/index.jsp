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
<title>一见喜</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<link rel="stylesheet" href="<%=basePath%>assets/home/css/pullToRefresh2.css">
<style type="text/css" media="all">
	body, html {
		padding: 0;
		margin: 0;
		height: 100%;
	}
	.menu {
		font-size: 1.6rem;
	}
	.goods-detail .goods-show {
		font-size: 1.4rem;
	}
    .swiper-container {
        width: 100%;
    }
    .swiper-slide {
        text-align: center;
        font-size: 18px;
        background: #fff;
        
        /* Center slide text vertically */
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
    }
    .swiper-slide > img {
        width: 100%;
    }
</style>
</head>
<body>
	<div id="wrap">
		<!-- 轮播图 -->
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
	        	<c:forEach items="${banner}" var="bannerList">
	        	    <div class="swiper-slide"><img src="<%=basePath%>${bannerList.image}"></div>	
	        	</c:forEach>        
	        </div>
	    </div> 
	    
	    <!-- 菜单 -->
		<div class="index-menu" style="position: relative;">
		  	<ul class="menu">
				<li class="menu-title menu-title-notice" data-toggle="modal" data-target="#myModal">公告</li>
				<li class="menu-title menu-title-show">最新<input type="hidden" value="1"></li>
				<li class="menu-title menu-title-show">人气<input type="hidden" value="2"></li>
				<li class="menu-title menu-title-show">现货<input type="hidden" value="3"></li>
				<li class="menu-title menu-title-search">
					<p class="fl screen clearfloat"><span class="glyphicon glyphicon-filter"></span>筛选</p>
					<p class="fr search clearfloat">
						<span class="glyphicon glyphicon-search" style="line-height: 40px;"></span>
					</p>
				</li>
		    </ul>			    
		    <input id="total" type="hidden" value="${total}" />
		    <ul class="goods-type" style="display: none;">
		    	<c:forEach items="${goodsTypeMsg}" var="goodsTypeList" begin="0" end="2" step="1">
					<li><a href="goodsType/${goodsTypeList.id}">${goodsTypeList.name}</a></li>
				</c:forEach>
				<c:if test="${fn:length(goodsTypeMsg) > 3}">
					<li><a href="goodsType/${goodsTypeMsg[0].id}">更多</a></li>
				</c:if>
		    </ul>
		    <div class="goods-search" style="display: none;">
		    	<input id="keyword" placeholder="请输入关键词" value="">
		    	<button type="button" id="searchKeyword">搜索</button>
		    </div>
		</div>
		
	    <!-- 商品展示 -->
	    <div id="wrapper" style="height: auto;">
	    	<c:if test="${!empty goodsMsg}">
		    	<ul class="goods-detail">
			    	<c:forEach items="${goodsMsg}" var="goodsList">
				      	<li class="goods-show">
				    		<a href="goodsDetail/${goodsList.id}" style="position: relative;">
				    	  		<img src="<%=basePath%>${goodsList.url}" /> 
				    	  		<div class="goods-block">
				    	  			<p class="goods-name">${goodsList.name}</p>				  		
						  			<p class="font-price fs-14">￥${goodsList.price}</p>	
				    	  		</div>					    	  			    	  		
				    		</a>
					  	</li>
					</c:forEach>
			    </ul>
	    	</c:if>
	    	<c:if test="${empty goodsMsg}">
	    		<p style="margin-top: 40px; text-align: center;">暂无符合搜索条件的商品</p>
	    	</c:if>
		    <div style="width: 100%; height: 100px;"></div>
	    </div>

		<!-- 导航 -->
		<ul class="tab-bar index-tab-bar">			
			<li>
				<a href="<%=basePath%>home/mainindex/index">
					<span class="tab-bar-bg home-page"></span>
					<span>首页</span>
				</a>
			</li>
			<li>
				<a href="../purchase/orderDetail">
					<span class="tab-bar-bg order"></span>
					<span>订单</span>
				</a>
			</li>
			<li>
				<a href="../member/memberCenter">
					<span class="tab-bar-bg member-center"></span>
					<span>会员中心</span>
				</a>
			</li>
			<li>
				<a href="<%=basePath%>home/member/kefu">
					<span class="tab-bar-bg customer-service"></span>
					<span>在线客服</span>
				</a>
			</li>
		</ul>

		<a class="shopping-cart" href="../purchase/cart">
	 		<span class="shopping-num">${amount}</span>
	    </a>
	    
	    <form action="selectGoods" method="post" id="selectForm">
		    <input id="flag" name="flag" type="hidden" value="0" />
		    <input id="fKeyword" name="keyword" type="hidden" value="" />
		    <input id="fTypeId" name="typeId" type="hidden" value="" />
		</form>
	    
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
		        	<p style="text-indent: 28px; word-wrap: break-word;">${notice}</p>		        	
		        </div>
		    </div>
	    </div>
	</div>
	<script src="<%=basePath%>assets/home/js/iscroll.js"></script>
	<script src="<%=basePath%>assets/home/js/pullToRefresh.js"></script>
	<!-- Swiper JS -->
    <script src="<%=basePath%>assets/home/Swiper-3.4.0/dist/js/swiper.min.js"></script>
    <!-- Initialize Swiper -->
    <script type="text/javascript">
    	var mySwiper = new Swiper('.swiper-container', {
    		autoplay: 3000,//可选选项，自动滑动
			loop: true,
			autoplayDisableOnInteraction : false
		})
    </script>
    <script type="text/javascript">
	    $(document).ready(function() {
	    	var flag = "${flag}";
	    	$(".menu-title").each(function() {
	    		if(flag == $(this).children("input[type=hidden]").val()) {
	    			$(this).css("border-bottom", "1px solid #c8161d");
	    		}
	    	});
	    })    	  	
    </script>
    <script type="text/javascript">
    	var num = 20;
    	var pageStart = 20;
    	
	    //最新、人气、现货
		$(".menu-title-show").click(function(){
			$(this).siblings().css("border-bottom", "0");
			if(!($(this).hasClass('menu-title-notice')) && !($(this).hasClass('menu-title-search'))) {
				$(".goods-type").hide();
				$(".goods-search").hide();
				$(this).css("border-bottom", "1px solid #c8161d");
				$("#flag").val($(this).children("input[type=hidden]").val());
				$("#fKeyword").val("");
				$("#fTypeId").val("");
				$("#selectForm").submit();		
			}				    
		});
		$(".menu-title-search .screen").click(function() {
			$(".goods-search").hide();
			$(".goods-type").toggle();
		});
		$(".menu-title-search .search").click(function() {
			$(".goods-type").hide();
			$(".goods-search").toggle();
		});
		
		//商品搜索
		$("#searchKeyword").click(function() {				
			var keyword = $("#keyword").val();
			$("#flag").val("");
			$("#fKeyword").val($("#keyword").val());
			$("#fTypeId").val("");
			if($.trim(keyword) == "") {
				alert("请输入关键字");
			}else {
				$("#selectForm").submit();
				$(".goods-search").hide();
			}		
			$("#flag").val(0);			
		});
    </script>
</body>
</html>