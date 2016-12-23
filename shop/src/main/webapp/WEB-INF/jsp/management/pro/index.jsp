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
<title>商品属性管理</title>
<script type="text/javascript"
	src="<%=basePath%>assets/management/javascripts/jquery.ztree.core.js"></script>
<script
	src="<%=basePath%>assets/management/datatablejs/pro.js"	type="text/javascript"></script>
<link rel="stylesheet" href="<%=basePath%>assets/management/images/zTreeStyle.css"
	type="text/css">
<style type="text/css">
.cztree li {
    padding: 3px;
}
.cztree * {
    font-size: 13.5px;
}
</style>
</head>
<body>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-lg-12">
				<div class="widget-container fluid-height clearfix">
					<div class="col-lg-3">
						<table border=0 height=600px align=left>
							<tr>
								<td width=260px align=left valign=top
									style="BORDER-RIGHT: #999999 1px dashed">
									<ul id="tree" class="ztree cztree"
										style="width: 260px; overflow: auto;"></ul>
								</td>
							</tr>
						</table>
					</div>					
					<div class="col-lg-9">
						<div class="heading">
							<i class="icon-table"></i>商品属性管理 <a
								class="btn btn-sm btn-primary-outline pull-right"
								data-toggle="modal" href="javascript:void(0)" id="delete-row"><i
								class="icon-trash"></i>删除</a> <a
								class="btn btn-sm btn-primary-outline pull-right"
								data-toggle="modal" href="#addModal" id="add-row"><i
								class="icon-plus"></i>添加</a>
						</div>
						<div class="widget-content padded clearfix">							
							<hr>
							<table class="table table-bordered table-striped table-hover"
								id="datatable" width="100%">
								<thead>
									<th></th>
									<th class="check-header hidden-xs"><label><input
											id="checkAll" name="checkAll" type="checkbox"><span></span></label>
									</th>									
									<th>商品属性名称</th>																	
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
	<jsp:include page="add.jsp"/>
	<jsp:include page="delete.jsp"/>
	<jsp:include page="update.jsp"/>
<script type="text/javascript">
	
	var demoIframe;
	
	var setting = {
			view: {
				selectedMulti: false				
			},
			async: {
				enable: true,
				url:"getTreeData",
				autoParam:["id"],
				otherParam:{"otherParam":"zTreeAsyncTest"},
				dataFilter: filter
			},
			callback:{
				onClick: zTreeOnClick
			}
		};
	
	function zTreeOnClick(event, treeId, treeNode) {
		tableI.table().columns(4).search(treeNode.id).draw();
	};
	
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	};
	$(document).ready(function() {
		var t = $("#tree");
		t = $.fn.zTree.init(t, setting);
		demoIframe = $("#testIframe");
		demoIframe.bind("load", loadReady);
	});
	
	function loadReady() {
		var bodyH = demoIframe.contents().find("body").get(
				0).scrollHeight, htmlH = demoIframe
				.contents().find("html").get(0).scrollHeight, maxH = Math
				.max(bodyH, htmlH), minH = Math.min(bodyH,
				htmlH), h = demoIframe.height() >= maxH ? minH
				: maxH;
		if (h < 530)
			h = 530;
		demoIframe.height(h);
	}
</script>
</body>
</html>