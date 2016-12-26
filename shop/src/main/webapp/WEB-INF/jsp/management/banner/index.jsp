<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link href="<%=basePath%>assets/management/stylesheets/isotope.css">
	<script src="<%=basePath%>assets/management/javascripts/jquery.isotope.min.js" type="text/javascript"></script>
	<script src="<%=basePath%>assets/management/javascripts/isotope_extras.js" type="text/javascript"></script>
	<title>首页管理</title>	
</head>
<body>
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
	#systems {
			color: #007aff;
		}
</style>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<input type="hidden" id="basepath" value="<%=basePath%>">
			<div class="col-lg-12">
				<div class="widget-container fluid-height clearfix">
					<div class="heading">
						<i class="icon-table"></i>首页管理 <a
							class="btn btn-sm btn-primary-outline pull-right"
							data-toggle="modal" href="#addModal" id="add-row"><i
							class="icon-plus"></i>添加图片</a>
					</div>
					<div class="widget-content padded clearfix">
						<div class="col-lg-12">
							<div class="row">
								<div class="col-lg-12">
									<div class="widget-container fluid-height">
										<div class="heading">
											<i class="icon-th-large"></i>图片总览
										</div>
										<div class="widget-content padded">
											<div class="gallery-container">
												<c:forEach items="${bannerMsg}" var="bannerList">
													<a class="gallery-item fancybox" href="javascript:void(0)" rel="gallery1"><img
														src="<%=basePath%>${bannerList.image}">
														<div class="actions">
															<i class="icon-trash del" data-id = "${bannerList.id}"></i>
															<i class="icon-pencil update" data-id= "${bannerList.id}" 
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