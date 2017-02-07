<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="addBrandModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">
					添加品牌 <span id="loading" style=""></span>
				</h4>
			</div>
			<form action="addBrand" id="addBrand" method="post">
				<fieldset>
				<div class="ibox-content">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="abrabdname">品牌名称(*)</label><input class="form-control"
									placeholder="请输入品牌名称" id="abrabdname" name="name" type="text">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label class="control-label">供应商名称(*)</label>
								<select class="reg-sel-add" style="width: 100%" id="asupplierId" name="supplierId">
									<option value=""></option>
									<option value=""></option>
									<%-- <c:forEach items="${supplierMsg}" var="supplierList">
										<option value="${supplierList.id}">${supplierList.name}</option>
									</c:forEach> --%>
								</select>
							</div>								 
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label for="content">品牌简介</label><textarea class="form-control" rows="3"
									placeholder="请输入品牌简介" id="acontent" name="content"></textarea>
							</div>
						</div>
					</div>
				</div>
				</fieldset>
			</form>
			<div class="modal-footer">
				<button class="btn btn-primary" id="brandSubmit" type="button">保存</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
<script>
	var addBrandValidate = "";
	$(document).ready(function(){
		brand = $("#brandTree");
		brand = $.fn.zTree.init(brand, brandSetting);
		demoIframe = $("#testIframe");
		demoIframe.bind("load", loadReady);
		var bTree = $.fn.zTree.getZTreeObj("brandTree");
		bTree.selectNode(bTree.getNodeByParam("id", 101));
		
		$('#addBrandModal').on('shown.bs.modal', function () {
			addBrandValidate.resetForm();
			$('.reg-sel-add').select2({
				placeholder: "请选择供应商",
				language:"zh-CN",
				ajax: {
				    url: 'getSupplierAll',
				    processResults: function (data) {
				      return {
				        results: data
				      };
				    }
				}
			});
		});
		
		
		$("#brandSubmit").click(function(){
			$("#addBrand").submit();
		});
		addBrandValidate=$("#addBrand").validate({
	        rules: {
	        	supplierId:{
	        		required:true,	        		
	        	},
	        	name: {
	        	    required:true,
	        	    remote: {
	        		    url: "validateBrand",     	//后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	name: function() {
	        		            return $("#abrabdname").val();
	        		      	}
	        		  	}
	        	  	}
	          	},	       
	        },
	        messages: {
	        	supplierId:{
	        		required:"该选择供应商"
	        	},
	        	name: {
		        	 required:"请输入品牌名称",
		        	 remote:"该品牌已存在"
		        },
		        content: {
		        	 required:"请输入品牌简介"
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
	        			   $("#brandSubmit").removeAttr("disabled"); 
	        		   },1000);
	        		   reset(form);
	        		   brand.reAsyncChildNodes(null, "refresh");
	        		 
	        	   },
	        	   error:function(){
	        		   $("#loading").html("<span class=\"label label-danger\">网络故障，稍后重试</span>");
	        		   setTimeout(function(){
	        			   $("#loading").html("");
	        			   $("#brandSubmit").removeAttr("disabled"); 
	        		   },1000);
	        	   }
	           });     
	        }  
	     });
	});
</script>