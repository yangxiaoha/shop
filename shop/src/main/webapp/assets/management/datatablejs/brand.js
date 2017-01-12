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
                    { "data": "suppliername" },
                    { "data": "content" },
                    { "data":"id","className": "actions","orderable":false },
                    { "data": "supplierId" }
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
             "targets": [6], //隐藏第六列，从第0列开始   
             "visible": false    
           }, 
           {
               "targets": [5],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
                 			'<a class="table-actions update" data-rowid="'+meta.row+'" href="javascript:void(0)" title="修改"><i class="fa fa-pencil"></i></a>'+
                 			'<a class="table-actions del" data-id="'+data+'" href="javascript:void(0)" title="删除"><i class="fa fa-trash"></i></a>'+
                 		'</div>';
               }
            }
        ],
        "drawCallback":function(settings){
        	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})
        	$(".del").click(function(){
        		$("#ids").val($(this).data("id"));
        		$("#delModal").modal('show');
        	});
        	
        	$(".update").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#eid").val(obj.id);
        		$("#ename").val(obj.name);
        		$("#econtent").val(obj.content);        		
        		$("#esupplierId option").each(function (){  
	        		  var a = $(this).text();
	          		  if ($(this).text() == obj.suppliername) {
	          		     $(this).prop('selected', true);
	          		  }
          		});
        		$("#updateModal").modal("show");
        	});
        },
        "className" : "Brand",
        "chosen" : true,
        "ids" : "#name,#content,#suppliername,#supplierId",
        "targets":"2,4,3,5"
	});
});