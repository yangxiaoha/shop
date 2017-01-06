<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade" id="stickModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">置顶该商品
				<span id="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<span id="dcontext">确认置顶当前选项？</span>
				<form id="tform" action="stick" method="post">
					<input type="hidden" name="id" id="tid">
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" id="sticksubmit" type="button">确定</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
<script>
	
	$(document).ready(function(){
		$("#sticksubmit").click(function(){
			$(this).attr("disabled","disabled"); 
			if($("#tid").val() != null && $("#tid").val() != ""){
				$("#tform").ajaxSubmit({
	        	   success:function(data){
        			   $("#tcontext").html(data.msg);
	        		   setTimeout(function(){
	        			   $("#sticksubmit").removeAttr("disabled"); 
	        			   reset("#tform");
		        		   $("#stickModal").modal('hide');
		        		   $("#tcontext").html("确认置顶当前选项？");
	        		   },1000);
	        		   tableI.table().draw();
	        	   },
	        	   error:function(){
	        		   $("#dcontext").html("<span class=\"label label-danger\">网络故障，稍后重试</span>");
	        		   setTimeout(function(){
	        			   $("#sticksubmit").removeAttr("disabled"); 
	        			   reset("#dform");
		        		   tableI.table.draw();
		        		   $("#stickModal").modal('hide');

	        		   },1000);
	        	   }
	           });     
			}
		});
	});
</script>