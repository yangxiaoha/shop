<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal fade" id="seeModal">
	<div class="modal-dialog" style="width:800px;">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" class="close" data-dismiss="modal"
					type="button">&times;</button>
				<h4 class="modal-title">商品详情
					<span class="loading" style=""></span>
				</h4>
			</div>
			<div class="modal-body">
				<form action="see" id="see" method="post">
					<fieldset>
						<div class="row">
							<div class="col-sm-8">
								<div class="row">
									<div class="col-sm-6">
										<span>商品名称：${goodsM.name }</span>																	
									</div>
									<div class="col-sm-6">										
										<span>商品编码：${goodsM.code }</span>							
									</div>								
								</div>
								<div class="row">
									<p></p>
									<div class="col-sm-6">
										<span>商品品牌：${goodsM.brandName }</span>									
									</div>
									<div class="col-sm-6">
										<span>商品数量：</span>
										<span id="snum"></span>
									</div>
								</div>
								<div class="row">	
									<p></p>						
									<div class="col-sm-6">
										<span>特征量编码：</span>
										<span id="scode"></span>									
									</div>
									<div class="col-sm-6">
										<span>商品价格：</span>
										<span id="sprice"></span>									
									</div>
								</div>									
								<c:forEach items="${goodsM.pros}" var="p" varStatus="status">
									<c:if test="${status.index%3 == 0}">
										<div class="row">										
										<p></p>
									</c:if>
									<div class="col-sm-4">
										<div class="form-group">
											<span>${p.name }:</span>
											<input class="form-control" placeholder="请输入${p.name }"
											id="s${status.index}" required="required" name=""
											type="text" readonly = "readonly"> 
										</div>
									</div>
									<c:set var="last" value="${status.last }"></c:set>
									<c:set var="odd" value="${status.index%3 == 2}"></c:set>										 
									<c:if test="${(odd)||(last)}">
										</div>
									</c:if>
								</c:forEach>
							</div>
							<div class="col-sm-4">
								<div class="row">
									<div class="col-sm-12">
										<div class="form-group">
											<p>商品图片</p>
											<p class="error" style="display: none;"></p>
											<div class="pic">
												<div id="preview" class="preview">
													<img id="simghead" class="imghead" width="240" height="252">
												</div>
											</div>
										</div>
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
				<button class="btn btn-default-outline" data-dismiss="modal"
					type="button">取消</button>
			</div>
		</div>
	</div>
</div>
