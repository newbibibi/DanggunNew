<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 상대경로를 유일하게 쓰는 곳 -->
<%@include file="../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
.batch{
	display: flex;
	flex-direction: row;
	justify-content: space-evenly;
	align-content: center;
}
</style>
<div id="banner-area" class="banner-area"
	style="background-color: rgb(50, 137, 76)">
	<div class="banner-text">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="banner-heading">
						<nav class="batch")>
							<div><a href="/user/myModify">내 정 보</a></div>
							<div><a href="/user/myCalendar/mySchedule">내 일 정</a></div>
							<div><a href="/center/cscenter/faq">내 문 의</a></div>
						</nav>
					</div>
				</div>
				<!-- Col end -->
			</div>
			<!-- Row end -->
		</div>
		<!-- Container end -->
	</div>
	<!-- Banner text end -->
</div>
<%@include file="../includes/footer.jsp"%>


