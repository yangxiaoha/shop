<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.divb0{
		margin-bottom:0px;
	}
</style>
<div class="modal fade" id="updateModal">
	<div class="modal-dialog" style="width:800px;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">
					修改商品 <span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="update" id="update" method="post">
					<fieldset>
						<div class="col-lg-12">
							<input type="hidden" id="uid" name="id" >
							<div class="col-lg-3">
								<table border=0 height=200px align=left>
									<tr>
										<td width=100px align=left valign=top
											style="BORDER-RIGHT: #999999 1px dashed">
											<ul id="etree" class="ztree"
												style="width: 100px; overflow: auto;"></ul>
										</td>
									</tr>
								</table>
							</div>
							<div class="col-lg-6">
								<div class="row">
									<div class="row">
										<div class="col-md-12">
											<label for="name">商品品牌</label> <select
												class="reg-sel form-control" id="ubrandId" name="brandId">
												<c:forEach items="${brandMsg}" var="brandList">
													<option value="${brandList.id}">${brandList.name}</option>
												</c:forEach>
											</select>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group divb0"
												style="margin-bottom: 0px !important;">
												<label for="name">商品名称</label><input class="form-control"
													placeholder="请输入商品名称" id="uname" name="name" type="text">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group divb0">
												<label for="exp_name">商品扩充名称</label><input
													class="form-control" placeholder="请输入商品扩充名称" id="uexp_name"
													name="exp_name" type="text">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group divb0">
												<label for="quantity">商品数量</label><input
													class="form-control" placeholder="请输入商品数量" id="uquantity"
													name="quantity" type="text">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group divb0">
												<label for="content">描述信息</label><input class="form-control"
													placeholder="请输入描述信息" id="ucontent" name="content"
													type="text">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group divb0">
												<label for="code">商品编码</label><input class="form-control"
													placeholder="请输入商品编码" id="ucode" name="code" type="text">
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group divb0">
												<label for="store">所属门店</label><input class="form-control"
													placeholder="请输入所属门店" id="ustore" name="store" type="text">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group divb0">
												<label for="typeId">商品类型</label> <input class="form-control"
													placeholder="请输入类型" readonly="readonly" id="utypename"
													name="typename" type="text"> <input type="hidden"
													placeholder="" id="utypeId" name="typeId" type="text">	
													<input type="hidden"
													placeholder="" id="uids" name="ids" type="text">												
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-3" id="ucheckbok">
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
	var zTreeUpdate;
	var domeIframeUpdate;
	
	var settingUpdate = {
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
				onClick: zTreeOnClickUpdate
			}
	};
	function zTreeOnClickUpdate(event, treeId, treeNode) {		
		console.log(treeNode);		
		$("#utypeId").val(treeNode.id);
		$("#utypename").val(treeNode.name);
		$.ajax({
			url:"getPro",
			type:"post",
			data:{typeId: treeNode.id},
			dataType:"json",
			async:true,
			success:function(res){
				var checkboxhtml = "";				
				//	alert(res.length);
				for (var i=0;i<res.length;i++){
					var restemp = (","+uids.value+",").indexOf(","+res[i].id+",");
					if(restemp != -1){
						checkboxhtml = checkboxhtml + "<label class=\"checkbox\"><input name=\"idstemp\" value="+res[i].id+" type=\"checkbox\" checked=\"checked\"><span>"+res[i].name+"</span></label>"
					}else{
						checkboxhtml = checkboxhtml + "<label class=\"checkbox\"><input name=\"idstemp\" value="+res[i].id+" type=\"checkbox\"><span>"+res[i].name+"</span></label>"
						
					}
				}
				$("#ucheckbok").html(checkboxhtml);
			},
			error:function(res){
				
			}
		});
	   //alert(treeNode.id + ", " + treeNode.name);
	};
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}
	$(document).ready(function() {
		var t = $("#etree");
		t = $.fn.zTree.init(t, settingUpdate);
		domeIframeUpdate = $("#testIframe");
		domeIframeUpdate.bind("load", loadReady);
		var zTreeUpdate = $.fn.zTree.getZTreeObj("etree");
		zTreeUpdate.selectNode(zTreeUpdate.getNodeByParam("id", 101));

	});
	function loadReady() {
		var bodyH = domeIframeUpdate.contents().find("body").get(
				0).scrollHeight, htmlH = domeIframeUpdate
				.contents().find("html").get(0).scrollHeight, maxH = Math
				.max(bodyH, htmlH), minH = Math.min(bodyH,
				htmlH), h = domeIframeUpdate.height() >= maxH ? minH
				: maxH;
		if (h < 530)
			h = 530;
		domeIframeUpdate.height(h);
	}
	$(document).ready(function(){
		$('.datepicker').datepicker();
		$("#updatesubmit").click(function(){
		$("#update").submit();
		});
 	   $("#update").validate({
 	       rules: {
 	    	  typeId:{
	        		required:true,
	        	},
	        	brandId:{
	        		required:true,
	        	},
	        	quantity:{
	        		required:true,	        		
	        	},
 	         name: {
 		       	 required:true,
  		      	 remote: {
	        		    url: "validate",     //后台处理程序
 		       		    type: "post",               //数据发送方式
        			    dataType: "json",           //接受数据格式   
        			    data: {                     //要传递的数据
        			    	schoolName: function() {
        		    	        return $("#uname").val();	        		           
        			       },
        			       id:function(){
	    				    	return $("#uid").val();
	    				   }
        			  }	    
        		  }
       	   	},
         	exp_name: {
	        	 required:true,
	        	 remote: {
	        		    url: "validate",     //后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	schoolName: function() {
	        		            return $("#uexp_name").val();	        		           
	        		       },
        			       id:function(){
	    				    	return $("#uid").val();
	    				   }
	        		  }	    
	        	}
	      },
	      code: {
	        	 required:true,
	        	 remote: {
	        		    url: "validate",     //后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	schoolName: function() {
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
          name: {
	        	 required:"请输入商品名称",
	        	 remote:"该商品已存在"
	      },
	      exp_name: {
	        	 required:"请输入商品扩充名称",
	        	 remote:"该名称已存在"
	      },
	      quantity: {
	        	 required:"请输入商品数量",		        	 
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
	      store: {
	        	 required:"请输入所属门店",		        	 
	      }
        },
        submitHandler: function(form) {   
           $(this).attr("disabled","disabled"); 
		   $("#loading").html("<i class=\"icon-spinner icon-spin\"></i>");
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
        		   reset(form);
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
        }  
      });
});
</script>