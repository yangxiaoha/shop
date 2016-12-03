<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<div class="modal fade" id="addModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">添加图片
				<span class="loading" id="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form id="add">
					<fieldset>
						<div class="row">
							<div class="col-md-12">
								<div class="form-group">
									<p>请选择图片</p>
 									<input name="imagename" id="aimagename" placeholder="请输入图片名称" />							
									<p class="error" style="display: none;"></p>
									<div class="pic">
							    		<div id="preview" class="preview">
							       			<img id="imghead" class="imghead" width="200" height="200" src="<%=basePath %>/res/bj_img1.jpg" />
							    		</div>
							    		<input type="file" name="photourl" class="image_file" id="addphoto" onchange="previewImage(this)">
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
		$("#addsubmit").click(function(){
			var imgname = $("#aimagename").val();
			var errornum = $("p.error").text();
			if(imgname != null && imgname != "") {	
				$(".error").text("");
				$.ajax({
		    	    url: "validate",
		    		type: "post",
		    	    data: {
		    	    	imagename:$("#aimagename").val()
		    	    },
		    	    dataType: "json",
		    	    success: function(data) {
		    	    	if(data) {
		    	    		ajaxFileUpload();
		    	    	}else {
	    	    			$(".error").text("图片名称已存在");
	    	    			$(".error").css("display", "block");	    	    		
		    	    	}	    	    	
		    	    }
		        })				
			}else {
				if(errornum == ""){
					$(".error").text("请输入图片名称");
	    			$(".error").css("display", "block");
				}			
			}
		});
	});
	
	//上传图片文件
	//var elementIds=["aimagename"]; //flag为id、name属性名
	function ajaxFileUpload() {
		var fileimage = $("#addphoto").val();
		if (fileimage.length != 0) {
			$.ajaxFileUpload({
				data : { imagename : $("#aimagename").val() },
				url: 'uploadphoto',   
	            type: 'post',  
	            secureuri: false, //一般设置为false  
	            fileElementId: 'addphoto', // 上传文件的id、name属性名  
	            dataType: 'text', //返回值类型，一般设置为json、application/json  
	            //elementIds: elementIds, //传递参数到服务器
				success:function(data){
        			$(".loading").html('<span class="label label-success">上传成功！</span>');
        		    setTimeout(function(){
        			    $(".loading").html("");
        			    $("#addsubmit").removeAttr("disabled"); 
        		    },1000);
        		    tableI.table().draw();
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
	}
</script>