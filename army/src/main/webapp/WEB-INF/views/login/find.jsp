<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/login.css">
<link rel="icon" href="/resources/images/favicon.png"
	type="image/x-icon">
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css">
<style type="text/css">


.btn1 {
	box-sizing: border-box;
	appearance: none;
	background-color: transparent;
	border: 2px solid #e74c3c;
	border-radius: 0.6em;
	color: #e74c3c;
	cursor: pointer;
	display: flex;
	justify-content: center; align-self : center;
	font-size: 0.8em;
	font-weight: 400;
	line-height: 1;
	padding: 1.2em 2.8em;
	text-decoration: none;
	text-align: center;
	text-transform: uppercase;
	font-family: 'Montserrat', sans-serif;
	font-weight: 700;
	align-self: center;
}

.btn1:hover, .btn1:focus {
	color: #fff;
	outline: 0;
}

.fifth {
	border-color: #8e44ad;
	border-radius: 0;
	color: #8e44ad;
	position: relative;
	overflow: hidden;
	z-index: 1;
	transition: color 150ms ease-in-out;
}

.fifth:after {
	content: '';
	position: absolute;
	display: block;
	top: 0;
	left: 50%;
	transform: translateX(-50%);
	width: 0;
	height: 100%;
	background: #8e44ad;
	z-index: -1;
	transition: width 150ms ease-in-out;
}

.fifth:hover {
	color: #fff;
}

.fifth:hover:after {
	width: 110%;
}

.fifth1 {
	border-color: green;
	border-radius: 0;
	color: green;
	position: relative;
	overflow: hidden;
	z-index: 1;
	transition: color 150ms ease-in-out;
}

.fifth1:after {
	content: '';
	position: absolute;
	display: block;
	top: 0;
	left: 50%;
	transform: translateX(-50%);
	width: 0;
	height: 100%;
	background: green;
	z-index: -1;
	transition: width 150ms ease-in-out;
}

.fifth1:hover {
	color: #fff;
}

.fifth1:hover:after {
	width: 110%;
}

body {
	height: 100%;
}

.container {
	height: 100%;
}

.content {
	height: 100%;
	width:100%;
	display: flex;
	flex-direction:column;
	align-items: start;
	position: relative;
	top: 25vh;
}

::placeholder { /* Modern browsers */
  text-align: center;
  font-size: 0.8em;
}

.wrap{
	display: flex;
	flex-direction: column;
	width: 100%;
}
#result{
	font-weight: bolder;
}
h1 {
	color:green;
	font-weight: bolder;
}

