<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.divb0{
		margin-bottom:0px;
	}
</style>
<div class="modal fade" id="addModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">
					添加商品属性 <span id="loading" style=""></span>
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
							<div class="col-lg-9">
								<div class="row">
									<div class="row">
										<div class="col-md-12">
											<div class="form-group divb0"
												style="margin-bottom: 0px !important;">
												<label for="name">商品属性(*)</label><input class="form-control"
													placeholder="请输入商品属性名称" id="aname" name="name" type="text">
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group divb0">
												<label for="typeId">商品类型(*)</label> <input class="form-control"
													placeholder="" readonly="readonly" id="atypeName"
													name="typeName" type="text"> <input type="hidden"
													placeholder="" id="atypeId" name="typeId" type="text">
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
		$("#atypeId").val(treeNode.id);
		$("#atypeName").val(treeNode.name);
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
	          name: {
	        	 required:true,
	        	 remote: {
	        		    url: "validate",     //后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	schoolName: function() {
	        		            return $("#aname").val();	        		           
	        		       }
	        		  }	    
	        	  }
	          },
	        },
	        messages: {
	          name: {
		        	 required:"请输入商品名称",
		        	 remote:"该商品已存在"
		      }		     
	        },
	        submitHandler: function(form) {   
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