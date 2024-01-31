<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
.recon-body p {
    word-wrap: break-word; /* 긴 단어가 있는 경우 줄 바꿈 */
    overflow-wrap: break-word; /* 현대 브라우저를 위한 줄 바꿈 속성 */
    max-width: 100%; /* 최대 너비 지정 */
    overflow: hidden; /* 넘치는 내용 숨기기 */
}
</style>
<div id="banner-area" class="banner-area"
	style="background-color: rgb(50, 137, 76)">
	<div class="banner-text">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="banner-heading">
						<h1 class="banner-title">고객센터</h1>
						<nav aria-label="breadcrumb">
							<ol class="breadcrumb justify-content-center">
								<li class="breadcrumb-item"><a href="/center/cscenter/faq">FAQ</a></li>
								<li class="breadcrumb-item"><a href="/center/cscenter/fqna">1:1문의</a></li>
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
<section id="main-container" class="main-container">
	<div class="container">
	<c:if test="${empty user}">
		<script>
                    // 사용자가 비어 있으면 로그인 페이지로 자동 이동
                    window.location.href = "/login/login";
                </script>
             </c:if>
		<div class="panel-body">

			<div class="recon-top">
				<div class="recon-tit">
					<span class="badgeset">${board.answer == null ? '미답변' : '답변'}</span>
					<h3>${board.title }</h3>
					
				</div>
				<p><span>${board.regDate }</span></p>

			</div>
			<div class="recon-body">
				<p>${board.content }</p>
			</div>
			<c:if test="${board.answer!=null }">
				
				<div style="padding-top: 1rem;" class="recon-body">
				<h3>답변</h3>
					<p>${board.answer }</p>
				</div>
			</c:if>
			<form role="form">
				<div class="form-group" id="actionf">
					<input type="hidden" name="nickname" value="${user.nickname }"> <input
						id="qno" type="hidden" name="qno" value="${board.qno }">
				</div>
				<a class="btn btn-primary" href="/center/cscenter/fqna">목록으로</a>
				<button style="padding: 8.5px 12px 8.5px;" id="openModalBtn" type="button" class="btn-primary">첨부그림확인</button>
				<button type="button" class="btn btn-primary header-right"
					data-oper="remove">삭제</button>
				<button type="button" class="btn btn-primary header-right maright"
					data-oper="modify">수정</button>
			</form>

			<div>
				


			</div>

			<div id="myModal" class="modal">
				<div class="modal-content">
					<span class="close">&times;</span>
					<table width="100%"
						class="table table-striped table-bordered table-hover">
						<thead>
						</thead>
						<tbody>
							<tr>

							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

	</div>
</section>



<script type="text/javascript">
	$(document).ready(
			function() {
				loadTableData();

				let formObj = $("form");
				$(".btn").click(
						function() {
							let operation = $(this).data("oper");
							console.log(operation);
							if (operation == "remove") {
								formObj.attr("action",
										"/center/cscenter/fqnaRemove").attr(
										"method", "get");
							} else if (operation == "modify") {
								formObj.attr("action",
										"/center/cscenter/fqnaModify").attr(
										"method", "get");
							}
							formObj.submit();
						});
				function loadTableData() {
					$.ajax({
						url : "/center/cscenter/fqnaFile",
						type : "POST",
						dataType : "json",
						data : {
							qno : $("#actionf").find("input[name='qno']").val()
						},
						success : function(data) {
							let boardTbody = $("tbody");
							$.each(data, function(index, qfile) {
								let row = $("<tr>");

								let image = $("<img>").attr(
										"src",
										"../../../../resources/upload/"
												+ qfile.filename).attr("alt",
										"이미지");

								row.append(image);

								boardTbody.append(row);
							});
						},
						error : function(e) {
							console.log(e);
							console.log("문제")
						}
					});
				}
			});
	document.getElementById('openModalBtn').addEventListener('click',
			function() {
				document.getElementById('myModal').style.display = 'block';
			});

	document.querySelector('.close').addEventListener('click', function() {
		document.getElementById('myModal').style.display = 'none';
	});

	window.addEventListener('click', function(event) {
		if (event.target == document.getElementById('myModal')) {
			document.getElementById('myModal').style.display = 'none';
		}
	});
</script>
<%@include file="../../includes/footer.jsp"%>