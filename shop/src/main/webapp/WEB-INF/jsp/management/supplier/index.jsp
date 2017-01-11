<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>供应商管理</title>
	<script
	src="<%=basePath%>assets/management/datatablejs/supplier.js"
	type="text/javascript"></script>
</head>
<body class="gray-bg">	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
					<div class="ibox-title">
                        <h5>供应商管理</h5>
                        <div class="ibox-tools">
                            <a data-toggle="modal" href="#addModal" id="add-row" title="添加">
                                <i class="fa fa-plus"></i>
                            </a>
                            
                            <a id="delete-row" title="删除">
                                <i class="fa fa-trash"></i>
                            </a>
                        </div>
                    </div>
					<div class="ibox-content">
                        <div class="row">
                            <form role="form">
	                           <div class="col-sm-6">
                                   <div class="form-group">
                                       <label>供应商名称:</label>
                                       <input type="text" placeholder="请输入供应商名称" id="name" class="form-control">
                                   </div>
	                           </div>
	                           <div class="col-sm-6">
                           			<div class="form-group">
                                       <label>供应商简介:</label>
                                       <input type="text" placeholder="请输供应商简介" id="brief" class="form-control">
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
									<label style="margin-right:0px" class="checkbox-inline i-checks"><input id="checkAll" name="checkAll" type="checkbox"></label>
								</th>
								<th width="20%">供应商名称</th>
								<th>供应商简介</th>		
								<th>操作</th>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="add.jsp"/>
	<jsp:include page="delete.jsp"/>
	<jsp:include page="update.jsp"/>
</body>
</html>