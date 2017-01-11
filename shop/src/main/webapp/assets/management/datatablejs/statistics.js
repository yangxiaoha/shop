var tableI = null;
$(document).ready(function(){
	tableI = $("#datatable").DatatableExt({
		"processing": true,
        "serverSide": true,
        "ajax": "listData",
        "language":  "/shop/assets/management/datatablejs/Chinese.json",
        "columns": [
                    { "data": "id","orderable":false,"visible":false},
                    { "data": "id","orderable":false },
                    { "data": "cityname" },
                    { "data": "name" },
                    { "data": "ordertime" },
                    { "data": "num" },
                    { "data": "starttime","orderable":false,"visible":false },
                    { "data": "endtime","orderable":false,"visible":false }
                ],
        "aoColumnDefs": [
           {
             "targets": [1],
             "data": "id",
             "render": function(data, type, full,meta) {
            	 return '<label style="margin-right:0px" class="checkbox-inline i-checks"><input name = "id" type="checkbox" value="'+data+'"></label>';
             }
           },          
        ],  
        "drawCallback":function(settings){  
        	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",});
        },
        "className" : "Statistics",
        "chosen" : true,
        "ids" : "#cityname,#name,#endtime,#starttime",
        "targets":"2,3,6,7"
	});
});
