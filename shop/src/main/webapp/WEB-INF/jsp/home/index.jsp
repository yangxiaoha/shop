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
	    <!-- Swiper -->
	    <div class="swiper-container">
	        <div class="swiper-wrapper">
	            <div class="swiper-slide"><img src="<%=basePath%>assets/home/images/carousel-img1.jpg" alt="图一"></div>
	            <div class="swiper-slide"><img src="<%=basePath%>assets/home/images/carousel-img1.jpg" alt="图二"></div>
	            <div class="swiper-slide"><img src="<%=basePath%>assets/home/images/carousel-img1.jpg" alt="图三"></div>
	        </div>
	    </div>

		<div class="index-menu" style="position: relative;">
		  	<ul class="menu">
				<li class="menu-title menu-title-notice" data-toggle="modal" data-target="#myModal">公告</li>
				<li class="menu-title">最新<input type="hidden" value="1"></li>
				<li class="menu-title">人气<input type="hidden" value="2"></li>
				<li class="menu-title">现货<input type="hidden" value="3"></li>
				<li class="menu-title menu-title-search">
					<p class="fl screen clearfloat"><span class="glyphicon glyphicon-filter"></span>筛选</p>
					<p class="fr search clearfloat"><span class="glyphicon glyphicon-search"></span></p>
				</li>
		    </ul>	    
		    <ul class="goods-type" style="display: none;">
		    	<c:forEach items="${goodsTypeMsg}" var="goodsTypeList">
					<li>${goodsTypeList.name}<input type="hidden" value="${goodsTypeList.id}"></li>
				</c:forEach>
		    </ul>
		    <div class="goods-search" style="display: none;">
		    	<input id="keyword" placeholder="请输入关键词">
		    	<button type="button" id="searchKeyword">搜索</button>
		    </div>
		</div>

		<div class="goods-detail">
			<c:forEach items="${goodsMsg}" var="goodsList">
			    <div class="goods-show">
			    	<a href="goodsDetail/${goodsList.typeId}/${goodsList.id}">
			    		<img src="<%=basePath%>${goodsList.url}" />
						<p class="p5">${goodsList.name}</p>
						<p class="mb5 fc-c8161d">${goodsList.price}</p>
			    	</a>
				</div>
			</c:forEach>
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
			<li>
				<a href="order.html">
					<span class="tab-bar-bg order"></span>
					<span>订单</span>
				</a>
			</li>
			<li>
				<a>
					<span class="tab-bar-bg member-center"></span>
					<span>会员中心</span>
				</a>
			</li>
		</ul>

		<a class="shopping-cart" href="car.html">
	 		<span class="shopping-num">0</span>
	    </a>
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
		        	<p style="text-indent: 28px; word-wrap: break-word;">
		        		替换文字替换文字替换文字替换文字替换文字替换文字替换文字替换文字替换文字
		        	</p>		        	
		        </div>
		    </div>
	    </div>
	</div>
	<!-- Swiper JS -->
    <script src="<%=basePath%>assets/home/Swiper-3.4.0/dist/js/swiper.min.js"></script>
    <!-- Initialize Swiper -->
    <script>
    	var mySwiper = new Swiper('.swiper-container', {
			autoplay: 3000,//可选选项，自动滑动
		})
    </script>
    <script>
	    $(document).ready(function(){
			$(".menu-title").click(function(){
				$(this).siblings().css("border-bottom", "0");
				if(!($(this).hasClass('menu-title-notice')) && !($(this).hasClass('menu-title-search'))) {
					$(this).css("border-bottom", "1px solid #c8161d");
					var flag = $(this).children("input[type=hidden]").val();
					var keyword = "";
					var typeId = "";
					console.log("1");
					showGoods(flag, keyword, typeId);
				}				    
			});
			$(".menu-title-search .screen").click(function() {
				$(".goods-type").toggle();
			});
			$(".menu-title-search .search").click(function() {
				$(".goods-search").toggle();
			});
		});    	
    </script>
    <script>
	    $(document).ready(function(){
	    	//根据类型查找商品
			$(".goods-type li").click(function() {
				var flag = 0;
				var keyword = "";
				var typeId = $(this).children("input[type=hidden]").val();
				alert("2");
				showGoods(flag, keyword, typeId);
			});
			//商品搜索
			$("#searchKeyword").click(function() {				
				var flag = 0;
				var keyword = $("#keyword").val();
				var typeId = "";
		    	alert("3");
				showGoods(flag, keyword, typeId);
			});
		}); 
	    function showGoods(flag, keyword, typeId) {
	    	console.log("4");
	    	$.ajax({
		   	    url: "selectGoods",
		   		type: "Post",
		   	    data: {
		   	    	flag:flag,
		   	    	keyword:keyword,
		   	    	typeId:typeId
		   	    },
		   	    dataType: "json",
		   	    success: function(data) {
		   	    	if(data.state){
		   	    		$(".goods-detail").html("");
		   	    		$.each(data.goodsMsg, function(i, goodsList) {   
		   	    			$(".goods-detail").append( 
		   	    				'<div class="goods-show">'+
   			          	  	    '<a href="goodsDetail/'+goodsList.typeId+'/'+goodsList.id+'">'+
   					            '<img src="<%=basePath%>'+goodsList.url+'">'+
								'<p class="p5">'+goodsList.name+'</p>'+
								'<p class="mb5 fc-c8161d">'+goodsList.price+'</p>'+
								'</a>'+
								'</div>'
		    				);
	   		  			});
		   			}else{
		   			    alert("网络故障，稍后重试");
		   			}
		   	    }
	        })
	    }
    </script>
</body>
</html>