<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/resources/css/login.css">
<meta charset="UTF-8">
<style>
	.idpw{
		display: flex;
		flex-direction: row;
		justify-content: space-around;
		padding-top: 10px;
	}
	
	
</style>
<title>계정 찾기</title>
</head>
<body>
	<div class="card-front">
		<!-- 모든걸 감쌈 -->
		<div class="card-3d-wrapper">
			<!-- 가운데 정렬해서 위치시킬 박스 -->
			<div class="idpw">
				<a class="btn" id="idf" style="width:30%;">ID 찾기</a>
				<a class="btn" id="pwf" style="width:30%;">PW 찾기</a>
			</div>
			<!-- 아이디 찾기를 눌렀을 때 표시할 것 -->
			<div class="content">
				<div>
				    <div class="center-wrap">
                    <div class="section text-center">
                      <h4 class="mb-4 pb-3">아이디 찾기</h4>
                      <div class="form-group" style="display:inline-block;">
                        <input type=text name=email class='form-style' required=required placeholder='나라사랑 email 입력.' autocomplete='off' style='width:32%; height:10%; padding-left:5px; : red;'>@narasarang.or.kr<i class='input-icon uil uil-at'></i>
                       <input
						id="idfinder" class='btn' type="button" value="확인">
                      </div>  

					<div id="result" style="color:red;"></div>
                        </div>
                      </div>
                    </div>
				</div>
			</div>
			<!-- 종료 -->
		</div>

	<script type="text/javascript">
window.onload = function() {
    let content = $(".content");
    let ec;
    let checker=false;
	
  	$("body").on("focus","[type='text']",function(){
  		$("[type='text']").css("caretColor","red");
  	});
    
    $("body").on("click", "#idf", () => {
    	$("#idf").css("background-color","#102770");
    	$("#idf").css("color","#ffeba7");
    	$("#pwf").css("background-color","#ffeba7");
    	$("#pwf").css("color","#102770");
        content.html("<div class='center-wrap'><div class='section text-center'><h4 class='mb-4 pb-3'>아이디 찾기</h4><div class='form-group'><input type=text name=email class='form-style' required=required placeholder='나라사랑 email 입력.' autocomplete='off' style='width:30%; height:10%; padding-left:5px;'>@narasarang.or.kr&nbsp<i class='input-icon uil uil-at'></i><input id='idfinder' class='btn' type='button' value='확인'></div><div id='result' style='color:red;'></div></div></div></div>");
    });

    $("body").on("click", "#pwf", () => {
    	$("#idf").css("background-color","#ffeba7");
    	$("#idf").css("color","#102770");
    	$("#pwf").css("background-color","#102770");
    	$("#pwf").css("color","#ffeba7");
        content.html("<div class='center-wrap'><div class='section text-center'><h4 class='mb-4 pb-3'>비밀번호 찾기</h4><div class='form-group'><input type='text' name='id' class='form-style' required='required' placeholder='ID 입력' autocomplete='off' style='width:30%; height:10%; padding-left:5px;'><i class='input-icon uil uil-at'></i>&nbsp<input type='button' id='pwfinder' class='btn' value='확인'></div><div id='result' style=color:red></div></div>");
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
            		console.log(data.email);
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
        					if (email.includes("나라사랑")||email.includes("유효")) {
        						$("#result").html(email);
        					}
        					else {
        						id=data.id;
        						ec=email;
        						$("#result").html("");
        						$("#pwfinder").after("<br><input class='form-style' style='width:30%; height:10%; padding-left:5px;' type='text' id='code' placeholder='인증 코드를 입력해주세요.'>&nbsp;<input type='button' class='btn' id='codecheck' value='인증'><div id='timeout'></div>");
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
        	if($("#code").val()==ec){
        		console.log("인증 성공");
        		$('.idpw').html("<h1>비밀번호 수정</h1>");
        		content.html("<div class='section text-center'><div class='form-group' style='left:25%; width:50%;'><input type='password' id='pw' placeholder='변경할 비밀번호 입력' class='form-style' style='width:60%; height:10%; padding-left:5px;'><input type='button' style='width:25%; height:25vh; float:right;' class='btn' id='modify' value='변경하기'><br><input type='password' id='pwc' placeholder='비밀번호 확인' class='form-style' style='width:60%; height:10%; padding-left:5px;'><br><div id='pwBox'></div></div>");
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
			let pw=$("#pw");
			let pwc=$("#pwc");
			if (pw.val() == null || pw.val() == "") {
				pw.focus();
				$("#pwBox").text("비밀번호를 먼저 입력하세요.");
				$("#pwBox").css("color","red");
				
			} else {
				if (pwc.val() != pw.val()) {
					pw.css("border", "2px solid red");
					pwc.css("border", "2px solid red");
					$("#pwBox").text("비밀번호가 일치하지 않습니다.");
					pw.focus();
					checker = false;
				} else {
					pw.css("border", "2px solid green");
					pwc.css("border", "2px solid green");
					$("#pwBox").html("");
					checker = true;
				}
			}
		});
		
   		 $("body").on("blur","#pw", function() {
			$("#pwBox").html("");
		});
}
</script>

</body>
</html>