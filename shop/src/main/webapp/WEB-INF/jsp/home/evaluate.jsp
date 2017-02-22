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
	.submitEvaluate {
		float: right;
	    height: 100%;
    	border-radius: 0;    
	}
	#evaluateForm {
		width: 100%;
	    padding: 10px;
	}
	#evaluateForm textarea {
		width: 100%;
		height: 200px;
	    resize: none;
	}
</style>
</head>
<body style="background-color: #ECECF2 !important">
	<div id="wrap">
	  	<p class="nav-bar clearfloat"><span class="red-block"></span>发表评价</p>
	
		<c:if test="${!empty orderMsg}">
		  <div class="order-detail pv10" style="margin-bottom: 5px;">
	    	<c:forEach items="${orderMsg}" var="orderList">
	    	  <div class="order-state-detail">
		      	<c:forEach items="${orderList.orderDetail}" var="orderDetailList">
		      	  <input type="hidden" value="${orderList.id}" id="orderId">
		      	  <input type="hidden" value="${orderDetailList.skuId}" id="skuId">
		      	  <div class="order-detail-show order-list clearfloat" style="border: 0">
		            <img src="<%=basePath%>${orderDetailList.url}">
		            <ul class="shopping-car-detail p5">
		              <li class="fc-595757 mb5">${orderDetailList.name}</li>
		              <li class="fc-9fa0a0 fs-1rem">商品属性：${orderDetailList.val}</li>
		            </ul>
		            <div class="shopping-car-edit">
		              <p class="pv5 font-price">￥<span class="unit-price">${orderDetailList.price}</span>x<span class="pur-num">${orderDetailList.num}</span></p>
		            </div>
		          </div> 
		    	</c:forEach>
		      </div>
			</c:forEach>
	      </div>
		</c:if>	 
		
	    <form id="evaluateForm" action="evaluate" method="post">
	      <label>亲,宝贝满足你的期待吗？说说您的评价吧!</label>
	      <textarea name="evaluate" id="evaluate"></textarea>
	    </form> 
	    
	    <p class="tab-bar"><button type="button" class="btn btn-danger submitEvaluate" id="submitEvaluate">发表评价</button></p>
	  	
    </div>
    
    <!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
		    <div class="modal-content">
		        <!-- <div class="modal-header">
			        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			        <h4 class="modal-title ta-center" id="myModalLabel">公告</h4>
		        </div> -->
		        <div class="modal-body">
		        	<p style="width: 60px; height: 60px; margin: 0 auto;"><img src="<%=basePath%>assets/home/images/smile.jpg" style="width: 100%" /></p>
		        	<p style="text-align: center;">感谢您的评价,我们会继续努力的！</p>		        	
		        </div>
		    </div>
	    </div>
	</div>

	<script>
		$(document).ready(function() {
			$("#submitEvaluate").click(function() {
				if($.trim($("#evaluate").val()) != "") {
					$(this).attr("disabled","disabled");
					$.ajax({
				   	    url: "evaluate",
				   		type: "Post",
				   	    data: {
				   	    	orderId:$("#orderId").val(),
				   	    	skuId:$("#skuId").val(),
				   	    	evaluate:$("#evaluate").val()
				   	    },
				   	    dataType: "json",
				   	    success: function(data) {
							if(data.state == 1) {
								$('#myModal').modal('show');
								setTimeout(function(){
									$('#myModal').modal('hide');
									window.location.href='<%=basePath%>home/purchase/orderDetail';
			        		    },1000);								
							}						
				   	    }
			        })
				}else {
					alert("请填写评论！");
				}
			});
		});
	</script>

</body>
</html>