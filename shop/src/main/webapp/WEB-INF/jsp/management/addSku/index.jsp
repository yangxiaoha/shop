<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- Mirrored from www.zi-han.net/theme/hplus/table_data_tables.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>
    <script src="<%=basePath%>assets/management/js/uploadphoto1.js"
	type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/js/ajaxfileupload1.js"
	type="text/javascript"></script>
	<script type="text/javascript">
		var asgoodsId = ${goodsM.id};
	</script>
	<style type="text/css">	
	.mb10 {margin-bottom: 10px;}	
	label {
			margin-right: 10px;
		}
	span.help-block {
			color: red;
		}
	.pic div {
	    width: 80%;
	    cursor: pointer;
	}
	.image_file {
	    width: 80%;
	    height: 100%;
	    position: absolute;
	    top: 0;
	    left: 0;
	    cursor: pointer;
	    opacity: 0;
	    z-index: 9999;
	}
	#aurl,#uurl{
		    padding: 5px;
		    margin-right: 5px;
		    margin-bottom: 5px;
		    border-radius: 5px;
		    border: 1px solid #d2d2d2; 
		}
	p.error {
		margin: 10px 0;
		color: red;
	}
</style>		
</head>

<body class="gray-bg">	
    <div class="wrapper wrapper-content animated fadeInRight">
	    <form action="addSku" id="addSku" method="post">
	        <div class="row">
				<div class="col-sm-4 mb10">					
					<input id="asgoodsId" value = "${goodsM.id}" type ="hidden"></input>
	                <label>商品数量(*):</label>
	                <input type="text" placeholder="请输入商品数量" id="asnum" name="num" class="form-control">
				</div>				
				<div class="col-sm-4 mb10">
	                <label>商品价格(*):</label>
	                <input type="text" placeholder="请输入商品价格" id="asprice" name="price" class="form-control">
				</div>
	        	<div class="col-sm-4 mb10">
	                <label>特征量编码:</label>
	                <input type="text" placeholder="请输入特征量编码" id="ascode" name="code" class="form-control">
				</div>
	        </div>
	        
	        <hr>
			<c:forEach items="${goodsM.pros}" var="p" varStatus="status">	
				<c:if test="${status.index%3 == 0}">
					<div class="row">
				</c:if>
				<div class="col-sm-4">
					<div class="form-group">
						<label for="proId">${p.name }(*)</label>
						<input class="form-control asvalue" placeholder="请输入${p.name }"
							title="${p.name }不能为空" id="asc${status.index}" required="required"
							 name="value" type="text"> 
						<input class=asproId type="hidden" id="" name="proId" value="${p.id }"
							type="text">
					</div>
				</div>
				<c:set var="last" value="${status.last }"></c:set>				
				<c:set var="odd" value="${status.index%3 == 2}"></c:set>
				<c:if test="${(odd)||(last)}">
					</div>
				</c:if>
			</c:forEach>
	    	<hr>
			<label>请选择图片:</label>
	        <div class="row">
				<div class="col-sm-3">
					<div class="form-group">
						<div class="pic">
	                        <div class="pic" width="240" height="252">
	                            <img id="asimghead1" class="imghead" width="240" height="252" alt="image" width="100%" src="<%=basePath%>${goodsM.url1}">	                            
	                        	<input type="hidden" id="url1" value="${goodsM.url1}" type="text">
	                        </div>
	                    </div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="form-group">
						<div class="pic">
	                        <div class="pic" width="240" height="252">
	                            <img id="asimghead2" class="imghead" width="240" height="252" alt="image" width="100%" src="<%=basePath%>${goodsM.url2}">	 
	                            <input type="hidden" id="url2" value="${goodsM.url2}" type="text">                           
	                        </div>
	                    </div>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="form-group">
						<div class="pic">
	                        <div class="pic" width="240" height="252">
	                            <img id="asimghead3" class="imghead" width="240" height="252" alt="image" width="100%" src="<%=basePath%>${goodsM.url3}">	
	                            <input type="hidden" id="url3" value="${goodsM.url3}" type="text">                               
	                        </div>
	                    </div>
					</div>
				</div>				
				<div class="col-sm-3">
					<div class="form-group">
						<p class="error" style="display: none;"></p>
						<div class="pic">
							<div id="preview" class="preview">
								<img id="asimghead" class="imghead" width="240" height="252"
									src="<%=basePath%>/res/bj_img1.jpg" />
							</div>
							<input type="file" name="photourl" class="image_file"
								id="asaddphoto" onchange="previewImage(this,'asimghead')">
							<input type="hidden" id="" name="imageUrl" type="text">
						</div>
					</div>
				</div>
			</div>
			<hr>
			<div style="width: 50%; margin: 0 auto;">
	        	<div class="col-sm-4">
	        		<button type="button" class="btn btn-primary btn-block m-t" id="addsubmit">保存</button>
	        	</div>
	        	<div class="col-sm-4">
	        		<button type="button" class="btn btn-primary btn-block m-t" id="updateState">发布</button>
	        	</div>	        	
	        	<div class="col-sm-4">
	        		<a href="<%=basePath%>management/addGoods/index" class="btn btn-primary btn-block m-t">返回上一步</a>
	        	</div>
	       	</div>
       	</form>
    </div>    
    <script>
    
    var imgsize = "图片大小为400*420！";
    var imglong1 = 240;
	var imgwide1 = 252;
	var imglong = 400;
	var imgwide = 420;
	var imageFlag = true;
	var imgmol = "<%=basePath%>/res/bj_img1.jpg";
	var imgheads = "#asimghead";
	var skuValidate;
	var path;
	var imageUrl;
	$(document).ready(function(){		
		$("#asimghead1").click(function(){
			path = $("#asimghead1")[0].src; 
			imageUrl = $("#url1").val();
			$("#asimghead").attr('src',path); 
		});
		$("#asimghead2").click(function(){
			path = $("#asimghead2")[0].src; 
			imageUrl = $("#url2").val();
			$("#asimghead").attr('src',path); 
		});
		$("#asimghead3").click(function(){
			path = $("#asimghead3")[0].src; 
			imageUrl = $("#url3").val();
			$("#asimghead").attr('src',path); 
		});
		
		$("#updateState").click(function(){
			$(this).attr("disabled","disabled"); 
			$.ajax({
				url:"updateState",
				async:false,
				dataType:"json",
				type:"post",
				data:{state:1,goodsId:$("#asgoodsId").val()},
				success:function(data){
					alert(data.msg);
					window.location.reload();
				}
			});
		});
		
		$("#addsubmit").click(function(){
			$("#addSku").submit();
		});
		$("#addSku").validate({
	        rules: {
	        	price:{
	        		required:true,
	        		number:true,
	        	},
	        	num:{
	        		required:true,
	        		digits:true,
	        	},
	            code: {
	        	    remote: {
	        		    url: "validate",     //后台处理程序
	        		    type: "post",               //数据发送方式
	        		    dataType: "json",           //接受数据格式   
	        		    data: {                     //要传递的数据
	        		    	code: function() {
	        		            return $("#ascode").val();
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
		        	required:"请输入商品数量",
		        	digits:"请输入一个整数"
		      	},
		      	price: {
		        	required:"请输入商品价格",
		        	number:"请输入一个数字"
		      	}
	        },		   	
	        submitHandler: function(form) {   
	           	$(this).attr("disabled","disabled"); 
			   
			   	var svalue = new Array();
			   	var sproId = new Array();
			   	$(".asvalue").each(function(index,e){
				  	svalue[index]=$(e).val();
			   	});
			   	$(".asproId").each(function(index,e){
				   	sproId[index] = $(e).val();
			   	});
				$.ajaxFileUpload({
					data :{
						num:$("#asnum").val(),
						price:$("#asprice").val(),
						code:$("#ascode").val(),
						goodsId:"${goodsM.id}",
						value:svalue,	
						proId:sproId,
						imageUrl:imageUrl,
					},
					url: 'addSku',   
		            type: 'post',  
		            secureuri: false, //一般设置为false
		            fileElementId: 'asaddphoto', // 上传文件的id、name属性名  
		            dataType: 'json', //返回值类型，一般设置为json、application/json  
		            //elementIds: elementIds, //传递参数到服务器
					success:function(data){
	        			setTimeout(function(){
	        			   $("#addsubmit").removeAttr("disabled"); 
	        		    },1000);
	        			window.location.reload();
	        	    }, 
        	    	
	        	    error:function(e){
	         		    setTimeout(function(){
	         			    $("#addsubmit").removeAttr("disabled"); 
	         		    },1000);
	        	    }
				});				   
	        } 
	    });
	});	    
    </script>
</body>
</html>