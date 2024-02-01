<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../includes/header.jsp" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	<c:if test="${user.admin != 1 }">
		<script type="text/javascript">
			alert("비정상 접근")
			window.location.href = "/center/notice/noticeList"
</script>
	</c:if>
	<div id="banner-area" class="banner-area" style="background-color: rgb(50 137 76)">
  <div class="banner-text">
    <div class="container">
        <div class="row">
          <div class="col-lg-12">
              <div class="banner-heading">
                <h1 class="banner-title">공지사항</h1>
              </div>
          </div><!-- Col end -->
        </div><!-- Row end -->
    </div><!-- Container end -->
  </div><!-- Banner text end -->
</div><!-- Banner area end --> 
<form id="registerForm" class="container">
	<div class="notheader">
	<input type="text" name="title" placeholder="제목을 입력해주세요.">
	<select name="category">
		<option value="NN">공지</option>
		<option value="FF">점검</option>
	</select>
	</div>
	<textarea id="summernote" name="content" required="required"></textarea>
	
	<button type="submit" class="btn btn-primary" data-oper="create">글 작성</button>
	<button type="submit" class="btn btn-primary" data-oper="delete">취소</button>
</form>
<script src="/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="\resources\summernote-0.8.18-dist\summernote-lite.css">
<script type="text/javascript">
function formatDate(date) {
    var year = date.getFullYear();
    var month = String(date.getMonth() + 1).padStart(2, '0');
    var day = String(date.getDate()).padStart(2, '0');
    var hours =date.getHours();
    var minutes = date.getMinutes();
    var seconds =date.getSeconds();

    // 결과 출력 또는 다른 용도로 사용
    console.log("현재 시간: " + hours + ":" + minutes + ":" + seconds);
    return year + '-' + month + '-' + day +" "+ hours + ":" + minutes + ":" + seconds;
}
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
        let formObj = $("#registerForm");
    	
		$(".btn").click(function() {
			let operation = $(this).data("oper");
			console.log(operation);
			
			if(operation == "create"){
				var currentDate = new Date();
			    
			    // 날짜를 형식화
			

			    var formattedDate = formatDate(currentDate);

			    // 날짜를 히든 필드에 추가
			    $("<input>").attr({
			        type: "hidden",
			        name: "regDate",
			        value: formattedDate
			    }).appendTo("#registerForm");
				formObj.attr("action","/center/notice/noticeRegister")
				.attr("method", "post");
			}
			if(operation == "delete"){
				window.location.href = "/center/notice/noticeList";
			}
			formObj.submit();
		});
    })
</script>
<%@ include file="../../includes/footer.jsp" %>
