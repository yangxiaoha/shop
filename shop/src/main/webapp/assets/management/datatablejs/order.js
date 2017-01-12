var tableI = null;
$(document).ready(function(){
	tableI=$("#datatable").DatatableExt({
		"processing": true,
        "serverSide": true,
        "ajax": "listData",
        "autoWidth":false,
        "language":  "/shop/assets/management/datatablejs/Chinese.json",
        "columns": [
                    { "data": "id","orderable":false,"visible":false},
                    { "data": "id","orderable":false},
                    { "data": "name"},
                    { "data": "phone" },
                    { "data": "address" },
                    { "data": "ordertime" },
                    { "data": "logistics" },
                    { "data": "logisticsnum", "width":"9%","className":"noautowidth" },
                    { "data": "ordernum" ,"width":"9%","className":"noautowidth"},
                    { "data": "state" },                  
                    { "data":"id","className": "actions","orderable":false },
                ],
        "aoColumnDefs": [
           {
             "targets": [1],
             "data": "id",
             "orderable":false,
             "render": function(data, type, full,meta) {
               return '<label style="margin-right:0px" class="checkbox-inline i-checks"><input name = "id" type="checkbox" value="'+data+'"></label>';
             }
           },  
           {
               "targets": [5],
               "data": "ordertime",
               "render": function(data, type, full,meta) {      	     
            	   if(data == null) {
            		   return data;
            	   }else {
            		   var d = new Date(data);  
            		   var date = d.toLocaleString(); 
            		   return date;
            	   }           	                  
               }
           },
           {
               "targets": [9],
               "data": "state",
               "render": function(data, type, full,meta) {
            	   var temp = "未付款";
            	   if(data == 2) {
            		   temp = "未发货";
            	   }else if(data == 3) {
            		   temp = "已发货";
            	   }else if(data == 4) {
            		   temp = "已收货";            		  
            	   } 
            	   var returnhtml = '<div class="btn-group">'+
            	   '<button class="btn btn-xs btn-primary dropdown-toggle" data-toggle="dropdown" ><i class="icon-reorder"></i>'+temp+'<span class="caret"></span></button>';
            	   if(data == 2){
            		   var lasthtml= '<ul class="dropdown-menu">'+
	            	   '<li>'+
	            	   '<a class="update" data-action="3" data-rowid="'+meta.row+'" href="javascript:void(0)"><i class="icon-edit"></i>发货</a>'+
	            	   '</li>'+
	            	   '</ul>';
	            	   
            	   }else if(data == 3||data == 4){
            		   lasthtml = "";
            	   }
            	    returnhtml = returnhtml + lasthtml + '</div>';
            	return returnhtml;
               }
           },           
           {
                "targets": [10],
                "data": "id",
                "render": function(data, type, full,meta) {
                  return '<div class="action-buttons">'+
                  			'<button class="btn btn-xs btn-primary see" data-rowid="'+meta.row+'" href="javascript:void(0)">订单详情</button>'+
                  		'</div>';
                }
             }
        ],
        "drawCallback":function(settings){  
        	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",});
        	$(".update").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];   
                var ustate = $(this).data("action");
                if(obj.logistics!=null&&obj.logistics!=""&&obj.logisticsnum!=null&&obj.logisticsnum!=""){
                	$.ajax({
                		url:"updateStateS",
                		type:"post",
                		data:{id:obj.id,state:ustate},
                		dataType:"json",
                		async:true,
                		success:function(res){        				
                			tableI.table().draw();
                		},
                		error:function(res){
                			
                		}
                	});
                }else{
                	alert("请先输入物流商家跟编号！");
                }
        		$("#updateModal").modal("show");
        	});
        	
        	$(".see").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#uid").val(obj.id);
        		$("#sname").html(obj.name);
        		$("#sphone").html(obj.phone);
        		$("#saddress").html(obj.address);
        		$("#smemo").html(obj.memo);
        		$("#sordernum").html(obj.ordernum);
        		$("#umemo").val(obj.memo);
        		$("#ulogistics").val(obj.logistics);
        		$("#ulogisticsnum").val(obj.logisticsnum);
        		var d = new Date(obj.ordertime);  
     		    var date = d.toLocaleString(); 
        		$("#sordertime").html(date);
        		if(obj.state == 2){
        			$("#sstate").html("未发货");
        		}else if(obj.state == 3) {
        			$("#sstate").html("已发货");
         	    }else if(obj.state == 4) {
         	    	$("#sstate").html("已收货");
         	    }         		
        		$.ajax({
        			url:"getOrderDetail",
        			type:"post",
        			data:{orderId: obj.id},
        			dataType:"json",
        			async:true,
        			success:function(res){        				
        				var checkboxhtml = "<table style=\"solid; border-width:1px; border-color:#000;width: 85%;margin-left: 40px;\" class=\"table table-bordered table-striped table-hover\" width=\"100%\">";
        				checkboxhtml = checkboxhtml + "<thead style=\"solid; border-width:1px; border-color:#000\">";
        				checkboxhtml = checkboxhtml + "<tr>";
        				checkboxhtml = checkboxhtml + "<td style=\"width:20%;solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">商品名称</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">商品属性</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"width:10%;solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">商品单价</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"width:10%;solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">购买数量</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"width:10%;solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">商品总价</td>";
        				checkboxhtml = checkboxhtml + "</tr>";        				
        				for(var i = 0;i<res.length;i++){
        					var valname = "";
        					if(res[i].provalue != null && res[i].provalue != ""){        						
        						var provalue = res[i].provalue.split("|#$%|");
        						var proname = res[i].proname.split(",");
        						for(var j=0;j<provalue.length;j++){
        							valname = valname + proname[j]+":"+provalue[j]+";";	
        						}
        					}
        					checkboxhtml = checkboxhtml + "<tr>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].name+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+valname+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].price+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].num+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].totalPrice+"</span></td>";
        					checkboxhtml = checkboxhtml + "</tr>";   
        				}
        				checkboxhtml = checkboxhtml + "<th colspan=\"5\" style=\"solid;text-align:right; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>总价：￥"+obj.totalPrice+"</span></th>";
        				checkboxhtml = checkboxhtml + "</thead>";
        				checkboxhtml = checkboxhtml + "</table>";
        				$("#checkbok").html(checkboxhtml);
        				
        			},
        			error:function(res){
        				
        			}
        		});
        		$("#seeModal").modal("show");
        	});
        },
        "className" : "Order",
        "chosen" : true,
        "ids" : "#state,#ordernum,#logisticsnum,#logistics",
        "targets":"9,8,7,6"
	});
});