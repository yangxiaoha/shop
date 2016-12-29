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
    <link href="<%=basePath %>/assets/management/plugin/ztree/css/metroStyle/metroStyle.css" rel="stylesheet">
    <link href="<%=basePath %>/assets/management/plugin/select2/css/select2.css" rel="stylesheet">
</head>

<body class="gray-bg">
	
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
        	<div class="col-sm-3" style="padding-right:0px">
        		<div class="ibox-contentTable">	
					<ul id="treeDemo" class="ztree"></ul>
                </div>
        	</div>
            <div class="col-sm-9" style="">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>功能模块 <small>查找，新增，修改</small></h5>
                        <div class="ibox-tools">
                        	<a >
                                <i class="fa fa-times"></i>
                            </a>
                            <a a data-toggle="modal" href="#addModal" id="add-row">
                                <i class="fa fa-plus"></i>
                            </a>
                            
                            <a >
                                <i class="fa fa-trash"></i>
                            </a>
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            
                        </div>
                    </div>
                    <div class="ibox-content">
                      <div class="row">
                            <form role="form">
		                           <div class="col-sm-6">
	                                   <div class="form-group">
	                                       <label>菜单名称</label>
	                                       <input type="text" placeholder="请输入菜单名称" id="sname" class="form-control">
	                                   </div>
		                           </div>
		                           <div class="col-sm-6">
	                           			<div class="form-group">
	                                       <label>url</label>
	                                       <input type="text" placeholder="请输菜单url" id="surl" class="form-control">
	                                   </div>
		                           </div>
                            </form>
                        </div>
                    </div>
                    <div class="ibox-contentTable">
                    	<table class="table table-bordered table-striped table-hover" id="datatable" width="100%">
							<thead>
								<th></th>
								<th class="check-header hidden-xs">
									<label style="margin-right:0px" class="checkbox-inline i-checks"><input id="checkAll" name="checkAll" type="checkbox"></label>
								</th>
								<th width="20%">用户名</th>
								<th>注册时间</th>
								<th>财富</th>
								<th></th>
								<th></th>
								<th></th>
								<th></th>
								<th style="color: #007aff;">操作</th>
							</thead>
							<tbody>
							</tbody>
						</table>

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
    <script src="<%=basePath %>/assets/management/datatablejs/func.js"></script>
    <script src="<%=basePath %>/assets/management/datatablejs/ajaxSubmit.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/iCheck/icheck.min.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/sweetalert/sweetalert.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugins/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugins/ueditor/ueditor.all.js"> </script>
    <script src="<%=basePath %>/assets/management/js/plugins/datapicker/bootstrap-datepicker.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="<%=basePath %>/assets/management/js/plugins/validate/validateCss.js"></script>
    <script type="text/javascript" src="<%=basePath %>/assets/management/plugins/ztree/js/jquery.ztree.core.js"></script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugins/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath %>/assets/management/plugins/select2/js/select2.js"></script>
    <script>
    	
    	var tree;
    	
	    function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
	    	var obj = eval(msg);
	        if(obj.length == 0){
	        	treeNode.isParent = false;
		        tree.updateNode(treeNode);
	        }
	    };
	    
	    function zTreeOnClick(event, treeId, treeNode) {
	    	tableI.table().columns(6).search(treeNode.id).draw();
	    };
	    
    	var setting = {
   			async: {
   				enable: true,
   				url:"getTree",
   				autoParam:["id=pid", "name=n", "level=lv"],
   				otherParam:{"otherParam":"zTreeAsyncTest"},
   				type: "post"
   			},
   			callback: {
   				onAsyncSuccess: zTreeOnAsyncSuccess,
   				onClick: zTreeOnClick
   			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};
  		$(document).ready(function(){
  			tree = $.fn.zTree.init($("#tree"), setting);
  		});
    </script>

</body>
</html>