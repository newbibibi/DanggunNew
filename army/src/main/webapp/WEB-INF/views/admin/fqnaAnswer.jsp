<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
						<h1 class="banner-title">관리자페이지</h1>
						<nav aria-label="breadcrumb">
							<ol class="breadcrumb justify-content-center">
								<li class="breadcrumb-item"><a href="#">유저관리</a></li>
								<li class="breadcrumb-item"><a href="#">신고확인</a></li>
								<li class="breadcrumb-item"><a href="/admin/adminFqna">고객문의</a></li>
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
		<form role="form">
			<div class="form-group">
				<input type="hidden" name="qno" value="${board.qno }">
			</div>
			<div class="form-group">
				<label>작성자</label> <input class="form-control" name="title"
					readonly="readonly" value="${board.nickname }">
			</div>
			<div class="form-group">
				<label>제목</label> <input class="form-control" name="title"
					readonly="readonly" value="${board.title }">
			</div>
			<div class="form-group">
				<label>내용</label>
				<textarea class="form-control" rows="5" cols="40" name="content"
					readonly="readonly">${board.content }</textarea>
			</div>
			<div class="form-group">
				<label>답변</label>
				<textarea class="form-control" rows="5" cols="40" name="answer">${board.answer }</textarea>
			</div>
			<a class="btn-primary" href="/admin/adminFqna">목록으로</a>
			<button type="button" class="btn btn-primary" data-oper="modify">답변완료</button>
			<button id="openModalBtn" type="button" class="btn-primary">첨부그림확인</button>
		</form>


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

							if (operation == "modify") {
								formObj.attr("action", "/admin/fqnaAnswer")
										.attr("method", "post");
							}
							formObj.submit();
						});
				function loadTableData() {
					$.ajax({
						url : "/center/cscenter/fqnaFile",
						type : "POST",
						dataType : "json",
						data : {
							qno : $(".form-group").find("input[name='qno']")
									.val()
						},
						success : function(data) {
							let boardTbody = $("tbody");
							$.each(data, function(index, qfile) {
								let row = $("<tr>");

								let image = $("<img>").attr(
										"src",
										"../../resources/upload/"
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
<%@include file="../includes/footer.jsp"%>