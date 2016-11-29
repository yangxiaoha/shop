<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="seeModal">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 style="color : black" class="modal-title">订单详情
				<span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="see" id="see" method="post">
					<fieldset>
						<div class="row">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">收货人姓名：</span> <span
											style="font-size: 1em; color: black" id="sname"></span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">收货人电话：</span> <span
											style="font-size: 1em; color: black" id="sphone"></span>
									</div>
								</div>
								<div class="col-md-12">
									<div class="form-group">
										<span style="font-size: 1em; color: black">收货人地址：</span> <span
											style="font-size: 1em; color: black" id="saddress"></span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">物流商家：</span> <span
											style="font-size: 1em; color: black" id="slogistics"></span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">物流编号：</span> <span
											style="font-size: 1em; color: black" id="slogisticsnum"></span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">下单时间：</span> <span
											style="font-size: 1em; color: black" id="sordertime"></span>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<span style="font-size: 1em; color: black">订单状态：</span> <span
											style="font-size: 1em; color: black" id="sstate"></span>
									</div>
								</div>
							</div>
							<div class="row" id="checkbok"></div>
							<div class="row">
								<div class="form-group">
									<p style="font-size: 1em; color: black">备注：</p>
									<span style="font-size: 1em; color: black" id="smemo"></span>
								</div>
							</div>				
							<div class="row">
								<button style="margin-left:15px;" class="btn btn-primary" id="seesubmit" type="button">修改备注</button>
								<div class="col-md-12">
									<div class="form-group">
										<label for="name"></label><input class="form-control"
											placeholder="输入备注内容" id="smeno" name="meno" type="text">
									</div>
								</div>
							</div>
						</div>
					</fieldset>
				</form>
			</div>			
			<div class="modal-footer">
				<button class="btn btn-primary" data-dismiss="modal"
					type="button">确定</button>
			</div>
		</div>
	</div>
</div>