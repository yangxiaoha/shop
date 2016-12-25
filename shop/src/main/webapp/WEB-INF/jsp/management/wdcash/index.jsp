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
	<title>提现管理</title>
	<script	src="<%=basePath%>assets/management/datatablejs/withdraw.js"
	type="text/javascript"></script>
	<script	src="<%=basePath%>assets/management/javascripts/sweetalert-dev.js"
	type="text/javascript"></script>
	<link href="<%=basePath %>assets/management/stylesheets/sweetalert.css" 
	 rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-lg-12">
				<div class="widget-container fluid-height clearfix">
					<div class="heading">
						<i class="icon-table"></i>提现管理
					</div>
					<div class="widget-content padded clearfix">
						<div class="col-lg-12">
							<table class="table table-bordered table-striped table-hover">
								<tr>						            
						            <td width="8%">用户id:</td>
									<td><input class="form-control" type="text" id="username" name="username" placeholder="用户id模糊搜索"></td>
									<td width="8%">审核已否:</td>
									<td>									
									<select class="reg-sel form-control" id="state" name="state">
										<option value=""></option>
										<option name="state" value="1">未审核</option>
										<option name="state" value="2">未通过</option>
										<option name="state" value="3">已通过</option>
									</select>
									</td>									
								</tr>
						    </table>
						 </div>						 
						 <hr>
						<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th></th>
								<th class="check-header hidden-xs" width="8%"><label><input
										id="checkAll" name="checkAll" type="checkbox"><span></span></label>
								</th>
								<th width="15%">用户id</th>
								<th width="15%">用户财富</th>
								<th>提现时间</th>
								<th width="15%">提现金额</th>		
								<th>提现状态</th>
								<th></th>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>	
</body>
</html>