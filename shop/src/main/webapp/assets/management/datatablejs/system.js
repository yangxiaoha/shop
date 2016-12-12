var tableI = null;
$(document).ready(function(){
	tableI=$("#datatable").DatatableExt({
		"processing": true,
        "serverSide": true,
        "ajax": "listData",
        "language":  "/shop/assets/management/datatablejs/Chinese.json",
        "columns": [
                    { "data": "id","orderable":false},
                    { "data": "skey" },
                    { "data": "sysvalue" },
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
        		$("#uskey").val(obj.skey);
        		$("#usysvalue").val(obj.sysvalue);
        		$("#updateModal").modal("show");
        	});
        },
        "className" : "System",
        "chosen" : true,
        "ids" : "#skey,#sysvalue",
        "targets":"1,2"
	});
});