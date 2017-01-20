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
	
	<script	src="<%=basePath%>assets/management/datatablejs/evaluate.js" type="text/javascript"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>评价管理</title>
    <style type="text/css">
    	.select-time {
		    float: right;
			width: 300px;
			height: 34px;
		}
    </style>
</head>
<body class="gray-bg">	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>评价管理</h5>
                        <div class="ibox-tools">                            
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
                                       <label>用户名:</label>
                                       <input type="text" placeholder="搜索用户名" id="name" class="form-control">
                                   </div>
	                           </div>
	                           <div class="col-sm-6">
                           			<div class="form-group">
                                       <label>评价内容:</label>
                                       <input type="text" placeholder="搜索评价内容" id="evaluate" class="form-control">
                                   </div>
	                           </div>		                           
                            </form>
                        </div>
                        <div class="row">
                        <div class="col-sm-12">				 
							<button type="button" class="btn btn-info" id="btn-inquiry" style="float: right; margin: 0 0 0 15px;" >查询</button>
						 	<div class="select-time">
						 		<div>
                                    <input readonly class="form-control layer-date endtime" id="endtime" placeholder="请选择评价结束时间" >
                                    <label class="laydate-icon inline demoicon" for="endtime"></label>
                                </div>
				            </div>
			            	<div style="float:right;height:34px;line-height:34px;margin:0 6px;">至</div>
				            <div class="select-time">				              
				                <div>
                                    <input readonly class="form-control layer-date" id="starttime" placeholder="请选择评价开始时间" >
                                    <label class="laydate-icon inline demoicon" for="starttime"></label>
                                </div>
				            </div>			            
						</div>
						</div>
                    </div>
                    <div class="ibox-contentTable">
                    	<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th></th>
								<th class="check-header hidden-xs">
									<label style="margin-right:0px" class="checkbox-inline i-checks"><input id="checkAll" name="checkAll" type="checkbox"></label>
								</th>
								<th>用户名</th>
								<th>评价时间</th>	
								<th width="40%">评价内容</th>	
								<th>订单详情</th>
								<th>操作</th>
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
	<jsp:include page="delete.jsp"/>
	<jsp:include page="see.jsp"/>  
	<script type="text/javascript">
	var start={elem:"#starttime",
			format:"YYYY-MM-DD",
			event: 'click',
			istime:false,istoday:false,
			choose:function(datas){
				select_time();
		}
	};
	var end={elem:"#endtime",
			format:"YYYY-MM-DD",
			event: 'click',
			istime:false,istoday:false,
			choose:function(datas){
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
	function select_time(){
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
	}
	
	$("#btn-inquiry").click( function() {
		tableI.table().columns(8).search($("#starttime").val());
		tableI.table().columns(9).search($("#endtime").val());
		tableI.table().draw();
	});
	</script>  
</body>
</html>