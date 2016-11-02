<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade" id="addModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">添加用户
				<span id="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="add" id="add" method="post">
					<fieldset>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="openid">用户openid</label><input
										class="form-control" placeholder="请输入用户openid" id="aopenid" name="openid"
										type="text">
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="money">金额</label><input
										class="form-control" placeholder="请输入金额" id="amoney" name="money" type="text">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								 <div class="input-group date datepicker" data-date-autoclose="true" data-date-format="dd-mm-yyyy">
					                <input class="form-control" type="text"><span class="input-group-addon"><i class="icon-calendar"></i></span></input>
					             </div>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" id="addsubmit" type="button">保存</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$('.datepicker').datepicker();
		$("#addsubmit").click(function(){
			$("#add").submit();
		});
	    $("#add").validate({
	        rules: {
	          openid: {
	        	 required:true
	          },
	          money: {
	        	 required:true
		      }
	        },
	        messages: {
	          openid: {
		        	 required:"请输入openid"
		      },
		      money: {
		        	 required:"请输入金额"
		      }
	        },
	        submitHandler: function(form) {   
	           $(this).attr("disabled","disabled"); 
			   $("#loading").html("<i class=\"icon-spinner icon-spin\"></i>");
	           $(form).ajaxSubmit({
	        	   success:function(data){
	        		   console.log(data);
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
	        		   tableI.table().draw();
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