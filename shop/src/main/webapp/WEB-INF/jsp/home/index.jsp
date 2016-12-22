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
<link rel="stylesheet" href="<%=basePath%>assets/home/dropload-gh-pages/dist/dropload.css">
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
					<p class="fr search clearfloat">
						<span class="glyphicon glyphicon-search" style="line-height: 40px;"></span>
					</p>
				</li>
		    </ul>	
		    <ul class="goods-type" style="display: none;">
		    	<c:forEach items="${goodsTypeMsg}" var="goodsTypeList">
					<li><a href="goodsType/${goodsTypeList.id}">${goodsTypeList.name}</a></li>
				</c:forEach>
		    </ul>
		    <div class="goods-search" style="display: none;">
		    	<input id="keyword" placeholder="请输入关键词">
		    	<button type="button" id="searchKeyword">搜索</button>
		    </div>
		</div>

		<div id="loadGoods">
			<div class="goods-detail">
				<c:forEach items="${goodsMsg}" var="goodsList">
				    <div class="goods-show">
				    	<a href="goodsDetail/${goodsList.id}">
				    		<img src="<%=basePath%>${goodsList.url}" />
							<p class="p5">${goodsList.name}</p>
							<c:if test="${!empty goodsList.price}">
								<p class="mb5 font-price">￥${goodsList.price}</p>
							</c:if>
							<c:if test="${empty goodsList.price}">
								<p class="mb5 font-price">￥0.00</p>
							</c:if>
				    	</a>
					</div>
				</c:forEach>
			</div>
		</div>

		<ul class="tab-bar index-tab-bar">
			<li>
				<a href="index">
					<span class="tab-bar-bg customer-service"></span>
					<span>在线客服</span>
				</a>
			</li>
			<li>
				<a href="index">
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
		</ul>

		<a class="shopping-cart" href="../purchase/cart">
	 		<span class="shopping-num">${amount}</span>
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
		        	<p style="text-indent: 28px; word-wrap: break-word;">${notice}</p>		        	
		        </div>
		    </div>
	    </div>
	</div>
	<script src="<%=basePath%>assets/home/dropload-gh-pages/dist/dropload.min.js"></script>
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
/* 	    	//根据类型查找商品
			$(".goods-type li").click(function() {
				var flag = 0;
				var keyword = "";
				var typeId = $(this).children("input[type=hidden]").val();
				showGoods(flag, keyword, typeId);
			}); */
			//商品搜索
			$("#searchKeyword").click(function() {				
				var flag = 0;
				var keyword = $("#keyword").val();
				var typeId = "";
				showGoods(flag, keyword, typeId);
			});
		}); 
	    function showGoods(flag, keyword, typeId) {
	    	$.ajax({
		   	    url: "selectGoods",
		   		type: "Post",
		   	    data: {
		   	    	pageStart:0,
		   	    	num:3,
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
   			          	  	    '<a href="goodsDetail/'+'/'+goodsList.id+'">'+
   					            '<img src="<%=basePath%>'+goodsList.url+'">'+
								'<p class="p5">'+goodsList.name+'</p>'+
								'<p class="mb5 font-price">￥'+goodsList.price+'</p>'+
								'</a>'+
								'</div>'
		    				);
	   		  			});
		   			}
		   	    }
	        })
	    }
    </script>
    <!-- 加载更多 -->
    <script>
	    $(document).ready(function(){
	    	var num = 3;
    	    var pageStart = 3;
    	    // dropload
    	    $('#loadGoods').dropload({
    	    	scrollArea : window,
    	        loadDownFn : function(me){
    	            $.ajax({
    	                type: 'POST',
    	                url: 'loadIndex',
    	                data: {    	                
    	                	pageStart:pageStart,
    	                	num:num,
    	                	flag:0,
    			   	    	keyword:"",
    			   	    	typeId:""
    			   	    },
    	                dataType: 'json',
    	                success: function(data){
    	                    var result = '';
    	                    pageStart = pageStart + num;
    	                    
    	                    for(var i = 0; i < data.goodsMsg.length; i++){
    	                        result += '<div class="goods-show">'+
   			          	  	    		'<a href="goodsDetail/'+'/'+data.goodsMsg[i].id+'">'+
   					            		'<img src="<%=basePath%>'+data.goodsMsg[i].url+'">'+
										'<p class="p5">'+data.goodsMsg[i].name+'</p>'+
										'<p class="mb5 font-price">￥'+data.goodsMsg[i].price+'</p>'+
										'</a>'+
										'</div>';
    	                        if((i + 1) >= data.goodsMsg.length){
    	                            // 锁定
    	                            me.lock();
    	                            // 无数据
    	                            me.noData();
    	                            break;
    	                        }
    	                    }
    	                    // 为了测试，延迟1秒加载
    	                    setTimeout(function(){
    	                        $('.goods-detail').append(result);
    	                        // 每次数据加载完，必须重置
    	                        me.resetload();
    	                    },1000);
    	                },
    	                error: function(xhr, type){
    	                    alert('Ajax error!');
    	                    // 即使加载出错，也得重置
    	                    me.resetload();
    	                }
    	            });
    	        }
    	    });
	    });
    </script>
</body>
</html>