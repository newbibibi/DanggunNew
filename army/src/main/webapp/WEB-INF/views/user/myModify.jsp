<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 상대경로를 유일하게 쓰는 곳 -->
<%@include file="../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<section class="call-to-action-box no-padding">
	<div class="container">
		<div class="action-style-box">
			<div class="row align-items-center">
				<div class="col-md-8 text-center text-md-left">
					<div class="call-to-action-text">
						<h3 class="action-title">내 정보 수정</h3>
					</div>
				</div>
				<!-- Col end -->
				<div class="col-md-4 text-center text-md-right mt-3 mt-md-0">
					<div class="call-to-action-btn">
						<a class="btn btn-dark" href="#">바로 가기</a>
					</div>
				</div>
				<!-- col end -->
			</div>
			<!-- row end -->
		</div>
		<!-- Action style box -->
	</div>
	<!-- Container end -->
</section>
<!-- Action end -->
<!-- Feature are end -->



<section id="project-area" class="project-area solid-bg">
	<div class="container">
		<!--/ Title row end -->

		<div class="row">
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light text-center rounded p-4">
					<div class="d-flex align-items-center justify-content-between mb-4">
						<h6 class="mb-0">유저 정보</h6>
					</div>
					<div class="table-responsive">
						<table
							class="table text-start align-middle table-bordered table-hover mb-0">
							<c:if test="${empty user}">
								<tr>
									<td>로그인되어 있지 않은 비정상 사용자</td>
								</tr>
							</c:if>
							<c:if test="${!empty user}">
								<c:forEach items="${user.declaredFields}" var="info">
									<tr>
										<td>${info.name}</td> <td>${user[info.name]}</td>
									</tr>
								</c:forEach>
							</c:if>
						</table>
					</div>
				</div>
			</div>
			<!-- Content row end -->
		</div>
	</div>
	<!--/ Container end -->
</section>
<!-- Project area end -->


<%@include file="../includes/footer.jsp"%>


