<%@page import="org.spring.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 상대경로를 유일하게 쓰는 곳 -->
<%@include file="../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div id="banner-area" class="banner-area"
	style="background-color: rgb(50, 137, 76)">
	<div class="banner-text">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="banner-heading">
						<h1 class="banner-title">내 정 보</h1>
						<nav aria-label="breadcrumb">
							<ol class="breadcrumb justify-content-center">
								<li class="breadcrumb-item"><a href="../user/myModify">내 정보 수정</a></li>
								<li class="breadcrumb-item"><a href="../user/myCalendar/mySchedule">내 일 정</a></li>
								<li class="breadcrumb-item"><a href="../center/cscenter/fqna">내 문 의</a></li>
							</ol>
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
<!-- Banner area end -->
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
								<tr>
									<td>닉네임</td>
									<td><input type="text" name="nickname"
										value="${user.nickname}"></td>
								</tr>
								<tr>
									<td>아이디</td>
									<td><input type="text" name="id" disabled="disabled"
										value="${user.id}"></td>
								</tr>
								<tr>
									<td>비밀번호</td>
									<td><input type="password" name="pw"></td>
								</tr>
								<tr>
									<td>비밀번호확인</td>
									<td><input type="password" name="pwc"></td>
								</tr>
								<tr>
									<td>군종</td>
									<%UserVO u=(UserVO)request.getSession().getAttribute("user");
										String result=u.getArmygroup().equals("earth") ? "(휴먼굴림체)육군" : u.getArmygroup().equals("sea") ? "해군" : "공군";%>
									<td><input type="text" disabled="disabled"
										value="<%=result%>"></td>
								</tr>
								<tr>
									<td>입대일</td>
									<td><input type="text" disabled="disabled"
										value="${user.enlisting}"></td>
								</tr>
								<tr>
									<td>이메일</td>
									<td><input type="text" disabled="disabled"
										value="${user.email}"></td>
								</tr>
								<tr>
									<td>SNS 연동</td>
									<td><img alt=""
										src="/resources/images/<c:if test='${user.sns.startsWith("n")}'>NaverBtn.png</c:if><c:if test='${user.sns.startsWith("k")}'>KakaoBtn.png</c:if><c:if test='${user.sns.startsWith("g")}'>GoogleBtn.png</c:if><c:if test='${empty user.sns}'>x.png</c:if>
									">
									</td>
								</tr>
								<tr>
									<td colspan="2"><a href="javascript:modify();">수정하기</a></td>
								</tr>
								<tr>
									<td colspan="2"><a href="javascript:delUser();">회원탈퇴</a></td>
								</tr>


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

<script type="text/javascript">
	let modify = function() {
		let id = $("[name=id]");
		let pw = $("[name=pw]");
		let nickname = $("[name=nickname]");
		let data = {
			"id" : id.val(),
			"pw" : pw.val(),
			"nickname" : nickname.val()
		}

		let xhr = new XMLHttpRequest();
		xhr.open("POST", "../login/modify", true);
		xhr.setRequestHeader("Content-Type", "application/json");
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				if (xhr.response == 1) {
					alert("변경 완료 다시 로그인 하세요.");
					window.location.href="../login/login";
				} else {
					alert("변경 실패 지속 시 1:1 문의 부탁드립니다.");
				}

			}
		};
		xhr.send(JSON.stringify(data));
	}
	let delUser=function(){
		let id=${user.id}
		console.log(id);
		console.log("진입");
		let xhr = new XMLHttpRequest();
		xhr.open("POST", "../login/delete", true);
		xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr.onreadystatechange = function() {
			if (xhr.readyState === 4 && xhr.status === 200) {
				if (xhr.response == 1) {
					alert("회원 탈퇴가 완료되었습니다.");
					window.location.href="../login/login"; //아직 header에 세션 불일치 시 로그인 화면 이동 구현 안해서 넣어둠
				} else {
					alert("탈퇴 실패 관리자에게 문의하세요.");
				}
			}
		};
		xhr.send("id="+id);
	}
</script>

<%@include file="../includes/footer.jsp"%>


