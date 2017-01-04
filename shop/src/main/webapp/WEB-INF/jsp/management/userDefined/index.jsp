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
	<title>自定义菜单</title>
</head>
<body>
	<div class="container-fluid main-content">
		<!-- DataTables Example -->
		<div class="row">
			<div class="col-lg-12">
				<div class="widget-container fluid-height clearfix">
					<div class="heading">
						<i class="icon-table"></i>自定义菜单
					</div>
					<div class="widget-content padded clearfix">
					 	<div style="height: 500px;width: 300px;border: 1px solid;overflow: hidden;position:relative;">
					 		<div style="padding:8px">
					 			<button onclick="deleteobj()" class="btn btn-danger">删除按钮</button>
					 			<button id="release" class="btn btn-info" style="float:right;margin:0px">发布菜单</button>
					 			<div>菜单名称<input id="name" class="form-control" type="text"></div>
					 			<div style="margin-top:5px;">菜单url<input id="url" class="form-control" type="text"></div>
					 		</div>
					 		<div style="position:absolute;bottom:0px">
					 			<div style="width:54px;float:left">
					 				<button onclick="addmenu()" class="btn btn-success" style="margin:0px;border-radius: 0px">添加</button>
					 			</div>
					 			<div style="width:246px;margin-left:54px;" id = "menu">
					 							 				
					 			</div>
					 		</div>
					 	</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	<script type="text/javascript">		
		var button = new Array();
		var chosenbtn = new Object;
		$(document).ready(function(){
			$.ajax({
				url:"suserDefined",
				async:false,
				dataType:"json",
				type:"post",
				success:function(data){		
					button = (JSON.parse(data)).button;
					showmenu();
				}
			});
		});
		function addmenu(){
			if(button.length == 3){
				alert("主菜单最多只能3个！");
				return;
			}
			var buttonobj = new Object;
			buttonobj.type = "view";
			buttonobj.url = "http://www.baidu.com";
			buttonobj.name = "菜单" + (button.length + 1);
			button[button.length] = buttonobj;
			showmenu();
		}
		
		function addsubbutton(i){
			var buttonobj = button[i];
			if(buttonobj.sub_button == null || buttonobj.sub_button.length == 0){
				buttonobjnew = new Object;
				buttonobjnew.sub_button = new Array();
				buttonobjnew.name = buttonobj.name;
				buttonobj = buttonobjnew;
			}
			if(buttonobj.sub_button.length == 5){
				alert("子菜单不能超过5个！");
				return;
			}
			var sub_buttonobj = new Object;
			sub_buttonobj.type = "view";
			sub_buttonobj.name = "子菜单" + (buttonobj.sub_button.length + 1);
			sub_buttonobj.url = "http://www.baidu.com";
			buttonobj.sub_button[buttonobj.sub_button.length] = sub_buttonobj;
			button[i] = buttonobj;
			showmenu();
		}
		
		function showmenu(){
			var menuhtml = "";
			for(var i = 0;i < button.length;i++){
				var buttonobj = button[i];
				var menuhtml = menuhtml + 
				"<div style=\"width:"+246/button.length+"px;position: absolute;margin-left:"+(246/button.length*i)+"px;\">"+
					"<button onclick=\"btnclick(this,"+i+")\" class=\"btn btn-default\" style=\"border-left: 1px solid;margin:0px;border-radius: 0px;width:100%\">"+buttonobj.name+"</button>"+
					"<button onclick=\"addsubbutton("+i+")\" class=\"btn btn-default\" style=\"border-left: 1px solid;margin:0px;border-radius: 0px;width: 100%;position: absolute;bottom: 35px;left:0px;\">添加</button>";
				if(buttonobj.sub_button != null){
					for(var j = 0;j < buttonobj.sub_button.length;j++){
						menuhtml = menuhtml + "<button onclick=\"subclick(this,"+i+","+j+")\" class=\"btn btn-default\" style=\"border-left: 1px solid;margin:0px;border-radius: 0px;width: 100%;position: absolute;bottom:"+35*(j+2)+"px;left:0px\">"+buttonobj.sub_button[j].name+"</button>";
					}
				}				
				var menuhtml = menuhtml + "</div>";
			}
			$("#menu").html(menuhtml);
		}
		
		function btnclick(obj,i){
			$(".btn").removeClass("btnactivi");
			$(obj).addClass("btnactivi");
			var btnobj = button[i];
			$("#name").val(btnobj.name);
			$("#url").val(btnobj.url);
			chosenbtn.type="par";
			chosenbtn.i = i;
			chosenbtn.j = 0;
		}
		
		function subclick(obj,i,j){
			$("a").removeClass("subactivi");
			$(obj).addClass("subactivi");
			var subobj = button[i].sub_button[j];
			$("#name").val(subobj.name);
			$("#url").val(subobj.url);
			chosenbtn.type="sub";
			chosenbtn.i = i;
			chosenbtn.j = j;
		}
		
		function deleteobj(){
			if(chosenbtn.type == "par"){
				button.splice(chosenbtn.i,1);
			}
			if(chosenbtn.type == "sub"){
				var subbutton = button[chosenbtn.i].sub_button;
				subbutton.splice(chosenbtn.j,1);
				button[chosenbtn.i].sub_button = subbutton;
				if(button[chosenbtn.i].sub_button.length == 0){
					var buttonobj = new Object;
					 buttonobj.type = "view";
					 buttonobj.url = "http://www.baidu.com";
					 buttonobj.name = button[chosenbtn.i].name;
					 button[chosenbtn.i] = buttonobj;
				}				
			}
			showmenu();
		}
		
		$("#url").blur(function(){
			 changeval("url",$(this).val());
			 showmenu();
		 });
		
		$("#name").blur(function(){
			 changeval("name",$(this).val());
			 showmenu();
		 });
		
		$("#release").click(function(){
			btn = new Object();
			btn.button = button;
			$.ajax({
				url:"updateDefined",
				async:false,
				dataType:"json",
				type:"post",
				data:{sysvalue:JSON.stringify(btn)},
				success:function(data){
					alert(data.msg);
				}
			})
		});
		
		function changeval(type,val){
			 if(chosenbtn.type == "par"){
				 if(type == "url"){
					 button[chosenbtn.i].url = val;
				 }
				 if(type == "name"){
					 button[chosenbtn.i].name = val;
				 }
			 }
			 if(chosenbtn.type == "sub"){
				 var subbutton = button[chosenbtn.i].sub_button[chosenbtn.j];
				 if(type == "url"){
					 subbutton.url = val;
				 }
				 if(type == "name"){
					 subbutton.name = val;
				 }
				 button[chosenbtn.i].sub_button[chosenbtn.j] = subbutton;
			 }
		 }
	</script>
</body>
</html>