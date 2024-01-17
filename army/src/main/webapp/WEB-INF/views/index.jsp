<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style type="text/css">
body {
	background-image: url("/resources/img/background.png");
	background-repeat: no-repeat;
	background-size: cover;
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

#container {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 100vh;
}

.head {
	background-color: #333;
	color: #fff;
	padding: 10px;
	text-align: center;
	width: 100%;
}

.logo {
	font-size: 24px;
	font-weight: bold;
}

.intro {
	margin-top: 20px;
	font-size: 18px;
	text-align: center;
}

a {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 20px;
	background-color: #333;
	color: #fff;
	text-decoration: none;
	border-radius: 5px;
	font-size: 16px;
}

a:hover {
	background-color: #555;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
$(document).ready(() => {

});
</script>
</head>
<body>
	<div id="container">
	
	<div class="head">
		<div class="logo">당군</div>
	</div>
	<div class="intro">
	이 사이트는 영국에서부터 시작되어.. 10명에게 소개하지 않으면..(대충 소개)
	</div>
	<a href="login/login">시작하기</a>
	</div>



</body>
</html>