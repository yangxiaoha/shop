<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.divb0{
		margin-bottom:0px;
	}
</style>

<div class="modal fade" id="detailModal">
	<div class="modal-dialog" style="width:800px;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">
					修改详细信息 <span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="update" id="update" method="post">
					<fieldset>
						<div class="col-lg-12">
							<input type="hidden" id="did" name="id" >
							<script id="editor" type="text/plain" style="width:100%;height:500px;"></script>
							
						</div>
					</fieldset>
				</form>
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" id="detailsubmit" type="button">保存</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
<script>
	var ue = UE.getEditor('editor');
	ue.addListener('afterExecCommand',function(t, e, arg){
		afterUploadImage(e);
	});
	function afterUploadImage() {
		if(arguments[0]=="inserthtml" || arguments[0]=="insertimage"){
			ue.execCommand( 'insertparagraph' );
		}
	}
	$(document).ready(function() {
		$("#detailsubmit").click(function(){
			var str = ue.getContent();
			var newstr = str.split("<p><br/></p>")
			var uecontent = newstr.join("");
			$.ajax({
				url:"updateContent",
				async:false,
				dataType:"json",
				type:"post",
				data:{id:$("#did").val(),content:uecontent},
				success:function(data){
					alert(data.msg);
					tableI.table().draw();
				}
			})
		//	alert(ue.getContent());
		});
	});

</script>