<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<title>单品商城平台</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link
		href="<%=basePath%>assets/management/stylesheets/bootstrap.min.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/font-awesome.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/se7en-font.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/isotope.css"
		media="all" rel="stylesheet" type="text/css" />
	<link
		href="<%=basePath%>assets/management/stylesheets/jquery.fancybox.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/fullcalendar.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/wizard.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/select2.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/morris.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/datatables.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/datepicker.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/timepicker.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/colorpicker.css"
		media="all" rel="stylesheet" type="text/css" />
	<link
		href="<%=basePath%>assets/management/stylesheets/bootstrap-switch.css"
		media="all" rel="stylesheet" type="text/css" />
	<link
		href="<%=basePath%>assets/management/stylesheets/daterange-picker.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/typeahead.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/summernote.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/pygments.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/style.css"
		media="all" rel="stylesheet" type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/color/green.css"
		media="all" rel="alternate stylesheet" title="green-theme"
		type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/color/orange.css"
		media="all" rel="alternate stylesheet" title="orange-theme"
		type="text/css" />
	<link
		href="<%=basePath%>assets/management/stylesheets/color/magenta.css"
		media="all" rel="alternate stylesheet" title="magenta-theme"
		type="text/css" />
	<link href="<%=basePath%>assets/management/stylesheets/color/gray.css"
		media="all" rel="alternate stylesheet" title="gray-theme"
		type="text/css" />
	<script src="<%=basePath%>assets/management/javascripts/jquery.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/jquery-ui.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/bootstrap.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/raphael.min.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/selectivizr-min.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.mousewheel.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.vmap.min.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.vmap.sampledata.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.vmap.world.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.bootstrap.wizard.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.dataTables.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.easy-pie-chart.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/excanvas.min.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.isotope.min.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/isotope_extras.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/modernizr.custom.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.fancybox.pack.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/select2.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/styleswitcher.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/wysiwyg.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/summernote.min.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.inputmask.min.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.validate.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/bootstrap-fileupload.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/bootstrap-datepicker.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/bootstrap-timepicker.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/bootstrap-colorpicker.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/bootstrap-switch.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/typeahead.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/daterange-picker.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/date.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/morris.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/skycons.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/fitvids.js"
		type="text/javascript"></script>
	<script
		src="<%=basePath%>assets/management/javascripts/jquery.sparkline.min.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/datatablejs/base.js"
		type="text/javascript"></script>
	
	<script src="<%=basePath%>assets/management/datatablejs/ajaxSubmit.js"
		type="text/javascript"></script>
	
	<script src="<%=basePath%>assets/management/javascripts/respond.js"
		type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/md5.js"
		type="text/javascript"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<decorator:head />
