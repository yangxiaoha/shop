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
    .active {
    	color: #fff !important;
    	background-color: #C8171F !important;	    	
    }
</style>
</head>
<body>
	<div id="wrap">
	    <div class="goods-parameter-detail mb80">
			<img src="<%=basePath%>assets/home/images/goods-detail.png">
			<img src="<%=basePath%>assets/home/images/goods-detail.png">
		</div>
	
		<ul class="tab-bar index-tab-bar">
			<li>
				<a href="index.html">
					<span class="tab-bar-bg customer-service"></span>
					<span>在线客服</span>
				</a>
			</li>
			<li>
				<a href="index.html">
					<span class="tab-bar-bg home-page"></span>
					<span>首页</span>
				</a>
			</li>
			<li class="shopping">
				<span class="tab-bar-bg add-goods"></span>
				<span>添加购物车</span>
			</li>
			<li class="shopping">
				<span class="tab-bar-bg order"></span>
				<span>立即购买</span>
			</li>
		</ul>
	
		<div class="goods-parameter-choice" id="goods-parameter-choice" style="display: none;">
			<div class="goods-parameter-show order-list clearfloat">
				<c:if test="${!empty goodsMsg}">
				     <img src="<%=basePath%>${goodsMsg.url}">
			         <ul class="shopping-car-detail p5">
			         	<c:if test="${goodsMsg.price != goodsMsg.highprice}">
			         		<li class="fc-c8161d mb5">￥${goodsMsg.price} — ${goodsMsg.highprice}</li>
			         	</c:if>
			         	<c:if test="${goodsMsg.price == goodsMsg.highprice}">
			         		<li class="fc-c8161d mb5">￥${goodsMsg.price}</li>
			         	</c:if>
			            <li class="fc-9fa0a0 fs-1rem mb5">库存${goodsMsg.quantity}件</li>
			            <li class="fc-595757 parameter-show">请选择
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
	        	<c:forEach items="${proMsg}" var="proList">
				    <div class="clearfloat">
		        		<p class="fc-595757 pv5">${proList.name}</p>
			        	<ul class="classify-detail clearfloat">
			        		<c:forEach items="${fn:split(proList.value,',')}" var="option">
								<li>${option}</li>
							</c:forEach>
			        	</ul>
		        	</div>
				</c:forEach>
<!-- 	        	<div class="clearfloat">
	        		<p class="fc-595757 pv5">尺寸</p>
		        	<ul class="classify-detail clearfloat">
		        		<li>红</li>
		        		<li>黄</li>
		        		<li>蓝</li>
		        		<li>绿</li>
		        		<li>青色</li>
		        		<li>100x200cm</li>
		        	</ul>
	        	</div> -->
	        </div>
	        <div class="goods-purchase-num">
	        	<div class="fl">购买数量</div>
	        	<div class="fr">
	        		<span>-</span>
	        		<span class="bc-fff mh5">1</span>
	        		<span>+</span>
	        	</div>
	        </div>
	        <div class="goods-purchase" style="position: relative; border-top: 1px solid #C7C3C5;">
	        	<p class="parameter-prompt">请选择商品属性</p>
	        	<a href="#" class="purchase" id="purchase">立即购买</a>
	        </div>
		</div>
	
		<a class="shopping-cart" href="car.html">
	 		<span class="shopping-num">0</span>
	    </a>
    </div>
 
    <script>
	    $(document).ready(function(){	
	    	var num = 0;    	    	
			var total = $('.classify-detail').length;
			$(".shopping").click(function() {
				$(".index-tab-bar").css("display", "none");
				$(".goods-parameter-choice").slideDown();
			});
			$("#close").click(function() {
				$(".index-tab-bar").css("display", "block");
				$(".goods-parameter-choice").slideUp();
			});
			$(".classify-detail > li").click(function() {
				num = 0;
				var flag = true;				
				var str = "";
				var parameter = "";
				if($(this).hasClass('active')) {
					$(this).removeClass('active');
				}else {
					$(this).parent().children().removeClass('active');
					$(this).addClass('active');						
				}
				$(".classify-detail").each(function(){
					flag = true;
				    $(this).children().each(function(){
						if($(this).hasClass('active')) {
							num++;
							flag = false;
							str+='"'+$(this).text()+'" ';							
						}
			        });
			        if(flag) {
			        	parameter+='"'+$(this).siblings("p").text()+'" ';
			        }	
			        if(num != total) {
			        	$(".parameter-show").text("请选择"+parameter);
					}else {
						$(".parameter-show").text("已选："+str);
					}			        
				});								
			});
			$("#purchase").click(function() {
				if(num != total) {
					$(".parameter-prompt").fadeIn();
					setTimeout(function(){$(".parameter-prompt").fadeOut();},2000);
				}else {
					//提交数据库
					alert();
				}
			});
		});    	
    </script>
</body>
</html>