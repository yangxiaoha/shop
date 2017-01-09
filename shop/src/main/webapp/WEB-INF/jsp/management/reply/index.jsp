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
	
	<script	src="<%=basePath%>assets/management/datatablejs/reply.js" type="text/javascript"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>自定义回复</title>
</head>
<body class="gray-bg">	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>自定义回复管理</h5>
                        <div class="ibox-tools">
                            <a data-toggle="modal" href="#addModal" id="add-row">
                                <i class="fa fa-plus"></i>
                            </a>
                            
                            <a id="delete-row">
                                <i class="fa fa-trash"></i>
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">
                      <div class="row">
                            <form role="form">
		                           <div class="col-sm-6">
	                                   <div class="form-group">
	                                       <label>关键词:</label>
	                                       <input type="text" placeholder="搜索关键词" id="skey" class="form-control">
	                                   </div>
		                           </div>
		                           <div class="col-sm-6">
	                           			<div class="form-group">
	                                       <label>品牌简介:</label>
	                                       <input type="text" placeholder="搜索回复内容" id="reply" class="form-control">
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
								<th width="20%">关键词</th>
								<th>回复内容</th>	
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