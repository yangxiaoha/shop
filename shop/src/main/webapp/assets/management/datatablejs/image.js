var tableI = null;
$(document).ready(function(){
	tableI = $("#datatable").DatatableExt({
		"processing": true,
        "serverSide": true,
        "ajax": "listData",
        "language":  "/ap/assets/management/datatablejs/Chinese.json",
        "columns": [
                    { "data": "id","orderable":false},
                    { "data": "imagename","className":"user" },
                    { "data": "imageurl" },
                    { "data":"id","className": "actions","orderable":false }
                ],
        "aoColumnDefs": [
           {
             "targets": [0],
             "data": "id",
             "render": function(data, type, full,meta) {
               return '<label><input name="id" type="checkbox" value="'+data+'"><span></span></label>';
             }
           },
           {
               "targets": [3],
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
        		$("#uimagename").val(obj.imagename);
        		$("#updateModal").modal("show");
        	});
        },
        "className" : "Image",
        "chosen" : true,
        "ids" : "#imagename,#imageurl",
        "targets":"1,2"
	});
});
