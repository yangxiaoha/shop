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
                    { "data": "brief" },                   
                    { "data":"id","className": "actions","orderable":false }
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
               "targets": [4],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
                 			'<a class="table-actions update" data-rowid="'+meta.row+'" href="javascript:void(0)" title="修改"><i class="fa fa-pencil"></i></a>'+
                 			'<a class="table-actions del" data-id="'+data+'" href="javascript:void(0)"><i class="fa fa-trash" title="删除"></i></a>'+
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
        	
        	$(".update").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#eid").val(obj.id);
        		$("#ename").val(obj.name);
        		$("#ebrief").val(obj.brief);
        		$("#updateModal").modal("show");
        	});
        },
        "className" : "Supplier",
        "chosen" : true,
        "ids" : "#name,#brief",
        "targets":"2,3"
	});
});