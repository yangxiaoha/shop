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
	<script	src="<%=basePath%>assets/management/datatablejs/order.js" type="text/javascript"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>订单管理</title>
    <style type="text/css">
     .noautowidth{
     	word-wrap:break-word;
		word-break:break-all;
     }
    </style>
</head>
<body class="gray-bg">	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>订单管理<small></small></h5>                       
                    </div>
                    <div class="ibox-content">
                      <div class="row">
                            <form role="form">
		                           <div class="col-sm-3">
	                                   <div class="form-group">
	                                       <label>物流商家:</label>
	                                       <input type="text" placeholder="搜索物流商家" id="logistics" class="form-control">
	                                   </div>
		                           </div>
		                           <div class="col-sm-3">
	                           			<div class="form-group">
	                                       <label>物流编号:</label>
	                                       <input type="text" placeholder="搜索物流编号" id="logisticsnum" class="form-control">
	                                   </div>
		                           </div>
		                            <div class="col-sm-3">
	                           			<div class="form-group">
	                                       <label>订单编号:</label>
	                                       <input type="text" placeholder="搜索订单编号" id="ordernum" class="form-control">
	                                   </div>
		                           </div>
		                           <div class="col-sm-3">
	                           			<div class="form-group">
	                           				<label class="control-label">订单状态</label>	
	                                       	<select class="reg-sel-index form-control" id="state"  name="state">
												<option value=""></option>
												<option value="0">全部</option>
												<option name="state" value="2">未发货</option>
												<option name="state" value="3">已发货</option>
												<option name="state" value="4">已收货</option>
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
								<th width="9%">收货人姓名</th>
								<th>收货人电话</th>
								<th width="18%">收货人地址</th>
								<th width="10%">下单时间</th>		
								<th width="9%">物流商家</th>		
								<th>物流编号</th>		
								<th>订单编号</th>		
								<th>订单状态</th>
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
    <jsp:include page="see.jsp"/>
    <script>    	
	    $(document).ready(function(){
			$('.reg-sel-index').select2({
				  placeholder: "搜索订单状态"
			});
		});
    </script>
</body>
</html>