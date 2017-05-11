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
	<script src="<%=basePath%>assets/management/js/uploadphoto1.js"
	type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/js/ajaxfileupload2.js"
	type="text/javascript"></script>	
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
		#update .pic {
	    width: 240px;
	    height: 180px;
	    position: relative;
	    border: 1px solid #d2d2d2;
	    overflow: hidden;
		}
		
		.pic div {
		    width: 250px;
		    cursor: pointer;
		}
		.image_file {
		    width: 250px;
		    height: 100%;
		    position: absolute;
		    top: 10px;
		    left: 10px;
		    cursor: pointer;
		    opacity: 0;
		    z-index: 9999;
		}		
		#aurl,#uurl{
			    padding: 5px;
			    margin-right: 5px;
			    margin-bottom: 5px;
			    border-radius: 5px;
			    border: 1px solid #d2d2d2; 
			}
		p.error {
			margin: 10px 0;
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
				<div class="col-sm-6 mb10">
					<a type="button" id = "pageinit" style="float:right">返回商品列表</a>
				</div>
				<!--<div class="col-sm-6 mb10">
	                <label>商品库存:</label>
	                <input type="text" placeholder="请输入商品库存量" id="iskuNum" name="skuNum" class="form-control goods-input">
				</div> -->
	        </div>
	        <div class="row">
				<div class="col-sm-6 mb10">
	                <label>商品编码(*):</label>
	                <input type="text" placeholder="请输入商品编码" id="igoodsCode" name="code" class="form-control goods-input">
				</div>
				<div class="col-sm-6 mb10">
	                <label>所属门店(*):</label>
	                <input type="text" placeholder="请输入所属门店" id="istore" name="store" class="form-control goods-input">
				</div>
			</div>
			<hr>
	        <div class="row">
	        	<div class="col-sm-6 mb10">
					<label>供应商管理:</label>
					<input type="text" placeholder="请选择供应商" readonly="readonly" id="selectSupplier" name="supplierNmae" class="form-control goods-input">
					<input type="hidden" id="selectSupplierId" class="form-control goods-input">
					<a data-toggle="modal" href="#addSupplierModal" style="width: 100px;height: 34px;margin-top: -4px;line-height: 23px;" class="btn btn-primary btn-sm" id="add-supplier">添加供应商</a>
	                <div style="margin-left:-21px;">	
						<ul id="storeTree" class="ztree"></ul>
		            </div>
				</div>
	        	<div class="col-sm-6 mb10">
	        		<div>
	        			<label>商品品牌(*):</label>
	        			<input type="text" placeholder="请选择商品品牌" readonly="readonly" id="selectBrand" name="brandName" class="form-control goods-input">
	        			<input type="hidden" id="selectBrandId" name="brandId" class="form-control goods-input">
	        			<a data-toggle="modal" href="#addBrandModal" style="width: 100px;height: 34px;margin-top: -4px;line-height: 23px;" class="btn btn-primary btn-sm" id="add-brand">添加品牌</a>
	        		</div>	        		
	                <div style="margin-left:-21px;">	
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
	        			<a data-toggle="modal" href="#addTypeModal" style="width: 100px;height: 34px;margin-top: -4px;line-height: 23px;" class="btn btn-primary btn-sm" id="add-type">添加类型</a>
	        		</div>	        		
	                <div>	
						<ul id="typeTree" class="ztree"></ul>
		            </div>
				</div>
				<div class="col-sm-6 mb10">
	        		<label>商品属性(*):</label>
	        		<input type="text" placeholder="请选择商品属性" readonly="readonly" id="selectPro" name="proName" class="form-control goods-input">
	        		<input type="hidden" id="selectProId" name="idstemp" class="form-control goods-input">
	        		<a data-toggle="modal" href="#addProModal" style="width: 100px;height: 34px;margin-top: -4px;line-height: 23px;" class="btn btn-primary btn-sm" id="add-pro">添加属性</a>
	                <div class="form-group proCheck" style="display: none;width:85%">
	                	<button type="button" class="btn btn-primary btn-sm mb10" id="addProBtn">添加</button>
	                	<button type="button" class="btn btn-primary btn-sm mb10" id="deleteProBtn">删除</button>
	                	<div style="margin-left:-15px" class="col-sm-10"></div>
	                </div>
				</div>
	        </div>
	        <div class="row">
				<div class="col-sm-4">
					<div class="form-group">
						<p>请选择图片(大小为：400*420)</p>
						<p class="error" style="display: none;"></p>
						<div class="pic">
							<div id="preview" class="preview" width="240" height="252">
								<img id="imghead1" class="imghead" width="240" height="252"
									src="<%=basePath%>/res/bj_img1.jpg" />									
							</div>
							<input type="file" name="photourl" class="image_file"
								id="addphoto1" onchange="previewImage(this,'imghead1')">
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<p>请选择图片(大小为：400*420)</p>
						<p class="error" style="display: none;"></p>
						<div class="pic">
							<div id="preview" class="preview">
								<img id="imghead2" class="imghead" width="240" height="252"
									src="<%=basePath%>/res/bj_img1.jpg" />
							</div>
							<input type="file" name="photourl2" class="image_file"
								id="addphoto2" onchange="previewImage(this,'imghead2')">
						</div>
					</div>
				</div>
				<div class="col-sm-4">
					<div class="form-group">
						<p>请选择图片(大小为：400*420)</p>
						<p class="error" style="display: none;"></p>
						<div class="pic">
							<div id="preview" class="preview">
								<img id="imghead3" class="imghead" width="240" height="252"
									src="<%=basePath%>/res/bj_img1.jpg" />
							</div>
							<input type="file" name="photourl3" class="image_file"
								id="addphoto3" onchange="previewImage(this,'imghead3')">
						</div>
					</div>
				</div>
			</div>	       
	        <div class="row">
	        	<div class="col-sm-12 mb10">
		   			<label style="float: left;">商品简介:</label>
		   			<!-- 
		   			<div><textarea name="content" style="float: left; width: 60%; min-height: 100px;" placeholder="请输入商品简介"></textarea></div>
		   			 -->	
		   			<script name="content" id="aditor" type="text/plain" style="float: left; width: 100%; min-height: 200px;"></script>
		   		</div>
	        </div>
	       	<div style="width: 50%; margin: 0 auto;">
	        	<div class="col-sm-6">
	        		<button type="button" class="btn btn-primary btn-block m-t" id="addSku">下一步</button>
	        	</div>
	        	<div class="col-sm-6">
	        		<a href="<%=basePath%>management/goods/index" class="btn btn-primary btn-block m-t">返回商品列表</a>
	        	</div>
	       	</div>
       	</form>
    </div>
    <jsp:include page="addBrand.jsp"/>
	<jsp:include page="addSupplier.jsp"/>
	<jsp:include page="addType.jsp"/>
	<jsp:include page="addPro.jsp"/>
    <script>
    var imgsize = "图片大小为400*420！";
    var imglong1 = 240;
	var imgwide1 = 252;
	var imglong = 400;
	var imgwide = 420;
	var imageFlag = true;
	var imgmol = "<%=basePath%>/res/bj_img1.jpg";
	var imgheads = "";
	var imgBigArrar = [];
	var goodsId;	
	var ue;	
	
	$("#addSku").click(function(){
		$("#addGoods").submit();
	});
	
	imgBigArrar.push("addphoto1");
	imgBigArrar.push("addphoto2");
	imgBigArrar.push("addphoto3");
	
    $("#pageinit").click(function(){		
		window.location.href="../goods/index"; 
	});
    
   	$(document).ready(function(){
   		
   		$('.datepicker').datepicker();
   		ue = UE.getEditor('aditor');
   		
   		$("#addphoto1").click(function(){
   			imgheads = "#imghead1";
   		});
   		
   		$("#addphoto2").click(function(){
   			imgheads = "#imghead2";
   		});
   		
   		$("#addphoto3").click(function(){
   			imgheads = "#imghead3";
   		});
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
       		var Confirm = true;
   			swal({
       			title: "你确定要删除该属性？",
       			text: "",
       			type: "warning",
       			showCancelButton: true,
       			showConfirmButton: Confirm,
       			confirmButtonColor: '#DD6B55',
       			confirmButtonText: "删除！",
       			cancelButtonText: "取消！",
       			closeOnConfirm: false
       		},
       		function(isConfirm){
   	    	    if (isConfirm){
   	    	    	$.ajax({
   	    		   	    url: "deletePro",
   	    		   		type: "Post",
   	    		   	    data: {
   	    		   	    	typeId:$("#selectTypeId").val(),
   	    		   	    	ids:$("#selectProId").val()
   	    		   	    },
   	    		   	    dataType: "json",
   	    		   	    success: function(data) {
   	    		   	    	$(".proCheck").hide();
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
   	    	   	    		swal("删除成功!", "", "success");
   	    		   	    }
   	    	        })        	    
   	    	    }
       		});
       		
       	});        	
       	
   	    $("#addGoods").validate({
   	        rules: {
   	        	name:{
   	        		required:true,
   	        		maxlength:20,
   	        		remote: {
   	        		    url: "validate",     //后台处理程序
    		       		    type: "post",               //数据发送方式
           			    dataType: "json",           //接受数据格式   
           			    data: {                     //要传递的数据
           			    	name: function() {
           		    	        return $("#igoodsName").val();	        		           
           			       	}
           			  	}	    
           		  	}
   	        	},
   	        	code: {
  		        	 remote: {
  		        		    url: "validate",     //后台处理程序
  		        		    type: "post",               //数据发送方式
  		        		    dataType: "json",           //接受数据格式   
  		        		    data: {                     //要传递的数据
  		        		    	code: function() {
  		        		            return $("#igoodsCode").val();	        		           
  		        		       }
  		        		  	}	    
  		        		}
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
   		        	maxlength:"最多20个字",
   		        	remote:"该名称已存在"
   		        },
   		        code: {
   		        	remote:"该编码已存在"
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
   	           
	   	        var str = ue.getContent();
				var newstr = str.split("<p><br/></p>")
				var uecontent = newstr.join("");
				
				   	           
   	           	var fileimage1 = $("#addphoto1").val();
   	           	var fileimage2 = $("#addphoto2").val();
   	           	var fileimage3 = $("#addphoto3").val();
   	           	var reader = new FileReader();
	   	        if(fileimage1.length == 0 || fileimage2.length == 0 || fileimage3.length == 0){
	   	        	alert("请上传图片！");
	    		};
	    		if(imageFlag == false){
	    			alert("请上传图片！");  	    			
	    		};
   	           if(fileimage1.length != 0 && fileimage2.length != 0 && fileimage3.length != 0 && imageFlag){   	        	   
	  			   $.ajaxFileUpload({
	 					data :{
	 						name:$("#igoodsName").val(),
	 						code:$("#igoodsCode").val(),
	 						store:$("#istore").val(),
	 						brandId:$("#selectBrandId").val(),
	 						typeId:$("#selectTypeId").val(),
	 						idstemp:$("#selectProId").val(),
	 						content:uecontent
	 					},
	 					url: 'addGoods',   
	 		            type: 'post',  
	 		            secureuri: false, //一般设置为false  
	 		            fileElementId: imgBigArrar, // 上传文件的id、name属性名  
	 		            dataType: 'json', //返回值类型，一般设置为json、application/json  
	 		            //elementIds: elementIds, //传递参数到服务器
	 					success:function(data){
	 	        			goodsId = data.goodsId;
	 	        			setTimeout(function(){
	 	        			   $("#addsubmit").removeAttr("disabled"); 
	 	        		    },1000);
	 	        			window.location.href="../addSku/index?goodsId="+goodsId; 
	 	        	    },	        	    	
	 	        	    error:function(e){
	 	         		    setTimeout(function(){
	 	         			    $("#addsubmit").removeAttr("disabled"); 
	 	         		    },1000);
	 	        	    }
	 				});
   	           }
   	        }  
   	      });
   	});
    </script>
    
    <script>
    	
		var zTree;
	
		var demoIframe;	
		
		var store;
		
		var brand;
		
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
						if(store.getSelectedNodes()!=null&&store.getSelectedNodes()!=""){
							return store.getSelectedNodes()[0].id;
						}
						return "";
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
		};
		
		function zTreeOnClickSupplier(event, treeId, treeNode) {
			$("#selectSupplier").val(treeNode.name);
			$("#selectSupplierId").val(treeNode.id);
			$("#selectBrand").val("");
			$("#selectBrandId").val("");
			brand.reAsyncChildNodes(null, "refresh");
		};
		
		function zTreeOnClickType(event, treeId, treeNode) {
			$("#selectType").val(treeNode.name);
			$("#selectTypeId").val(treeNode.id);
			$("#selectPro").val("");
			$("#selectProId").val("");
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
			var Confirm = true;
			swal({
    			title: "你确定要删除该品牌？",
    			text: "",
    			type: "warning",
    			showCancelButton: true,
    			showConfirmButton: Confirm,
    			confirmButtonColor: '#DD6B55',
    			confirmButtonText: "删除！",
    			cancelButtonText: "取消！",
    			closeOnConfirm: false
    		},
    		function(isConfirm){
	    	    if (isConfirm){
	    	    	$.ajax({
	    		   	    url: "deleteBrand",
	    		   		type: "Post",
	    		   	    data: {
	    		   	    	id:treeNode.id
	    		   	    },
	    		   	    dataType: "json",
	    		   	    success: function(data) {
	    		   	    	swal("删除成功!", "", "success");
	    		   	    	brand.reAsyncChildNodes(null, "refresh");
	    		   	    }
	    	        })
	    	    }else{
	    	    	brand.reAsyncChildNodes(null, "refresh");
	    	    }
    		});	    	
		}		
		
		function zTreeOnRemoveSupplier(event, treeId, treeNode) {
			var Confirm = true;
			swal({
    			title: "你确定要删除该供应商？",
    			text: "",
    			type: "warning",
    			showCancelButton: true,
    			showConfirmButton: Confirm,
    			confirmButtonColor: '#DD6B55',
    			confirmButtonText: "删除！",
    			cancelButtonText: "取消！",
    			closeOnConfirm: false
    		},
    		function(isConfirm){
	    	    if (isConfirm){
	    	    	$.ajax({
	    		   	    url: "deleteSupplier",
	    		   		type: "Post",
	    		   	    data: {
	    		   	    	id:treeNode.id
	    		   	    },
	    		   	    dataType: "json",
	    		   	    success: function(data) {
	    		   	    	swal("删除成功!", "", "success");
	    					brand.reAsyncChildNodes(null, "refresh");
	    					store.reAsyncChildNodes(null, "refresh");
	    		   	    }
	    	        })
	    	    }else{
	    	    	store.reAsyncChildNodes(null, "refresh");
	    	    }
    		});
		}
		
		function zTreeOnRemoveType(event, treeId, treeNode) {
			var Confirm = true;
			swal({
    			title: "你确定要删除该类型？",
    			text: "",
    			type: "warning",
    			showCancelButton: true,
    			showConfirmButton: Confirm,
    			confirmButtonColor: '#DD6B55',
    			confirmButtonText: "删除！",
    			cancelButtonText: "取消！",
    			closeOnConfirm: false
    		},
    		function(isConfirm){
	    	    if (isConfirm){
	    	    	$.ajax({
	    		   	    url: "deleteType",
	    		   		type: "Post",
	    		   	    data: {
	    		   	    	id:treeNode.id
	    		   	    },
	    		   	    dataType: "json",
	    		   	    success: function(data) {
	    		   	    	swal("删除成功!", "", "success");
							type.reAsyncChildNodes(null, "refresh");
							atype.reAsyncChildNodes(null, "refresh");
							pro.reAsyncChildNodes(null, "refresh");
							if($("#selectTypeId").val()==treeNode.id){		 			   
								$(".proCheck").hide();
							}
	    		   	    }
	    	        })
	    	    }else{
	    	    	type.reAsyncChildNodes(null, "refresh");
	    	    }
    		});			
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