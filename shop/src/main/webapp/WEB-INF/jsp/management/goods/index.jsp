<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- Mirrored from www.zi-han.net/theme/hplus/table_data_tables.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>
    <script src="<%=basePath %>assets/management/datatablejs/goods.js" type="text/javascript"></script>
</head>

<body class="gray-bg">	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">        	
        	<div class="col-sm-3" style="padding-right:0px">
        		<div class="ibox-contentTable">	
        			<h5>商品类型：</h5>
					<ul id="tree" class="ztree"></ul>
                </div>
        	</div>
            <div class="col-sm-9" style="">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>商品管理</h5>
                        <div class="ibox-tools">
                            <a href="../addGoods/index" id="add-row" title="添加">
                                <i class="fa fa-plus"></i>
                            </a>                           
                            <a id="delete-row">
                                <i class="fa fa-trash" title="删除"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <form role="form">
	                           <div class="col-sm-6">
                                   <div class="form-group">
                                       <label>商品名称:</label>
                                       <input type="text" placeholder="请输入商品名称" id="name" class="form-control">
                                   </div>
	                           </div>
	                           <div class="col-sm-6">
                           			<div class="form-group">
                                       <label>商品编码:</label>
                                       <input type="text" placeholder="请输商品编码" id="code" class="form-control">
                                   </div>
	                           </div>
                            </form>
                        </div>
                    </div>
                    <div class="ibox-contentTable">
                    	<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th></th>
								<th class="check-header hidden-xs">
									<label style="margin-right:0px" class="checkbox-inline i-checks">
										<input id="checkAll" name="checkAll" type="checkbox">
									</label>
								</th>
								<th width="20%">商品名称</th>
								<th>商品供应商</th>
								<th>商品总量</th>
								<th>商品编码</th>
								<th>商品品牌</th>
								<th>所属门店</th>
								<th>操作</th>
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
	<jsp:include page="delete.jsp"/>
	<jsp:include page="update.jsp"/>
	<jsp:include page="stick.jsp"/>
	<jsp:include page="detailedit.jsp"/>
    <script>
    	
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
		
		$("#blank").click(function(){
			tableI.table().columns(10).search("").draw();
			var treeObj = $.fn.zTree.getZTreeObj("tree");
			treeObj.cancelSelectedNode();
		});
		
		function zTreeOnClick(event, treeId, treeNode) {
			tableI.table().columns(10).search(treeNode.id).draw();
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

</body>
</html>