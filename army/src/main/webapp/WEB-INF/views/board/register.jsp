<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
   <div id="banner-area" class="banner-area" style="background-color: rgb(50 137 76)">
  <div class="banner-text">
    <div class="container">
        <div class="row">
          <div class="col-lg-12">
              <div class="banner-heading">
                <h3 class="banner-title">글 작성</h3>

              </div>
          </div><!-- Col end -->
        </div><!-- Row end -->
    </div><!-- Container end -->
  </div><!-- Banner text end -->
</div><!-- Banner area end --> 
<script src="/resources/summernote-0.8.18-dist/summernote-lite.js"></script>
<script src="/resources/summernote-0.8.18-dist/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="\resources\summernote-0.8.18-dist\summernote-lite.css">

<form id="postForm" class="col-x" action="register.do" method="post" enctype="multipart/form-data">
    <!-- 나머지 폼 필드 -->
    <div>
			<label for="title">제목:</label> <input type="text" id="title"
				name="title" required>
		</div>
		<div>
			<label for="category">카테고리:</label> <select id="category"
				class="form-control" name="category">

				<option value="ssul"
					<c:out value="${category == 'ssul'?'selected':''}"/>>썰</option>
				<option value="tip"
					<c:out value="${category == 'tip'?'selected':''}"/>>팁</option>
				<option value="free"
					<c:out value="${category == 'free'?'selected':''}"/>>자유</option>
			</select> <label for="anonymous">익명:</label> <input type="checkbox"
				id="anonymous" name="anonymous" value="1">
		</div>

		<div>
			<label for="content">내용:</label>
			<textarea id="summernote" name="content" required="required"></textarea>
		</div>
    <div>
        <label for="image">이미지:</label>
        <input type="file" id="image" name="image" onchange="showImagePreviews(this)" multiple>
    </div>
    <div id="imagePreviewsContainer" style="display: none;">
        <!-- <img id="imagePreview" style="width: 200px; height: auto;">
        <button type="button" onclick="removeImage()">이미지 취소</button> -->
    </div>
    <!-- 폼 제출 버튼 -->
    <div class="submitr">
        <input type="hidden" name="nickname" value="${nickname}">
        <button class="btn-primary" type="submit">게시물 업로드</button>
    </div>
</form>


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
                ['insert', ['link', 'video']], // 이미지 삽입, 링크 삽입, 동영상 삽입 옵션
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
<script>

    // 이미지 미리보기 함수
   function showImagePreviews(input) {
    var imagePreviewsContainer = document.getElementById('imagePreviewsContainer');
    imagePreviewsContainer.innerHTML = ""; // 이미지 미리보기를 초기화

    if (input.files && input.files.length > 0) {
        for (var i = 0; i < input.files.length; i++) {
            var reader = new FileReader();
            var fileName = input.files[i].name;
            reader.onload = function (e) {
                // 이미지 미리보기를 생성하고 컨테이너에 추가
                var imagePreview = document.createElement('img');
                imagePreview.src = e.target.result;
                imagePreview.style.width = '100px'; // 이미지 미리보기의 너비 조절
                imagePreview.style.height = 'auto'; // 높이 자동 조절
                imagePreviewsContainer.appendChild(imagePreview);

                // Add click event to each image
                imagePreview.addEventListener('click', function () {
                    // Insert the clicked image into the Summernote editor
                    var imgSrc = '/resources/boardImage/' + fileName;
                    if (imgSrc) {
                    	$('#summernote').summernote('pasteHTML', '<img src="' + imgSrc + '" style="max-width: 600px;" alt="' + fileName + '"/>');
                    }
                });
            }

            reader.readAsDataURL(input.files[i]);
        }

        // 이미지 미리보기 컨테이너를 보여줌
        imagePreviewsContainer.style.display = 'block';
    }
}

    // 이미지 제거 함수
    function removeImage() {
        var imageInput = document.getElementById('image');
        var imagePreview = document.getElementById('imagePreview');
        var imagePreviewContainer = document.getElementById('imagePreviewContainer');

        if (imageInput) {
            imageInput.value = "";
        }
        if (imagePreview) {
            imagePreview.src = "";
        }
        if (imagePreviewContainer) {
            imagePreviewContainer.style.display = 'none';
        }
    }
</script>
<%@include file="../includes/footer.jsp"%>
</body>
</html>