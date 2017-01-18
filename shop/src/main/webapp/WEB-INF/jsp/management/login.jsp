<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<link href="<%=basePath %>/assets/management/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
<link href="<%=basePath %>/assets/management/css/animate.min.css" rel="stylesheet">
<link href="<%=basePath %>/assets/management/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath %>/assets/management/css/style.min.css" rel="stylesheet">
<link href="<%=basePath %>/assets/management/css/login.min.css" rel="stylesheet">
<script src="<%=basePath %>/assets/management/js/jquery.min.js"></script>
<script src="<%=basePath %>/assets/management/js/md5.js"></script>
<title>一见喜商城</title>
</head>
<body class = "signin">
	<div class="signinpanel">
		<div class="row">
			<div class="col-sm-7">
				<div class="signin-info">
					<div>
						<h1>一见喜商城平台</h1>
					</div>
					<div class="m-b"></div>
				</div>
			</div>
		<!-- 
			<img width="154" height="40"
				src="<%=basePath%>assets/management/images/logo.png" />
		 -->		 	
			<div class="col-sm-5">
				<form id="login_form" action="login" method="post">
					<h4 class="no-margins">登录：</h4>
					<div class="form-group">
						<input class="form-control uname" id="username" placeholder="用户名"
							name="username" type="text">
					</div>
					<div class="form-group">
						<input class="form-control pword m-b" id="noencryptpassword" placeholder="密码"
							name="noencryptpassword" type="password"> <input
							class="form-control" id="password" name="password" type="hidden">
					</div>
					<input type="button" class="btn btn-success btn-block" onclick="submitForm()" value="登录">				
				</form>
				<c:if test="${!empty msg}">
					<div class="alert alert-danger">${msg}</div>
				</c:if>
			</div>
		</div>
	</div>
	<!-- End Login Screen -->
   	<script type="text/javascript">
	  $(document).ready(function(){
    	  $(document).keypress(function(e) {  
      	      //回车键事件  
      	      if(e.which == 13) { 
      	    	submitForm();
      	      }  
  	      });		 	
	  });
   	  //手动提交表单	  
	  function submitForm() {
   		  var username = document.getElementById("username");
   	      var password = document.getElementById("password");
   	   	  var noencryptpassword = document.getElementById("noencryptpassword");
   	      var pas_val = noencryptpassword.value;
   		  if(username.value == ""||username.value == null) {
	   		  $(".alert-danger").css("display","block");	   		
	   		  $(".alert-danger").html("用户名不能为空");
   		  }else {  	   	      
   	   		  var hash = hex_md5(pas_val);//hash为加密后的值
   	   		  password.value = hash;
   			  document.getElementById("login_form").submit();
   		  }
   	  }
	</script> 
</body>
</html>