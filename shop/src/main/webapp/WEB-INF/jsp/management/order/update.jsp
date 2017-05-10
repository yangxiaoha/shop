<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<div class="modal fade" id="updateModal" >
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 style="color : black" class="modal-title">订单发货
				<span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body" id="pr">
				<form action="update" id="update" method="post" class="form-horizontal">
					<fieldset>
						<div class="row" >
							<input type="hidden" id="uuid" name="id">
							<input type="hidden" id="ustate" name="state">
							<input type="hidden" id="totalPrice" name="totalPrice">
							<input type="hidden" id="nums" name="nums">
							<input type="hidden" id="goodsnames" name="goodsnames">
							<div class="row">
							<div class="col-md-3" style="padding-left:25px;">
							<label for="logis1"> 
							<input type="radio" name="logis" id="logis1"/>自提</label> 
							</div>
							<div class="col-md-3">
							<label for="logis2"> 
							<input type="radio" name="logis" value = "1" id="logis2"/>物流</label> 
							</div>
							</div>
							<div class="row">
								<div class="col-md-12">
								<div class="form-group" style="margin-right:15px;margin-left:15px">									
								<label class="control-label" style="color: black">
								<span>*</span>物流商家：</label>
								<input class="form-control" type="text" id="uulogistics" name="logistics" placeholder="请输入物流商家">										
								</div>
									
								</div>
							</div>
							<div class="row">
							<div class="col-md-12" >
								<div class="form-group" style="margin-right:15px;margin-left:15px">
								<label class="control-label" style="color: black">
								<span>*</span>物流编号：</label>
								<input class="form-control" type="text" id="uulogisticsnum" name="logisticsnum" placeholder="请输入物流编号">										
								</div>
							</div>
							</div>							
						</div>
					</fieldset>
				</form>
			</div>			
			<div class="modal-footer">
				<button class="btn btn-primary" id="updatesubmit" type="button">发货</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){		
		document.getElementsByName("logis")[1].checked="checked";		
		
		$("#updateModal").on('show.bs.modal',function(){
			document.getElementsByName("logis")[1].checked="checked";
			$("#uulogistics").removeAttr("readonly"); 
			$("#uulogisticsnum").removeAttr("readonly");
		});
		$("#updatesubmit").click(function(){
			$("#update").submit();
		});
		$("#logis1").click(function(){			
			$("#uulogistics").val("自提");
			$("#uulogisticsnum").val("自提");
			$("#uulogistics").attr("readonly","readonly"); 
			$("#uulogisticsnum").attr("readonly","readonly"); 
		});
		
		$("#logis2").click(function(){
			$("#uulogistics").val("");
			$("#uulogisticsnum").val("");
			$("#uulogistics").removeAttr("readonly"); 
			$("#uulogisticsnum").removeAttr("readonly"); 
		});
		
		$("#update").validate({	        
	        submitHandler: function(form) { 
	           $(this).attr("disabled","disabled"); 
			   $(".loading").html("<i class=\"icon-spinner icon-spin\"></i>");
			   if($("#uulogistics").val()!=null&&$("#uulogistics").val()!=""&&$("#uulogisticsnum").val()!=null&&$("#uulogisticsnum").val()!=""){				   
				   $("#ustate").val("3");
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
			   }else{
				   alert("请输入物流信息！");
			   }
	        }  
	    });
	});
</script>