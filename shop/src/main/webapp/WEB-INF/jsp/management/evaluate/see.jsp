<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<div class="modal fade" id="seeModal" >
	<div class="modal-dialog" style="width:650px;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 style="color : black" class="modal-title">订单详情
				<span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body" id="pr">
				<form action="see" id="see" method="post" class="form-horizontal">
					<fieldset>
						<div class="row" >
						<input type="hidden" id="sid" name="id">															
							<div class="col-md-12">
								<div class="form-group">										
									<span style="font-size: 1em; color: black"><ul><li>收货人信息</li></ul></span>
								</div>
							</div>
							<div class="row">
							<div class="col-md-6" style="float:left">
								<div class="form-group"  style="margin-left:40px;">
									<span style="font-size: 1em; color: black">收货人姓名：</span> <span
										style="font-size: 1em; color: black" id="sname"></span>
								</div>
							</div>
							<div class="col-md-6" style="float:right">
								<div class="form-group" style="margin-left:-20px">
									<span style="font-size: 1em; color: black">收货人电话：</span> <span
										style="font-size: 1em; color: black" id="sphone"></span>
								</div>
							</div>
							</div>
							<div class="col-md-12">
								<div class="form-group"  style="margin-left:25px;width: 90%;">
									<span style="font-size: 1em; color: black">收货人地址：</span> <span
										style="font-size: 1em; color: black" id="saddress"></span>
								</div>
							</div>
							<hr>														
							<div class="col-md-12">
								<div class="form-group">										
									<span style="font-size: 1em; color: black"><ul><li>订单详情</li></ul></span>
								</div>
							</div>	
							<div class="col-md-12">
							<div class="row">							
							<div class="col-md-6" style="float:left">
								<div class="form-group"  style="margin-left:25px;">
									<span style="font-size: 1em; color: black">下单时间：</span> <span
										style="font-size: 1em; color: black;margin-left:0px" id="sordertime"></span>
								</div>
							</div>
							<div class="col-md-6" style="float:right">
								<div class="form-group" style="margin-left:-20px;">
									<span style="font-size: 1em; color: black">订单状态：</span> <span
										style="font-size: 1em; color: black" id="sstate"></span>
								</div>
							</div>
							</div>
							</div>
							<div class="col-md-12">
							<div class="row">
								<div class="form-group"  style="margin-left:7%;">
									<span style="font-size: 1em; color: black">订单编号：</span> <span
										style="font-size: 1em; color: black;margin-left:0px" id="sordernum"></span>
								</div>
							</div>
							</div>
							<div class="col-md-12">
							<div class="row">
								<div class="col-md-6">
								<div class="form-group" style="margin-left:25px;">
								<span style="font-size: 1em; color: black">物流商家：</span>
								<span style="font-size: 1em; color: black;margin-left:0px" id="ulogistics"></span>										
								</div>
								</div>
								<div class="col-md-6" >
								<div class="form-group" style="margin-left:-20px">								
								<span style="font-size: 1em; color: black">物流编号：</span>
								<span style="font-size: 1em; color: black;margin-left:0px" id="ulogisticsnum"></span>									
								</div>
							</div>
							</div>
							</div>
							<hr>														
							<div class="row" id="checkbok"></div>
							<div class="row">
								<div class="form-group" style="margin-left:40px;width: 90%">
									<p style="font-size: 1em; color: black">备注：</p>
									<span style="font-size: 1em; color: black" id="smemo"></span>
								</div>
							</div>							
						</div>
					</fieldset>
				</form>
			</div>			
			<div class="modal-footer">			
				<button class="btn btn-primary" id="seesubmit" type="button">确定</button>
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>