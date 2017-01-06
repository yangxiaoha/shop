<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="seeModal">
	<div class="modal-dialog" style="width:650px;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 style="color : black" class="modal-title">详情信息
				<span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="see" id="see" method="post" class="form-horizontal">
					<fieldset>
						<div class="row" id="checkbok"></div>
					</fieldset>
				</form>
			</div>			
			<div class="modal-footer">
				<button class="btn btn-primary" data-dismiss="modal" type="button">确定</button>
			</div>
		</div>
	</div>
</div>