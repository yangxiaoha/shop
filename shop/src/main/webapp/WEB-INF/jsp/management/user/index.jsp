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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>会员管理</title>
<script type="text/javascript">
 	var userId = ${id};
</script>
<script src="<%=basePath%>assets/management/datatablejs/user.js"
	type="text/javascript"></script>	
</head>
<body>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-lg-12">
				<div div class="widget-container fluid-height clearfix">
					<c:set var = "ids" value = "${id}"></c:set>
					<c:if test="${ ids > 0 }">
					<div class="col-lg-2">
						<div class="row">
							<div class="col-lg-12">
								<p>用户名&nbsp：${user.openid}</p>
								<p>注册时间：${user.regtime}</p>
								<p>财&nbsp;&nbsp富：${user.money}</p>
							</div>
						</div>
					</div>					
					<div class="col-lg-10">
					</c:if>
					<c:if test="${ ids == 0 }">
						<div class="col-lg-12">
					</c:if>
						<div class="heading">
							<i class="icon-table"></i>会员管理
							<c:set var = "ids" value = "${id}"></c:set>
							<c:if test="${ ids > 0 }">
							<a class="btn btn-sm btn-primary-outline pull-right" href= "../user/index"><i
								class="icon-reply"></i>返回用户列表</a>
							</c:if>
						</div>
						<div class="widget-content padded clearfix">
							<div class="col-lg-12">
								<table class="table table-bordered table-striped table-hover">
									<tr>
										<td width="8%">用户名:</td>
										<td><input class="form-control" type="text" id="openid"
											name="openid" placeholder="用户名模糊搜索"></td>
										<td width="8%">财富:</td>
										<td><input class="form-control" type="text" id="money"
											name="money"></td>
									</tr>
								</table>
							</div>
							<hr>
							<table class="table table-bordered table-striped table-hover"
								id="datatable" width="100%">
								<thead>
									<th class="check-header hidden-xs" width="8%"><label><input
											id="checkAll" name="checkAll" type="checkbox"><span></span></label>
									</th>
									<th width="20%">用户名</th>
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
	</div>
</body>
</html>