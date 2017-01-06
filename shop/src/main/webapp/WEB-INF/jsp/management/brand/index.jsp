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
<!-- Mirrored from www.zi-han.net/theme/hplus/table_data_tables.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${webapp}</title>
	<script	src="<%=basePath%>assets/management/datatablejs/brand.js" type="text/javascript"></script>    
</head>
<body class="gray-bg">	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>品牌管理<small>查找，新增，修改</small></h5>
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
		                           <div class="col-sm-4">
	                                   <div class="form-group">
	                                       <label>品牌名称:</label>
	                                       <input type="text" placeholder="搜索品牌名称" id="name" class="form-control">
	                                   </div>
		                           </div>
		                           <div class="col-sm-4">
	                           			<div class="form-group">
	                                       <label>品牌简介:</label>
	                                       <input type="text" placeholder="搜索品牌简介" id="content" class="form-control">
	                                   </div>
		                           </div>
		                           <div class="col-sm-4">
	                           			<div class="form-group">
	                           				<label class="control-label">供应商名称：</label>	                           				
	                                       	<select class="reg-sel-index form-control" id="suppliername"  name="suppliername">
												<option value=""></option>
												<option value="">全部</option>
												<c:forEach items="${supplierMsg}" var="supplierList">
													<option value="${supplierList.name}">${supplierList.name}</option>
												</c:forEach>
											</select>											
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
								<th>品牌名称</th>
								<th>供应商名称</th>
								<th>品牌简介</th>
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
    <jsp:include page="add.jsp"/>
	<jsp:include page="delete.jsp"/>
	<jsp:include page="update.jsp"/>
    <!-- 
     -->
    <script>
	    $(document).ready(function(){
			$('.reg-sel-index').select2({
				  placeholder: "搜索供应商"
			});
		});
    </script>
</body>
</html>