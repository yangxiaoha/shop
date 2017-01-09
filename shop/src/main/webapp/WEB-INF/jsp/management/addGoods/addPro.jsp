<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.divb0{
		margin-bottom:0px;
	}
</style>
<div class="modal fade" id="addProModal">
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
				<form action="addPro" id="addPro" method="post">
					<fieldset>
						<div class="col-sm-12">						
							<div class="col-sm-5">
								<table border=0 height=200px align=left>
									<tr>
										<td width=150px align=left valign=top
											style="BORDER-RIGHT: #999999 1px dashed">
											<ul id="aprotree" class="ztree"
												style="width: 150px; overflow: auto;"></ul>
										</td>
									</tr>
								</table>
							</div>
							<div class="col-sm-7">
								<div class="row">
									<div class="row">
										<div class="col-sm-12">
											<div class="form-group divb0"
												style="margin-bottom: 0px !important;">
												<label for="name">商品属性(*)</label>
												<input class="form-control"
													placeholder="请输入商品属性名称" id="aproname" name="name" type="text">
												<input style = "opacity: 0; width: 0px"
													placeholder="" id="atypeId" name="typeId" type="text">												
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-sm-12">
											<div class="form-group divb0">
												<label for="typeId">商品类型(*)</label> 
												<input class="form-control"
													placeholder="" readonly="readonly" id="atypeName"
													name="typeName" type="text">
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
				<button class="btn btn-primary" id="proSubmit" type="button">保存</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
<script>
	var zTreeAdd;
	var domeIframeAdd;
	var pro;
	var addProValidate;
	var settingPro = {
		view: {
			selectedMulti: false
		},
		async:{
			enable: true,
			url:"getTypeTree",
			autoParam:["id"],
			otherParam:{"otherParam":"zTreeAsyncTest"},
			dataFilter: filter				
		},
		callback:{
			onClick: zTreeOnClickAddPro
		}
	};
	
	function zTreeOnClickAddPro(event, treeId, treeNode) {
		console.log(treeNode);
		$("#atypeId").val(treeNode.id);
		$("#atypeName").val(treeNode.name);
	};
	
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes;
	}

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
	
	$('#addProModal').on('shown.bs.modal',
	    function() {
			addProValidate.resetForm();
			$("#aproname").val("");
			$("#atypeId").val("");
			$("#atypeName").val("");
    })

	$(document).ready(function(){		
		pro = $("#aprotree");
		pro = $.fn.zTree.init(pro, settingPro);
		domeIframeAdd = $("#testIframe");
		domeIframeAdd.bind("load", loadReady);
		var pTree = $.fn.zTree.getZTreeObj("aprotree");
		pTree.selectNode(pTree.getNodeByParam("id", 101));	
		
		$("#proSubmit").click(function(){
			$("#addPro").submit();
		});
		
	    addProValidate = $("#addPro").validate({
	        rules: {
	            name: {
	        	    required:true,
	        	    remote: {
	        		    url: "validatePro",     	//后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	name: function() {
	        		            return $("#aproname").val();	        		           
	        		        },
	        		        typeId: function() {
	        		            return $("#atypeId").val();	        		           
	        		        }
	        		    }	    
	        	    }
	            },
	          	typeId: {
	        		 required:true,
		        	 remote: {
	        		     url: "validatePro",     	//后台处理程序
	        		     type: "post",               //数据发送方式
	        		     dataType: "json",           //接受数据格式   
	        		     data: {
	        		       	typeId: function() {
	        		            return $("#atypeId").val();	        		           
	        		       	},
	        		       	name: function() {
	        		            return $("#aproname").val();	        		           
	        		       	}
	        		  	}	    
		        	}
		        },
	       	},
	        messages: {
	          	name: {
		        	required:"请输入商品属性",
		        	remote:"该属性已存在"
		        },
		      	typeId: {
		        	required:"请输入商品类型",
		        	remote:"该属性已存在"
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
	        		   
	        		   $.ajax({
	       		   	    url: "getGoodsPro",
	       		   		type: "Post",
	       		   	    data: {
	       		   	    	typeId:type.getSelectedNodes()[0].id
	       		   	    },
	       		   	    dataType: "json",
	       		   	    success: function(data) {
	       	   	    		$(".proCheck .col-sm-10").html("");
	       	   	    		$.each(data.proMsg, function(i, proList) {   
	       	   	    			$(".proCheck").show();
	       	   	    			$(".proCheck .col-sm-10").append( 
	          	    					'<label class="checkbox-inline i-checks">'+
	          	    					'<input type="checkbox" value="'+proList.name+'" style="position: absolute; opacity: 0;">'+proList.name+   	   	    				
	          	    					'<input type="hidden" value="'+proList.id+'" />'+
	          	    					'</label>'
	       	    				);
	          		  			});
	       	   	    		$(".i-checks").iCheck({checkboxClass:"icheckbox_square-green",radioClass:"iradio_square-green",});
	       		   	    }
	       	        })
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