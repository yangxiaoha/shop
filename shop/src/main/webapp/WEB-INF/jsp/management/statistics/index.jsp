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
	<script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/js/plugins/flot/jquery.flot.js"></script>	
	<script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/js/plugins/flot/jquery.flot.pie.js"></script>	
	<script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/js/plugins/flot/jquery.flot.resize.js"></script>	
	<script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/js/plugins/flot/jquery.flot.tooltip.min.js"></script>
		
	<script src="<%=basePath%>assets/management/datatablejs/statistics.js" type="text/javascript"></script>
	<style type="text/css">
		.error {
		    margin: 10px 0px;
    		color: #EA4242;
		}
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
                        <h5>统计管理</h5>
                    </div>
                    <div class="ibox-content">
                      <div class="row">
                            <form role="form">
	                           <div class="col-sm-6">
                                   <div class="form-group">
                                       <label>城市:</label>
                                       <input type="text" placeholder="搜索城市" id="cityname" class="form-control">
                                   </div>
	                           </div>
	                           <div class="col-sm-6">
                           			<div class="form-group">
                                       <label>商品名称:</label>
                                       <input type="text" placeholder="搜索商品名称" id="name" class="form-control">
                                   </div>
	                           </div>
                            </form>
                        </div>
                        <div class="row">
                        <div class="col-lg-12">				 
							<button type="button" class="btn btn-info" id="btn-inquiry" style="float: right; margin: 0 0 0 15px;" >查询</button>
						 	<div class="select-time">
						 		<div>
                                    <input readonly class="form-control layer-date endtime" id="endtime" placeholder="请选择卖出结束时间" >
                                    <label class="laydate-icon inline demoicon" for="endtime"></label>
                                </div>
				            </div>
			            	<div style="float:right;height:34px;line-height:34px;margin:0 6px;">至</div>
				            <div class="select-time">				              
				                <div>
                                    <input readonly class="form-control layer-date" id="starttime" placeholder="请选择卖出开始时间" >
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
                <div class="row">
					<div class="col-sm-12" style = "top:15px">
						<div class="col-sm-5">
			                <div class="ibox float-e-margins">
			                    <div class="ibox-title">
			                        <h5>按城市</h5>
			                    </div>
			                    <div class="ibox-content">
			                        <div class="flot-chart">
			                            <div class="flot-chart-content" id="flot-pie-chart"></div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			            <div class="col-sm-7">
			                <div class="ibox float-e-margins">
			                    <div class="ibox-title">
			                        <h5>按商品</h5>
			                        <div class="ibox-tools">
			                        </div>
			                    </div>
			                    <div class="ibox-content">
			                        <div class="flot-chart">
			                            <div class="flot-chart-content" id="flot-bar-chart"></div>
			                        </div>
			                    </div>
			                </div>
			            </div>					
					</div>
				</div>
            </div>
        </div>
    </div>    
<script type="text/javascript">
	var start={elem:"#starttime",
			format:"YYYY-MM-DD",
			event: 'click',
			istime:true,istoday:false,
			choose:function(datas){
				select_time();
		}
	};
	var end={elem:"#endtime",
			format:"YYYY-MM-DD",
			event: 'click',
			istime:true,istoday:false,
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
	tableI.table().columns(6).search($("#starttime").val());
	tableI.table().columns(7).search($("#endtime").val());
	tableI.table().columns(2).search($("#cityname").val());
	tableI.table().columns(3).search($("#name").val());
	tableI.table().draw();
	countCity();
	countName();
});

function countCity(){
	$.ajax({
		url:"getNumbyCity",
		type:"post",
		data:{cityname:$("#cityname").val(),name:$("#name").val(),starttime:$("#starttime").val(),endtime:$("#endtime").val()},
		dataType:"json",
		async:true,
		success:function(res){
			var colors = new Array();
			var e = new Array();
			var checkboxhtml = "";
			for(var i = 0;i<res.length;i++){
				colors[i] = '#'+('00000'+(Math.random()*0x1000000<<0).toString(16)).substr(-6); 
				var obj = new Object();
				obj.label = res[i].cityname;
				obj.data = parseInt(res[i].num);
				obj.color = colors[i];
				e[i] = obj;
			}
			$.plot($("#flot-pie-chart"),
					e,{series:{pie:{show:!0}},
					grid:{hoverable:!0},
						tooltip:!0,
						tooltipOpts:{content:"%p.0%, %s",shifts:{x:20,y:0},defaultTheme:!1}
					}
			);	
		},
		error:function(res){			
			$("#flot-pie-chart").html("<h2>数据为空...</h2>");			
		}
	});
}
countCity();
function countName(){
	$.ajax({
		url:"getNumbyName",
		type:"post",
		data:{cityname:$("#cityname").val(),name:$("#name").val(),starttime:$("#starttime").val(),endtime:$("#endtime").val()},
		dataType:"json",
		async:true,
		success:function(res){
			var e = new Array();
			var x = new Array();
			for(var i = 0;i<res.length;i++){								
				e[i] = [i,parseInt(res[i].num)];
				x[i] = [i,res[i].name];
			}
			var o={
				series:{
					bars:{
						show:!0,
						barWidth:.6,
						fill:!0,
						fillColor:{
							colors:[{opacity:.8},{opacity:.8}]
						},
					},
				},
				xaxis:{
					position:"bottom",
					ticks: x,  
                    tickSize: 1,  
                    axisLabelUseCanvas: true,  
                    axisLabelFontSizePixels: 12,  
                    axisLabelFontFamily: 'Verdana, Arial',  
                    axisLabelPadding: 10  
				},
				colors:["#1ab394"],
				grid:{
					color:"#999999",
					hoverable:!0,
					clickable:!0,
					tickColor:"#D4D4D4",
					borderWidth:0
				},
				legend:{show:!1},
				tooltip:!0,
				tooltipOpts:{content:function(label, xval, yval) {
			          var content = res[parseInt(xval)]["name"]+":" + yval;
			          return content;
			        }},
			}		
			var list = {label:"2",data:e};
			$.plot($("#flot-bar-chart"),
							[list],o)
		},
		error:function(res){			
			$("#flot-bar-chart").html("<h2>数据为空...</h2>");			
		}
	});
}
countName();
</script>
</body>
</html>