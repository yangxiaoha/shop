<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script src="<%=basePath%>assets/management/javascripts/uploadphoto.js"
	type="text/javascript"></script>
<script src="<%=basePath%>assets/management/javascripts/ajaxfileupload1.js"
	type="text/javascript"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="addModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">
					添加图片 <span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="add" id="add" method="post">
					<fieldset>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<p>请选择图片</p>
									<input name="url" id="aurl" placeholder="请输入..." />
									<p class="error" style="display: none;"></p>
									<div class="pic">
										<div id="preview" class="preview">
											<img id="imghead" class="imghead" width="240" height="240"
												src="<%=basePath%>/res/bj_img1.jpg" />
										</div>
										<input type="file" name="photourl" class="image_file"
											id="addphoto" onchange="previewImage(this,'imghead')">
									</div>
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
			$(this).attr("disabled","disabled"); 
			   $(".loading").html("<i class=\"icon-spinner icon-spin\"></i>");
			   var fileimage = $("#addphoto").val();
			   if(fileimage.length == 0){
	    		$(".loading").html("<span class=\"label label-danger\">请上传图片</span>");
	    		};
				if (fileimage.length != 0) {
					$.ajaxFileUpload({
						data :{
							url:$("#aurl").val(),							
							},
						url: 'add',   
			            type: 'post',  
			            secureuri: false, //一般设置为false  
			            fileElementId: 'addphoto', // 上传文件的id、name属性名  
			            dataType: 'json', //返回值类型，一般设置为json、application/json  
			            //elementIds: elementIds, //传递参数到服务器
						success:function(data){
		        			$(".loading").html("<span class=\"label label-success\">"+data.msg+"</span>");
		        			setTimeout(function(){
		        			   $(".loading").html("");
		        			   $("#addsubmit").removeAttr("disabled"); 
		        		    },1000);
		        			window.location.reload(); 
		        	    },
	        	    	
		        	    error:function(e){
		        		    $(".loading").html("<span class=\"label label-danger\">网络故障，稍后重试</span>");
		         		    setTimeout(function(){
		         			    $(".loading").html("");
		         			    $("#addsubmit").removeAttr("disabled"); 
		         		    },1000);
		        	    }
					});
				}
		});
	});	
</script>