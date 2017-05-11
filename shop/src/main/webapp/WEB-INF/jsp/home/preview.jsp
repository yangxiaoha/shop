<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	.mt40 {
		margin-top: 40px;
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
	.tabActive {
		color: #c8161d;
	}
	#tabs {
		padding: 5px 15px;
		border-top: 1px solid #e5e5e5;
		border-bottom: 1px solid #e5e5e5;
		margin-bottom: 10px;
	}
	#tabs li {
		float: left;
		width: 50%;
		text-align: center;
	}
	#tabs li:first-child {
		border-right: 1px solid #C7C3C5;
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
    .index-tab-bar li {
    	border-right: 1px solid #e5e5e5;
    }
    .index-tab-bar li:nth-child(3),
    .index-tab-bar li:nth-child(4) {
    	border-right: none;
    }
    .index-tab-bar .shopping-state,
    .index-tab-bar .buy-state {
    	line-height: 50px;
    }
    .goods-parameter-detail a {
    	color: #000;
    }
    video {
    	object-fit: fill;
    }
</style>
</head>
<body>
	<div id="wrap">
		<!-- 轮播图 -->
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
	        	<c:forEach items="${goodsImgMsg}" var="goodsImgList">
	        	    <div class="swiper-slide"><img src="<%=basePath%>${goodsImgList.url1}"></div>	
	        	    <div class="swiper-slide"><img src="<%=basePath%>${goodsImgList.url2}"></div>
	        	    <div class="swiper-slide"><img src="<%=basePath%>${goodsImgList.url3}"></div>
	        	</c:forEach>        
	        </div>
	    </div>
	    
	    <div class="goods-introduce ph15 mb20">
	    	<c:if test="${!empty goodsMsg}">
		    	<p class="fs-16" style="padding: 8px 0;border-bottom: 1px solid #e5e5e5;">${goodsMsg.name}</p>
		    	<c:if test="${goodsMsg.price != goodsMsg.highprice}">
	         		<p class="font-price">￥${goodsMsg.price} ~ ${goodsMsg.highprice}</p>
	         	</c:if>
	         	<c:if test="${goodsMsg.price == goodsMsg.highprice}">
	         		<p class="font-price">￥${goodsMsg.price}</p>
	         	</c:if>
         	</c:if>
         	
	    </div>
	
		<ul class="tabs clearfloat" id="tabs">
	       <li class="tabActive">商品详情</li>
	       <li class="">评价</li>
	    </ul>
	    
		<ul class="tab_conbox" id="tab_conbox">
	        <li class="tab_con" style="display: none;">
	           	<c:if test="${!empty goodsMsg}">
					<div class="goods-parameter-detail mb80" style="position: absolute;">${goodsMsg.content}</div>
				</c:if>
	        </li>
	        <li class="tab_con" style="display: none; margin-bottom: 60px;">
	           <c:if test="${!empty evaluateMsg}">					
					<c:forEach items="${evaluateMsg}" var="evaluateList">
						<div class="evaluate-show">
							<p class="userName">${evaluateList.name}</p>
							<p class="fc-9fa0a0 pv5">${evaluateList.evaluateTime}&nbsp;商品属性:${evaluateList.val}</p>
							<p>${evaluateList.evaluate}</p>
						</div>
					</c:forEach>
					<div class="block60 clearfloat"></div>			
				</c:if>
				<c:if test="${empty evaluateMsg}">
					<p style="text-align: center;">暂无评论</p>
				</c:if>
	        </li>
	    </ul>
	    
	    
		<ul class="tab-bar index-tab-bar goods-tab-bar">
			<li>				
				<span class="tab-bar-bg home-page"></span>
				<span>首页</span>				
			</li>
			<li>
				<span class="tab-bar-bg customer-service"></span>
				<span>在线客服</span>
			</li>
			<li class="shopping shopping-state fs-16">
				<span style="color: #c8161d">加入购物车</span>
			</li>
			<li class="shopping buy-state fs-16" style="color: #fff; background-color: #c8161d">
				<span>立即购买</span>
			</li>			
		</ul>
	
		<div id="modifyAttr">
			<iframe style="position:absolute; visibility:inherit; top:0px; left:0px; width:100%; height:100%; z-index:9999; filter='Alpha(style=0,opacity=0)';"></iframe>
			<div class="goods-parameter-choice" id="goods-parameter-choice" style="display: none;">
				<div class="goods-parameter-show order-list clearfloat">
					<input id="goodsId" type="hidden" value="${goodsId}">
					<c:if test="${!empty goodsMsg}">
					     <img id="goodsImg" src="<%=basePath%>${goodsMsg.url}">
				         <ul class="shopping-car-detail p5">
				         	<c:if test="${goodsMsg.price != goodsMsg.highprice}">
				         		<li class="mb5 font-price" id="goodsPrice">￥${goodsMsg.price} ~ ${goodsMsg.highprice}</li>
				         	</c:if>
				         	<c:if test="${goodsMsg.price == goodsMsg.highprice}">
				         		<li class="mb5 font-price">￥${goodsMsg.price}</li>
				         	</c:if>
				            <li class="fc-9fa0a0 fs-1rem mb5">库存<span id="goodsNum">${goodsMsg.quantity}</span>件</li>
				            <li class="fc-595757 parameter-show" id="eGoodsSelect">请选择
					            <c:forEach items="${proMsg}" var="proList">
				            		<span>${proList.name}</span>
								</c:forEach>
				            </li>
				        </ul>
				        <div class="shopping-car-edit">
			            	<i id="close"></i>
			          	</div>
					</c:if>
		        </div>
		        <div class="goods-parameter-classify">
		        	<button class="clear-attr">清空</button>
		        	<c:forEach items="${proMsg}" var="proList">
					    <div class="clearfloat">
			        		<p class="fc-595757 pv5">${proList.name}</p>
			        		<input type="hidden" value="${proList.proId}">
				        	<ul class="classify-detail clearfloat">
				        		<c:forEach items="${fn:split(proList.value,',')}" var="option">
									<li class="select-no-active">${option}</li>
								</c:forEach>
				        	</ul>
			        	</div>
					</c:forEach>
		        </div>
		        <div class="goods-purchase-num">
		        	<div class="fl">购买数量</div>
		        	<div class="fr">
		        		<span id="reduceNum">-</span>
		        		<span class="bc-fff mh5" id="purchaseNum">1</span>
		        		<span id="plusNum">+</span>
		        	</div>
		        </div>
		        <div class="goods-purchase" style="position: relative; border-top: 1px solid #C7C3C5;">
		        	<p class="parameter-prompt">请选择商品属性</p>
		        	<a href="" class="purchase" id="purchase">立即购买</a>
		        </div>
			</div>
		</div>	
		<a class="shopping-cart" >
	 		<span class="shopping-num" id="shopping-num">${amount}</span>
	    </a>
    </div>
    
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
    <script type="text/javascript" src="<%=basePath%>assets/home/js/emoji.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			//tab
			jQuery.jqtab = function(tabtit,tab_conbox,shijian) {
				$(tab_conbox).find("li").hide();
				$(tabtit).find("li:first").addClass("thistab").show(); 
				$(tab_conbox).find("li:first").show();
			
				$(tabtit).find("li").bind(shijian,function(){
				  $(this).addClass("tabActive").siblings("li").removeClass("tabActive"); 
				  $(this).addClass("thistab").siblings("li").removeClass("thistab"); 
				  var activeindex = $(tabtit).find("li").index(this);
				  $(tab_conbox).children().eq(activeindex).show().siblings().hide();
				  return false;
				});			
			};
			$.jqtab("#tabs","#tab_conbox","click");

		});
	</script>
</body>
</html>