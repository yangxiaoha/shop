<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
	<title>图片管理</title>
	<script
	src="<%=basePath%>assets/management/datatablejs/image.js"
	type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/ajaxfileupload1.js"
	type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/uploadphoto.js"
	type="text/javascript"></script>
	<style type="text/css">
		#add .pic {
		    width: 200px;
		    height: 200px;
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
		    height: 200px;
		    position: absolute;
		    top: 0;
		    left: 0;
		    cursor: pointer;
		    opacity: 0;
		    z-index: 9999;
		}
		#aimagename {
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
</head>
<body>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-lg-12">
				<div class="widget-container fluid-height clearfix">
					<div class="heading">
						<i class="icon-table"></i>图片管理
						<a class="btn btn-sm btn-primary-outline pull-right" data-toggle="modal" href="javascript:void(0)" id="delete-row"><i class="icon-trash"></i>删除</a>
						<a class="btn btn-sm btn-primary-outline pull-right" data-toggle="modal" href="#addModal" id="add-row"><i class="icon-plus"></i>添加</a>
					</div>
					<div class="widget-content padded clearfix">
						<div class="col-lg-12">
							<table class="table table-bordered table-striped table-hover">
								<tr>
						            <td>图片名称:</td>
						            <td><input class="form-control" type="text" id="" name=""></td>				          
						        </tr>
						    </table>
						 </div>
						 <hr>
						<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th class="check-header hidden-xs"><label><input
										id="checkAll" name="checkAll" type="checkbox"><span></span></label>
								</th>
								<th>图片名称</th>
								<th>图片链接</th>
								<th></th>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 
	<jsp:include page="add.jsp"/>
	<jsp:include page="edit.jsp"/>
	<jsp:include page="delete.jsp"/>
	 -->
</body>
</html>