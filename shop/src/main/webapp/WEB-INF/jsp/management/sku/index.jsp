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
<title>${webapp}</title>
<link rel="shortcut icon" href="favicon.ico"> 
<link href="<%=basePath%>assets/management/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
<link href="<%=basePath%>assets/management/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
<link href="<%=basePath%>assets/management/css/plugins/iCheck/custom.css" rel="stylesheet">
<link href="<%=basePath%>assets/management/css/animate.min.css" rel="stylesheet">
<link href="<%=basePath%>assets/management/css/style.min862f.css?v=4.1.0" rel="stylesheet">
<script type="text/javascript">
 	var goodsId = ${goodsM.id};
 	var pageinit = ${pageinitM};
</script>
<script src="<%=basePath%>assets/management/js/plugins/iCheck/icheck.min.js"></script>
<script src="<%=basePath%>assets/management/datatablejs/sku.js" type="text/javascript"></script>
<style type="text/css">
	#add .pic {
	    width: 240px;
	    height: 252px;
	    position: relative;
	    border: 1px solid #d2d2d2;
	    overflow: hidden;
	}
	.pic div {
	    width: 100%;
	    cursor: pointer;
	}
	.image_file {
	    width: 100%;
	    height: 252px;
	    position: absolute;
	    top: 0;
	    left: 0;
	    cursor: pointer;
	    opacity: 0;
	    z-index: 9999;
	}
	p.error {
		margin: 10px 0;
		color: red;
	}
</style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row" style="margin: 0;">
        	<div class="col-sm-3 ibox-title">
        		<p>商品名称：${goodsM.name }</p>
				<p>商品总量：${goodsM.quantity }</p>
				<p>商品编码：${goodsM.code }</p>
				<p>商品供应商：${goodsM.suppliername }</p>
				<p>商品品牌：${goodsM.brandName }</p>
				<p>所属门店：${goodsM.store }</p>
        	</div>
            <div class="col-sm-9" style="">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                    <input id="pageinitval" value = ${pageinitM } type = "hidden"></input>
                        <h5>商品管理&nbsp;&nbsp;&nbsp;</h5>
                        <a type="button" id = "pageinit">返回商品列表</a>
                        <div class="ibox-tools">
                            <a data-toggle="modal" href="#addModal" id="add-row">
                                <i class="fa fa-plus"></i>
                            </a>                           
                        </div>
                    </div>
                    <div class="ibox-contentTable">
                    	<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th></th>
								<th class="check-header hidden-xs">
									<label style="margin-right:0px" class="checkbox-inline i-checks"><input id="checkAll" name="checkAll" type="checkbox"></label>
								</th>
								<th>商品名称</th>
								<th>商品数量</th>
								<th>商品价格</th>
								<th>特征量编码</th>
								<th></th>
								<th></th>
								<th>操作</th>
								<th>详情</th>	
							</thead>
							<tbody>
							</tbody>
						</table>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<jsp:include page="add.jsp" />
	<jsp:include page="update.jsp" />
	<jsp:include page="updateAdd.jsp" />
	<jsp:include page="see.jsp" />
	<script type="text/javascript">
		$("#pageinit").click(function(){
			var pageinitGoods = $("#pageinitval").val();
			window.location.href="../goods/index?pageinitGoods="+pageinitGoods; 
		});
	</script>
</body>
</html>