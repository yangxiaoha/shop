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
						<input type="hidden" id="upnum">	
						<input type="hidden" name="goodsId" value="${goodsM.id }" type="text">									
							<div class="col-md-12">
								<div class="form-group">
									<label>商品数量(*)</label><input class="form-control"
										placeholder="请输入商品数量" id="apnum" name="num" type="text">
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
	var uaskuValidate;
	$(document).ready(function(){		
		$("#updateAddsubmit").click(function(){
			if((parseInt($("#apnum").val())+parseInt($("#upnum").val()))<0){
				alert("总数不能低于0！")
			}else{				
				$("#updateAdd").submit();
			}
		});
		$('#updateAddModal').on('shown.bs.modal',
		    function() {
				uaskuValidate.resetForm();
	    });
		uaskuValidate=$("#updateAdd").validate({	
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