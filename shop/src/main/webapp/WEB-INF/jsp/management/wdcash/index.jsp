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
<title>提现管理</title>
<script	src="<%=basePath%>assets/management/datatablejs/withdraw.js"
type="text/javascript"></script>
<script	src="<%=basePath%>assets/management/javascripts/sweetalert-dev.js"
type="text/javascript"></script>
<script src="<%=basePath%>assets/management/javascripts/select2.js" type="text/javascript"></script>
<script type="text/javascript" 
src="<%=basePath%>assets/management/javascripts/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" 
src="<%=basePath%>assets/management/javascripts/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<link href="<%=basePath%>assets/management/stylesheets/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen">
<link href="<%=basePath %>assets/management/stylesheets/sweetalert.css" 
 rel="stylesheet" type="text/css" />
	 
<style type="text/css">
	#settlement {
			color: #007aff;
		}		
	.btn-info-a {
		    color: #fff;
		    background-color: #C0C0C0;
		    border-color: #C0C0C0;
		}
	.select-time {
	    float: right;
		width: 300px;
		height: 34px;
		}
</style>	
</head>
<link href="<%=basePath%>assets/management/stylesheets/select2.css" media="all" rel="stylesheet" type="text/css" />
<body>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-lg-12">
				<div class="widget-container fluid-height clearfix">
					<div class="heading">
						<i class="icon-table"></i>提现管理
					</div>
					<div class="widget-content padded clearfix">
						<div class="col-lg-12">
							<table class="table table-bordered table-striped table-hover">
								<tr>						            
						            <td width="8%">用户id:</td>
									<td><input class="form-control" type="text" id="username" name="username" placeholder="搜索用户id"></td>
									<td width="8%">审核已否:</td>
									<td>									
									<select class="reg-sel" id="state" name="state">
										<option value=""></option>
										<option value="">全部</option>
										<option name="state" value="1">未审核</option>
										<option name="state" value="2">不通过</option>
										<option name="state" value="3">已通过</option>
									</select>
									</td>									
								</tr>
						    </table>
						 </div>
						 <div class="col-lg-12"> 				 
							<button type="button" class="btn btn-md btn-info-a" id="btn-inquiry-a" style="float: right; margin: 0 0 0 15px;" >清除</button>
							<button type="button" class="btn btn-md btn-info" id="btn-inquiry" style="float: right; margin: 0 0 0 15px;" >查询</button>
						 	<div class="select-time">	              
				                <div class="input-group date form_date" data-date="" data-date-format="dd MM yyyy" data-link-field="endtime" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="select-endtime" size="16" type="text" value="" placeholder="请选择查询结束时间" readonly>				                    
									<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
								<input name="endtime" type="hidden" id="endtime" /><br/>
				            </div>
				            <div style="float:right;height:34px;line-height:34px;margin:0 6px;">至</div>
				            <div class="select-time">				              
				                <div class="input-group date form_date" data-date="" data-date-format="dd MM yyyy" data-link-field="starttime" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="select-starttime" size="16" type="text" value="" placeholder="请选择查询开始时间" readonly>
									<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
								<input name="starttime" type="hidden" id="starttime" /><br/>
				            </div>			            
					 	</div>
					 	<div style="height:1px;clear:both;"></div>													 
						 <hr>
						<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th></th>
								<th class="check-header hidden-xs" width="8%"><label><input
										id="checkAll" name="checkAll" type="checkbox"><span></span></label>
								</th>
								<th width="15%">用户id</th>
								<th width="15%">用户财富</th>
								<th>提现时间</th>
								<th width="15%">提现金额</th>		
								<th>提现状态</th>
								<th style="color: #007aff;">操作</th>
								<th></th>
								<th></th>
							</thead>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">	
	$(document).ready(function(){
		$('.reg-sel').select2({
			  placeholder: "搜索审核结果"
		});
	});
	$('.form_date').datetimepicker({
		format: 'yyyy-mm-dd',
	    language:  'zh-CN',
	    weekStart: 1,
	    todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0
	});

	//时间比较大小
	function diffDate(currentTime) {
		var current = new Date().getTime();
		var select = new Date(currentTime).getTime();
		if (current > select) {
		    return 1;
		} 
		return 0;
	}
	$("#select-endtime").change(function(){
		var starttime = new Date($("#starttime").val()).getTime();
		var endtime = new Date($("#endtime").val()).getTime();
		if(starttime != null && starttime != "" && endtime != null && endtime != "") {
			if(starttime > endtime) {
				alert("结束时间不可早于开始查询时间");	
				$("#btn-inquiry").attr("disabled", true);
			}else {
				$("#btn-inquiry").removeAttr("disabled");
			}
		}
	});

	$("#btn-inquiry-a").click( function() {	
		$("#select-starttime").val("");
		$("#select-endtime").val("");
		$("#starttime").val("");
		$("#endtime").val("");
		tableI.table().columns(8).search($("#starttime").val());
		tableI.table().columns(9).search($("#endtime").val());
		tableI.table().draw();
		
	});
	$("#btn-inquiry").click( function() {	
		tableI.table().columns(8).search($("#starttime").val());
		tableI.table().columns(9).search($("#endtime").val());
		tableI.table().draw();
	});
</script>	
</body>
</html>