var tableI = null;
$(document).ready(function(){
	tableI=$("#datatable").DatatableExt({
		"processing": true,
        "serverSide": true,
        "ajax": "listData",
        "language":  "/shop/assets/management/datatablejs/Chinese.json",
        "columns": [
                    { "data": "id","orderable":false,"visible":false},
                    { "data": "id","orderable":false},
                    { "data": "name" },
                    { "data": "evaluateTime" },
                    { "data": "evaluate" },
                    { "data":"id","className": "actions","orderable":false },
                    { "data":"id","className": "actions","orderable":false },
                    { "data":"orderId","orderable":false,"visible":false },
                    { "data": "starttime","orderable":false,"visible":false },
                    { "data": "endtime","orderable":false,"visible":false }
                ],
        "aoColumnDefs": [
           {
             "targets": [1],
             "data": "id",
             "render": function(data, type, full,meta) {
            	 return '<label style="margin-right:0px" class="checkbox-inline i-checks"><input name = "id" type="checkbox" value="'+data+'"></label>';
             }
           },
           {
               "targets": [5],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
                 			'<button class="btn btn-xs btn-primary see" data-rowid="'+meta.row+'" href="javascript:void(0)">订单详情</button>'+
                 		'</div>';
               }
            },
           {
               "targets": [6],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
                 			'<a class="table-actions del" data-id="'+data+'" href="javascript:void(0)" title="删除"><i class="fa fa-trash"></i></a>'+
                 		'</div>';
               }
            }
        ],
        "drawCallback":function(settings){
        	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})
        	$(".del").click(function(){
        		$("#dcontext").html("确认删除当前选项？");
        		$("#ids").val($(this).data("id"));
        		$("#delModal").modal('show');
        	});
        	
        	$(".see").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#sid").val(obj.id);
        		$.ajax({
        			url:"seeOrderAll",
        			type:"post",
        			data:{orderId: obj.orderId},
        			dataType:"json",
        			async:true,
        			success:function(res){
        				$("#sname").html(res[0].name);
                		$("#sphone").html(res[0].phone);
                		$("#saddress").html(res[0].address);
                		$("#smemo").html(res[0].memo);
                		$("#sordernum").html(res[0].ordernum);
                		$("#ulogistics").html(res[0].logistics);
                		$("#ulogisticsnum").html(res[0].logisticsnum);
                		var d = new Date(res[0].ordertime);  
             		    var date = d.toLocaleString(); 
                		$("#sordertime").html(date);
                		if(res[0].state == 2){
                			$("#sstate").html("未发货");
                		}else if(res[0].state == 3) {
                			$("#sstate").html("已发货");
                 	    }else if(res[0].state == 4) {
                 	    	$("#sstate").html("已收货");
                 	    }         		
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
        					if(res[i].orderDetail[0].provalue != null && res[i].orderDetail[0].provalue != ""){        						
        						var provalue = res[i].orderDetail[0].provalue.split("|#$%|");
        						var proname = res[i].orderDetail[0].proname.split(",");
        						for(var j=0;j<provalue.length;j++){
        							valname = valname + proname[j]+":"+provalue[j]+";";	
        						}
        					}
        					checkboxhtml = checkboxhtml + "<tr>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].orderDetail[0].name+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+valname+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].orderDetail[0].price+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].orderDetail[0].num+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].orderDetail[0].totalPrice+"</span></td>";
        					checkboxhtml = checkboxhtml + "</tr>";   
        				}
        				checkboxhtml = checkboxhtml + "<th colspan=\"5\" style=\"solid;text-align:right; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>总价：￥"+res[0].totalPrice+"</span></th>";
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
        "className" : "Evaluate",
        "chosen" : true,
        "ids" : "#name,#evaluate,#endtime,#starttime",
        "targets":"2,4,8,9"
	});
});