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
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>自动回复管理</title>
	<script
	src="<%=basePath%>assets/management/datatablejs/reply.js"
	type="text/javascript"></script>
</head>
<body>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-lg-12">
				<div class="widget-container fluid-height clearfix">
					<div class="heading">
						<i class="icon-table"></i>自动回复管理
						<a class="btn btn-sm btn-primary-outline pull-right" data-toggle="modal" href="javascript:void(0)" id="delete-row"><i class="icon-trash"></i>删除</a>
						<a class="btn btn-sm btn-primary-outline pull-right" data-toggle="modal" href="#addModal" id="add-row"><i class="icon-plus"></i>添加</a>
					</div>
					<div class="widget-content padded clearfix">
						<div class="col-lg-12">
							<table class="table table-bordered table-striped table-hover">
								<tr>
						            <td width="8%">skey:</td>
						            <td width="30%"><input class="form-control" type="text" id="skey" name="skey" placeholder="skey模糊搜索"></td>
						            <td width="8%">回复内容:</td>
									<td><input class="form-control" type="text" id="reply" name="reply" placeholder="回复内容模糊搜索"></td>																				
								</tr>
						    </table>
						 </div>						 
						 <hr>
						<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th class="check-header hidden-xs" width="8%"><label><input
										id="checkAll" name="checkAll" type="checkbox"><span></span></label>
								</th>
								<th width="20%">skey</th>
								<th>回复内容</th>	
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
	<jsp:include page="delete.jsp"/>
	<jsp:include page="update.jsp"/>
</body>
</html>