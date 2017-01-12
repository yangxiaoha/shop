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
<title>商品类型管理</title>
<script
	src="<%=basePath%>assets/management/datatablejs/goodstype.js"	type="text/javascript"></script>
<style type="text/css">
.cztree li {
    padding: 3px;
}
.cztree * {
    font-size: 13.5px;
}
</style>	
</head>
<body class="gray-bg">	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
					<div class="col-sm-3">
						<table border=0 height=600px align=left>
							<tr>
								<td width=260px align=left valign=top
									style="BORDER-RIGHT: #999999 1px dashed;position: relative; ">
									<div style="position: absolute;right:10px;top:8px">
									 	<button class="btn btn-xs btn-info-outline" id = "blank">重置</button>
									</div>
									<h5>商品类型：</h5>
									<ul id="tree" class="ztree cztree"
										style="width: 260px; overflow: auto;"></ul>
								</td>
							</tr>
						</table>
					</div>					
					<div class="col-sm-9">
					<div class="row">
			            <div class="col-sm-12" >
			                <div class="ibox float-e-margins">
								<div class="ibox-title">						
						<h5>商品类型管理</h5>
						<div class="ibox-tools">
                            <a data-toggle="modal" href="#addModal" id="add-row" title="添加">
                                <i class="fa fa-plus"></i>
                            </a>
                            
                            <a id="delete-row" title="删除">
                                <i class="fa fa-trash"></i>
                            </a>
                        </div> 
                        <hr>                      
						<div class="widget-content padded clearfix">
							<table class="table table-bordered table-striped table-hover"
								id="datatable" width="100%">
								<thead>
									<th></th>
									<th class="check-header hidden-xs">
										<label style="margin-right:0px" class="checkbox-inline i-checks"><input id="checkAll" name="checkAll" type="checkbox"></label>
									</th>								
									<th>商品类型名称</th>																	
									<th>操作</th>																	
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
	$("#blank").click(function(){
		tableI.table().columns(4).search("").draw();
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		treeObj.cancelSelectedNode();
	});
	
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
	var it;
	$(document).ready(function() {
		var t = $("#tree");
		t = $.fn.zTree.init(t, setting);
		it = t;
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