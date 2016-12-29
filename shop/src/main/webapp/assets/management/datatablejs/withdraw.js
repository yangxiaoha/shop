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
                    { "data":"id","className": "actions","orderable":false },
                    { "data": "starttime","orderable":false,"visible":false },
                    { "data": "endtime","orderable":false,"visible":false },              
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
            	 if(full.state == 1){            		 
            		 return '<div style="text-align: center;padding-right:8px"><a style="margin:0px" class="btn btn-sm btn-primary-outline update" data-rowid="'+meta.row+'" >未审核</a></div>';
            	 }else{
            		 return '<div style="text-align: center;padding-right:8px"><a style="margin:0px" class="btn btn-sm btn-primary-outline" disabled="true">已审核</a></div>';
            	 }
               }
            }
        ],
        "drawCallback":function(settings){        	        
        	$(".update").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0]; 
        		swal({
        			title: "确定通过审核？",
        			text: "",
        			type: "warning",
        			showCancelButton: true,
        			confirmButtonColor: '#DD6B55',
        			confirmButtonText: "确定通过！",
        			cancelButtonText: "不通过！",
        			closeOnConfirm: false,
        			closeOnCancel: false
        		},
        		function(isConfirm){
		    	    if (isConfirm){
		    	    	ustate = 3;
		    	    	$.ajax({
		        			url:"updateState",
		        			type:"post",
		        			data:{id:obj.id,state:ustate},
		        			dataType:"json",
		        			async:true,
		        			success:function(res){   
		        				swal("通过审核!", "", "success");
		        			},
		        			error:function(res){
		        				
		        			}
		                });
		    	    } else {
		    	    	ustate = 2;
		    	    	$.ajax({
		        			url:"updateState",
		        			type:"post",
		        			data:{id:obj.id,state:ustate},
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
        },
        "className" : "Withdraw",
        "chosen" : true,
        "ids" : "#state,#username",
        "targets":"6,2"
	});
});