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
               return '<label><input name="id" type="checkbox" value="'+data+'"><span></span></label>';
             }
           },          
        ],        
        "className" : "Statistics",
        "chosen" : true,
        "ids" : "#cityname,#name,#endtime,#starttime",
        "targets":"2,3,6,7"
	});
});
