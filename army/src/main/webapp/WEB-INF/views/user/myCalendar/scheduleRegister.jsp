<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../includes/header.jsp" %>
		
			 <div id="banner-area" class="banner-area"
	style="background-color: rgb(50, 137, 76)">
	<div class="banner-text">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="banner-heading">
						<h1 class="banner-title">내 일 정</h1>
						<nav aria-label="breadcrumb">
							<ol class="breadcrumb justify-content-center">
								<li class="breadcrumb-item"><a href="/user/myModify">내 정보 수정</a></li>
								<li class="breadcrumb-item"><a href="/user/myCalendar/mySchedule">내 일 정</a></li>
								<li class="breadcrumb-item"><a href="/center/cscenter/fqna">내 문 의</a></li>
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
			<form id="form" class="container" style="width:40%;height:50vh;padding-top:10%" action="/user/myCalendar/scheduleRegister" method="post">
				<input type="hidden" name="nickname" value="${user.nickname }">
				<div class="calc">
				<input name="content" placeholder="제목 입력"  value="${vo.content }" >
				</div>
				<div class="cald">
				<input type="date" name="startDate" id="sd" value="${vo.startDate }" required>
				<strong style="text-align:center">~</strong>
				<input type="date" style="float:right" name="endDate" id="ed" value="${vo.endDate }" required>
				</div>
				<div class="calb">
				<button class="btn btn-primary" type="button" data-oper="out">취소</button>
				<button class="btn btn-primary" id="create" style="float:right" type="submit" data-oper="create">생성</button>
				</div>
			</form>
</body>
<script type="text/javascript">
$(document).ready(function() {
	
	let formObj = $("form");
	
		$(".btn").click(function() {
			let operation = $(this).data("oper");
			console.log(operation);
			
			if(operation == "out"){
				window.location.href = "/user/myCalendar/mySchedule"
			}
		});
	});
window.addEventListener('keyup', e => {
    var key = e.keyCode;

    switch (key) {
      case 13:
        
        	document.getElementById('create').click();

        break;
    }
  });
	</script>
<%@ include file="../../includes/footer.jsp" %>	
