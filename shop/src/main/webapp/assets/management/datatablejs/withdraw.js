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
                    { "data": "username"},
                    { "data": "user.money" },
                    { "data": "cashTime" },
                    { "data": "cashMoney" },
                    { "data": "state" },
                    { "data":"id","className": "actions","orderable":false },                    { "data":"id","className": "actions","orderable":false },
                    { "data": "starttime","orderable":false,"visible":false },
                    { "data": "endtime","orderable":false,"visible":false },              
                    { "data": "userId","orderable":false,"visible":false },              
                ],
        "aoColumnDefs": [
           {
             "targets": [1],
             "data": "id",
             "orderable":false,
             "render": function(data, type, full,meta) {
            	 return '<label style="margin-right:0px" class="checkbox-inline i-checks"><input type="checkbox" value="'+data+'"></label>';
             }
           },             
           {
               "targets": [6],
               "data": "state",
               "render": function(data, type, full,meta) {
            	   var temp = "";
            	   if(data == 1) {
            		   temp = "未审核";
            	   }else if(data == 2) {
            		   temp = "不通过";
            	   }else if(data == 3) {
            		   temp = "已通过";
            	   }
            	   return temp;            	   
               }
           },
           {
               "targets": [7],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div style="text-align: center;padding-right:8px"><a style="margin:0px" class="btn btn-sm btn-primary-outline see" data-rowid="'+meta.row+'" >详情信息</a></div>';
               }
            },
           {
               "targets": [8],
               "data": "id",
               "render": function(data, type, full,meta) {
            	 if(full.state == 1){            		 
            		 return '<div style="text-align: center;padding-right:8px"><a style="margin:0px" class="btn btn-sm btn-primary-outline update" data-rowid="'+meta.row+'" >未审核</a></div>';
            	 }else{
            		 return '<div style="text-align: center;padding-right:8px"><a style="margin:0px" class="btn btn-sm btn-primary-outline" disabled="true">已审核</a></div>';
            	 }
               }
            }
        ],
        "drawCallback":function(settings){
        	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})
        	$(".update").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0]; 
                var title = "确定通过审核？"
                var Confirm = true;
                if(obj.user.money<obj.cashMoney){
                	title = "用户金额不足！"
                	Confirm = false;
                }
        		swal({
        			title: title,
        			text: "",
        			type: "warning",
        			showCancelButton: true,
        			showConfirmButton: Confirm,
        			confirmButtonColor: '#DD6B55',
        			confirmButtonText: "确定通过！",
        			cancelButtonText: "不通过！",
        			closeOnConfirm: false,
        			closeOnCancel: false
        		},
        		function(isConfirm){
		    	    if (isConfirm){
		    	    	$.ajax({
		    	    		url:"updateState",
		    	    		type:"post",
		    	    		data:{id:obj.id,
		    	    			  userId:obj.userId,
		    	    			  money:obj.money,
		    	    			  state:3},
		    	    		dataType:"json",
		    	    		async:true,
		    	    		success:function(res){   
		    	    			swal("通过审核!", "", "success");
		    	    		},
		    	    		error:function(res){
		    	    			
		    	    		}
		    	    	});
		    	    } else {
		    	    	$.ajax({
		        			url:"updateState",
		        			type:"post",
		        			data:{id:obj.id,state:2},
		        			dataType:"json",
		        			async:true,
		        			success:function(res){   
		        				swal("已经拒绝申请", "", "error");
		        			},
		        			error:function(res){
		        				
		        			}
		                });
		    	    }
		    	    tableI.table().draw();
        		});
        		
        	});
        	$(".see").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$.ajax({
        			url:"seeWithdraw",
        			type:"post",
        			data:{userId: obj.userId},
        			dataType:"json",
        			async:true,
        			success:function(res){
        				var checkboxhtml = "<table style=\"solid; border-width:1px; border-color:#000;width: 85%;margin-left: 40px;\" class=\"table table-bordered table-striped table-hover\" width=\"100%\">";
        				checkboxhtml = checkboxhtml + "<thead style=\"solid; border-width:1px; border-color:#000\">";
        				checkboxhtml = checkboxhtml + "<tr>";
        				checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">用户名</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">用户id</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">买家姓名</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">订单编号</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">订单金额</td>";
        				checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:blue\">提成金额</td>";
        				checkboxhtml = checkboxhtml + "</tr>";        				
        				for(var i = 0;i<res.length;i++){
        					checkboxhtml = checkboxhtml + "<tr>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+obj.username+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].openid+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].name+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].ordernum+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].totalprice+"</span></td>";
        					checkboxhtml = checkboxhtml + "<td style=\"solid; border-width:1px; border-color:#000;font-size:1em;color:black\"><span>"+res[i].money+"</span></td>";
        					checkboxhtml = checkboxhtml + "</tr>";   
        				}
        				checkboxhtml = checkboxhtml + "</thead>";
        				checkboxhtml = checkboxhtml + "</table>";
        				$("#checkbok").html(checkboxhtml);
        				
        			},
        			error:function(res){
        				alert("xxxxx");
        				
        			}
        		});
        		$("#seeModal").modal("show");
        	});
        },
        "className" : "Withdraw",
        "chosen" : true,
        "ids" : "#state,#username",
        "targets":"6,2"
	});
});