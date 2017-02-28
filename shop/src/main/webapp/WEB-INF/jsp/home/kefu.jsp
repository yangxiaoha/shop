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
.phone {	
    position: absolute;
    top: 170px;
    left: 10px;
    width: 180px;
    height: auto;
}
</style>
</head>
<body>
	<div id="wrap">
		<h4 class="follow-tit">一见喜新疆棉花被</h4>
		<div style="position: relative; padding: 10px; margin-top: 50px; width: 100%">
			<img src="<%=basePath%>assets/home/images/kefu.png" style="width: 100%;" />
			<img src="<%=basePath%>assets/home/images/phone.gif" class="phone" />
		</div>		
	</div>
</body>
</html>