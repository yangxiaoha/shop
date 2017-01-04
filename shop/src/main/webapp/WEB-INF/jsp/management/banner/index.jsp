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
    <title>${webapp}</title>
    <meta name="keywords" content="${webapp}">
    <meta name="description" content="${webapp}">
    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="<%=basePath %>/assets/management/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <!-- Data Tables -->
    <link href="<%=basePath %>/assets/management/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/animate.min.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/style.min.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/css/plugins/datapicker/datepicker3.css" rel="stylesheet">
</head>

<body class="gray-bg">
<style type="text/css">
	#add .pic {
	    width: 240px;
	    height: 240px;
	    position: relative;
	    border: 1px solid #d2d2d2;
	    overflow: hidden;
	}
	#update .pic {
	    width: 240px;
	    height: 240px;
	    position: relative;
	    border: 1px solid #d2d2d2;
	    overflow: hidden;
	}
	
	.pic div {
	    width: 100%;
	    cursor: pointer;
	}
	.image_file {
	    width: 100%;
	    height: 240px;
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
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12" style="">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>首页滚动图管理<small>(新增,修改,删除)</small></h5>
                        <div class="ibox-tools">
                            <a data-toggle="modal" href="#addModal" id="add-row">
                                <i class="fa fa-plus"></i>
                            </a>
                        </div>
                    </div>
                    <hr>                    
                    <div class="widget-content padded clearfix">
						<div class="col-lg-12">
							<div class="row">
								<div class="col-lg-12">
									<div class="widget-container fluid-height">
										<div class="heading">
											<label>图片总览</label>
										</div>
										<hr>
										<div class="widget-content padded">
											<div class="gallery-container">
												<c:forEach items="${bannerMsg}" var="bannerList">
													<a class="gallery-item fancybox" href="javascript:void(0)" rel="gallery1"><img
														src="<%=basePath%>${bannerList.image}">
														<div class="actions">
															<i class="fa fa-trash del" data-id = "${bannerList.id}"></i>
															<i class="fa fa-pencil update" data-id= "${bannerList.id}" 
															data-url="${bannerList.url}" data-image="${bannerList.image}"></i>
														</div> </a>
												</c:forEach>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
                </div>
            </div>
        </div>
    </div>
    <script src="<%=basePath %>/assets/management/js/jquery.min.js?v=2.1.4"></script>
    <script src="<%=basePath %>/assets/management/js/bootstrap.min.js?v=3.3.6"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/jeditable/jquery.jeditable.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/dataTables/jquery.dataTables.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/dataTables/dataTables.bootstrap.js"></script>
    <script src="<%=basePath %>/assets/management/js/content.min.js?v=1.0.0"></script>
    <script src="<%=basePath %>/assets/management/datatablejs/base.js"></script>   
    <script src="<%=basePath %>/assets/management/datatablejs/ajaxSubmit.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/iCheck/icheck.min.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugin/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugin/ueditor/ueditor.all.js"> </script>
    <script src="<%=basePath %>/assets/management/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/validate/validateCss.js"></script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugin/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script src="<%=basePath%>assets/management/datatablejs/goods.js" type="text/javascript"></script>
	<script type="text/javascript" charset="utf-8" src="<%=basePath%>assets/management/plugin/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="<%=basePath%>assets/management/plugin/ueditor/ueditor.all.js"> </script>
	<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
	<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
	<script type="text/javascript" charset="utf-8" src="<%=basePath%>assets/management/plugin/ueditor/lang/zh-cn/zh-cn.js"></script>
    <jsp:include page="add.jsp"/>
	<jsp:include page="delete.jsp"/>
	<jsp:include page="update.jsp"/>
    <script type="text/javascript">
	    $(document).ready(function() {
			$container = $(".gallery-container");
			$container.isotope({});	
		});
    </script>
</body>
</html>