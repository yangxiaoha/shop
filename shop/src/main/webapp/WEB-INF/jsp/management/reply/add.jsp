<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="addModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">
					添加自动回复 <span id="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="add" id="add" method="post">
					<fieldset>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<label for="name">关键词(*)</label><input class="form-control"
										placeholder="请输入关键词" id="askey" name="skey" type="text">
								</div>
							</div>
							<div class="col-md-12">
								<div class="form-group">
									<label for="brief">自动回复内容(*)</label><textarea class="form-control" rows="3"
										placeholder="请输入自动回复内容" id="areply" name="reply"></textarea>
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
	        	reply:{
	        		required:true,	        		
	        	},
	          skey: {
	        	 required:true,
	        	 remote: {
	        		    url: "validate",     //后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	skey: function() {
	        		            return $("#askey").val();
	        		       }
	        		  }
	        	  }
	          },	       
	        },
	        messages: {
	          skey: {
		        	 required:"请输入skey",
		        	 remote:"该skey已存在"
		      },
		      reply: {
		        	 required:"请输入reply"
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