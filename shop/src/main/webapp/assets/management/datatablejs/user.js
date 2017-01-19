var tableI = null;
$(document).ready(function(){
	tableI=$("#datatable").DatatableExt({
		"processing": true,
        "serverSide": true,
        "ajax": "listData?userId="+userId,
        "language":  "/shop/assets/management/datatablejs/Chinese.json",
        "columns": [
                    { "data": "id","orderable":false,"visible":false},
                    { "data": "id","orderable":false},
                    { "data": "name" },
                    { "data": "regtime" },
                    { "data": "money" },
                    { "data": "startmoney","orderable":false,"visible":false },
                    { "data": "endmoney","orderable":false,"visible":false },
                    { "data": "starttime","orderable":false,"visible":false },
                    { "data": "endtime","orderable":false,"visible":false },
                    { "data":"id","className": "actions","orderable":false },
                    { "data": "isnot","orderable":false,"visible":false }
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
               "targets": [9],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
                 			'<a class="" href="index?userId='+data+'" title="下级会员"><i class="fa fa-sitemap"></i></a>'+
                 		'</div>';
               }
            }
        ],
        "drawCallback":function(settings){
        	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",})
        },
        "className" : "User",
        "chosen" : true,
        "ids" : "#name,#money",
        "targets":"2,4"
	});
});