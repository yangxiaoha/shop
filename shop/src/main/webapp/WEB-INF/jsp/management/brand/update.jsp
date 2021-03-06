<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="updateModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">修改品牌
				<span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="update" id="update" method="post">
					<fieldset>
						<div class="row">
							<input type="hidden" id="eid" name="id">
							<div class="col-md-6">
								<div class="form-group">
									<label for="name">品牌名称(*)</label><input class="form-control"
										placeholder="请输入品牌名称" id="ename" name="name" type="text">
								</div>
							</div>
							<div class="col-md-6">
								<label for="supplierId">供应商名称(*)</label> 
								<select class="reg-sel form-control" id="esupplierId"  name="supplierId">																	
									<c:forEach items="${supplierMsg}" var="supplierList">
										<option value="${supplierList.id}">${supplierList.name}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label for="content">品牌简介</label><textarea class="form-control" rows="3"
										placeholder="请输入品牌简介" id="econtent" name="content"></textarea>
								</div>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" id="updatesubmit" type="button">保存</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
<script>
	var ubrandValidate;
	$(document).ready(function(){		
		$("#updatesubmit").click(function(){			
			$("#update").submit();
		});
		$('#updateModal').on('shown.bs.modal',
		    function() {
				ubrandValidate.resetForm();
	    });
	    ubrandValidate=$("#update").validate({
	        rules: {
	          name: {
	        	 required:true,
	        	 remote: {
	        		    url: "validate",     //后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	name: function() {
	        		            return $("#ename").val();
	        		       },
	        		       id:function(){
	    				    	return $("#eid").val();
	    				   }
	        		  }
	        	  }
	          },	       
	        },
	        messages: {
	          name: {
		        	 required:"请输入品牌名称",
		        	 remote:"品牌已存在"
		      },
		      content: {
		        	 required:"请输入品牌简介",		        	
		      }
	        },
	        submitHandler: function(form) { 
	           $(this).attr("disabled","disabled"); 
			   $(".loading").html("<i class=\"icon-spinner icon-spin\"></i>");
	           $(form).ajaxSubmit({
	        	   success:function(data){
	        		   if(data.state == 1){
	        			   $(".loading").html("<span class=\"label label-success\">"+data.msg+"</span>");
	        		   }else{
	        			   $(".loading").html("<span class=\"label label-danger\">"+data.msg+"</span>");
	        		   }
	        		   setTimeout(function(){
	        			   $(".loading").html("");
	        			   $("#updatesubmit").removeAttr("disabled"); 
	        			   $("#updateModal").modal('hide');
	        		   },1000);
	        		   tableI.table().draw();
	        	   },
	        	   error:function(){
	        		   $(".loading").html("<span class=\"label label-danger\">网络故障，稍后重试</span>");
	        		   setTimeout(function(){
	        			   $(".loading").html("");
	        			   $("#updatesubmit").removeAttr("disabled"); 
	        		   },1000);
	        	   }
	           });     
	        }  
	      });
	});
</script>