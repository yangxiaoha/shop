<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- Mirrored from www.zi-han.net/theme/hplus/table_data_tables.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>
    <link href="<%=basePath%>/assets/management/js/plugins/fancybox/jquery.fancybox.css" rel="stylesheet">
    <script type="text/javascript" src="<%=basePath %>/assets/management/plugin/ztree/js/jquery.ztree.all.js"></script>
    <script src="<%=basePath %>assets/management/datatablejs/goods.js" type="text/javascript"></script>
	<style>
		.mb10 {margin-bottom: 10px;}
		.goods-input {
		    display: inline-block;
    		width: 50%;
		}
		.proCheck {
			padding: 10px;
			margin-top: 5px;
		    border: 1px solid #000;    
		    border-radius: 5px;
		    overflow: hidden;
		}
		label {
			margin-right: 10px;
		}
		span.help-block {
			color: red;
		}
	</style>
</head>

<body class="gray-bg">
	
    <div class="wrapper wrapper-content animated fadeInRight">
	    <form action="addGoods" id="addGoods" method="post">
	        <div class="row">
				<div class="col-sm-6 mb10">
	                <label>商品名称(*):</label>
	                <input type="text" placeholder="请输入商品名称" id="igoodsName" name="name" class="form-control goods-input">
				</div>
				<!--<div class="col-sm-6 mb10">
	                <label>商品库存:</label>
	                <input type="text" placeholder="请输入商品库存量" id="iskuNum" name="skuNum" class="form-control goods-input">
				</div> -->
	        </div>
	        <div class="row">
				<div class="col-sm-6 mb10">
	                <label>商品编码&nbsp;&nbsp;&nbsp;:</label>
	                <input type="text" placeholder="请输入商品编码" id="igoodsCode" name="code" class="form-control goods-input">
				</div>
				<div class="col-sm-6 mb10">
	                <label>所属门店&nbsp;&nbsp;&nbsp;:</label>
	                <input type="text" placeholder="请输入所属门店" id="istore" name="store" class="form-control goods-input">
				</div>
			</div>
			<hr>
	        <div class="row">
	        	<div class="col-sm-6 mb10">
					<label>供应商管理:</label>
					<input type="text" placeholder="请选择供应商" readonly="readonly" id="selectSupplier" name="supplierNmae" class="form-control goods-input">
					<input type="hidden" id="selectSupplierId" class="form-control goods-input">
					<button data-toggle="modal" href="#addSupplierModal" class="btn btn-primary btn-sm" id="add-supplier">添加供应商</button>
	                <div>	
						<ul id="storeTree" class="ztree"></ul>
		            </div>
				</div>
	        	<div class="col-sm-6 mb10">
	        		<div>
	        			<label>商品品牌(*):</label>
	        			<input type="text" placeholder="请选择商品品牌" readonly="readonly" id="selectBrand" name="brandName" class="form-control goods-input">
	        			<input type="hidden" id="selectBrandId" name="brandId" class="form-control goods-input">
	        			<button data-toggle="modal" href="#addBrandModal" class="btn btn-primary btn-sm" id="add-brand">添加品牌</button>
	        		</div>	        		
	                <div>	
						<ul id="brandTree" class="ztree"></ul>
		            </div>
				</div>
	        </div>
	        <div class="row">
	        	<div class="col-sm-6 mb10">
	        		<div>
	        			<label>商品类型(*):</label>
	        			<input type="text" placeholder="请选择商品类型" readonly="readonly" id="selectType" name="typeName" class="form-control goods-input">
	        			<input type="hidden" id="selectTypeId" name="typeId" class="form-control goods-input">
	        			<button data-toggle="modal" href="#addTypeModal" class="btn btn-primary btn-sm" id="add-type">添加类型</button>
	        		</div>	        		
	                <div>	
						<ul id="typeTree" class="ztree"></ul>
		            </div>
				</div>
				<div class="col-sm-6 mb10">
	        		<label>选择商品属性(*):</label>
	        		<input type="text" placeholder="请选择商品属性" readonly="readonly" id="selectPro" name="proName" class="form-control goods-input">
	        		<input type="hidden" id="selectProId" name="idstemp" class="form-control goods-input">
	        		<button data-toggle="modal" href="#addProModal" class="btn btn-primary btn-sm" id="add-pro">添加属性</button>
	                <div class="form-group proCheck" style="display: none;width:85%">
	                	<button type="button" class="btn btn-primary btn-sm mb10" id="addProBtn">添加</button>
	                	<button type="button" class="btn btn-primary btn-sm mb10" id="deleteProBtn">删除</button>
	                	<div class="col-sm-10"></div>
	                </div>
				</div>
	        </div>
	        <!--<div class="row">
	        	<div class="col-sm-6 mb10">
	        		<label>商品属性值:</label>
	        		<button class="btn btn-primary btn-sm" id="add-sku">添加属性值</button>
	        	</div>
	        </div>
			<div class="row">
	        	<div class="col-sm-6 mb10">
		   			<label style="float: left;">商品图片:</label>	
		   			<div class="pic" style="float: left;">
						<div id="preview" class="preview">
							<img id="imghead" class="imghead" width="240" height="240" src="http://xz.zptmall.com:80/shop//res/bj_img1.jpg">
						</div>
						<input type="file" name="photourl" class="image_file" id="addphoto" onchange="previewImage(this,'imghead')">
					</div>
				</div>
	        </div> -->
	        <div class="row">
	        	<div class="col-sm-6 mb10">
		   			<label style="float: left;">商品简介:</label>	
		   			<div><textarea name="content" style="float: left; width: 60%; min-height: 100px;" placeholder="请输入商品简介"></textarea></div>
		   		</div>
	        </div>
	       	<div style="width: 50%; margin: 0 auto;">
	        	<div class="col-sm-6">
	        		<button type="button" class="btn btn-primary btn-block m-t" id="goodsSubmit">保存</button>
	        	</div>
	        	<div class="col-sm-6">
	        		<a href="<%=basePath %>management/goods/index" class="btn btn-primary btn-block m-t">返回</a>
	        	</div>
	       	</div>
       	</form>
    </div>
    <jsp:include page="addBrand.jsp"/>
	<jsp:include page="addSupplier.jsp"/>
	<jsp:include page="addType.jsp"/>
	<jsp:include page="addPro.jsp"/>
    <script>
    	$(document).ready(function(){
        	$("#addProBtn").click(function(){
        		var addVal = "";
        		var addIds = "";
        		$(".icheckbox_square-green").each(function() {
        			if($(this).hasClass("checked")) {
        				if(addVal == "") {
        					addVal = $(this).find("input[type=checkbox]").val();
        				}else {
        					addVal = addVal + " " + $(this).find("input[type=checkbox]").val();
        				}
        				if(addIds == "") {
        					addIds = $(this).siblings("input[type=hidden]").val();
        				}else {
        					addIds = addIds + "," + $(this).siblings("input[type=hidden]").val();
        				}
        			}
        		});
        		$("#selectPro").val(addVal);
        		$("#selectProId").val(addIds);
        	});

        	$('#deleteProBtn').click(function () {
        		var addIds = "";
        		$(".icheckbox_square-green").each(function() {
        			if($(this).hasClass("checked")) {
        				if(addIds == "") {
        					addIds = $(this).siblings("input[type=hidden]").val();
        				}else {
        					addIds = addIds + "," + $(this).siblings("input[type=hidden]").val();
        				}
        			}
        		});
        		$("#selectProId").val(addIds);
        	    swal({
        	        title: "您确定要删除这些属性吗",
        	        text: "删除后将无法恢复，请谨慎操作！",
        	        type: "warning",
        	        showCancelButton: true,
        	        confirmButtonColor: "#DD6B55",
        	        confirmButtonText: "删除",
        	        closeOnConfirm: false
        	    }, function () {
        	    	$.ajax({
        		   	    url: "deletePro",
        		   		type: "Post",
        		   	    data: {
        		   	    	typeId:$("#selectTypeId").val(),
        		   	    	ids:$("#selectProId").val()
        		   	    },
        		   	    dataType: "json",
        		   	    success: function(data) {
        		   	    	$(".proCheck .col-sm-10").html("");
        	   	    		$.each(data.proMsg, function(i, proList) {   
        	   	    			$(".proCheck").show();
        	   	    			$(".proCheck .col-sm-10").append( 
           	    					'<label class="checkbox-inline i-checks">'+
           	    					'<input type="checkbox" value="'+proList.name+'" style="position: absolute; opacity: 0;">'+proList.name+   	   	    				
           	    					'<input type="hidden" value="'+proList.id+'" />'+
           	    					'</label>'
        	    				);
           		  			});
        	   	    		$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",});
        		   	    }
        	        })
        	        swal("删除成功！", "您已经永久删除了这条信息。", "success");
        	    });
        	});
        	
        	$("#add-sku").click(function() {
        		$("#addSkuModal").show();
        	});
        	
    		$("#goodsSubmit").click(function(){
    			$("#addGoods").submit();
    		});
    		
    	    $("#addGoods").validate({
    	        rules: {
    	        	name:{
    	        		required:true,
    	        		maxlength:20,
    	        	},
    	        	brandName:{
    	        		required:true,
    	        	},
    	        	typeName: {
    	        	 	required:true,
    	          	},
    	          	proName: {
       	        	 	required:true,
       	          	}
    	        },
    	        messages: {
    	        	name: {
    		        	required:"请输入商品名称",
    		        	maxlength:"最多20个字"
    		        },
    		        brandName:{
    	        		required:"请选择商品品牌",
    	        	},
    	        	typeName: {
    	        	 	required:"请选择商品类型",
    	          	},
    	          	proName: {
       	        	 	required:"请选择商品属性",
       	          	}
    	        },
    	        submitHandler: function(form) {
    	           $(this).attr("disabled","disabled"); 
    			   $("#loading").html("<i class=\"icon-spinner icon-spin\"></i>");
    	           $(form).ajaxSubmit({
    	        	   success:function(data){
    	        		   if(data.state == 1){
    	        			   $("#loading").html("<span class=\"label label-success\">"+data.msg+"</span>");
    	        		   }else{
    	        			   $("#loading").html("<span class=\"label label-danger\">"+data.msg+"</span>");
    	        		   }
    	        		   setTimeout(function(){
    	        			   $("#loading").html("");
    	        			   $("#addsubmit").removeAttr("disabled"); 
    	        		   },1000);
    	        		   reset(form);
    	        	   },
    	        	   error:function(){
    	        		   $("#loading").html("<span class=\"label label-danger\">网络故障，稍后重试</span>");
    	        		   setTimeout(function(){
    	        			   $("#loading").html("");
    	        			   $("#addsubmit").removeAttr("disabled"); 
    	        		   },1000);
    	        	   }
    	           });     
    	        }  
    	      });
    	});
    </script>
    
    <script>
    	
		var zTree;
	
		var demoIframe;	
		
		var store;
		
		var brand;
		
		var brandSetting = {
			view: {
				selectedMulti: false				
			},
			async: {
				enable: true,
				url:"getBrandTree",
				autoParam:["id"],
				otherParam:{"supplierid":function(){
					if(store != null){
						return store.getSelectedNodes()[0].id;
					}
					return "";
				}},
				dataFilter: filter
			},
			callback:{
				onClick: zTreeOnClickBrand,
				onRemove: zTreeOnRemoveBrand
			},
			edit: {
				enable: true,
				showRemoveBtn: true,
				showRenameBtn: false,
				removeTitle: "删除"
			}
		};
		
		var storeSetting = {
			view: {
				selectedMulti: false				
			},
			async: {
				enable: true,
				url:"getSupplierTree",
				autoParam:["id"],
				otherParam:{"otherParam":"zTreeAsyncTest"},
				dataFilter: filter
			},
			callback:{
				onClick: zTreeOnClickSupplier,
				onRemove: zTreeOnRemoveSupplier
			},
			edit: {
				enable: true,
				showRemoveBtn: true,
				showRenameBtn: false,
				removeTitle: "删除"
			}
		};
		
		var typeSetting = {
			view: {
				selectedMulti: false				
			},
			async: {
				enable: true,
				url:"getTypeTree",
				autoParam:["id"],
				otherParam:{"otherParam":"zTreeAsyncTest"},
				dataFilter: filter
			},
			callback:{
				onClick: zTreeOnClickType,
				onRemove: zTreeOnRemoveType
			},
			edit: {
				enable: true,
				showRemoveBtn: true,
				showRenameBtn: false,
				removeTitle: "删除"
			}
		};

		function zTreeOnClickBrand(event, treeId, treeNode) {
			$("#selectBrand").val(treeNode.name);
			$("#selectBrandId").val(treeNode.id);
			tableI.table().columns(10).search(treeNode.id).draw();
		};
		
		function zTreeOnClickSupplier(event, treeId, treeNode) {
			$("#selectSupplier").val(treeNode.name);
			$("#selectSupplierId").val(treeNode.id);
			brand.reAsyncChildNodes(null, "refresh");
			tableI.table().columns(10).search(treeNode.id).draw();
		};
		
		function zTreeOnClickType(event, treeId, treeNode) {
			$("#selectType").val(treeNode.name);
			$("#selectTypeId").val(treeNode.id);
			$.ajax({
		   	    url: "getGoodsPro",
		   		type: "Post",
		   	    data: {
		   	    	typeId:treeNode.id
		   	    },
		   	    dataType: "json",
		   	    success: function(data) {
	   	    		$(".proCheck .col-sm-10").html("");
	   	    		$.each(data.proMsg, function(i, proList) {   
	   	    			$(".proCheck").show();
	   	    			$(".proCheck .col-sm-10").append( 
   	    					'<label class="checkbox-inline i-checks">'+
   	    					'<input type="checkbox" value="'+proList.name+'" style="position: absolute; opacity: 0;">'+proList.name+   	   	    				
   	    					'<input type="hidden" value="'+proList.id+'" />'+
   	    					'</label>'
	    				);
   		  			});
	   	    		$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",});
		   	    }
	        })
		};		
		
		function zTreeOnRemoveBrand(event, treeId, treeNode) {
	    	$.ajax({
		   	    url: "deleteBrand",
		   		type: "Post",
		   	    data: {
		   	    	id:treeNode.id
		   	    },
		   	    dataType: "json",
		   	    success: function(data) {}
	        })
		}
		
		function zTreeOnRemoveSupplier(event, treeId, treeNode) {
			$.ajax({
		   	    url: "deleteSupplier",
		   		type: "Post",
		   	    data: {
		   	    	id:treeNode.id
		   	    },
		   	    dataType: "json",
		   	    success: function(data) {}
	        })
		}
		
		function zTreeOnRemoveType(event, treeId, treeNode) {
			$.ajax({
		   	    url: "deleteType",
		   		type: "Post",
		   	    data: {
		   	    	id:treeNode.id
		   	    },
		   	    dataType: "json",
		   	    success: function(data) {}
	        })
	       type.reAsyncChildNodes(null, "refresh");
 		   atype.reAsyncChildNodes(null, "refresh");
 		   pro.reAsyncChildNodes(null, "refresh");
		}
	
		function filter(treeId, parentNode, childNodes) {
			if (!childNodes) return null;
			for (var i=0, l=childNodes.length; i<l; i++) {
				childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
			}
			return childNodes;
		};
		
		function loadReady() {
			var bodyH = demoIframe.contents().find("body").get(
					0).scrollHeight, htmlH = demoIframe
					.contents().find("html").get(0).scrollHeight, maxH = Math
					.max(bodyH, htmlH), minH = Math.min(bodyH,
					htmlH), h = demoIframe.height() >= maxH ? minH
					: maxH;
			if (h < 530)
				h = 530;
			demoIframe.height(h);
		}		
	
    </script>

</body>
</html>