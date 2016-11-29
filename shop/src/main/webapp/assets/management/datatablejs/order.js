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
                    { "data": "name"},
                    { "data": "phone" },
                    { "data": "address" },
                    { "data": "ordertime" },
                    { "data": "logistics" },
                    { "data": "logisticsnum" },
                    { "data": "state" },                  
                    { "data":"id","className": "actions","orderable":false },
                ],
        "aoColumnDefs": [
           {
             "targets": [1],
             "data": "id",
             "orderable":false,
             "render": function(data, type, full,meta) {
               return '<label><input name="id" type="checkbox" value="'+data+'"><span></span></label>';
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
               "targets": [8],
               "data": "state",
               "render": function(data, type, full,meta) {
            	   if(data == 2) {            		   
            	return '<div class="btn-group">'+
       						'<button class="btn btn-xs btn-primary dropdown-toggle" data-toggle="dropdown"><i class="icon-reorder"></i>未发货<span class="caret"></span></button>'+ 
       						'<ul class="dropdown-menu">'+
       						'<li>'+
       						'<a href="#"><i class="icon-edit"></i>发货</a>'+
       						'</li>'+
       						'<li>'+
       						'<a href="#"><i class="icon-edit"></i>已收货</a>'+
       						'</li>'+                       
       						'</ul>'+
       					'</div>';
            	   }else if(data == 3) {
            		
            	   }else if(data == 4) {
            		 
            	   }else if(data == 1) {
            		  
            	   } 
            	  
            	       	                  
               }
           },           
           {
                "targets": [9],
                "data": "id",
                "render": function(data, type, full,meta) {
                  return '<div class="action-buttons">'+
                  			'<button class="btn btn-xs btn-primary see" data-rowid="'+meta.row+'" href="javascript:void(0)">订单详情</button>'+
                  		'</div>';
                }
             }
        ],
        "drawCallback":function(settings){        	        
        	$(".update").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#uid").val(obj.id);
        		$("#ustate").val(obj.state);
        		$("#updateModal").modal("show");
        	});
        	$(".updateAdd").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#uid").val(obj.id);
        		$("#umeno").val(obj.meno);
        		$("#updateAddModal").modal("show");
        	});
        	
        	$(".see").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#sid").val(obj.id);
        		$("#sname").html(obj.name);
        		$("#sphone").html(obj.phone);
        		$("#saddress").html(obj.address);
        		$("#slogistics").html(obj.logistics);
        		$("#slogisticsnum").html(obj.logisticsnum);
        		$("#smemo").html(obj.memo);
        		var d = new Date(obj.ordertime);  
     		    var date = d.toLocaleString(); 
        		$("#sordertime").html(date);        		
        		$("#sstate").html(obj.state);
        		$.ajax({
        			url:"getOrderDetail",
        			type:"post",
        			data:{orderId: obj.id},
        			dataType:"json",
        			async:true,
        			success:function(res){
        				var checkboxhtml = "<table style=\"solid; border-width:1px; border-color:#000\" class=\"table table-bordered table-striped table-hover\" width=\"100%\">";
        				checkboxhtml = checkboxhtml + "<thead style=\"solid; border-width:1px; border-color:#000\">";
        				checkboxhtml = checkboxhtml + "<tr>";
        				checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">商品名称</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">商品单价</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">购买数量</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">商品总价</td>";
        				checkboxhtml = checkboxhtml + "</tr>";        				
        				for(var i = 0;i<res.length;i++){
        					checkboxhtml = checkboxhtml + "<tr>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].name+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].price+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].num+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].totalPrice+"</span></td>";
        					checkboxhtml = checkboxhtml + "</tr>";   
        				}
        				checkboxhtml = checkboxhtml + "<th colspan=\"4\" style=\"solid;text-align:right; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>总价：￥"+obj.totalPrice+"</span></th>";
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
        "ids" : "#state,#logisticsnum,#logistics",
        "targets":"8,7,6"
	});
});