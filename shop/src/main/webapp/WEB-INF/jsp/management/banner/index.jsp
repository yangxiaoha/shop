<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- Mirrored from www.zi-han.net/theme/hplus/table_data_tables.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="<%=basePath %>/assets/management/js/plugins/fancybox/jquery.fancybox.css" rel="stylesheet">
    <script src="<%=basePath %>/assets/management/js/plugins/peity/jquery.peity.min.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/fancybox/jquery.fancybox.js"></script>
    <title>首页滚动图</title>
</head>
<body class="gray-bg">
<style type="text/css">
	#add .pic {
	    width: 240px;
	    height: 240px;
	    position: relative;
	    border: 1px solid #d2d2d2;
	    overflow: hidden;
	}
	#update .pic {
	    width: 240px;
	    height: 240px;
	    position: relative;
	    border: 1px solid #d2d2d2;
	    overflow: hidden;
	}
	
	.pic div {
	    width: 100%;
	    cursor: pointer;
	}
	.image_file {
	    width: 100%;
	    height: 240px;
	    position: absolute;
	    top: 0;
	    left: 0;
	    cursor: pointer;
	    opacity: 0;
	    z-index: 9999;
	}
	#aurl,#uurl{
		    padding: 5px;
		    margin-right: 5px;
		    margin-bottom: 5px;
		    border-radius: 5px;
		    border: 1px solid #d2d2d2; 
		}
	p.error {
		margin: 10px 0;
		color: red;
	}
</style>	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                	<input type="hidden" id="basepath" value="<%=basePath%>">
                    <div class="ibox-title">
                        <h5>首页滚动图管理</h5>
                        <div class="ibox-tools">
                            <a data-toggle="modal" href="#addModal" id="add-row" title="添加">
                                <i class="fa fa-plus"></i>
                            </a>
                        </div>
                    </div>
                    <hr>                    
					<div class="col-lg-12">
						<ul class="notes">
		               		<c:forEach items="${bannerMsg}" var="bannerList">
			                    <li>
			                        <div>
			                            <img alt="image" width="100%" src="<%=basePath%>${bannerList.image}">
			                            <a>
			                            <i class="fa fa-trash del" data-id = "${bannerList.id}" title="删除"></i>
										<i class="fa fa-pencil update" data-id= "${bannerList.id}" 
										data-url="${bannerList.url}" data-image="${bannerList.image}" title="修改"></i></a>
			                        </div>
			                    </li>
		                    </c:forEach>                   
		                </ul>
					</div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="add.jsp"/>
	<jsp:include page="delete.jsp"/>
	<jsp:include page="update.jsp"/>
    <script type="text/javascript">
	    $(document).ready(function(){
	    	$(".fancybox").fancybox({openEffect:"none",closeEffect:"none"});
	    });
    </script>
</body>
</html>