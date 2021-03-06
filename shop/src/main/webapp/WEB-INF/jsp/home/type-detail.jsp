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
<link rel="stylesheet" href="<%=basePath%>assets/home/css/pullToRefresh2.css">
<style>
	.active {
		color: red;
	}
	#scroller li {
		float: left;
		width: 49%;
		margin-bottom: 9px;
		text-align: center;
		border: 1px solid #968f8e;
		background-color: #fff;
	}
	#scroller li:nth-child(odd) {
		margin-right: 2%;
	}
	#scroller li img {
		width: 100%;
	}
</style>
</head>
<body>
	<div id="wrap">
	  	<div class="nav-bar write-order ta-center clearfloat">
	      <p class="clearfloat"><a href="../index" class="fc-231815">商品分类</a></p>
	    </div>
	    
		<input id="typeId" type="hidden" value="${typeId}" />
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
	      
	      	<div id="wrapper" style="width: 76%; height: 100%; right: 0">
		      <ul class="goods-detail">
			    <c:forEach items="${goodsMsg}" var="goodsList">
			      <li class="goods-show">
			    	<a href="../goodsDetail/${goodsList.id}" style="position: relative;">
			    	  <img src="<%=basePath%>${goodsList.url}" /> 
					  <div class="goods-block">
	    	  		  	<p class="goods-name">${goodsList.name}</p>				  		
			  			<p class="font-price">￥${goodsList.price}</p>	
	    	  		  </div>		
			    	</a>
				  </li>
				</c:forEach>
			  </ul>
		    </div>	     
	    </div>
    </div>
    <script src="<%=basePath%>assets/home/js/iscroll.js"></script>
    <script src="<%=basePath%>assets/home/js/pullToRefresh2.js"></script>
	<script type="text/javascript">
    	$(document).ready(function(){

    		var wHeight = $(window).height()-$(".nav-bar").innerHeight();
        	$(".type-detail").css("height", wHeight);  
        	$("#wrapper").css("height", wHeight);
    		
    		$(".goods-name").each(function() {
	    		/* var pHeight = $(this).height();
	    		var text = $(this).text();
	    		$(this).parent($(".goods-block")).css("margin-top", -(pHeight/2)); */
	    		var text = $(this).text();
	    		if(text.length > 14) {
	    			$(this).text(text.substring(0,13)+"...");
	    		}
	    	});

	    	var num = 10;
	        var pageStart = 10;
	        
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
					refresher.loadflag = true;
					$("#pullDown").css("display", "block");
   	    			$("#pullUp").css("display", "block");
   	 	            pageStart = 10;
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
					$("p").siblings().find("li").removeClass("active");
					$(".type-detail-show ul").hide();
					$(this).addClass("active");
					$(this).siblings("ul").show();
					refresher.loadflag = true;
					$("#block").remove();
					$("#pullDown").css("display", "block");
   	    			$("#pullUp").css("display", "block");
   	    			pageStart = 10;
					showGoodsByType(typeId);
				}				
			});
			function showGoodsByType(typeId) {
		    	$.ajax({
			   	    url: "../goodsTypeLevel",
			   		type: "Post",
			   	    data: {
			   	    	pageStart:0,
			   	    	num:10,
			   	    	flag:"",
			   	    	keyword:"",
			   	    	typeId:typeId
			   	    },
			   	    dataType: "json",
			   	    success: function(data) {
		   	    		$("#scroller ul").html("");
		   	    		$("#total").val(data.total);
		   	    		if(data.goodsMsg != null) { 
			   	    		$.each(data.goodsMsg, function(i, goodsList) {   
			   	    			$("#scroller ul").append( 
			   	    				'<li class="goods-show">'+
	   			          	  	    '<a href="../goodsDetail/'+goodsList.id+'" style="position: relative;">'+
	   					            '<img src="<%=basePath%>'+goodsList.url+'">'+
	   					            '<div class="goods-block">'+
	   					            '<p class="goods-name">'+goodsList.name+'</p>'+
									'<p class="font-price">￥'+goodsList.price+'</p>'+
									'</div></a></li>'
			    				);
		   		  			});
		   	    		}else {
		   	    			refresher.loadflag = false;
		   	    			$("#pullDown").css("display", "none");
		   	    			$("#pullUp").css("display", "none");
		   	    		}
		   			}
		        })
			}
			
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
	    	            	num:num,
	    	            	flag:"",
	    		   	    	keyword:"",
	    		   	    	typeId:typeId
	    		   	    },
	    	            dataType: 'json',
	    	            success: function(data){
	    	                var result = '';
	    	                pageStart = pageStart + num;
	    	                $('#scroller ul').html("");
	    	                if(data.goodsMsg != null) { 
	    	                    for(var i = 0; i < data.goodsMsg.length; i++){
	    	                        result += '<li class="goods-show">'+
	   			          	  	    '<a href="../goodsDetail/'+data.goodsMsg[i].id+'" style="position: relative;">'+
	   					            '<img src="<%=basePath%>'+data.goodsMsg[i].url+'">'+
	   					            '<div class="goods-block">'+
	   					            '<p class="goods-name">'+data.goodsMsg[i].name+'</p>'+
									'<p class="font-price">￥'+data.goodsMsg[i].price+'</p>'+
									'</div></a></li>'
	    	                    }
	    	                    $('#scroller ul').append(result);
	    	                }	    	               
	    	            }
	    	        });	
	    			refresher.loadflag = true;
	    			$("#block").remove();
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
	   			          	  	    '<a href="../goodsDetail/'+data.goodsMsg[i].id+'" style="position: relative;">'+
	   					            '<img src="<%=basePath%>'+data.goodsMsg[i].url+'">'+
	   					            '<div class="goods-block">'+
	   					            '<p class="goods-name">'+data.goodsMsg[i].name+'</p>'+
									'<p class="font-price">￥'+data.goodsMsg[i].price+'</p>'+
									'</div></a></li>'
	    	                    }
	    	                    $('#scroller ul').append(result);
	    	                }	    	                
	    	            }
	    	        });
	    	        if(parseInt($("#total").val(), 10)-pageStart < num) {
	    	        	refresher.loadflag = false;
	    	        	$('#scroller').append('<div id="block" style="height: 60px; width: 100%; background-color: fff"></div>');	                    
	    	        }else {
	    	        	refresher.loadflag = true;
	    	        }
	    			myScroll.refresh();
	    		}, 1000);
	    	}
		});
	</script>
</body>
</html>