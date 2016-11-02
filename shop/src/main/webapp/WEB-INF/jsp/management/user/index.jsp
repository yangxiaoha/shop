<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>会员管理</title>
	<script
	src="<%=basePath%>assets/management/datatablejs/user.js"
	type="text/javascript"></script>
</head>
<body>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-lg-12">
				<div class="widget-container fluid-height clearfix">
					<div class="heading">
						<i class="icon-table"></i>会员管理
						<a class="btn btn-sm btn-primary-outline pull-right" data-toggle="modal" href="javascript:void(0)" id="delete-row"><i class="icon-trash"></i>删除</a>
						<a class="btn btn-sm btn-primary-outline pull-right" data-toggle="modal" href="#addModal" id="add-row"><i class="icon-plus"></i>添加</a>
					</div>
					<div class="widget-content padded clearfix">
						<div class="col-lg-12">
							<table class="table table-bordered table-striped table-hover">
								<tr>
						            <td>openid:</td>
						            <td><input class="form-control" type="text" id="openid" name="openid"></td>
						            <td>财富:</td>
						            <td><input class="form-control" type="text" id="money" name="money"></td>
						        </tr>
						    </table>
						 </div>
						 <hr>
						<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th class="check-header hidden-xs"><label><input
										id="checkAll" name="checkAll" type="checkbox"><span></span></label>
								</th>
								<th>openid</th>
								<th>注册时间</th>
								<th>财富</th>	
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
	<jsp:include page="add.jsp"/>
</body>
</html>