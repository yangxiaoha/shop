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
<title>结算管理</title>
<script	src="<%=basePath%>assets/management/datatablejs/withdraw.js"
type="text/javascript"></script>	 
<style type="text/css">
	.select_time {
	    float: right;
		width: 250px;
		height: 34px;
		}
</style>	
</head>
<body class="gray-bg">
	<div class="wrapper wrapper-content animated fadeInRight">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-sm-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
                        <h5>结算管理<small></small></h5>                       
                    </div>
					<div class="ibox-content">					
						<div class="row">
							<form role="form">
							<div class="col-sm-5">
	                           <div class="col-sm-6">
                                   <div class="form-group">
                                       <label>用户id:</label>
                                       <input type="text" placeholder="搜索用户id" id="username" class="form-control">
                                   </div>
	                           </div>	                           
	                           <div class="col-sm-6">
                           			<div class="form-group">
                           				<label class="control-label">审核已否：</label>	
                                       	<select class="reg-sel-index form-control" id="state"  name="state">
											<option value=""></option>
											<option value="0">全部</option>
											<option name="state" value="1">未审核</option>
											<option name="state" value="2">不通过</option>
											<option name="state" value="3">已通过</option>
										</select>
                                   </div>
	                           </div>
	                           </div>
                            </form>							
						
							<div class="col-sm-7" style="float: right;margin-top: 2%">
								<button type="button" class="btn btn-info" id="btn-inquiry"
									style="float: right; margin: 0 0 0 15px;">查询</button>
								<div class="select_time">
									<div>
										<input style="width:80%;" readonly class="form-control layer-date endtime"
											id="endtime" placeholder="请选择提现申请结束时间"> <label
											class="laydate-icon inline demoicon" for="endtime"></label>
									</div>
								</div>
								<div
									style="float: right; height: 34px; line-height: 34px; margin: 0 6px;">至</div>
								<div class="select_time">
									<div>
										<input style="width:80%;"  readonly class="form-control layer-date" id="starttime"
											placeholder="请选择提现申请开始时间"> <label
											class="laydate-icon inline demoicon" for="starttime"></label>
									</div>
								</div>
							</div>
						</div>
						<hr>
						 <div class="ibox-contentTable">
						<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th></th>
								<th class="check-header hidden-xs" width="7%"><label
									style="margin-right: 0px" class="checkbox-inline i-checks"><input
										id="checkAll" name="checkAll" type="checkbox"></label></th>
								<th width="15%">用户名</th>
								<th width="15%">用户财富</th>
								<th>提现时间</th>
								<th width="15%">提现金额</th>		
								<th>提现状态</th>
								<th>详情</th>
								<th>操作</th>
								<th></th>
								<th></th>
								<th></th>
							</thead>
						</table>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="see.jsp"/>
<script type="text/javascript">	
	$(document).ready(function(){
		$('.reg-sel-index').select2({
			  placeholder: "搜索审核结果"
		});
	});
	var start = {
		elem : "#starttime",
		format : "YYYY-MM-DD",
		event : 'click',
		istime : true,
		istoday : false,
		choose : function(datas) {
			select_time();
		}
	};
	var end = {
		elem : "#endtime",
		format : "YYYY-MM-DD",
		event : 'click',
		istime : true,
		istoday : false,
		choose : function(datas) {
			select_time();
		}
	};
	laydate(start);
	laydate(end);

	//时间比较大小
	function diffDate(currentTime) {
		var current = new Date().getTime();
		var select = new Date(currentTime).getTime();
		if (current > select) {
			return 1;
		}
		return 0;
	}
	function select_time() {
		var starttime = new Date($("#starttime").val()).getTime();
		var endtime = new Date($("#endtime").val()).getTime();
		if (starttime != null && starttime != "" && endtime != null
				&& endtime != "") {
			if (starttime > endtime) {
				alert("结束时间不可早于开始查询时间");
				$("#btn-inquiry").attr("disabled", true);
			} else {
				$("#btn-inquiry").removeAttr("disabled");
			}
		}
	}
	$("#btn-inquiry").click( function() {	
		tableI.table().columns(9).search($("#starttime").val());
		tableI.table().columns(10).search($("#endtime").val());
		tableI.table().draw();
	});
</script>	
</body>
</html>