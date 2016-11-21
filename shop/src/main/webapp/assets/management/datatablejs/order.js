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
               "targets": [9],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
                 			'<a class="table-actions update" data-rowid="'+meta.row+'" href="javascript:void(0)"><i class="icon-pencil"></i></a>'+
                 			'<a class="table-actions del" data-id="'+data+'" href="javascript:void(0)"><i class="icon-trash"></i></a>'+
                 		'</div>';
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
        	$(".del").click(function(){
        		$("#ids").val($(this).data("id"));
        		$("#delModal").modal('show');
        	});
        	        
        	$(".update").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#uid").val(obj.id);
        		$("#uname").val(obj.name);
        		$("#updateModal").modal("show");
        	});
        	
        	$(".see").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#uid").val(obj.id);
        		$("#uname").val(obj.name);
        		$("#seeModal").modal("show");
        	});
        },
        "className" : "Order",
        "chosen" : true,
        "ids" : "#state,#logisticsnum,#logistics",
        "targets":"8,7,6"
	});
});