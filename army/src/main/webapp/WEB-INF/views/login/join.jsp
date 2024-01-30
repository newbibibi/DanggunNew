<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/login.css">
<link rel="icon" href="/resources/images/favicon.png" type="image/x-icon">
<title>회원가입</title>
<style type="text/css">
.form-style {
	width: 50%;
	height: 10%;
	margin-top: 10px;
	height: 10%;
}

.selectBox {
	position: relative;
	width: 150px;
	height: 35px;
	border-radius: 4px;
	border: 2px solid;
	background: #1f2029;
	color: #c4c3ca;
}

.selectBox .select {
	width: inherit;
	height: inherit;
	background: transparent;
	border: 0 none;
	outline: 0 none;
	padding: 0 5px;
	position: relative;
	z-index: 3;
	//
	select가
	위로
	올라와야
	함
}

.selectBox .select option {
	background: lightcoral;
	color: #fff;
	padding: 3px 0;
	font-size: 16px;
}

.selectBox .icoArrow {
	position: absolute;
	top: 0;
	right: 0;
	z-index: 1;
	width: 35px;
	height: inherit;
	border-left: 2px solid lightcoral;
	display: flex;
	justify-content: center;
	align-items: center;
}

.selectBox .icoArrow img {
	width: 50%;
	transition: .3s;
	//
	부드럽게
	회전
}

