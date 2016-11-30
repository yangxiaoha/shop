<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fun" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="modal fade" id="editModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">修改图片名称
				<span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="edit" id="edit" method="post">
					<fieldset>
						<div class="row">
							<input type="hidden" id="eid" name="id" >
							<div class="col-md-12">
								<div class="form-group">
									<label for="eimagename">图片名称</label><input
										class="form-control" placeholder="请输入图片名称" id="eimagename" name="imagename"
										type="text">
								</div>
							</div>
							<div class="col-md-12">
								<input id="imageinputurl" value="<%=basePath %>" type="hidden" />
								<img id="imageshow" src="http://127.0.0.1:8080/ap/assets/home/images/logo.png" style="width: 100%" />
							</div>								
						</div>
					</fieldset>
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" id="editsubmit" type="button">保存</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$("#editsubmit").click(function(){			
			$("#edit").submit();
		});
		
	    $("#edit").validate({
	        rules: {
	        	imagename: {
	        	    required:true,
	        	    remote: {
	        		    url: "validate",     		//后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	imagename: function() {
	        		            return $("#eimagename").val();
	        		       },
	    				    id:function(){
	    				    	return $("#eid").val();
	    				   }	
	        		   }
	        	   }
	           }
	        },
	        messages: {
	        	imagename: {
		        	 required:"请输入图片名称",
		        	 remote:"图片名称已存在"
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
	        			   $("#editsubmit").removeAttr("disabled"); 
	        			   $("#editModal").modal('hide');
	        		   },1000);
	        		   tableI.table().draw();
	        	   },
	        	   error:function(){
	        		   $(".loading").html("<span class=\"label label-danger\">网络故障，稍后重试</span>");
	        		   setTimeout(function(){
	        			   $(".loading").html("");
	        			   $("#editsubmit").removeAttr("disabled"); 
	        		   },1000);
	        	   }
	           });     
	        }  
	    });
	});
</script>