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
<script type="text/javascript"
	src="<%=basePath%>assets/management/javascripts/jquery.ztree.core.js"></script>
<script
	src="<%=basePath%>assets/management/datatablejs/goods.js"
	type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>assets/management/plugin/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>assets/management/plugin/ueditor/ueditor.all.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="<%=basePath%>assets/management/plugin/ueditor/lang/zh-cn/zh-cn.js"></script>
<link rel="stylesheet"
	href="<%=basePath%>assets/management/images/zTreeStyle.css"	type="text/css">
<style type="text/css">
.cztree li {
    padding: 3px;
}
.cztree * {
    font-size: 13.5px;
}
.modal-backdrop{
	z-index:900;
}
.navbar-fixed-top {
    z-index: 800;
}
.modal {
    z-index: 910;
}
</style>

<script type="text/javascript">
	var zTree;
	
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
		tableI.table().columns(9).search(treeNode.id).draw();
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
		var zTree = $.fn.zTree.getZTreeObj("tree");
		zTree.selectNode(zTree.getNodeByParam("id", 101));
	
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
							<i class="icon-table"></i>商品管理 <a
								class="btn btn-sm btn-primary-outline pull-right"
								data-toggle="modal" href="javascript:void(0)" id="delete-row"><i
								class="icon-trash"></i>删除</a> <a
								class="btn btn-sm btn-primary-outline pull-right"
								data-toggle="modal" href="#addModal" id="add-row"><i
								class="icon-plus"></i>添加</a>
						</div>
						<div class="widget-content padded clearfix">
							<div class="col-lg-12">
								<table class="table table-bordered table-striped table-hover">
									<tr>
										<td>商品名称:</td>
										<td><input class="form-control" type="text" id="name"
											name="name" placeholder="商品名称模糊搜索"></td>
										<td>商品描述:</td>
										<td><input class="form-control" type="text" id="content"
											name="content" placeholder="商品描述模糊搜索"></td>
										<td>商品编码:</td>
										<td><input class="form-control" type="text" id="code"
											name="code" placeholder="商品编码模糊搜索"></td>										
									</tr>
								</table>
							</div>
							<hr>
							<table class="table table-bordered table-striped table-hover"
								id="datatable" width="100%">
								<thead>
									<th></th>
									<th class="check-header hidden-xs"><label><input
											id="checkAll" name="checkAll" type="checkbox"><span></span></label>
									</th>									
									<th>商品名称</th>
									<th>商品扩充名称</th>
									<th>商品编码</th>
									<th>商品品牌</th>
									<th>所属门店</th>
									<th></th>
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
	<jsp:include page="stick.jsp"/>
	<jsp:include page="detailedit.jsp"/>
</body>
</html>