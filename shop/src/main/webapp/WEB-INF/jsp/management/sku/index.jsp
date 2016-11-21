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
<title>品牌管理</title>
<script type="text/javascript">
 	var goodsId = ${goodsM.id};
</script>
<script
	src="<%=basePath%>assets/management/datatablejs/sku.js"
	type="text/javascript"></script>
</head>
<body>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-lg-12">
				<div class="widget-container fluid-height clearfix">
					<div class="col-lg-3">
						<div class="row">
							<div class="col-lg-7">
								<p>商品名称：${goodsM.name }</p>
								<p>扩充名称：${goodsM.exp_name }</p>
								<p>商品总量：${goodsM.quantity }</p>
								<p>商品编码：${goodsM.code }</p>
								<p>商品品牌：${goodsM.brandName }</p>
								<p>所属门店：${goodsM.store }</p>
								<p>描述信息：${goodsM.content }</p>
							</div>
							<div class="col-lg-5">
								<p>商品类型：${goodsM.typename }</p>
								<p>商品属性：</p>
								<c:forEach items="${ goodsM.pros}" var="p">
									<p>${p.proname }</p>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="col-lg-9">
						<div class="heading">
							<i class="icon-table"></i>商品管理 <a
								class="btn btn-sm btn-primary-outline pull-right"
								data-toggle="modal" href="#addModal" id="add-row"><i
								class="icon-plus"></i>添加</a>
						</div>
						<div class="widget-content padded clearfix">
							<div class="col-lg-12">
								<table class="table table-bordered table-striped table-hover">
									<tr>
										<td>特征量编码:</td>
										<td><input class="form-control" type="text" id="code"
											name="code"></td>
									</tr>
								</table>
							</div>
							<table class="table table-bordered table-striped table-hover"
								id="datatable" width="100%">
								<thead>
									<th></th>
									<th class="check-header hidden-xs"><label><input
											id="checkAll" name="checkAll" type="checkbox"><span></span></label>
									</th>
									<th>商品数量</th>
									<th>商品价格</th>
									<th>特征量编码</th>
									<th></th>
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
	<jsp:include page="update.jsp" />
	<jsp:include page="add.jsp" />
	<jsp:include page="updateAdd.jsp" />
</body>
</html>