.selectBox .select:focus+.icoArrow img {
	transform: rotate(180deg);
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	window.onload = function() {
		let ec;
		let nick = $("[name=nickname]");
		let id = $("[name=id]");
		let email = $("[name=email]");
		let nickBox = $(".nickCheck");
		let idBox = $(".idCheck");
		let emailBox = $(".emailCheck");
		let pw = $("[name=pw]");
		let pwc = $("[name=pwc]");
		let pwBox = $(".pwCheck");

		let checker1 = false;
		let checker2 = false;
		let checker3 = false;
		let checker4 = false;
		let checker5 = false;
		let bcheck1=false; // 버튼 생성 한번만 되도록 체크
		let bcheck2=false; // 버튼 생성 한번만 되도록 체크
		let bcheck3=false; // 버튼 생성 한번만 되도록 체크
		let nickRegex = /^[가-힣a-zA-Z0-9_-\S]{2,16}$/;
		let idRegex=/^[a-zA-Z0-9\S]{8,16}$/;
		let pwRegex=/^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d\S]{8,20}$/;
		let emailRegex=/\b\d{13}\b/
		// 최소 8자 이상, 대문자와 소문자, 숫자가 각각 1개 이상 포함되어야 함
		
		var pattern = 
		nick.bind("blur", function() {
			$.ajax({
				url : '../../login/checker',
				method : 'POST',
				data : {
					checkValue : nick.val(), checkColumn : "nickname"
				},
				success : function(data) {
					if(nickRegex.test(nick.val())){
						nickBox.html("");
						if (nick.val() != "") {
							if (data != "") {
								nick.css("border", "2px solid red");
								nickBox.css("color","red");
								nickBox.text("중복된 닉네임이 존재합니다.");
								checker1 = false;
								nick.focus();
								console.log("c1" + checker1);
							} else {
								nick.css("border", "2px solid green");
								checker1 = true;
								console.log("c1" + checker1);
							}
						}
					}else{
						nick.css("border", "2px solid red");
						nickBox.css("color","red");
						nickBox.text("닉네임은 2글자 이상, 16글자 이하만 사용 가능합니다.(특문 불가)");
						checker1 = false;
					}
				},
				error : function(xhr, status, error) {
					console.error(error);
				}
			});
		});

		id.bind("blur", function() {
			$.ajax({
				url : '../../login/checker',
				method : 'POST',
				data : {
					checkValue : id.val(), checkColumn : "id"
				},
				success : function(data) {
					if(idRegex.test(id.val())){
						idBox.html("");
					if (id.val() != "") {
						if (data != "") {
							id.css("border", "2px solid red");
							idBox.css("color", "red");
							idBox.text("중복된 아이디가 존재합니다.");
							checker2 = false;
							id.focus();
							console.log("c2" + checker2);
						} else {
							id.css("border", "2px solid green");
							idBox.html("");
							checker2 = true;
							console.log("c2" + checker2);
						}
					}
					}else{
						id.css("border", "2px solid red");
						idBox.css("color", "red");
						idBox.text("아이디는 8자 이상, 16자 이하의 영문 대/소문자와 숫자만 사용 가능합니다.");
						checker2 = false;
					}
				},
				error : function(xhr, status, error) {
					console.error(error);
				}
			});
		});

		email.bind("blur", function() {
			$.ajax({
				url : '../../login/checker',
				method : 'POST',
				data : {
					checkValue : email.val()+"@narasarang.or.kr", checkColumn : "email"
				},
				success : function(data) {
					if(emailRegex.test(email.val())){
						emailBox.html("");
					if (email.val() != "") {
						if (data != "") {
							email.css("border", "2px solid red");
							emailBox.css("color", "red");
							emailBox.text("중복된 이메일이 존재합니다.");
							checker3 = false;
							email.focus();

						} else {
							email.css("border", "2px solid green");
							checker3 = true;
							if(!bcheck1){
							$("#m").after("<Button type='button' class='btn' id='eauth'>인증 요청</button>");
							bcheck1=true;
							}
						}
					}
					}else{
						emailBox.html("");
						email.css("border", "2px solid red");
						emailBox.css("color", "red");
						emailBox.text("나라사랑 이메일은 13자리입니다. 카드 뒷면을 확인해주세요.");
						checker3 = false;
					}
				},
				error : function(xhr, status, error) {
					console.error(error);
				}
			});
		});
		let timeout;
		$("body").on("click",'#eauth',function()
		{ // 인증 버튼을 누르게 되면 ajax로 ec에 랜덤코드 넣어줌
			$.ajax({
				url : '../../login/emailauth',
				method : 'POST',
				data : {
					email : email.val()+"@narasarang.or.kr"
				},
				success : function(data) {
					if (data.includes("나라사랑")) {
						emailBox.text(data);
					}else if(data.includes("유효")){
						emailBox.text(data);
					}
					else {
						emailBox.html("");
						ec = data;
					}
				},
				error : function(xhr, status, error) {
					console.error(error);
				}
			}); //ajax 종료
			clearInterval(timeout);
			$("#authcheck").remove();
			$("#checkconfirm").remove();
			$("#limit").remove();
			$("#eauth").after("<input type='text' class='form-style' id='authcheck'>");
			$("#authcheck").after("&nbsp;<button type='button' class='btn' id='checkconfirm'>인증 확인</button> <div id='limit'></div>");
			
			let time=180;
			timeout=setInterval(() => {
			if(time==0){
					ec="";
				clearInterval(timeout);
				$("#authcheck").remove();
				$("#checkconfirm").remove();
				$("#limit").remove();
			}else{
				time-=1;
			}
				$("#limit").html(Math.floor(time / 60) + "분 " + (time % 60) + "초");
			}, 1000);
			
		}); //eauth 종료

		$("body").on("click","#checkconfirm",function() {
			console.log(ec);
			if (ec == $("#authcheck").val()) {
				clearInterval(timeout);
				$("#limit").remove();
				emailBox.text("인증 성공!");
				emailBox.css("color", "green");
				checker5 = true;
				$("#eauth").remove();
				$("#authcheck").remove();
				$("#checkconfirm").remove();
				
			} else {
				emailBox.text("값이 올바르지 않습니다.");
				emailBox.css("color", "red");
				checker5 = false;
			}
		});

		pwc.bind("blur", function() {
			if (pw.val() == null || pw.val() == "") {
				pw.focus();
				pwBox.text("비밀번호를 먼저 입력하세요.");
			} else {
				if(pwRegex.test(pw.val())){
					pwBox.html("");
				if (pwc.val() != pw.val()) {
					pw.css("border", "2px solid red");
					pwc.css("border", "2px solid red");
					pwBox.css("color", "red");
					pwBox.text("비밀번호가 일치하지 않습니다.");
					pw.focus();
					checker4 = false;
				} else {
					pw.css("border", "2px solid green");
					pwc.css("border", "2px solid green");
					checker4 = true;
				}
				}else{
					pw.css("border", "2px solid red");
					pwc.css("border", "2px solid red");
					pwBox.css("color", "red");
					pwBox.text("비밀번호는 8자 이상, 20자 이하 (대/소문자)/숫자가 최소 1개 이상 포함되어야 합니다.");
					checker4 = false;
				}
			}
		});
		pw.bind("blur", function() {
			pwBox.html("");
		});

		$("#sign").submit(function(event) {
			event.preventDefault();
		});

		$("#signup").click(
				function() {
					console.log(checker1 && checker2 && checker3 && checker4
							&& checker5);
					if (checker1 && checker2 && checker3 && checker4
							&& checker5) {
						$("#sign").unbind("submit");
						$("#sign").submit();
					}
				});
	} //onload 종료
	

