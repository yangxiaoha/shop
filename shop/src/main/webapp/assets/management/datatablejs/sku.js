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
                    { "data": "ids" },
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
               "targets": [7],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
                 			'<a class="table-actions update" data-rowid="'+meta.row+'" href="javascript:void(0)"><i class="icon-pencil"></i></a>'+
                 			'<a class="table-actions del" data-id="'+data+'" href="javascript:void(0)"><i class="icon-trash"></i></a>'+                 			
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
        		$("#uids").val(obj.ids);
        		$("#unum").val(obj.num);
        		$("#uprice").val(obj.price);        		
        		$("#ucode").val(obj.code);
        		$("#updateModal").modal("show");
        	});
        },
        "className" : "Sku",
        "chosen" : true,
        "ids" : "#dids,#code",
        "targets":"4,5"
	});
});