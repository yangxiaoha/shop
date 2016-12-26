<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.divb0{
		margin-bottom:0px;
	}
</style>
<div class="modal fade" id="addModal">
	<div class="modal-dialog"  style="width:800px;">
		<div class="modal-content" >
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">
					添加商品 <span id="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="add" id="add" method="post">
					<fieldset>
						<div class="col-lg-12">						
							<div class="col-lg-3">
								<table border=0 height=200px align=left>
									<tr>
										<td width=100px align=left valign=top
											style="BORDER-RIGHT: #999999 1px dashed">
											<ul id="atree" class="ztree"
												style="width: 100px; overflow: auto;"></ul>
										</td>
									</tr>
								</table>
							</div>
							<div class="col-lg-6">
								<div class="row">
									<div class="row">
									<div class="col-md-12">
										<label for="name">商品品牌(*)</label> <select
											class="reg-sel form-control" name="brandId">
											<option value=""></option>
											<c:forEach items="${brandMsg}" var="brandList">
												<option value="${brandList.id}">${brandList.name}</option>
											</c:forEach>
										</select>
									</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group divb0" style="margin-bottom:0px !important;">
												<label for="name">商品名称(*)</label><input class="form-control"
													placeholder="请输入商品名称" id="aname" name="name" type="text">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group divb0">
												<label for="exp_name">商品扩充名称</label><input
													class="form-control" placeholder="请输入商品扩充名称" id="aexp_name"
													name="exp_name" type="text">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group divb0">
												<label for="code">商品编码</label><input class="form-control"
													placeholder="请输入商品编码" id="acode" name="code" type="text">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group divb0">
												<label for="store">所属门店</label><input class="form-control"
													placeholder="请输入所属门店" id="astore" name="store" type="text">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group divb0">
												<label for="typeId">商品类型(*)</label> <input class="form-control"
													placeholder="" readonly="readonly" id="atypename"
													name="typeName" type="text"> <input type="hidden"
													placeholder="" id="typeId" name="typeId" type="text">																									
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-3" id="checkbok">
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
	var zTreeAdd;
	var domeIframeAdd;
	
	var settingAdd = {
			view: {
				selectedMulti: false
			},
			async:{
				enable: true,
				url:"getTreeData",
				autoParam:["id"],
				otherParam:{"otherParam":"zTreeAsyncTest"},
				dataFilter: filter				
			},
			callback:{
				onClick: zTreeOnClickAdd
			}
	};
	function zTreeOnClickAdd(event, treeId, treeNode) {
		console.log(treeNode);
		$("#typeId").val(treeNode.id);
		$("#atypename").val(treeNode.name);
		$.ajax({
			url:"getPro",
			type:"post",
			data:{typeId: treeNode.id},
			dataType:"json",
			async:true,
			success:function(res){
				if(res != null && res != ""){					
					var checkboxhtml = "";									
					for (var i=0;i<res.length;i++){
						checkboxhtml = checkboxhtml + "<label class=\"checkbox\"><input name=\"idstemp\" value="+res[i].id+" type=\"checkbox\"><span>"+res[i].name+"</span></label>"
					}
					$("#checkbok").html(checkboxhtml);
				}else{
					alert("商品属性不能为空，请先设置商品属性！");
					$("#atypename").val("");
					$("#checkbok").html("");
				}
			},
			error:function(res){
				
			}
		});
	// 	 alert(treeNode.id + ", " + treeNode.name);
	};
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	$(document).ready(function() {
		var t = $("#atree");
		t = $.fn.zTree.init(t, settingAdd);
		domeIframeAdd = $("#testIframe");
		domeIframeAdd.bind("load", loadReady);
		var zTreeAdd = $.fn.zTree.getZTreeObj("atree");
		zTreeAdd.selectNode(zTreeAdd.getNodeByParam("id", 101));
	
	});
	function loadReady() {
		var bodyH = domeIframeAdd.contents().find("body").get(
				0).scrollHeight, htmlH = domeIframeAdd
				.contents().find("html").get(0).scrollHeight, maxH = Math
				.max(bodyH, htmlH), minH = Math.min(bodyH,
				htmlH), h = domeIframeAdd.height() >= maxH ? minH
				: maxH;
		if (h < 530)
			h = 530;
		domeIframeAdd.height(h);
	}
	
	$(document).ready(function(){
		$('.datepicker').datepicker();
		$("#addsubmit").click(function(){
			$("#add").submit();
		});
	    $("#add").validate({
	        rules: {
	        	typeName:{
	        		required:true,
	        	},
	        	brandId:{
	        		required:true,
	        	},
	          name: {
	        	 required:true,
	        	 remote: {
	        		    url: "validate",     //后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	name: function() {
	        		            return $("#aname").val();	        		           
	        		       }
	        		  }	    
	        	  }
	          },
	          exp_name: {		        	
		        	 remote: {
		        		    url: "validate",     //后台处理程序
		        		    type: "post",               //数据发送方式
		        		    dataType: "json",           //接受数据格式   
		        		    data: {                     //要传递的数据
		        		    	exp_name: function() {
		        		            return $("#aexp_name").val();	        		           
		        		       }
		        		  }	    
		        	}
		      },
		      code: {
		        	 remote: {
		        		    url: "validate",     //后台处理程序
		        		    type: "post",               //数据发送方式
		        		    dataType: "json",           //接受数据格式   
		        		    data: {                     //要传递的数据
		        		    	code: function() {
		        		            return $("#acode").val();	        		           
		        		       }
		        		  }	    
		        	}
		      },
	        },
	        messages: {
	          name: {
		        	 required:"请输入商品名称",
		        	 remote:"该商品已存在"
		      },
		      exp_name: {
		        	 required:"请输入商品扩充名称",
		      	 	 remote:"该名称已存在"
		      },
		      content: {
		        	 required:"请输入描述信息",		        	
		      },
		      code: {
		        	 required:"请输入商品编码",
		        	 remote:"该编码已存在"
		      },
		      brandId: {
		        	 required:"请输入商品品牌",		        	
		      },
		      typeName: {
		        	 required:"请选择商品类型",		        	
		      },
		      store: {
		        	 required:"请输入所属门店",		        	 
		      }
	        },
	        submitHandler: function(form) {
	           if($("[name=idstemp]:checked").val()==null ||$("[name=idstemp]:checked").val()=="" ){
	        	   alert("属性必选");
	        	   return;
	           };
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
	        		   $("#checkbok").html("");
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