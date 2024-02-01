<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../../includes/header.jsp" %>
		
			<form id="form" class="container" action="/user/myCalendar/scheduleRegister" method="post">
				<input type="hidden" name="calNo" value="${vo.calNo }">
				<input type="hidden" name="nickname" value="${vo.nickname }">
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
