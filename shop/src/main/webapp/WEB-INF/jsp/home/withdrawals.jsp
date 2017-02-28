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
	      <c:if test="${empty headImg}">
	      	<img src="<%=basePath%>assets/home/images/headImg.png">
	      </c:if>
	      <c:if test="${!empty headImg}">
	      	<img src="${headImg}">
	      </c:if>	      
	      <p style="color: #fff; font-size: 1.8rem; line-height: 120px;">${name}</p>
	    </div>
	
	    <div class="withdrawals-info p10 mb10 bc-fff">
	      <p class="mb10 fc-595757" style="font-weight: 700;">提现信息</p>
	      <div class="mb10">
	        <label for="withdrawalsPrice" class="fc-595757">提现金额：</label>
	        <input class="withdrawals-price" id="withdrawalsPrice" placeholder="请输入提现金额">
	      </div>
	      <button class="withdrawals-submit">确定提交</button>
	    </div>
	    
		<div style="width: 100%; height: 200px; overflow-y:scroll;">
		<table class="bc-fff" id="withdrawals-info-detail" style="width: 100%; height: 100%;">
	      <thead>
	        <tr>
	          <th>编号</th>
	          <th>金额</th>
	          <th>状态</th>
	        </tr>
	      </thead>
	      <tbody>
	      	<c:forEach items="${withdrawsMsg}" var="withdrawsList">
		      <tr>
		        <td>${withdrawsList.cashNum}</td>
		        <td>￥${withdrawsList.cashMoney}</td>
		        <c:if test="${withdrawsList.state == 3}">
		          <td>已提现</td>
		        </c:if>
		        <c:if test="${withdrawsList.state == 2}">
		          <td>审批不通过</td>
		        </c:if>
		        <c:if test="${withdrawsList.state == 1}">
		          <td>等待</td>
		        </c:if>
		      </tr>
	      	</c:forEach>
	      </tbody>
	    </table>
		</div>
	
	  	<ul class="tab-bar order-detail-tab-bar">
	      <li>
	        <a href="../mainindex/index">
	          <span class="tab-bar-bg home-page"></span>
	          <span>首页</span>
	        </a>
	      </li>
	      <li>
	        <a href="../purchase/orderDetail">
	          <span class="tab-bar-bg order"></span>
	          <span>我的订单</span>
	        </a>
	      </li>
	      <li>
	        <a href="memberCenter">
	          <span class="tab-bar-bg member-center"></span>
	          <span>会员中心</span>
	        </a>
	      </li>
	      <li>
	        <a href="myQr">
	          <span class="tab-bar-bg qr-code"></span>
	          <span>我的二维码</span>
	        </a>
	      </li>
	    </ul>
	</div>
	
	<script type="text/javascript">
		$(document).ready(function(){
			var money = "${money}";
			$(".withdrawals-submit").click(function() {	
				if($("#withdrawalsPrice").val() != "") {
					if(!(isNaN($("#withdrawalsPrice").val())) && parseFloat($("#withdrawalsPrice").val(), 10) > parseFloat("0.00", 10)) {
						if(parseFloat($("#withdrawalsPrice").val(), 10) > parseFloat(money, 10)) {
							alert("提现金额不可大于可提现金额！");
						}else{
							$.ajax({
						   	    url: "withdrawalsApply",
						   		type: "Post",
						   	    data: {
						   	    	money:$("#withdrawalsPrice").val()
						   	    },
						   	    dataType: "json",
						   	    success: function(data) {
						   	    	if(data.state){
						   	    		$("#withdrawals-info-detail > tbody").html("");
						   	    		$.each(data.withdrawsMsg, function(i, withdrawsList) {   
						   	    			if(withdrawsList.state == 3) {
							   	    			$("#withdrawals-info-detail > tbody").append( 
						   	    					'<tr>'+
						   	    					'<td>'+withdrawsList.cashNum+'</td>'+
						   	    					'<td>￥'+withdrawsList.cashMoney.toFixed(2)+'</td>'+
						   	    					'<td>已提现</td>'
							    				);
						   	    			}else if(withdrawsList.state == 2) {
						   	    				$("#withdrawals-info-detail > tbody").append( 
						   	    					'<tr>'+
						   	    					'<td>'+withdrawsList.cashNum+'</td>'+
						   	    					'<td>￥'+withdrawsList.cashMoney.toFixed(2)+'</td>'+
						   	    					'<td>审批不通过</td>'
							    				);
						   	    			}else if(withdrawsList.state == 1) {
							   	    			$("#withdrawals-info-detail > tbody").append( 
						   	    					'<tr>'+
						   	    					'<td>'+withdrawsList.cashNum+'</td>'+
						   	    					'<td>￥'+withdrawsList.cashMoney.toFixed(2)+'</td>'+
						   	    					'<td>等待</td>'
							    				);
						   	    			}
					   		  			});
						   			}
						   	    }
					        })
						}
					}else {
						alert("请填写正确的提现金额！");
					}
				}else {
					alert("请填写提现金额！");
				}
			});
		});
	</script>

</body>
</html>