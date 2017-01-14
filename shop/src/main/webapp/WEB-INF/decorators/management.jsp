<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>一见喜商城</title>
    <meta name="keywords" content="${webapp}">
    <meta name="description" content="${webapp}">
    <link rel="shortcut icon" href="favicon.ico"> 
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="<%=basePath %>/assets/management/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <!-- Data Tables -->
    <link href="<%=basePath %>/assets/management/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/animate.min.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/style.min.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/plugins/datapicker/datepicker3.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/plugin/ztree/css/metroStyle/metroStyle.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/plugin/select2/css/select2.css" rel="stylesheet">

	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="<%=basePath %>/assets/management/js/jquery.min.js"></script>
    <script src="<%=basePath %>/assets/management/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/jeditable/jquery.jeditable.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/dataTables/jquery.dataTables.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/dataTables/dataTables.bootstrap.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/layer/laydate/laydate.js"></script>
    <script src="<%=basePath %>/assets/management/js/content.min.js?v=1.0.0"></script>
    <script src="<%=basePath %>/assets/management/datatablejs/base.js"></script>   
    <script src="<%=basePath %>/assets/management/datatablejs/ajaxSubmit.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/iCheck/icheck.min.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugin/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugin/ueditor/ueditor.all.js"> </script>
    <script src="<%=basePath %>/assets/management/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/validate/jquery.validate.min.js"></script>
     <script src="<%=basePath %>/assets/management/js/plugins/validate/additional-methods.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/validate/validateCss.js"></script>
    <script type="text/javascript" src="<%=basePath %>/assets/management/plugin/ztree/js/jquery.ztree.core.js"></script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugin/ueditor/lang/zh-cn/zh-cn.js"></script>    
	<script type="text/javascript" charset="utf-8" src="<%=basePath%>assets/management/plugin/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=basePath%>assets/management/plugin/ueditor/ueditor.all.js"> </script>
	<script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugin/select2/js/select2.js"></script>

	<script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugin/select2/js/i18n/zh-CN.js"></script>

	<script src="<%=basePath %>/assets/management/js/jquery.PrintArea.js"></script> 
	<script src="<%=basePath %>/assets/management/js/jQuery.print.js"></script> 

	<decorator:head />
</head>
<body class = "gray-bg">
	<decorator:body/>
</body>
</html>