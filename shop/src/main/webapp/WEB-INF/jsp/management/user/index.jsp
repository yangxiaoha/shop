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
 	var temp = ${tempM};
</script>
<script src="<%=basePath%>assets/management/datatablejs/user.js"
	type="text/javascript"></script>
<style type="text/css">
	.error {
	    margin: 10px 0px;
  		color: #EA4242;
		}
	.select_time {
	    float: right;
		width: 300px;
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
						<h5>会员管理</h5>
						<c:set var="ids" value="${id}"></c:set>
						<c:if test="${ ids > 0 }">
						<a class="btn btn-sm btn-primary-outline pull-right"
							href="../user/index"><i class=""></i>返回用户列表</a>
					</c:if>
					</div>
					<c:set var = "ids" value = "${id}"></c:set>
					<c:if test="${ ids > 0 }">
					<div class="col-sm-2">
						<div class="row">
							<div class="col-sm-12">
								<hr>
								<h5>上级会员信息：</h5>
								<p></p>
								<p>用户名&nbsp：${user.name}</p>
								<p>注册时间：${user.regtime}</p>
								<p>财&nbsp;&nbsp富：${user.money}</p>
							</div>
						</div>
					</div>					
						<div class="col-sm-10">
					</c:if>					
					<div class="ibox-content">
						<div class="row">
							<form role="form">
								<div class="col-sm-3">
									<div class="form-group">
										<label>用户名:</label> <input type="text" placeholder="搜索用户名"
											id="name" class="form-control">
									</div>
								</div>
								<div class="col-sm-3">
                           			<div class="form-group">
                           				<label class="control-label">会员分销类型：</label>	
                                       	<select class="reg-sel-index form-control" id="isnot"  name="isnot">
											<option value=""></option>
											<option value="0">全部</option>
											<option name="isnot" value="1">非分销会员</option>
											<option name="isnot" value="2">分销会员</option>
										</select>
                                   </div>
	                           </div>
								<div class="col-sm-3">
									<div class="form-group">
										<label>财富:</label> <input type="text" placeholder="财富值下限"
											id="startmoney" class="form-control">
									</div>
								</div>
								<div class="col-sm-3">
									<div class="form-group">
										<label>&nbsp;</label> 
										<input type="text"
											placeholder="财富值上限" id="endmoney" class="form-control">
									</div>
								</div>						
							</form>
						</div>
						<div class="row">
							<div class="col-sm-12">
								<button type="button" class="btn btn-info" id="btn-inquiry"
									style="float: right; margin: 0 0 0 15px;">查询</button>
								<div class="select_time">
									<div>
										<input readonly class="form-control layer-date endtime"
											id="endtime" placeholder="请选择注册结束时间"> <label
											class="laydate-icon inline demoicon" for="endtime"></label>
									</div>
								</div>
								<div
									style="float: right; height: 34px; line-height: 34px; margin: 0 6px;">至</div>
								<div class="select_time">
									<div>
										<input readonly class="form-control layer-date" id="starttime"
											placeholder="请选择注册开始时间"> <label
											class="laydate-icon inline demoicon" for="starttime"></label>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="ibox-contentTable">
						<table class="table table-bordered table-striped table-hover"
							id="datatable" width="100%">
							<thead>
								<th></th>
								<th class="check-header hidden-xs" width="7%"><label
									style="margin-right: 0px" class="checkbox-inline i-checks"><input
										id="checkAll" name="checkAll" type="checkbox"></label></th>
								<th width="20%">用户名</th>
								<th>注册时间</th>
								<th>财富</th>
								<th></th>
								<th></th>
								<th></th>
								<th></th>
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
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			$('.reg-sel-index').select2({
				language:"zh-CN",
				placeholder: "搜索分销会员"
			});
		});
		var start = {
			elem : "#starttime",
			format : "YYYY-MM-DD",
			event : 'click',
			istime : false,
			istoday : false,
			choose : function(datas) {
				select_time();
			}
		};
		var end = {
			elem : "#endtime",
			format : "YYYY-MM-DD",
			event : 'click',
			istime : false,
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
		$("#btn-inquiry").click(function() {
			tableI.table().columns(5).search($("#startmoney").val());
			tableI.table().columns(6).search($("#endmoney").val());
			tableI.table().columns(7).search($("#starttime").val());
			tableI.table().columns(8).search($("#endtime").val());
			tableI.table().draw();
		});
		$("#isnot").change(function() {
			tableI.table().columns(10).search($("#isnot").val());
			tableI.table().draw();
		});
	</script>
</body>
</html>