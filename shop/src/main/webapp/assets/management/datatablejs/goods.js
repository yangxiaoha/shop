var tableI = null;
$(document).ready(function(){
	tableI=$("#datatable").DatatableExt({
		"processing": true,
        "serverSide": true,
        "bFilter":false,
        "ajax": "listData",
        "language":  "/shop/assets/management/datatablejs/Chinese.json",
        "columns": [
                    { "data": "id","orderable":false,"visible":false},
                    { "data": "id","orderable":false},
                    { "data": "name"},
                    { "data": "exp_name" },
                    { "data": "quantity" },
                    { "data": "code" },
                    { "data": "brandName" },
                    { "data": "store" },
                    { "data":"id","className": "actions","orderable":false },                   
                    { "data": "top","orderable":false,"visible":false }, 
                    { "data": "typeId","orderable":false,"visible":false },
                ],
        "aoColumnDefs": [
           {
             "targets": [1],
             "data": "id",
             "orderable":false,
             "render": function(data, type, full,meta) {
                return '<label style="margin-right:0px" class="checkbox-inline i-checks"><input type="checkbox" value="'+data+'"></label>';
             }
           },          
           {
               "targets": [8],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
			                '<a class="table-actions" href="../sku/index?goodsId='+data+'"><i class="fa fa-sitemap" title="详细商品"></i></a>'+
			                '<a class="table-actions detail" data-rowid="'+meta.row+'" data-id="'+data+'" href="javascript:void(0)" title="编辑"><i class="fa fa-file-word-o"></i></a>'+
                 			'<a class="table-actions update" data-rowid="'+meta.row+'" href="javascript:void(0)" title="修改"><i class="fa fa-pencil"></i></a>'+
                 			'<a class="table-actions stick" data-id="'+data+'" href="javascript:void(0)" title="置顶"><i class="fa fa-arrow-up"></i></a>'+
                 			'<a class="table-actions del" data-id="'+data+'" href="javascript:void(0)" title="删除"><i class="fa fa-trash"></i></a>'+
                 		'</div>';
               }
            }
        ],
        "drawCallback":function(settings){
        	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",});
        	$(".del").click(function(){
        		$("#ids").val($(this).data("id"));
        		$("#delModal").modal('show');
        	});
        	
        	$(".stick").click(function(){
        		$("#tid").val($(this).data("id"));
        		$("#stickModal").modal('show');
        	});
        	
        	$(".detail").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#did").val($(this).data("id"));
        		ue.setContent(obj.content);
        		$("#detailModal").modal('show');
        	});
        	
        	$(".update").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#uid").val(obj.id);
        		$("#uname").val(obj.name);
        		$("#uexp_name").val(obj.exp_name);
        		$("#uquantity").val(obj.quantity);
        		$("#ucontent").val(obj.content);
        		$("#ucode").val(obj.code);
        		$("#ustore").val(obj.store);
        		$("#utypename").val(obj.typename);
        		$("#utypeId").val(obj.typeId);
        		$("#uids").val(obj.ids); 
        		$.ajax({
        			url:"getPro",
        			type:"post",
        			data:{typeId: obj.typeId},
        			dataType:"json",
        			async:true,
        			success:function(res){
        				var checkboxhtml = "";	
        				var idstemp = ","+obj.ids+",";
        				for (var i=0;i<res.length;i++){
        					var restemp = idstemp.indexOf(","+res[i].id+",");
        					if(restemp != -1){        						
        						checkboxhtml = checkboxhtml + '<div class="checkbox i-checks"><label><input name="idstemp" type="checkbox" value="'+res[i].id+'" checked=""> <i></i>'+res[i].name+'</label></div>'
        					}else{        							
        						checkboxhtml = checkboxhtml + '<div class="checkbox i-checks"><label><input name="idstemp" type="checkbox" value="'+res[i].id+'"> <i></i>'+res[i].name+'</label></div>'	
        					}        				
        				}
        				$("#ucheckbok").html(checkboxhtml);
        				$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",});
        			},
        			error:function(res){
        				
        			}
        		});
        		$("#ubrandId option").each(function (){  
	        		  var a = $(this).text();
	          		  if ($(this).text() == obj.brandName) {
	          		     $(this).prop('selected', true);
	          		  }
        		});
        		$("#updateModal").modal("show");
        	});
        },
        "className" : "Goods",
        "chosen" : true,
        "ids" : "#name,#code",
        "targets":"2,5"
	});
});