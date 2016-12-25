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
	<title>订单管理</title>
	<script
	src="<%=basePath%>assets/management/datatablejs/order.js"
	type="text/javascript"></script>
</head>
<body>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-lg-12">
				<div class="widget-container fluid-height clearfix">
					<div class="heading">
						<i class="icon-table"></i>订单管理	
					</div>
					<div class="widget-content padded clearfix">
						<div class="col-lg-12">
							<table class="table table-bordered table-striped table-hover">
								<tr>						            
						            <td>物流商家:</td>
									<td><input class="form-control" type="text" id="logistics" name="logistics" placeholder="物流商家模糊搜索"></td>	
									<td>物流编号:</td>
									<td><input class="form-control" type="text" id="logisticsnum" name="logisticsnum" placeholder="物流编号模糊搜索"></td>
									<td>订单编号:</td>
									<td><input class="form-control" type="text" id="ordernum" name="ordernum" placeholder="订单编号模糊搜索"></td>									
									<td>订单状态:</td>
									<td>
									<select class="reg-sel form-control" id="state" name="state">
										<option value=""></option>
										<option name="state" value="2">未发货</option>
										<option name="state" value="3">已发货</option>
										<option name="state" value="4">已收货</option>
									</select>
									</td>									
								</tr>
						    </table>
						 </div>						 
						 <hr>
						<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th></th>
								<th class="check-header hidden-xs"><label><input
										id="checkAll" name="checkAll" type="checkbox"><span></span></label>
								</th>
								<th>收货人姓名</th>
								<th>收货人电话</th>
								<th width="20%">收货人地址</th>
								<th width="14%">下单时间</th>		
								<th>物流商家</th>		
								<th>物流编号</th>		
								<th>订单编号</th>		
								<th>订单状态</th>
								<th></th>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>	
	<jsp:include page="see.jsp"/>
</body>
</html>