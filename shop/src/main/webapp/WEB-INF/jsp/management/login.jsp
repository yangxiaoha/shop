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
	<link href="<%=basePath %>assets/management/stylesheets/bootstrap.min.css" media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath %>assets/management/stylesheets/font-awesome.css" media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath %>assets/management/stylesheets/se7en-font.css" media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath %>assets/management/stylesheets/style.css" media="all" rel="stylesheet" type="text/css" />
	<script src="<%=basePath %>assets/management/javascripts/jquery.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery-ui.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/bootstrap.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/raphael.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.mousewheel.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.vmap.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.vmap.sampledata.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.vmap.world.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.bootstrap.wizard.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/fullcalendar.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/gcal.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.dataTables.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/datatable-editable.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.easy-pie-chart.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/excanvas.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.isotope.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/masonry.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/modernizr.custom.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.fancybox.pack.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/select2.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/styleswitcher.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/wysiwyg.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.inputmask.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.validate.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/bootstrap-fileupload.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/bootstrap-datepicker.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/bootstrap-timepicker.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/bootstrap-colorpicker.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/bootstrap-switch.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/daterange-picker.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/date.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/morris.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/skycons.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/jquery.sparkline.min.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/fitvids.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/main.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/respond.js" type="text/javascript"></script>
	<script src="<%=basePath %>assets/management/javascripts/md5.js" type="text/javascript"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>一见喜商城</title>
</head>
<body class = "login1">
	<div class="login-wrapper">
		<div class="login-container">
		<!-- 
			<img width="154" height="40"
				src="<%=basePath%>assets/management/images/logo.png" />
		 -->
		 	<p>一见喜商城平台</p>
			<c:if test="${!empty msg}">
				<div class="alert alert-danger">${msg}</div>
			</c:if>
			<div class="alert alert-danger" style="display: none;"></div>
			<form id="login_form" action="login" method="post">
				<div class="form-group">
					<input class="form-control" id="username" placeholder="用户名"
						name="username" type="text">
				</div>
				<div class="form-group">
					<input class="form-control" id="noencryptpassword" placeholder="密码"
						name="noencryptpassword" type="password"> <input
						class="form-control" id="password" name="password" type="hidden">
				</div>
				<input class="btn btn-lg btn-info"
					style="width: 100%; margin-top: 10px" type="button" value="登录"
					onclick="submitForm()">
			</form>
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
   	      
   		  if(username.value == "") {
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