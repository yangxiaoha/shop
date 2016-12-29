<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="updateModal">
	<div class="modal-dialog" style="width:700px;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">
					修改商品 <span class="loading" style=""></span>
					<input type="hidden" id="basepath" value="<%=basePath %>">
					
				</h4>
			</div>
			<div class="modal-body">
				<form action="update" id="update" method="post">
					<fieldset>
						<div class="row">
						<div class="col-md-7">
							<input type="hidden" id="uid" name="id">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label for="price">商品价格(*)</label><input class="form-control"
											placeholder="请输入商品价格" id="uprice" name="price" type="text">
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label for="code">特征量编码</label><input class="form-control"
											placeholder="请输入特征量编码" id="ucode" name="code" type="text">
									</div>
								</div>
							</div>
							<c:forEach items="${goodsM.pros}" var="p" varStatus="status">
								<c:if test="${status.index%2 == 0}">
									<div class="row">
								</c:if>
								<div class="col-md-6">
									<div class="form-group">
										<label for="proId">${p.name }(*)</label><input
											class="form-control uvalue" placeholder="请输入${p.name }" title="${p.name }不能为空"
											id="a${status.index}" required="required" name="value"
											type="text"> <input type="hidden" 
											id="b${status.index}" name="" type="text">
											<input class = "uproId" type = "hidden"	id="" name="proId" value = "${p.id }" 
											type="text">
											<input type = "hidden"	id="uids" name="ids" 
											type="text">
									</div>
								</div>
								 <c:set var="last" value="${status.last }"></c:set>
								 <c:set var="odd" value="${status.index%2 == 1}"></c:set>										 
								<c:if test="${(odd)||(last)}">
									</div>
								</c:if>
							</c:forEach>
							<div class="col-md-6">
								<div class="form-group">
									<input type="hidden" id="ugoodsId" name="goodsId" value="${goodsM.id }"
										type="text">
								</div>
							</div>
						</div>
						<div class="col-md-5">
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<p>请选择图片(大小不超过：300*150)</p>
										<p class="error" style="display: none;"></p>
										<div class="pic">
											<div id="preview" class="preview">
											<input type="hidden" name="url" id="uurl">
												<img id="uimghead" class="imghead" width="240" height="240">
											</div>
											<input type="file" name="photourl" class="image_file"
												id="updatephoto" onchange="previewImage(this,'uimghead')">
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
			<button class="btn btn-primary" id="updatesubmit" type="button">保存</button>
			<button class="btn btn-default-outline" data-dismiss="modal"
				type="button">取消</button>
		</div>
	</div>
	</div>
</div>
<script>
	$(function () {		
		if ($.validator) {		
		    //fix: when several input elements shares the same name, but has different id-ies....		
		    $.validator.prototype.elements = function () {		
		        var validator = this,		
		            rulesCache = {};
	        // select all valid inputs inside the form (no submit or reset buttons)	
	        // workaround $Query([]).add until http://dev.jquery.com/ticket/2114 is solved	
	        return $([]).add(this.currentForm.elements)	
	        .filter(":input")	
	        .not(":submit, :reset, :image, [disabled]")	
	        .not(this.settings.ignore)	
	        .filter(function () {	
	            var elementIdentification = this.id || this.name;	
	            !elementIdentification && validator.settings.debug && window.console && 
	            console.error("%o has no id nor name assigned", this);
	            // select only the first element for each name, and only those with rules specified	
	            if (elementIdentification in rulesCache || !validator.objectLength($(this).rules()))	
	                return false;
	            rulesCache[elementIdentification] = true;	
	            return true;	
	        });	
	    };
	}
	});


	$(document).ready(function(){
		$('.datepicker').datepicker();
		$("#updatesubmit").click(function(){			
			$("#update").submit();
		});
		
	    $("#update").validate({
	        rules: {
	        	price:{
	        		required:true,
	        		number:true,
	        	},	        	
	          code: {
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
		      code: {
		        	 required:"请输入商品编码",
		        	 remote:"该编码已存在"
		      },
		      price: {
		        	 required:"请输入商品价格",
		        	 number:"请输入一个数字"
		      }
	        },
	        submitHandler: function(form) {   
		           $(this).attr("disabled","disabled"); 
				   $(".loading").html("<i class=\"icon-spinner icon-spin\"></i>");
				   var fileimage = $("#updatephoto").val();
				   var usvalue = new Array();
				   var usproId = new Array();
				   $(".uvalue").each(function(index,e){
					  usvalue[index]=$(e).val();
				   });
				   $(".uproId").each(function(index,e){
					   usproId[index] = $(e).val();
				   });
					$.ajaxFileUpload({
						data :{
							id:$("#uid").val(),
							goodsId:$("#ugoodsId").val(),
							ids:$("#uids").val(),
							price:$("#uprice").val(),
							code:$("#ucode").val(),								
							value:usvalue,	
							proId:usproId
							},
						url: 'update',   
			            type: 'post',  
			            secureuri: false, //一般设置为false  
			            fileElementId: 'updatephoto', // 上传文件的id、name属性名  
			            dataType: 'json', //返回值类型，一般设置为json、application/json  
			            //elementIds: elementIds, //传递参数到服务器
						success:function(data){
		        			$(".loading").html("<span class=\"label label-success\">"+data.msg+"</span>");
		        			setTimeout(function(){
		        			   $(".loading").html("");
		        			   $("#updatesubmit").removeAttr("disabled");
		        			   $("#updateModal").modal('hide');
		        		    },1000);
		        					        			
		        		    tableI.table().draw(false);
		        	    },
		        	    error:function(e){
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