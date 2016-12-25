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
	      <div id="loadGoods">
	        <div class="goods-detail fr">
	          <c:forEach items="${goodsMsg}" var="goodsList">
			    <div class="goods-show">
			      <a href="../goodsDetail/${goodsList.id}">
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
	    </div>
    </div>
    
    <script src="<%=basePath%>assets/home/dropload-gh-pages/dist/dropload.min.js"></script>
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
				var typeId = $(this).find(".getTypeId").val();
				if($(this).hasClass("active")) {
					$(this).removeClass("active");
				}else {
					$(".type-detail-show ul li").removeClass("active");
					$(this).addClass("active");
					showGoodsByType(typeId);
				}				
			});
			$(".type-detail-show p").click(function() {
				var typeId = $(this).siblings(".getTypeId").val();
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
		});
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
    	                url: '../loadIndex',
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
   			          	  	    		'<a href="../goodsDetail/'+'/'+data.goodsMsg[i].id+'">'+
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