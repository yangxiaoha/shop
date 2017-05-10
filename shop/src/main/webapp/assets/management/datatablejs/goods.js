var tableI = null;
$(document).ready(function(){
	if(pageinit == null || pageinit == ""){
		pageinit = 0;
	}
	if(pageinitGoods != null && pageinitGoods !=""){
		pageinit = parseInt(pageinitGoods);
	}
	tableI=$("#datatable").DatatableExt({
		"processing": true,
        "serverSide": true,
        "bFilter":false,
        "ajax": "listData?pageinitGoods="+pageinitGoods,
        "displayStart": pageinit,
        "language":  "/shop/assets/management/datatablejs/Chinese.json",
        "columns": [
                    { "data": "id","orderable":false,"visible":false},
                    { "data": "id","orderable":false},
                    { "data": "name"},
                    { "data": "suppliername" },
                    { "data": "quantity" },
                    { "data": "code" },
                    { "data": "brandName" },
                    { "data": "store" },
                    { "data": "id","className": "actions","orderable":false },
                    { "data": "id","className": "actions","orderable":false },                   
                    { "data": "top","orderable":false,"visible":false }, 
                    { "data": "typeId","orderable":false,"visible":false },
                ],
        "aoColumnDefs": [
           {
             "targets": [1],
             "data": "id",
             "orderable":false,
             "render": function(data, type, full,meta) {
                return '<label style="margin-right:0px" class="checkbox-inline i-checks"><input name = "id" type="checkbox" value="'+data+'"></label>';
             }
           },
           {
               "targets": [8],
               "data": "id",
               "render": function(data, type, full,meta) {
            	 if(full.state == 2){            		 
              		 return '<div style="text-align: center;padding-right:8px"><a style="margin:0px" class="btn btn-sm btn-primary-outline updateState" data-rowid="'+meta.row+'" >未发布</a></div>';
              	 }else if(full.state == 1){
              		 return '<div style="text-align: center;padding-right:8px"><a style="margin:0px" class="btn btn-sm btn-primary-outline" disabled="true">已发布</a></div>';
              	 }
               }
           },           
           {
               "targets": [9],
               "data": "id",
               "render": function(data, type, full,meta) {
                 return '<div class="action-buttons">'+
			                '<a class="table-actions" href="../sku/index?goodsId='+data+'&pageinit='+tableI.table().page()*tableI.table().page.len()+'"><i class="fa fa-sitemap" title="商品详情"></i></a>'+
			                '<a class="table-actions detail" data-rowid="'+meta.row+'" data-id="'+data+'" href="javascript:void(0)" title="编辑"><i class="fa fa-file-word-o"></i></a>'+
                 			'<a class="table-actions update" data-rowid="'+meta.row+'" href="javascript:void(0)" title="修改"><i class="fa fa-pencil"></i></a>'+
                 			'<a class="table-actions stick" data-id="'+data+'" href="javascript:void(0)" title="置顶"><i class="fa fa-arrow-up"></i></a>'+
                 			'<a class="table-actions down" data-id="'+data+'" href="javascript:void(0)" title="取消置顶"><i class="fa fa-arrow-down"></i></a>'+
                 			'<a class="table-actions del" data-id="'+data+'" href="javascript:void(0)" title="删除"><i class="fa fa-trash"></i></a>'+
                 		'</div>';
               }
            }
        ],
        "drawCallback":function(settings){
        	$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",});
        	$(".del").click(function(){
        		$("#dcontext").html("确认删除当前选项？");
        		$("#ids").val($(this).data("id"));
        		$("#delModal").modal('show');
        	});
        	
        	$(".updateState").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0]; 
                $.ajax({
                	url:"updateState",
                	type:"post",
                	data:{id:obj.id,                		
                		state:1},
                		dataType:"json",
                		async:true,
                		success:function(res){   
                			alert("商品发布！");
                			tableI.table().draw();
                		},
                		error:function(res){
                			alert("发布失败！");
                		}
                });	    	      		
        	});

        	$(".stick").click(function(){
        		$("#tid").val($(this).data("id"));
        		$("#stickModal").modal('show');
        	});
        	$(".down").click(function(){
        		$("#oid").val($(this).data("id"));
        		$("#downModal").modal('show');
        	});
        	
        	$(".detail").click(function(){
        		var rowid = $(this).data("rowid");
        		var api = new $.fn.dataTable.Api( settings );
                var obj = api.rows(rowid).data()[0];
        		$("#did").val($(this).data("id"));
        		if(obj.content == null){
        			obj.content = "";
        		}
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
        		var uurl1 = $("#basepath").val()+obj.url1;
        		var uurl2 = $("#basepath").val()+obj.url2;
        		var uurl3 = $("#basepath").val()+obj.url3;
        		$("#uurl1").val(uurl1);
        		$("#uurl2").val(uurl2);
        		$("#uurl3").val(uurl3);
        		$("#uimghead1").attr("src",uurl1);
        		$("#uimghead2").attr("src",uurl2);
        		$("#uimghead3").attr("src",uurl3);
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
        						checkboxhtml = checkboxhtml + '<div class="checkbox i-checks"><label><input name="idstemp" type="checkbox" value="'+res[i].id+'" checked="" disabled="disabled"> <i></i>'+res[i].name+'</label></div>'
        					}else{        							
        						checkboxhtml = checkboxhtml + '<div class="checkbox i-checks"><label><input name="idstemp" type="checkbox" value="'+res[i].id+'" disabled="disabled"> <i></i>'+res[i].name+'</label></div>'	
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