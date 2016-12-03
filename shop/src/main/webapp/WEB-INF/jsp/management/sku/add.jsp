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
	<div class="modal-dialog" style="width:700px;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">
					添加商品 <span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="add" id="add" method="post">
					<fieldset>
						<div class="row">
							<div class="col-md-7">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="num">商品数量</label><input class="form-control"
												placeholder="请输入商品数量" id="anum" name="num" type="text">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label for="price">商品价格</label><input class="form-control"
												placeholder="请输入商品价格" id="aprice" name="price" type="text">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label for="code">特征量编码</label><input class="form-control"
												placeholder="请输入特征量编码" id="acode" name="code" type="text">
											<input type="hidden" id="" name="goodsId"
												value="${goodsM.id }" type="text">
										</div>
									</div>
								</div>
								<div class="row">
									<c:forEach items="${goodsM.pros}" var="p" varStatus="status">
										<div class="col-md-6">
											<div class="form-group">
												<label for="proId">${p.name }</label><input
													class="form-control avalue" placeholder="请输入${p.name }"
													id="avalue" name="value" type="text"> <input
													class=aproId type="hidden" id="" name="proId" value="${p.id }"
													type="text">
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
							<div class="col-md-5">
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<p>请选择图片</p>
											<p class="error" style="display: none;"></p>
											<div class="pic">
												<div id="preview" class="preview">
													<img id="imghead" class="imghead" width="240" height="240"
														src="<%=basePath%>/res/bj_img1.jpg" />
												</div>
												<input type="file" name="photourl" class="image_file"
													id="addphoto" onchange="previewImage(this)">
											</div>
										</div>
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
			$("#add").submit();
		});
	    $("#add").validate({
	        rules: {
	        	price:{
	        		required:true,
	        	},
	        	num:{
	        		required:true,
	        	},
	          code: {
	        	 remote: {
	        		    url: "validate",     //后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	schoolName: function() {
	        		            return $("#acode").val();
	        		       }
	        		  }
	        	  }
	          },	       
	        },
	        messages: {
	          code: {
		        	 required:"请输入特征量编码",
		        	 remote:"该编码已存在"
		      },
		      num: {
		        	 required:"请输入商品数量"
		      },
		      price: {
		        	 required:"请输入商品价格"
		      }
	        },
	        submitHandler: function(form) {   
	           $(this).attr("disabled","disabled"); 
			   $(".loading").html("<i class=\"icon-spinner icon-spin\"></i>");
			   var fileimage = $("#addphoto").val();
			   var svalue = new Array();
			   var sproId = new Array();
			   $(".avalue").each(function(index,e){
				  svalue[index]=$(e).val();
			   });
			   $(".aproId").each(function(index,e){
				   sproId[index] = $(e).val();
			   });
				if (fileimage.length != 0) {
					$.ajaxFileUpload({
						data :{
							num:$("#anum").val(),
							price:$("#aprice").val(),
							code:$("#acode").val(),
							goodsId:"${goodsM.id}",
							value:svalue,	
							proId:sproId
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
		        			$("#acode").val(""); 
		        			$("#imghead").css({"margin-top":"0px","width":"240px","height":"240px"});
		        			$("#imghead").attr("src","<%=basePath%>/res/bj_img1.jpg");
		        		    tableI.table().draw(false);
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
	    });
	});	
</script>