</head>
<body>
	<div class="modal-shiftfix">
		<!-- Navigation -->
		<div class="navbar navbar-fixed-top scroll-hide">
			<div class="container-fluid top-bar">
				<div class="pull-right">
					<ul class="nav navbar-nav pull-right">
						<li class="dropdown notifications hidden-xs"><a
							class="dropdown-toggle" data-toggle="dropdown" href="#"><span
								aria-hidden="true" class="se7en-flag"></span>
								<div class="sr-only">Notifications</div>
								<p class="counter">4</p> </a>
							<ul class="dropdown-menu">
								<li><a href="#">
										<div class="notifications label label-info">New</div>
										<p>New user added: Jane Smith</p>
								</a></li>
								<li><a href="#">
										<div class="notifications label label-info">New</div>
										<p>Sales targets available</p>
								</a></li>
								<li><a href="#">
										<div class="notifications label label-info">New</div>
										<p>New performance metric added</p>
								</a></li>
								<li><a href="#">
										<div class="notifications label label-info">New</div>
										<p>New growth data available</p>
								</a></li>
							</ul></li>
						<li class="dropdown messages hidden-xs"><a
							class="dropdown-toggle" data-toggle="dropdown" href="#"><span
								aria-hidden="true" class="se7en-envelope"></span>
								<div class="sr-only">Messages</div>
								<p class="counter">3</p> </a>
							<ul class="dropdown-menu messages">
								<li><a href="#"> <img width="34" height="34"
										src="../../assets/management/images/avatar-male2.png" />Could
										we meet today? I wanted...
								</a></li>
								<li><a href="#"> <img width="34" height="34"
										src="../../assets/management/images/avatar-female.png" />Important
										data needs your analysis...
								</a></li>
								<li><a href="#"> <img width="34" height="34"
										src="../../assets/management/images/avatar-male2.png" />Buy
										Se7en today, it's a great theme...
								</a></li>
							</ul></li>
						<li class="dropdown settings hidden-xs"><a
							class="dropdown-toggle" data-toggle="dropdown" href="#"><span
								aria-hidden="true" class="se7en-gear"></span>
								<div class="sr-only">Settings</div> </a>
							<ul class="dropdown-menu">
								<li><a class="settings-link blue"
									href="javascript:chooseStyle('none', 30)"><span></span>Blue</a>
								</li>
								<li><a class="settings-link green"
									href="javascript:chooseStyle('green-theme', 30)"><span></span>Green</a>
								</li>
								<li><a class="settings-link orange"
									href="javascript:chooseStyle('orange-theme', 30)"><span></span>Orange</a>
								</li>
								<li><a class="settings-link magenta"
									href="javascript:chooseStyle('magenta-theme', 30)"><span></span>Magenta</a>
								</li>
								<li><a class="settings-link gray"
									href="javascript:chooseStyle('gray-theme', 30)"><span></span>Gray</a>
								</li>
							</ul></li>
						<li class="dropdown user hidden-xs"><a data-toggle="dropdown"
							class="dropdown-toggle" href="#"> <img width="34" height="34"
								src="../../assets/management/images/avatar-male.jpg" />用户信息
								<b class="caret"></b></a>
							<ul class="dropdown-menu">
								<li><a data-toggle="modal" data-target="#myModal"> <i
										class="icon-user"></i>修改密码
								</a></li>
								<li><a href="#"> <i class="icon-gear"></i>账号信息设置
								</a></li>
								<li><a href="../exit"> <i class="icon-signout"></i>退出
								</a></li>
							</ul></li>
					</ul>
				</div>
				<button class="navbar-toggle">
					<span class="icon-bar"></span><span class="icon-bar"></span><span
						class="icon-bar"></span>
				</button>
				<a class="logo" href="index-2.html">单品商城平台</a>
			</div>
			<div class="container-fluid main-nav clearfix">
				<div class="nav-collapse">
					<ul class="nav">
						<li><a class="current" href="../dashborad/index"><span
								aria-hidden="true" class="se7en-home"></span>首页</a></li>
						<li class="dropdown"><a data-toggle="dropdown" href="#">
								<span aria-hidden="true" class="se7en-star"></span>会员管理<b
								class="caret"></b>
						</a>
							<ul class="dropdown-menu">
								<li><a href="../user/index">会员信息</a></li>
								<li><a href="../supplier/index">会员下线查询</a></li>
							</ul></li>
						<li class="dropdown"><a data-toggle="dropdown" href="#">
								<span aria-hidden="true" class="se7en-forms"></span>商品管理<b
								class="caret"></b>
						</a>
							<ul class="dropdown-menu">
								<li><a href="../goodstype/index">商品类型管理</a></li>
								<li><a href="../goods/index">商品管理</a></li>
								<li><a href="../supplier/index">供应商管理</a></li>
								<li><a href="../brand/index">品牌管理</a></li>
								<li><a href="../sku/index">库存管理</a></li>
							</ul></li>
						<li><a class="current" href="../dashborad/index"><span
								aria-hidden="true" class="se7en-home"></span>结算管理</a></li>
						<li class="dropdown"><a data-toggle="dropdown" href="#">
								<span aria-hidden="true" class="se7en-pages"></span>系统管理<b
								class="caret"></b>
						</a>
							<ul class="dropdown-menu">
								<li><a href="../testbuy/index">系统参数配置</a></li>
								<li><a href="../system/index">公告发布</a></li>
								<li><a href="../couponuse/index">公众号菜单修改</a></li>
								<li><a href="../distribution/index">自定义回复</a></li>
								<li><a href="../banner/index">首页banner</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- End Navigation -->
		<decorator:body />
	</div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-body">
					<div class="alert alert-danger" style="display: none;"></div>
					<form id="login_form2" action="" method="post">
						<div class="form-group">
							<input class="form-control" id="username" placeholder="用户名"
								name="username" type="text">
						</div>
						<div class="form-group">
							<input class="form-control" id="password" placeholder="密码"
								name="password" type="password">
						</div>
						<div class="form-group">
							<input class="form-control" id="newPassword"
								placeholder="请输入新的密码" name="newPassword" type="password">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="submit()">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<script>
		function submit() {
			var username = $("#username").val();
			var password = $("#password").val();
			var newPassword = $("#newPassword").val();
			var hash = hex_md5(password); //hash为加密后的值
			var hash2 = hex_md5(newPassword);

			if (username.length == 0 || password.length == 0
					|| newPassword.length == 0) {
				$(".alert-danger").css("display", "block");
				$(".alert-danger").html("请输入用户名信息");
			} else {
				$.ajax({
					type : 'POST',
					url : '<%=basePath%>management/modify',
					data : {
						username : username,
						password : hash,
						newPassword : hash2
					},
					dataType : 'json',
					success : function(data) {
						if (data == 1) {
							$('#myModal').modal('hide');
							$("#username").val('');
							$("#password").val('');
							$("#newPassword").val('');
							$(".alert-danger").css("display", "none");
						} else {
							$("#username").val('');
							$("#password").val('');
							$("#newPassword").val('');
							$(".alert-danger").css("display", "block");
							$(".alert-danger").html("用户名或密码错误");
						}
					}
				});
			}
		}
	</script>
</body>
</html>