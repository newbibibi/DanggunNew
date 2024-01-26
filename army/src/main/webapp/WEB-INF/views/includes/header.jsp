<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<!-- Basic Page Needs
================================================== -->
<meta charset="utf-8">
<title>Constra - Construction Html5 Template</title>

<!-- Mobile Specific Metas
================================================== -->
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Construction Html5 Template">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=5.0">

<!-- Favicon
================================================== -->
<link rel="icon" type="../../../resources/image/png"
	href="../../../resources/images/favicon.png">

<!-- CSS
================================================== -->
<!-- Bootstrap -->
<link rel="stylesheet"
	href="../../../resources/plugins/bootstrap/bootstrap.min.css">
<!-- FontAwesome -->
<link rel="stylesheet"
	href="../../../resources/plugins/fontawesome/css/all.min.css">
<!-- Animation -->
<link rel="stylesheet"
	href="../../../resources/plugins/animate-css/animate.css">
<!-- slick Carousel -->
<link rel="stylesheet" href="../../../resources/plugins/slick/slick.css">
<link rel="stylesheet"
	href="../../../resources/plugins/slick/slick-theme.css">
<!-- Colorbox -->
<link rel="stylesheet"
	href="../../../resources/plugins/colorbox/colorbox.css">
<!-- Template styles-->
<link rel="stylesheet" href="../../../resources/css/style.css">
<script src="../../../resources/plugins/jQuery/jquery.min.js"></script>
<!-- Bootstrap jQuery -->
<script src="../../../resources/plugins/bootstrap/bootstrap.min.js"
	defer></script>
<!-- Slick Carousel -->
<script src="../../../resources/plugins/slick/slick.min.js"></script>
<script src="../../../resources/plugins/slick/slick-animation.min.js"></script>
<!-- Color box -->
<script src="../../../resources/plugins/colorbox/jquery.colorbox.js"></script>
<!-- shuffle -->
<script src="../../../resources/plugins/shuffle/shuffle.min.js" defer></script>



<!-- Template custom -->
<script src="../../../resources/js/script.js"></script>

<c:if test="${empty user}">
<script type="text/javascript">
window.location.href="/login/login";
</script>
</c:if>


