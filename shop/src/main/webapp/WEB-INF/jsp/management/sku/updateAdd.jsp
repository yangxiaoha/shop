<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="updateAddModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">
					添加商品 <span id="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="updateAdd" id="updateAdd" method="post">
					<fieldset>
						<div class="row">
						<input type="hidden" id="aid" name="skuId" >											
							<div class="col-md-6">
								<div class="form-group">
									<label for="num">商品数量</label><input class="form-control"
										placeholder="请输入商品数量" id="anum" name="num" type="text">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="batch">商品批次</label><input class="form-control"
										placeholder="请输入商品批次" id="abatch" name="batch" type="text">
								</div>
							</div>							
						</div>
					</fieldset>
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" id="updateAddsubmit" type="button">保存</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){		
		$("#updateAddsubmit").click(function(){
			$("#updateAdd").submit();
		});
	    $("#updateAdd").validate({	
	    	rules: {		        	
		        	num:{
		        		required:true,
		        		digits:true,
		        	}
	    	},
	        messages: {
		      num: {
		        	 required:"请输入商品数量",
		        	 digits:"请输入一个整数"
		      },
		      batch: {
		        	 required:"请输入商品批次",
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
	        			   $("#updateAddsubmit").removeAttr("disabled"); 
	        		   },1000);
	        		   reset(form);
	        		   $("#updateAddModal").modal("hide");
	        		   tableI.table().draw();
	        		   
	        	   },
	        	   error:function(){
	        		   $("#loading").html("<span class=\"label label-danger\">网络故障，稍后重试</span>");
	        		   setTimeout(function(){
	        			   $("#loading").html("");
	        			   $("#updateAddsubmit").removeAttr("disabled"); 
	        		   },1000);
	        	   }
	           });     
	        }  
	      });
	});
</script>