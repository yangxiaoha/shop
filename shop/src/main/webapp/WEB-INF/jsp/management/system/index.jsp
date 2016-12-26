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
	<title>系统管理</title>
	<script
	src="<%=basePath%>assets/management/datatablejs/system.js"
	type="text/javascript"></script>
	<style type="text/css">
		#systems {
			color: #007aff;
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
						<i class="icon-table"></i>系统管理
					</div>
					<div class="widget-content padded clearfix">
						<div class="col-lg-12">
							<table class="table table-bordered table-striped table-hover">
								<tr>
						            <td width="8%">skey:</td>
						            <td><input class="form-control" type="text" id="skey" name="skey" placeholder="搜索skey"></td>
						            <td width="8%">sysvalue:</td>
									<td><input class="form-control" type="text" id="sysvalue" name="sysvalue" placeholder="搜索sysvalue"></td>																				
								</tr>
						    </table>
						 </div>						 
						 <hr>
						<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th></th>
								<th class="check-header hidden-xs"  width="8%"><label><input
										id="checkAll" name="checkAll" type="checkbox"><span></span></label>
								</th>
								<th  width="20%">skey</th>
								<th>sysvalue</th>	
								<th style="color: #007aff;">操作</th>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="update.jsp"/>
</body>
</html>