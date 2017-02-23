<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade" id="downModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">取消该商品置顶
				<span id="oloading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<span id="ocontext">确认取消该商品置顶？</span>
				<form id="oform" action="down" method="post">
					<input type="hidden" name="id" id="oid">
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" id="downsubmit" type="button">确定</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
<script>
	
	$(document).ready(function(){
		$("#downsubmit").click(function(){
			$(this).attr("disabled","disabled"); 
			if($("#oid").val() != null && $("#oid").val() != ""){
				$("#oform").ajaxSubmit({
	        	   success:function(data){
        			   $("#ocontext").html(data.msg);
	        		   setTimeout(function(){
	        			   $("#downsubmit").removeAttr("disabled"); 
	        			   reset("#oform");
		        		   $("#downModal").modal('hide');
		        		   $("#ocontext").html("确认取消该商品置顶？");
	        		   },1000);
	        		   tableI.table().draw();
	        	   },
	        	   error:function(){
	        		   $("#ocontext").html("<span class=\"label label-danger\">网络故障，稍后重试</span>");
	        		   setTimeout(function(){
	        			   $("#downsubmit").removeAttr("disabled"); 
	        			   reset("#oform");
		        		   tableI.table.draw();
		        		   $("#downModal").modal('hide');

	        		   },1000);
	        	   }
	           });     
			}
		});
	});
</script>