</head>
<body>

	<div class="body-inner">

		<!-- Header start -->
		<header id="header" class="header-one">
			<div class="bg-white">
				<div class="container">
					<div class="logo-area">
						<div class="row align-items-center">
							<div
								class="logo col-lg-3 text-center text-lg-left mb-3 mb-md-5 mb-lg-0">
								<a class="d-block" href="${pageContext.request.contextPath}/login/main""> <img loading="lazy"
									src="../../../resources/images/logo.PNG" alt="Constra">
								</a>
							</div>
							<!-- logo end -->

							<div class="col-lg-9 header-right">
								<ul class="top-info-box">
									<li>
										<div class="info-box">
											<div class="info-box-content">
												<c:if test="${user.admin==0}">
													<p class="info-box-title">닉네임</p>
													<p id="" class="info-box-subtitle">${user.nickname }</p>
												</c:if>
												<c:if test="${user.admin==1}">
													<p class="info-box-title">접속중</p>
													<p id="" class="info-box-subtitle">${user.nickname }</p>
												</c:if>
											</div>
										</div>
									</li>
									<c:if test="${user.admin==0}">
									<li>
										<div class="info-box">
											<div class="info-box-content">
												
													<p class="info-box-title">계급</p>
													<p id="currentRank" class="info-box-subtitle"></p>
												
												
											</div>
										</div>
									</li>
									</c:if>
									<c:if test="${user.admin==0}">
									<li>
										<div class="info-box">
											<div class="info-box-content">
												
													<p class="info-box-title">다음 진급일</p>
													<p id="promotionDates" class="info-box-subtitle"></p>
												
											</div>
										</div>
									</li>
									</c:if>
									<c:if test="${user.admin==0}">
									<li class="last">
										<div class="info-box last">
											<div class="info-box-content">
												
													<p class="info-box-title">전역일</p>
													<p id="remainDates" class="info-box-subtitle"></p>
												
											</div>
										</div>
									</li>
									</c:if>
									<li class="header-get-a-quote"><a class="btn btn-primary"
										href="${pageContext.request.contextPath}/login/logout">로그아웃</a></li>
								</ul>
								<!-- Ul end -->
							</div>
							<!-- header right end -->
						</div>
						<!-- logo area end -->

					</div>
					<!-- Row end -->
				</div>
				<!-- Container end -->
			</div>

			<div class="site-navigation">
				<div class="container">
					<div class="row">
						<div class="col-lg-12">
							<nav class="navbar navbar-expand-lg navbar-dark p-0">
								<button class="navbar-toggler" type="button"
									data-toggle="collapse" data-target=".navbar-collapse"
									aria-controls="navbar-collapse" aria-expanded="false"
									aria-label="Toggle navigation">
									<span class="navbar-toggler-icon"></span>
								</button>

								<div id="navbar-collapse" class="collapse navbar-collapse">
									<ul class="nav navbar-nav mr-auto">
										<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login/main">Home</a></li>

										<li class="nav-item"><a class="nav-link"
											href="/center/notice/noticeList">Notice</a></li>

										<li class="nav-item dropdown"><a href="#"
											class="nav-link dropdown-toggle" data-toggle="dropdown">Information
												<i class="fa fa-angle-down"></i>
										</a>
											<ul class="dropdown-menu" role="menu">
												<li><a href="/center/information/mealSchedule">meal
														schedule</a></li>
												<li><a href="/center/information/benefit">Benefit</a></li>
											</ul></li>
											<!-- ------------------------------------------- -->
									
										<li class="nav-item dropdown"><a href="/board/list"
											class="nav-link dropdown-toggle" data-toggle="dropdown">Community
												<i class="fa fa-angle-down"></i>
										</a>
											<ul class="dropdown-menu" role="menu">
												<li><a href="/board/list?category=best">BEST
														</a></li>
												<li><a href="/board/list?category=ssul">썰</a></li>
												<li><a href="/board/list?category=tip">팁</a></li>
												<li><a href="/board/list?category=free">자유</a></li>
											</ul></li>
										<!--  
										<li class="nav-item"><a class="nav-link"
											href="/board/list">Community</a></li>-->

										<li class="nav-item dropdown"><a href="#"
											class="nav-link dropdown-toggle" data-toggle="dropdown">Customer
												Service <i class="fa fa-angle-down"></i>
										</a>
											<ul class="dropdown-menu" role="menu">
												<li><a href="/center/cscenter/faq">FAQ</a></li>
												<li><a href="/center/cscenter/fqna">Questions</a></li>

											</ul></li>

										<li class="nav-item dropdown"><a href="#"
											class="nav-link dropdown-toggle" data-toggle="dropdown">User
												<i class="fa fa-angle-down"></i>
										</a>
											<ul class="dropdown-menu" role="menu">
												<li><a href="/user/myPage">MyPage</a></li>
												<li><a href="/user/myCalendar/mySchedule">Calendar</a></li>
											</ul></li>
										<c:if test="${user.admin == 1}">
										<li class="nav-item dropdown"><a href="#"
											class="nav-link dropdown-toggle" data-toggle="dropdown">admin
												<i class="fa fa-angle-down"></i>
										</a>
											<ul class="dropdown-menu" role="menu">
												<li><a href="/admin/report">Report</a></li>
												<li><a href="/admin/userManage">UserManage</a></li>
												<li><a href="/admin/adminFqna">FqnaAnswer</a></li>
											</ul></li>
										</c:if>

									</ul>
								</div>
							</nav>
						</div>
						<!--/ Col end -->
					</div>
					<!--/ Row end -->

					<div class="nav-search">
						<span id="search"><i class="fa fa-user"></i></span>
					</div>
					<!-- Search end -->

					<div class="search-block" style="display: none;">
						<label for="search-field" class="w-100 mb-0"> <a class="btn btn-primary"
										href="${pageContext.request.contextPath}/login/logout">로그아웃</a>
										<a class="btn btn-primary"
										href="${pageContext.request.contextPath}/user/myPage">마이페이지</a>
						</label> <span class="search-close">&times;</span>
					</div>
					<!-- Site search end -->
				</div>
				<!--/ Container end -->

			</div>
			<!--/ Navigation end -->
		</header>
		<!--/ Header end -->