.con{
	width: 100%;
	height: 100%;
	display: flex;
}
</style>
<title>계정 찾기</title>
</head>
<body>
	<!-- 모든걸 감쌈 -->
	<div class="container">
		<!-- 가운데 정렬해서 위치시킬 박스 -->
		<div class="idpw">
			<a class="fifth1 btn1" id="idf" style="width: 28vw">ID 찾기</a> <a
				class="fifth btn1" id="pwf" style="width: 28vw">PW 찾기</a>
		</div>
		<!-- 아이디 찾기를 눌렀을 때 표시할 것 -->
		<div class="content">
				<h1 class="mb-4 pb-3">아이디 찾기</h1>
				<div class="wrap">
				<div class="con">
				<input type=text name=email class='form-control' required=required
					placeholder='나라사랑 email 입력.' autocomplete='off'
					style='width: 40%; height: 10%; padding-left: 5px;'> <span style="font-size:1.3em; font-weight:300;">@narasarang.or.kr</span><i
					class='input-icon uil uil-at'></i>&nbsp; <input id="idfinder"
					class='btn btn-outline-primary' type="button" style="height: 11vh;" value="확인">
					</div>
				</div>
				<div id="result" style="color: red;"></div>
		</div>
	</div>
	<!-- 종료 -->

	<script type="text/javascript">

	let content = $(".content");
	let ec;
    let checker=false;
    $("body").on("click", "#idf", () => {
        $("#idf").addClass("fifth1");
        $("#pwf").removeClass("fifth1");
        $("#pwf").addClass("fifth");
    	content.html("");
        content.html("<h1 class='mb-4 pb-3'>아이디 찾기</h1><div class='wrap'><div class='con'><input type=text name=email class='form-control' required=required placeholder='나라사랑 email 입력.' autocomplete='off' style='width: 40%; height: 10%; padding-left: 5px; : red;'> <span style='font-size:1.3em; font-weight:400;'>@narasarang.or.kr</span><i class='input-icon uil uil-at'></i>&nbsp; <input id='idfinder' class='btn btn-outline-primary' type='button' style='height: 11vh;' value='확인'><div></div>");
    	$(".con:last").after("<div id='result' style=color:red></div>");
    });
    $("body").on("click", "#pwf", () => {
    	$("#idf").addClass("fifth");
    	$("#idf").removeClass("fifth1");
    	$("#pwf").addClass("fifth1");
    	content.html("");
        content.html("<h1 class='mb-4 pb-3'>비밀번호 찾기</h1><div class='wrap'><div class='con'><input type='text' name='id' class='form-control' required='required' placeholder='ID 입력' autocomplete='off' style='width:40%; height:10%; padding-left:5px;'><i class='input-icon uil uil-at'></i>&nbsp<input type='button' id='pwfinder' class='btn btn-outline-primary' style='height: 11vh;' value='확인'></div></div>");
        $(".con:last").after("<div id='result' style=color:red></div>");
    });


    $("body").on("click", "#idfinder", () => {
    	console.log("email val"+$("[name=email]").val());
    	$.ajax({
            url: '../../login/checker',
            method: 'POST',
            data: {
                checkValue: $("[name=email]").val()+"@narasarang.or.kr",
                checkColumn: "email"
            },
            success: function(data) {
                console.log(data);
 				if(data==""){
 					$("#result").css("color","red");
 					$("#result").html("<p>해당 Email로 등록된 아이디가 존재하지 않습니다.</p>");
                }else{
                	$("#result").css("color","green");
                	$("#result").html("<p>ID는 "+'"'+data.id+'"'+"입니다.</p>");
                }
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
    });
    let limiter;
    let id;
    $("body").on("click","#pwfinder", () => {
    	
        $("#result").text("로딩 중..")
    	$.ajax({
            url: '../../login/checker',
            method: 'POST',
            data: {
                checkValue: $("[name=id]").val(),
                checkColumn: "id"
            },
            success: function(data) {
            	if(data!=""){
            		$.ajax({
        				url : '../../login/emailauth',
        				method : 'POST',
        				data : {
        					email : data.email
        				},
        				success : function(email) {
        			    	$("#code").remove();
        			        $("#codecheck").remove();
        			        $("#timeout").remove();
        			        $("#result").remove();
        			        $(".con:last").after("<div id='result' style=color:red></div>");
        					if (email.includes("나라사랑")||email.includes("유효")) {
        						$("#result").html(email);
        					}
        					else {
        						id=data.id;
        						ec=email;
        						console.log(ec);
        						
        						$("#result").html("");
        						$(".wrap").append("<div class='con' style='width:100%; display:flex; flex-direction:columun;'><input class='form-control' style='width:40%; height:10%; padding-left:5px;' type='text' id='code' placeholder='인증 코드를 입력해주세요.'>&nbsp;<input type='button' class='btn btn-outline-primary' style='height:11vh;' id='codecheck' value='인증'></div>");
        						$(".move").after("<div id='timeout'></div>");
        						let timer = 180;
        	                    clearInterval(limiter);
        	                    limiter = setInterval(() => {
        	                        timer -= 1;
        	                        $("#timeout").html(Math.floor(timer / 60) + "분 " + (timer % 60) + "초");
        	                        if (timer == 0) {
        	                            ec="";
        	                        	clearInterval(limiter);
        	                        }
        	                    }, 1000);
        					}
        				},
        				error : function(xhr, status, error) {
        					$(".con:last").after("<div id='result' style=color:red></div>");
        					console.error(error);
        				}
        			}); //ajax 종료
            	}else{
            		 $("#result").html("<p>ID가 존재하지 않습니다.</p>");
            	}
            },
            error: function(xhr, status, error) {
                console.error(error);
            }
        });
        
        
     
        });
        //이 아래는 인증코드 if문으로 분기
         $("body").on("click","#codecheck",()=>{
        	 console.log(ec);
        	 $("#result").remove();
		        $(".con:last").after("<div id='result' style=color:red></div>");
        	if($("#code").val()==ec){
        		console.log("인증 성공");
        		$('.idpw').html("<h1>비밀번호 수정</h1>");
        		content.html("<div class='wrap'><input type='password' id='pw' placeholder='변경할 비밀번호 입력' class='form-control' style='width:60%; height:10%; padding-left:5px;'><input type='password' id='pwc' placeholder='비밀번호 확인' class='form-control' style='width:60%; height:10%; padding-left:5px;'><input type='button' class='btn btn-outline-primary' style='width:25%; height:20vh; position:relative; top:-21vh; left:60vw;' id='modify' value='변경하기'><br><div id='pwBox' style='margin-top:-15vh'></div>");
        	}else{
        		$("#result").html("인증코드가 일치하지 않습니다.");
        	}
        });
        
         $("body").on("click", "#modify", () => {
        	    if (checker) {
        	        let pw = { "pw": $("#pw").val(), "id":id};
        	        console.log(pw);
        	        $.ajax({
        	            url: '../../login/modify',
        	            method: 'POST',
        	            contentType: "application/json",
        	            data: JSON.stringify(pw),
        	            success: function (data) {
        	                console.log(data);
        	                if(data==1){
        	                	alert("비밀번호 변경이 정상적으로 완료되었습니다.");
        	                	window.parent.modalClose();
        	                }else if(data==0){
        	                	alert("아이디가 없거나 변경 불가능한 비밀번호입니다.");
        	                	window.parent.modalClose();
        	               	}else{
        	               		alert("치명적인 에러 관리자에게 문의해주세요.");
        	               		window.parent.modalClose();
        	               	}
        	                
        	                
        	            },
        	            error: function (e) {
        	                console.log(e);
        	            }
        	        });
        	        id="";
        	        pw = "";
        	    }
        	});
        
		$("body").on("blur","#pwc", function() {
			let pwRegex=/^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d\S]{8,20}$/;
			let pw=$("#pw");
			let pwc=$("#pwc");
			$("#pwBox").css("color","red");
			if(pwRegex.test(pw.val())){
			if (pw.val() == null || pw.val() == "") {
				pw.focus();
				$("#pwBox").text("비밀번호를 먼저 입력하세요.");
				pw.css("border-color","red");
				pwc.css("border-color","red");
				
			} else {
				if (pwc.val() != pw.val()) {
					pw.css("border-color","red");
					pwc.css("border-color","red");
					$("#pwBox").text("비밀번호가 일치하지 않습니다.");
					pw.focus();
					checker = false;
				} else {
					pw.css("border-color","green");
					pwc.css("border-color","green");
					$("#pwBox").html("");
					checker = true;
				}
			}
			}else{
				pw.css("border-color","red");
				pwc.css("border-color","red");
				$("#pwBox").text("비밀번호는 8자 이상, 20자 이하 (대/소문자)/숫자가 최소 1개 이상 포함되어야 합니다.");
			}
			});
		
   		 $("body").on("blur","#pw", function() {
   			let pw=$("#pw");
   			let pwRegex=/^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d\S]{8,20}$/;
   			if(pwRegex.test(pw.val())){
   				
   			}else{
   				checker = false;
				pw.css("border-color","red");
				pwc.css("border-color","red");
   				$("#pwBox").css("color","red");
				$("#pwBox").text("비밀번호는 8자 이상, 20자 이하 (대/소문자)/숫자가 최소 1개 이상 포함되어야 합니다.");
			}
			$("#pwBox").html("");
		});

</script>

</body>
</html>