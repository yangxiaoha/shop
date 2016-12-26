var tableI = null;
$(document).ready(function(){
	tableI=$("#datatable").DatatableExt({
		"processing": true,
        "serverSide": true,
        "ajax": "listData?userId="+userId,
        "language":  "/shop/assets/management/datatablejs/Chinese.json",
        "columns": [
                    { "data": "id","orderable":false},
                    { "data": "openid" },
                    { "data": "regtime" },
                    { "data": "money" },
                    { "data": "startmoney","orderable":false,"visible":false },
                    { "data": "endmoney","orderable":false,"visible":false },
                    { "data": "starttime","orderable":false,"visible":false },
                    { "data": "endtime","orderable":false,"visible":false },
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
               "targets": [8],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
                 		'<a class="" href="index?userId='+data+'"><i class="icon-sitemap"></i></a>'+
                 		'</div>';
               }
            }
        ],
        "drawCallback":function(settings){
        	
        },
        "className" : "User",
        "chosen" : true,
        "ids" : "#openid,#money",
        "targets":"1,3"
	});
});