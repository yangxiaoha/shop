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
	<title>数据统计</title>
	<link href="<%=basePath%>assets/management/stylesheets/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
	<script src="<%=basePath%>assets/management/datatablejs/statistics.js" type="text/javascript"></script>
	<script type="text/javascript" src="<%=basePath%>assets/management/javascripts/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="<%=basePath%>assets/management/javascripts/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
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
		#homepage {
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
					<div class="heading">
						<i class="icon-table"></i>统计管理
					</div>
					<div class="widget-content padded clearfix">
					<div class="col-lg-12">
					<table class="table table-bordered table-striped table-hover">
						<tr>
				            <td width="8%">城市:</td>
				            <td><input class="form-control" type="text" id="cityname" name="cityname" placeholder="搜索城市"></td>
				            <td width="8%">商品名称:</td>
				            <td><input class="form-control" type="text" id="name" name="name" placeholder="搜索商品名称"></td>
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
							<th class="check-header hidden-xs"><label><input
									id="checkAll" name="checkAll" type="checkbox"><span></span></label>
							</th>							
							<th>城市</th>
							<th>商品名称</th>
							<th>卖出时间</th>
							<th>卖出数量</th>						
							<th></th>						
							<th></th>						
						</thead>
						<tbody>
						</tbody>
					</table>							
				</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12" style = "top:15px">
					<div class="col-lg-4">
						<div class="widget-container">
							<div class="heading">
								<i class="icon-bar-chart"></i>按城市
							</div>
							<div class="widget-content padded">
								<div class="pie-chart">
									<div id="pie-chart"></div>
									<ul class="chart-key" id = "checkbok"></ul>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="widget-container">
							<div class="heading">
								<i class="icon-bar-chart"></i>按时间
							</div>
							<div class="widget-content padded">
								<div id="linechart-1">Loading...</div>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="widget-container fluid-height">
							<div class="heading">
								<i class="icon-bar-chart"></i>按商品
							</div>
							<div class="widget-content padded text-center">
								<div class="graph-container">
									<div class="caption"></div>
									<div class="graph" id="hero-bar"></div>
									<!-- Bar Charts:Morris -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
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
	tableI.table().columns(2).search($("#cityname").val());
	tableI.table().columns(3).search($("#name").val());
	tableI.table().draw();
	countCity();
	countName();
	
});
$("#btn-inquiry").click( function() {	
	tableI.table().columns(6).search($("#starttime").val());
	tableI.table().columns(7).search($("#endtime").val());
	tableI.table().columns(2).search($("#cityname").val());
	tableI.table().columns(3).search($("#name").val());
	tableI.table().draw();
	countCity();
	countName();
});

 var countCity=function(){
	$.ajax({
		url:"getNumbyCity",
		type:"post",
		data:{cityname:$("#cityname").val(),name:$("#name").val(),starttime:$("#starttime").val(),endtime:$("#endtime").val()},
		dataType:"json",
		async:true,
		success:function(res){		
			var num = new Array();
			var colors = new Array();
			var checkboxhtml = "";
			for(var i = 0;i<res.length;i++){
				num[i] = res[i].num;
				colors[i] = '#'+('00000'+(Math.random()*0x1000000<<0).toString(16)).substr(-6); 
				checkboxhtml = checkboxhtml + "<li><span style=\"background:"+colors[i]+"\"></span>"+res[i].cityname+"</li>";
			};
			$("#checkbok").html(checkboxhtml);
			$("#pie-chart").sparkline(num, {
				type : "pie",
				height : "220",
				width : "220",
				offset : "+90",
				sliceColors : colors
			});	
		},
		error:function(res){
			$("#checkbok").html("");
			$("#pie-chart").html("数据为空");			
		}
	});
}
countCity();
$("#linechart-1").sparkline([160, 240, 120, 200, 180, 350, 230, 200, 280, 380, 400, 360, 300, 220, 200, 150, 40, 70, 180, 110, 200, 160, 200, 220], {
      type: "line",
      width: "100%",
      height: "226",
      lineColor: "#a5e1ff",
      fillColor: "rgba(241, 251, 255, 0.9)",
      lineWidth: 2,
      spotColor: "#a5e1ff",
      minSpotColor: "#bee3f6",
      maxSpotColor: "#a5e1ff",
      highlightSpotColor: "#80cff4",
      highlightLineColor: "#cccccc",
      spotRadius: 6,
      chartRangeMin: 0
});
$("#linechart-1").sparkline([100, 280, 150, 180, 220, 180, 130, 180, 180, 280, 260, 260, 200, 120, 200, 150, 100, 100, 180, 180, 200, 160, 180, 120], {
     type: "line",
     width: "100%",
     height: "226",
     lineColor: "#cfee74",
     fillColor: "rgba(244, 252, 225, 0.5)",
     lineWidth: 2,
     spotColor: "#b9e72a",
     minSpotColor: "#bfe646",
     maxSpotColor: "#b9e72a",
     highlightSpotColor: "#b9e72a",
     highlightLineColor: "#cccccc",
     spotRadius: 6,
     chartRangeMin: 0,
     composite: true
});
function countName(){	
	$(window).resize(function(e) {
	    var morrisResize;
	    clearTimeout(morrisResize);
	    return morrisResize = setTimeout(function() {
	      return buildMorris(true);
	    }, 500);
	  });
	  $(function() {
	    return buildMorris();
	  });
	  buildMorris = function($re) {
		  $.ajax({
			url:"getNumbyName",
			type:"post",
			data:{name:$("#name").val(),cityname:$("#cityname").val(),starttime:$("#starttime").val(),endtime:$("#endtime").val()},
			dataType:"json",
			async:true,
			success:function(res){
				var names = new Array();
				for(var i = 0;i<res.length;i++){
	            	names[i] = {device:res[i].name,
	            			 	geekbench:res[i].num};
	            };
				var tax_data;
			    if ($('#hero-bar').length) {
			    	$("#hero-bar").html("");
			        return Morris.Bar({
			          element: "hero-bar",
			          data: names,
			          xkey: "device",
			          ykeys: ["geekbench"],
			          labels: ["Geekbench"],
			          barRatio: 0.4,
			          xLabelAngle: 35,
			          hideHover: "auto",
			          barColors: ["#5bc0de"]
			        });
			     }
			},
			error:function(res){
				$("#hero-bar").html("数据为空");				
			}
		}); 
	};
}
countName();

</script>
</body>
</html>