<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="updateModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">修改商品Sku
				<span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="update" id="update" method="post">
					<fieldset>
						<div class="row">
						<input type="hidden" id="uid" name="id" >
							<div class="col-md-6">
								<div class="form-group">
									<label for="num">商品数量</label><input class="form-control"
										placeholder="请输入商品数量" id="unum" name="num" type="text">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="price">商品价格</label><input class="form-control"
										placeholder="请输入商品价格" id="uprice" name="price" type="text">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="ids">特征量组合</label><input class="form-control"
										placeholder="请输入特征量组合" id="uids" name="ids" type="text">
								</div>
							</div>							
							<div class="col-md-6">
								<div class="form-group">
									<label for="code">特征量编码</label><input class="form-control"
										placeholder="请输入特征量编码" id="ucode" name="code" type="text">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<input type = "hidden"	id="" name="goodsId" 
										value = "${goodsM.id }" type="text">
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
	$(document).ready(function(){
		$("#updatesubmit").click(function(){			
			$("#update").submit();
		});
		
	    $("#update").validate({
	        rules: {
	          ids: {
	        	 required:true,
	        	 remote: {
	        		    url: "validate",     //后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	ids: function() {
	        		            return $("#uids").val();
	        		       },
	        		       id:function(){
	    				    	return $("#uid").val();
	    				   }
	        		  }
	        	  }
	          },
	          code: {
		        	 required:true,
		        	 remote: {
		        		    url: "validate",     //后台处理程序
		        		    type: "post",               //数据发送方式
		        		    dataType: "json",           //接受数据格式   
		        		    data: {                     //要传递的数据
		        		    	code: function() {
		        		            return $("#ucode").val();
		        		       },
		        		       id:function(){
		    				    	return $("#uid").val();
		    				   }
		        		  }
		        	  }
		          },
	        },
	        messages: {
	          ids: {
		        	 required:"请输入特征量组合编码",
		        	 remote:"该编码已存在"
		      },
		      code: {
		        	 required:"请输入商品编码",
		        	 remote:"该编码已存在"
		      },
		      num: {
		        	 required:"请输入商品数量",		        	
		      },
		      price: {
		        	 required:"请输入商品价格",		        	
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