<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="updateModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<input name="id" id="uid" class="hidden" />
			<input name="image" id="uimage" class="hidden" />
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">修改图片
				<span id="loading"></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="update" id="update" method="post">
					<fieldset>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<p>请选择图片(大小为：800*600)</p>
									<input name="url" id="uurl" placeholder="请输入url" />
									<p class="error" style="display: none;"></p>
									<div class="pic">
										<div id="preview" class="preview">
											<img id="uimghead" class="imghead" width="240" height="180" />
										</div>
										<input type="file" name="photourl" class="image_file"
											id="updatephoto" onchange="previewImage(this,'uimghead')">									
									</div>
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
	imageFlag = true;
	var imglong1 = 240;
	var imgwide1 = 180;
	$(document).ready(function(){
		$('.datepicker').datepicker();
		$(".update").click(function(){
			$("#uid").val($(this).data("id"));
			$("#uimage").val($(this).data("image"));
			$("#uurl").val($(this).data("url"));
			var imghead = $("#basepath").val()+$("#uimage").val();
			imgmol = imghead;
			imgheads = "#uimghead";
    		$("#uimghead").attr("src",imghead);
    		$("#uimghead").css({"width":"240px","height":"180px"});
    		var obj = document.getElementById('updatephoto') ; 
			obj.outerHTML=obj.outerHTML; 
    		$("#updateModal").modal("show");
    	});
		$("#updatesubmit").click(function(){
//			$(this).attr("disabled","disabled");			
     	   	$("#loading").html("<i class=\"icon-spinner icon-spin\"></i>");
     	   	var fileimage = $("#updatephoto").val();
     	   	if(!imageFlag){     	   		
				var obj = document.getElementById('updatephoto') ; 
				obj.outerHTML=obj.outerHTML; 
     	   	}
   	   		$.ajaxFileUpload({
   	   			data:{     	   				
   	   				id:$("#uid").val(),
   	   				url:$("#uurl").val(),
   	   				image:$("#uimage").val(),
   	   			},
   	   			url:'update',
   	   			type:'post',
   	   			secureuri:false,
   	   			fileElementId: 'updatephoto',
   	   			dataType: 'json',
    	   		success:function(data){
       			$("#loading").html("<span class=\"label label-success\">"+data.msg+"</span>");
       			setTimeout(function(){
       			   $("#loading").html("");
       			   $("#updatesubmit").removeAttr("disabled"); 
       		    },1000);
       			window.location.reload(); 
       	    	},
   	    	
	       	    error:function(e){
	       		    $("#loading").html("<span class=\"label label-danger\">网络故障，稍后重试</span>");
	        		    setTimeout(function(){
	        			    $("#loading").html("");
	        			    $("#updatesubmit").removeAttr("disabled"); 
	        		    },1000);
	       	    },
    	   	});
    	   	
		});		
	});
</script>