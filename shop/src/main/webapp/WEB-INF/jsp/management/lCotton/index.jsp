<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- Mirrored from www.zi-han.net/theme/hplus/table_data_tables.html by HTTrack Website Copier/3.x [XR&CO'2014], Wed, 20 Jan 2016 14:20:01 GMT -->
<head>	
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>爱棉人</title>
</head>
<body class="gray-bg">	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>爱棉人</h5>
                    </div>                    
                    <div class="modal-body">
						<form action="update" id="update" method="post">
							<fieldset>
								<div class="col-lg-12">
									<script id="editor" type="text/plain" style="width:100%;height:100%;"></script>									
								</div>
							</fieldset>
						</form>
						<div class="modal-footer">
							<button class="btn btn-primary" id="detailsubmit" type="button">保存</button>
							<button class="btn btn-default-outline" data-dismiss="modal"
								type="button">取消</button>
						</div>
					</div>
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
		$.ajax({
			url:"selLCotton",
			async:false,
			dataType:"json",
			type:"post",
			success:function(data){
				if(data == null){
					data = "";
				}
				ue.addListener("ready",function(){					
					ue.setContent(data);
				});
			}
		});
		$("#detailsubmit").click(function(){
			var str = ue.getContent();
			var newstr = str.split("<p><br/></p>")
			var uecontent = newstr.join("");
			$.ajax({
				url:"update",
				async:false,
				dataType:"json",
				type:"post",
				data:{skey:"lCotton",sysvalue:uecontent},
				success:function(data){
					alert(data.msg);
				}
			})
		//	alert(ue.getContent());
		});
	});	
	</script>  
</body>
</html>