</script>
</head>
<body>
	<form action="../login/sign" method="post" id="sign" class="form-style">
		<div class="section">
			<div class="container">
				<div class="row full-height justify-content-center">
					<div class="col-12 text-center align-self-center py-5">
						<div class="header">
							<div class="log" style="">대충 로고</div>
						</div>
						<div class="section pb-5 pt-5 pt-sm-2 text-center">
							<div class="card-3d-wrap mx-auto"
								style="margin-left: 20vw; width: 70vw; height: 80vh;">
								<div class="card-3d-wrapper">
									<div class="card-front">
										<div class="center-wrap">
											<div class="section text-center"
												style="position: relative; left: 15%;">
												<h1 class="mb-4 pb-3">회원가입</h1>

												<div class="form-group">
													<input type="text" placeholder="닉네임" class="form-style"
														name="nickname" required="required" autocomplete="off">
													<i class="input-icon uil uil-user"></i>
												</div>
												<div class="nickCheck box"></div>
												<div class="form-group mt-2">
													<input type="text" placeholder="아이디" name="id"
														class="form-style" autocomplete="off" required="required"><i
														class="input-icon uil uil-at"></i>
												</div>
												<div class="idCheck box"></div>
												<div class="form-group mt-2">
													<input required="required" type="password"
														placeholder="비밀번호" name="pw" class="form-style"> <i
														class="input-icon uil uil-lock-alt"></i>
												</div>
												<div class="form-group mt-2">
													<input required="required" type="password"
														placeholder="비밀번호 확인" name="pwc" class="form-style"><i
														class="input-icon uil uil-lock-alt"></i>
												</div>
												<div class="pwCheck box"></div>
												<div class="form-group mt-2">
													<input required="required" type="text"
														placeholder="나라사랑 이메일" maxlength="13" name="email" class="form-style"
														autocomplete="off" style="width: 33%;"><i
														class="input-icon uil uil-lock-alt"></i><span id="m">@narasarang.or.kr</span>
												</div>
												<div class="emailCheck box"></div>
												<div class="form-group mt-2">
													<input required="required" type="date" class="form-style"
														placeholder="입대일" name="enlisting" style="width: 30%">
													<select class="selectBox"
														style="margin-top: 5px; width: 20%; height: 5vh;"
														name="armygroup" required="required">
														<optgroup label="군종"></optgroup>
														<option value="earth">육군</option>
														<option value="sea">해군</option>
														<option value="fly">공군</option>
													</select> <input type="hidden" name="sns" value="${snsID}">
												</div>
												<div class="form-group mt-2">
													<button id="signup" class="btn"
														style="width: 60%; margin-top: 5px;">확인</button>
												</div>
												<div class="lastBox box"></div>

											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
</body>
</html>