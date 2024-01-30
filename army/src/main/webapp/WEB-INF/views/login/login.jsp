<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">
<link rel="icon" href="/resources/images/favicon.png" type="image/x-icon">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Favicon -->
<link href="img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link
	href="/resources/login/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link
	href="/resources/login/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<link href="/resources/login/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="/resources/login/css/style.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>



<script type="text/javascript">
$(document).ready(() => {
    $(".signup").click(() => {
      window.location.href = "../login/login/join";
    });

    $(".findAccount").click(function(){
//    	window.open("../login/login/find", "아이디/비밀번호 찾기", "width=400,height=600,left=100,top=50,resizable=yes,scrollbars=no");
   		$("#modalIframe").attr("src","../login/login/find");
   		$("#view").modal("show");
    });
});
	function login(){
		let id=$("[name=id]");
		let pw=$("[name=pw]");
		$.ajax({
			url : '../../login/login/login',
			method : 'POST',
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			data : {
				"id" : id.val(), "pw" : pw.val()
			},
			success : function(data) {
				if(data.includes("성공")){
					window.location.href="../login/main";
				}else{
					Toastify({
		                text: data,
		                duration: 2000,
		                close: true,
		                gravity: "top",
		                position: 'center',
		                backgroundColor: "#FF0000"
		            }).showToast();
				}
			},
			error : function(xhr, status, error) {
				console.error(error);
			}
	});
	}
	document.addEventListener('keydown', function(event) {
		  if (event.key === 'Enter') {
		    // 엔터키가 눌렸을 때 로그인 함수 호출
		    login();
		  }
		});
	function modalClose(){
		$("#view").modal("hide");
	}
</script>
</head>
<body>
	<div class="container-xxl position-relative bg-white d-flex p-0">
		<!-- Spinner Start -->
		<div id="spinner"
			class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
			<div class="spinner-border text-primary"
				style="width: 3rem; height: 3rem;" role="status">
				<span class="sr-only">Loading...</span>
			</div>
		</div>
		<!-- Spinner End -->
<!-- 모달 -->
<div class="modal fade" id="view" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header" style="background-color: #32894c;">
        <h5 class="modal-title" id="exampleModalLabel">ID/PW 찾기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" style="height:40vh;">
        <iframe id="modalIframe" src="" style="width: 100%; height: 100%;"></iframe>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>


		<!-- Sign In Start -->
		<div class="container-fluid">
			<div class="row h-100 align-items-center justify-content-center"
				style="min-height: 100vh;">
				<div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
					<div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
						<div
							class="d-flex align-items-center justify-content-between mb-3">
							<h3>당군 로그인</h3>
						</div>
						<div class="form-floating mb-3">
							<input type="text" name="id" class="form-control"
								id="floatingInput" placeholder=""> <label
								for="floatingInput">ID</label>
						</div>

						<div class="form-floating mb-4">
							<input type="password" name="pw" class="form-control"
								id="floatingPassword" placeholder=""> <label
								for="floatingPassword">Password</label>
						</div>
						<div
							class="d-flex align-items-center justify-content-between mb-4">
							<a href="#" class="findAccount">ID/PW찾기</a> <a href="#"
								class="signup">회원가입</a>
						</div>
						<button onclick="login()" class="btn btn-primary py-3 w-100 mb-4">로그인</button>
						<div>
							<a href="../login/authReq?v=k"><img class="loginBtn" alt=""
								src="/resources/images/KakaoBtn.png"></a> <a
								href="../login/authReq?v=n"><img class="loginBtn" alt=""
								src="/resources/images/NaverBtn.png"></a> <a
								href="../login/authReq?v=g"><img class="loginBtn" alt=""
								src="/resources/images/GoogleBtn.png"></a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Sign In End -->
	</div>

	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="/resources/login/lib/chart/chart.min.js"></script>
	<script src="/resources/login/lib/easing/easing.min.js"></script>
	<script src="/resources/login/lib/waypoints/waypoints.min.js"></script>
	<script src="/resources/login/lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="/resources/login/lib/tempusdominus/js/moment.min.js"></script>
	<script
		src="/resources/login/lib/tempusdominus/js/moment-timezone.min.js"></script>
	<script
		src="/resources/login/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>


	<!-- Template Javascript -->
	<script src="/resources/login/js/main.js"></script>


</body>
</html>