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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>会员管理</title>
<script type="text/javascript">
 	var userId = ${id};
</script>
<link href="<%=basePath%>assets/management/stylesheets/bootstrap-datetimepicker.min.css"
 rel="stylesheet" media="screen">
<script src="<%=basePath%>assets/management/datatablejs/user.js"
	type="text/javascript"></script>
<script type="text/javascript" 
	src="<%=basePath%>assets/management/javascripts/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" 
	src="<%=basePath%>assets/management/javascripts/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<style type="text/css">
	.btn-info-a {
		    color: #fff;
		    background-color: #C0C0C0;
		    border-color: #C0C0C0;
		}
	.error {
	    margin: 10px 0px;
  		color: #EA4242;
		}
	.select-time {
	    float: right;
		width: 300px;
		height: 34px;
		}
	#member {
			color: #007aff;
		}
</style>	
</head>
<body>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-lg-12">
				<div class="widget-container fluid-height clearfix">
					<c:set var = "ids" value = "${id}"></c:set>
					<c:if test="${ ids > 0 }">
					<div class="col-lg-2">
						<div class="row">
							<div class="col-lg-12">
								<p>用户名&nbsp：${user.openid}</p>
								<p>注册时间：${user.regtime}</p>
								<p>财&nbsp;&nbsp富：${user.money}</p>
							</div>
						</div>
					</div>					
					<div class="col-lg-10">
					</c:if>
					<c:if test="${ ids == 0 }">
						<div class="col-lg-12">
					</c:if>
						<div class="heading">
							<i class="icon-table"></i>会员管理
							<c:set var = "ids" value = "${id}"></c:set>
							<c:if test="${ ids > 0 }">
							<a class="btn btn-sm btn-primary-outline pull-right" href= "../user/index"><i
								class="icon-reply"></i>返回用户列表</a>
							</c:if>
						</div>
						<div class="widget-content padded clearfix">
							<div class="col-lg-12">
								<table class="table table-bordered table-striped table-hover">
									<tr>
										<td width="8%">用户名:</td>
										<td><input class="form-control" type="text" id="openid"
											name="openid" placeholder="用户名模糊搜索"></td>
										<td width="8%">财富:</td>
										<td  width="23%"><input class="form-control" type="text" id="startmoney"
											name="startmoney" placeholder="财富值下限"></td>
										<td width="23%"><input class="form-control" type="text" id="endmoney"
											name="endmoney" placeholder="财富值上限"></td>
										<td width="7%"><button type="button" class="btn btn-md btn-info" id="btn-inquiry-m" 
										style="float: right; margin: 0 0 0 15px;" >查询</button></td>
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
							<table class="table table-bordered table-striped table-hover"
								id="datatable" width="100%">
								<thead>
									<th class="check-header hidden-xs" width="8%"><label><input
											id="checkAll" name="checkAll" type="checkbox"><span></span></label>
									</th>
									<th width="20%">用户名</th>
									<th>注册时间</th>
									<th>财富</th>
									<th></th>
									<th></th>
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
	<script type="text/javascript">
	$("#btn-inquiry-m").click( function() {	
		tableI.table().columns(4).search($("#startmoney").val());
		tableI.table().columns(5).search($("#endmoney").val());
		tableI.table().draw();
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
		tableI.table().columns(6).search($("#starttime").val());
		tableI.table().columns(7).search($("#endtime").val());
		tableI.table().draw();
		
	});
	$("#btn-inquiry").click( function() {	
		tableI.table().columns(6).search($("#starttime").val());
		tableI.table().columns(7).search($("#endtime").val());
		tableI.table().draw();
	});
	</script>
</body>
</html>