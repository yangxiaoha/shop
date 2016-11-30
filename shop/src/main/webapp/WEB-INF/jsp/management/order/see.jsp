<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="seeModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 style="color : black" class="modal-title">订单详情
				<span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="see" id="see" method="post">
					<fieldset>
						<div class="row">
						<input type="hidden" id="uid" name="id">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">收货人姓名：</span> <span
											style="font-size: 1em; color: black" id="sname"></span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">收货人电话：</span> <span
											style="font-size: 1em; color: black" id="sphone"></span>
									</div>
								</div>
								<div class="col-md-12">
									<div class="form-group">
										<span style="font-size: 1em; color: black">收货人地址：</span> <span
											style="font-size: 1em; color: black" id="saddress"></span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">物流商家：</span> <span
											style="font-size: 1em; color: black" id="slogistics"></span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">物流编号：</span> <span
											style="font-size: 1em; color: black" id="slogisticsnum"></span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">下单时间：</span> <span
											style="font-size: 1em; color: black" id="sordertime"></span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">订单状态：</span> <span
											style="font-size: 1em; color: black" id="sstate"></span>
									</div>
								</div>
							</div>
							<div class="row" id="checkbok"></div>
							<div class="row">
								<div class="form-group">
									<p style="font-size: 1em; color: black">备注：</p>
									<span style="font-size: 1em; color: black" id="smemo"></span>
								</div>
							</div>				
							<div class="row">
								<span style="margin-left:15px;color: black">修改备注</span>
								<div class="col-md-12">
									<div class="form-group">
										<label for="name"></label><textarea class="form-control" rows="3"
											placeholder="输入备注内容" id="umemo" name="memo"></textarea>
									</div>
								</div>
							</div>
						</div>
					</fieldset>
				</form>
			</div>			
			<div class="modal-footer">
				<button class="btn btn-primary" id="seesubmit" type="button">确定</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$("#seesubmit").click(function(){			
			$("#see").submit();
		});
		
	    $("#see").validate({	        
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
	        			   $("#seesubmit").removeAttr("disabled"); 
	        			   $("#seeModal").modal('hide');
	        		   },1000);
	        		   tableI.table().draw();
	        	   },
	        	   error:function(){
	        		   $(".loading").html("<span class=\"label label-danger\">网络故障，稍后重试</span>");
	        		   setTimeout(function(){
	        			   $(".loading").html("");
	        			   $("#seesubmit").removeAttr("disabled"); 
	        		   },1000);
	        	   }
	           });     
	        }  
	      });
	});
</script>