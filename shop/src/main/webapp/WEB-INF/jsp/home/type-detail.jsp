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
<link rel="stylesheet" href="<%=basePath%>assets/home/css/pullToRefresh.css">
<style>
	.active {
		color: red;
	}
</style>
</head>
<body>
	<div id="wrap">
	  	<div class="nav-bar write-order ta-center clearfloat">
	      <p class="clearfloat"><a href="../index" class="fc-231815">商品分类</a></p>
	    </div>
	    
		<input id="typeId" value="${typeId}" />
		<input id="total" type="hidden" value="${total}" />
	    <div class="type-detail">
	      <div class="type-show fl">
	      	<c:forEach items="${typeMsg}" var="typeList">
	          <div class="type-detail-show">
	            <input type="hidden" class="getTypeId" value="${typeList.id}" />
	            <input type="hidden" class="isParent" value="${typeList.isParent}" />
		        <p>${typeList.name}</p>
		        <c:if test="${typeList.isParent == 'true'}">
		          <ul style="display: none;">
		            <c:forEach items="${typeList.goodsType}" var="goodsType">
		          	  <li>
		          	    ${goodsType.name}
		          	    <input type="hidden" class="getTypeId" value="${goodsType.id}" />
	            	    <input type="hidden" class="isPrent" value="${goodsType.isParent}" />
		          	  </li>
		            </c:forEach>
		          </ul>
		        </c:if>
	          </div>
			</c:forEach>
	      </div>
	      <div style="position: relative; width: 76%; height: 100%; float: right;">
	      	<div id="wrapper">
		      <ul class="goods-detail">
			    <c:forEach items="${goodsMsg}" var="goodsList">
			      <li class="goods-show">
			    	<a href="goodsDetail/${goodsList.id}">
			    	  <img src="<%=basePath%>${goodsList.url}" />
					  <p class="p5 goods-name">${goodsList.name}</p>
					  <p class="mb5 font-price">￥${goodsList.price}</p>
			    	</a>
				  </li>
				</c:forEach>
			  </ul>
		    </div>
	      </div>
	    </div>
    </div>
    <script src="<%=basePath%>assets/home/js/iscroll.js"></script>
    <script src="<%=basePath%>assets/home/js/pullToRefresh.js"></script>
	<script type="text/javascript">
    	$(document).ready(function(){
    		var typeId = $("#typeId").val();
			//商品搜索
			$(".type-detail-show").each(function() {	
		  		var getTypeId = $(this).children(".getTypeId").val();
	    		var isPrent = $(this).children(".isPrent").val();
	    		if(typeId == getTypeId) { 
	    			$(this).children("p").addClass("active");
	    			$(this).children("ul").show();
	    		}
			});
			$(".type-detail-show ul li").click(function() {
				typeId = $(this).find(".getTypeId").val();
				if($(this).hasClass("active")) {
					$(this).removeClass("active");
				}else {
					$(".type-detail-show ul li").removeClass("active");
					$(this).addClass("active");
					showGoodsByType(typeId);
				}				
			});
			$(".type-detail-show p").click(function() {
				typeId = $(this).siblings(".getTypeId").val();
				if($(this).hasClass("active")) {
					$(this).removeClass("active");
					$(this).siblings("ul").hide();
				}else {
					$("p").removeClass("active");
					$(".type-detail-show ul").hide();
					$(this).addClass("active");
					$(this).siblings("ul").show();
					showGoodsByType(typeId);
				}				
			});
			function showGoodsByType(typeId) {
		    	$.ajax({
			   	    url: "../goodsTypeLevel",
			   		type: "Post",
			   	    data: {
			   	    	pageStart:0,
			   	    	num:3,
			   	    	flag:"",
			   	    	keyword:"",
			   	    	typeId:typeId
			   	    },
			   	    dataType: "json",
			   	    success: function(data) {
		   	    		$(".goods-detail").html("");
		   	    		$("#total").val(data.total);
		   	    		$.each(data.goodsMsg, function(i, goodsList) {   
		   	    			$(".goods-detail").append( 
		   	    				'<div class="goods-show">'+
   			          	  	    '<a href="../goodsDetail/'+goodsList.id+'">'+
   					            '<img src="<%=basePath%>'+goodsList.url+'">'+
								'<p class="p5">'+goodsList.name+'</p>'+
								'<p class="mb5 font-price">￥'+goodsList.price+'</p>'+
								'</a>'+
								'</div>'
		    				);
	   		  			});
		   			}
		        })
			}

	    	var num = 3;
	        var pageStart = 3;
	    	refresher.init({
	    		id:"wrapper",
	    		pullDownAction:Refresh,
	    		pullUpAction:Load
	    	});
	    	
	    	function Refresh() {
	    		pageStart = 0;
	    		setTimeout(function () {
	    			$.ajax({
	    	            type: 'POST',
	    	            url: '<%=basePath%>home/mainindex/loadIndex',
	    	            data: {    	                
	    	            	pageStart:0,
	    	            	num:3,
	    	            	flag:"",
	    		   	    	keyword:"",
	    		   	    	typeId:typeId
	    		   	    },
	    	            dataType: 'json',
	    	            success: function(data){
	    	                var result = '';
	    	                pageStart = pageStart + num;
	    	                $('.goods-detail').html("");
	    	                if(data.goodsMsg != null) { 
	    	                    for(var i = 0; i < data.goodsMsg.length; i++){
	    	                        result += '<li class="goods-show">'+
	    			          	  	    	'<a href="goodsDetail/'+'/'+data.goodsMsg[i].id+'">'+
	    					            	'<img src="<%=basePath%>'+data.goodsMsg[i].url+'">'+
	    									'<p class="p5">'+data.goodsMsg[i].name+'</p>'+
	    									'<p class="mb5 font-price">￥'+data.goodsMsg[i].price+'</p>'+
	    									'</a>'+
	    									'</li>';
	    	                    }
	    	                    $('.goods-detail').append(result);
	    	                }
	    	            }
	    	        });	
	    			refresher.loadflag = true;
	    			myScroll.refresh();			
	    		}, 1000);
	    	}

	    	function Load() {
	    		setTimeout(function () {
	    	        $.ajax({
	    	            type: 'POST',
	    	            url: '<%=basePath%>home/mainindex/loadIndex',
	    	            data: {    	                
	    	            	pageStart:pageStart,
	    	            	num:num,
	    	            	flag:"",
	    		   	    	keyword:"",
	    		   	    	typeId:typeId
	    		   	    },
	    	            dataType: 'json',
	    	            success: function(data){
	    	                var result = '';
	    	                pageStart = pageStart + num;
	    	                
	    	                if(data.goodsMsg != null) {  
	    	                    for(var i = 0; i < data.goodsMsg.length; i++){
	    	                        result += '<li class="goods-show">'+
	    			          	  	    	'<a href="goodsDetail/'+'/'+data.goodsMsg[i].id+'">'+
	    					            	'<img src="<%=basePath%>'+data.goodsMsg[i].url+'">'+
	    									'<p class="p5">'+data.goodsMsg[i].name+'</p>'+
	    									'<p class="mb5 font-price">￥'+data.goodsMsg[i].price+'</p>'+
	    									'</a>'+
	    									'</li>';
	    	                    }
	    	                    $('.goods-detail').append(result);
	    	                }
	    	            }
	    	        });
	    	        alert(pageStart);
	    	        if(pageStart < $("#total").val()) {
	                    refresher.loadflag = true;
	    	        }else {
	    	        	refresher.loadflag = false;
	    	        }
	    			myScroll.refresh();
	    		}, 1000);
	    	}
		});
	</script>
</body>
</html>