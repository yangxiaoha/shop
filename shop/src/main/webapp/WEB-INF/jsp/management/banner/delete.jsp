<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="modal fade" id="delModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">删除图片
				<span id="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<span id="dcontext">确认删除当前选项？</span>
				<form id="dform" action="delete" method="post">
					<input type="hidden" name="ids" id="ids">
				</form>
			</div>
			<hr>
			<div class="modal-footer">
				<button class="btn btn-primary" id="deletesubmit" type="button">确定</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
<script>	
	$(document).ready(function(){
		$(".del").click(function(){
    		$("#ids").val($(this).data("id"));
    		$("#delModal").modal('show');
    	});
		$("#deletesubmit").click(function(){
			$(this).attr("disabled","disabled"); 
			if($("#ids").val() != null && $("#ids").val() != ""){
				$("#dform").ajaxSubmit({
	        	   success:function(data){
        			   $("#dcontext").html(data.msg);
	        		   setTimeout(function(){
	        			   $("#deletesubmit").removeAttr("disabled"); 
	        			   reset("#dform");
		        		   $("#delModal").modal('hide');
		        		   $("#dcontext").html("确认删除当前选项？");
	        		   },1000);
	        		   window.location.reload(); 
	        	   },
	        	   error:function(){
	        		   $("#dcontext").html("<span class=\"label label-danger\">网络故障，稍后重试</span>");
	        		   setTimeout(function(){
	        			   $("#deletesubmit").removeAttr("disabled"); 
	        			   reset("#dform");
		        		   tableI.table.draw();
		        		   $("#delModal").modal('hide');

	        		   },1000);
	        	   }
	           });     
			}
		});
	});
</script>