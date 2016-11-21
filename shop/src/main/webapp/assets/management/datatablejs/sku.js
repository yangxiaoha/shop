var tableI = null;
$(document).ready(function(){
	tableI=$("#datatable").DatatableExt({
		"processing": true,
        "serverSide": true,
        "ajax": "listData?goodsId="+goodsId,
        "language":  "/shop/assets/management/datatablejs/Chinese.json",
        "columns": [
                    { "data": "id","orderable":false,"visible":false },
                    { "data": "id","orderable":false },
                    { "data": "num" },
                    { "data": "price" },                    
                    { "data": "code" }, 
                    { "data": "goodsId","orderable":false,"visible":false }, 
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
               "targets": [6],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
                 			'<a class="table-actions update" data-rowid="'+meta.row+'" href="javascript:void(0)"><i class="icon-pencil"></i></a>'+
                 			'<a class="table-actions updateAdd" data-rowid="'+meta.row+'" href="javascript:void(0)"><i class="icon-plus-sign-alt"></i></a>'+
                 		'</div>';
               }
            }
        ],
        "drawCallback":function(settings){
        	$(".updateAdd").click(function(){        		
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#aid").val(obj.id);
        		$("#upnum").val(obj.num);
        		$("#updateAddModal").modal('show');
        	});
        	
        	$(".update").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#uid").val(obj.id);        		
        		$("#uprice").val(obj.price);        		
        		$("#ucode").val(obj.code);
        		$("#updateModal").modal("show");
        	});
        },
        "className" : "Sku",
        "chosen" : true,
        "ids" : "#code",
        "targets":"4"
	});
});