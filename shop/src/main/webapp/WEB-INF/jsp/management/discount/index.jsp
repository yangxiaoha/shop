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
	<script	src="<%=basePath%>assets/management/datatablejs/discount.js" type="text/javascript"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>会员优惠</title>
    <style type="text/css">
	   .dataTables_filter label{
	   	display: none !important;
	   }
    </style>
</head>
<body class="gray-bg">	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12" >
                <div class="ibox float-e-margins">
                	<div class="col-md-12">
                    <div class="ibox-title">
                        <h5>会员优惠</h5>
                    </div>   
                    </div>                 
                    <div class="col-md-12">
						<div class="form-group">
							<label for="discount"></label><textarea class="form-control" rows="3"
								placeholder="请输入会员优惠" id="discount" name="discount" type="text"></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-primary" id="detailsubmit" type="button">保存</button>
						<button class="btn btn-default-outline" data-dismiss="modal"
							type="button">取消</button>
					</div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    $(document).ready(function() {
		$.ajax({
			url:"selDiscount",
			async:false,
			dataType:"json",
			type:"post",
			success:function(data){
				if(data == null){
					data = "";
				}
				$("#discount").val(data);
			}
		});
		$("#detailsubmit").click(function(){
			$.ajax({
				url:"update",
				async:false,
				dataType:"json",
				type:"post",
				data:{skey:"discount",sysvalue:$("#discount").val()},
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