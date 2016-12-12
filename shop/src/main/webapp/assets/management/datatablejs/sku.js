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
                    { "data": "name" },
                    { "data": "num" },
                    { "data": "price" },                    
                    { "data": "code" }, 
                    { "data": "value","orderable":false,"visible":false  }, 
                    { "data": "goodsId","orderable":false,"visible":false }, 
                    { "data":"id","className": "actions","orderable":false },
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
               "targets": [8],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
                 			'<a class="table-actions update" data-rowid="'+meta.row+'" href="javascript:void(0)"><i class="icon-pencil"></i></a>'+
                 			'<a class="table-actions updateAdd" data-rowid="'+meta.row+'" href="javascript:void(0)"><i class="icon-plus-sign-alt"></i></a>'+
                 		'</div>';
               }
            },          
            {
                "targets": [9],
                "data": "id",
                "render": function(data, type, full,meta) {
                  return '<div class="action-buttons">'+
                  '<button class="btn btn-xs btn-primary see" data-rowid="'+meta.row+'" href="javascript:void(0)">商品详情</button>'+
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
        	
        	$(".see").click(function(){        		
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#sid").val(obj.id);
        		$("#snum").html(obj.num);
        		$("#sprice").html(obj.price); 
        		$("#scode").html(obj.code);
        		$("#svalue").html(obj.value);
        		var imghead = $("#basepath").val()+obj.url;
        		$("#simghead").attr("src",imghead);
        		$("#simghead").css({"margin-top":"16px","width":"238px","height":"179px"});
        		if(obj.ids != null && obj.ids != ""){        			
        			var str = obj.value.split("|#$%|");
        			for(var i=0;i<str.length;i++){
        				var valueId = "#s"+i;
        				$(valueId).val(str[i]);        				
        			}
        		}
        		$("#seeModal").modal('show');
        	});
        	
        	$(".update").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#uid").val(obj.id);        		
        		$("#uprice").val(obj.price);        		
        		$("#ucode").val(obj.code);
        		$("#uvalue").val(obj.value);
        		$("#uurl").val(obj.url);
        		$("#uids").val(obj.ids);
        		var imghead = $("#basepath").val()+obj.url;
        		$("#uimghead").attr("src",imghead);
        		$("#uimghead").css({"margin-top":"16px","width":"238px","height":"179px"});
        		if(obj.ids != null && obj.ids != ""){        			
        			var str = obj.value.split("|#$%|");
        			var proIds = obj.ids.split(",");
        			for(var i=0;i<str.length;i++){
        				var valueId = "#a"+i;
        				var idsId = "#b"+i;
        				$(valueId).val(str[i]);
        				$(idsId).val(proIds[i]);
        			}
        		}
        		$("#updateModal").modal("show");
        	});
        },
        "className" : "Sku",
        "chosen" : true,
        "ids" : "#code",
        "targets":"5"
	});
});