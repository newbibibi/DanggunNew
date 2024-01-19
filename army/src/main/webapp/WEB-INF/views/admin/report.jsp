<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 상대경로를 유일하게 쓰는 곳 -->
<%@include file="../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
.batch {
	display: flex;
	flex-direction: row;
	justify-content: space-evenly;
	align-content: center;
}
</style>
<div id="banner-area" class="banner-area"
	style="background-color: rgb(50, 137, 76)">
	<div class="banner-text">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="banner-heading">
						<nav class="batch" )>
							<div>
								<a href="javascript:report()">신고 확인</a>
							</div>
							<div>
								<a href="/?">유저 관리</a>
							</div>
							<div>
								<a href="/?">문의 확인</a>
							</div>
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


<section id="project-area" class="project-area solid-bg">
	<div class="container">
		<!--/ Title row end -->

		<div class="row">
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light text-center rounded p-4">
					<div class="table-responsive">
						<table id="viewer" border="1">

						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- Content row end -->
	</div>
	<!--/ Container end -->
</section>
<!-- Project area end -->

<script type="text/javascript">
$("document").ready(()=>{
	report(1);
});
function report(pageNum){
	
	$.ajax({
		  url: '../admin/reportList', // 요청을 보낼 서버의 URL을 입력하세요.
		  method: 'GET', // 요청 메서드를 선택하세요(GET, POST, 등).
		  data: {"pageNum":pageNum}, // 요청에 포함될 데이터를 객체 형태로 입력하세요.
		  success: function(data) {
		    console.log(data); // 응답 데이터를 출력하거나 원하는 작업을 수행하세요.
		    if(data.reportList==null){
		    	$("#viewer").append("<tr><td colspan='5'>비어있음</td></tr>");
		    }else{
		    $("#viewer").html("");
		    $("#viewer").append("<tr><td>종류</td><td>가해자 닉네임</td><td>"+"신고자 닉네임"+"</td><td>처벌 수위</td><td>실행</td></tr>");
		    for(let vo of data.reportList){
		    	if(vo.bno==0){
		    		$("#viewer").append("<tr><td>댓글</td><td>"+vo.nickname+"</td><td>"+"신고자 나중에"+"</td><td><select></select></td><td><a href=''>처리</a></td></tr>");
			    }else if(vo.cno==0){
			    	$("#viewer").append("<tr><td>게시글</td><td>"+vo.nickname+"</td><td>"+"신고자 나중에"+"</td><td><select></select></td><td><a href=''>처리</a></td></tr>");
				}else{
					console.log("실패");
			    }
		    }
		    let tr = $("<tr></tr>");
			let td = $("<td></td>");
			tr.append(td);
		    for(let i=1; i<data.pageMaker.endPage+1; i++){
		    	let pm=data.pageMaker;
		    	let p="";
		    	
		    	p+=pm.prev ? "<a href='javascript:report(${"+pm.startPage+"})'>이전</a>" : "";
		    	p+="<a href='javascript:report(${"+i+"})'>"+i+"</a>";
		    	p+=pm.next ? "<a href='javascript:report(${"+pm.endPage+"})'>다음</a>" : "";
		    	tr.append(p);
		    	$("#viewer").append(tr);
				   
	    	}
		    
		    }
		  },
		  error: function(xhr, status, error) {
		    console.log(error); // 에러 메시지를 출력하거나 에러 처리를 수행하세요.
		  }
		});

}

</script>

<%@include file="../includes/footer.jsp"%>
