<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="\resources\summernote-0.8.18-dist\summernote-lite.css">
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
								<li class="breadcrumb-item"><a href="/admin/userManage">유저관리</a></li>
								<li class="breadcrumb-item"><a href="/admin/report">신고확인</a></li>
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
	<h2>고객문의사항 답변</h2>
	<div class="panel-body">
<form id="answerForm" role="form">
<div class="form-group">
				<input type="hidden" name="qno" value="${board.qno }">
			</div>
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
			<div class="form-group">
				<label>답변</label>
				<textarea id="summernote" class="form-control" rows="5" cols="40" name="answer">${board.answer }</textarea>
			</div>
			
			
			
			<a class="btn-primary" href="/admin/adminFqna">목록으로</a>
			<button type="button" class="btn btn-primary" data-oper="modify">답변완료</button>
			<button id="openModalBtn" type="button" class="btn-primary">첨부그림확인</button>
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
<script>
    $(document).ready(function () {
        $('#summernote').summernote({
            codeviewFilter: false, // 코드 보기 필터 비활성화
            codeviewIframeFilter: false, // 코드 보기 iframe 필터 비활성화

            height: 500, // 에디터 높이
            minHeight: null, // 최소 높이
            maxHeight: null, // 최대 높이
            focus: true, // 에디터 로딩 후 포커스 설정
            lang: 'ko-KR', // 언어 설정 (한국어)

            toolbar: [
                ['style', ['style']], // 글자 스타일 설정 옵션
                ['fontsize', ['fontsize']], // 글꼴 크기 설정 옵션
                ['font', ['bold', 'underline', 'clear']], // 글자 굵게, 밑줄, 포맷 제거 옵션
                ['color', ['color']], // 글자 색상 설정 옵션
                ['table', ['table']], // 테이블 삽입 옵션
                ['para', ['ul', 'ol', 'paragraph']], // 문단 스타일, 순서 없는 목록, 순서 있는 목록 옵션
                ['height', ['height']], // 에디터 높이 조절 옵션
                ['insert', ['picture', 'link', 'video']], // 이미지 삽입, 링크 삽입, 동영상 삽입 옵션
                ['view', ['codeview', 'help']], // 코드 보기, 전체 화면, 도움말 옵션
            ],

            fontSizes: [
                '8', '9', '10', '11', '12', '14', '16', '18',
                '20', '22', '24', '28', '30', '36', '50', '72',
            ], // 글꼴 크기 옵션

            styleTags: [
                'p',  // 일반 문단 스타일 옵션
                {
                    title: 'Blockquote',
                    tag: 'blockquote',
                    className: 'blockquote',
                    value: 'blockquote',
                },  // 인용구 스타일 옵션
                'pre',  // 코드 단락 스타일 옵션
                {
                    title: 'code_light',
                    tag: 'pre',
                    className: 'code_light',
                    value: 'pre',
                },  // 밝은 코드 스타일 옵션
                {
                    title: 'code_dark',
                    tag: 'pre',
                    className: 'code_dark',
                    value: 'pre',
                },  // 어두운 코드 스타일 옵션
                'h1', 'h2', 'h3', 'h4', 'h5', 'h6',  // 제목 스타일 옵션
            ],

            callbacks: {
                onImageUpload: function (files, editor, welEditable) {
                    // 파일 업로드 (다중 업로드를 위해 반복문 사용)
                    for (var i = files.length - 1; i >= 0; i--) {
                        var fileName = files[i].name

                        // 이미지 alt 속성 삽일을 위한 설정
                        var caption = prompt('이미지 설명 :', fileName)
                        if (caption == '') {
                            caption = '이미지'
                        }
                        uploadSummernoteImageFile(files[i], this, caption)
                    }
                },
                
            },
        })
    })

   
</script>
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
<script>
window.onload = function() {
    document.getElementById("answerForm").onsubmit = function() {
        var textareaContent = document.getElementById("summernote").value;
        var maxLength = 500; // 원하는 최대 글자 수로 변경 가능
        
        if (textareaContent.length > maxLength) {
            alert("답변의 글자 수가 너무 많습니다. " + maxLength + "자 이하로 작성해주세요.");
            return false; // 제출 방지
        }

    };
};
</script>
<%@include file="../includes/footer.jsp"%>