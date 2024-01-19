<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 상대경로를 유일하게 쓰는 곳 -->
<%@include file="../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<section class="call-to-action-box no-padding">
	<div class="container">
		<div class="action-style-box">
			<div class="row align-items-center">
				<div class="col-md-8 text-center text-md-left">
					<div class="call-to-action-text">
						<h3 class="action-title">내 정보 수정</h3>
					</div>
				</div>
				<!-- Col end -->
				<div class="col-md-4 text-center text-md-right mt-3 mt-md-0">
					<div class="call-to-action-btn">
						<a class="btn btn-dark" href="#">바로 가기</a>
					</div>
				</div>
				<!-- col end -->
			</div>
			<!-- row end -->
		</div>
		<!-- Action style box -->
	</div>
	<!-- Container end -->
</section>
<!-- Action end -->
<!-- Feature are end -->



<section id="project-area" class="project-area solid-bg">
	<div class="container">
		<!--/ Title row end -->

		<div class="row">
			<div class="container-fluid pt-4 px-4">
				<div class="bg-light text-center rounded p-4">
					<div class="d-flex align-items-center justify-content-between mb-4">
						<h6 class="mb-0">
							<a href="javascript:report()">신고 확인</a>
						</h6>
					</div>
					<div class="d-flex align-items-center justify-content-between mb-4">
						<h6 class="mb-0">
							<a href="/?">유저 관리</a>
						</h6>
					</div>
					<div class="d-flex align-items-center justify-content-between mb-4">
						<h6 class="mb-0">
							<a href="/?">문의 확인</a>
						</h6>
					<c:if test="${empty pageMaker}">
						페이지메이커 비어있음
					</c:if>
					</div>
	
					<div class="table-responsive">
						<table id="viewer" border="1">
							<tr>
							
								<td><c:if test="${pageMaker.prev}">
										<a href="">이전</a>
									</c:if> 
									<c:forEach var="i" begin="${pageMaker.startPage}"
										end="${pageMakger.endPage}">
										<a href="javascript:report(${i})">${i}</a>
									</c:forEach> <c:if test="${pageMaker.next}">
										<a href="">다음</a>
									</c:if></td>
							</tr>
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
		    console.log("${pageMaker}");
		    $("#viewer").append("<tr><td>종류</td><td>가해자 닉네임</td><td>"+"신고자 닉네임"+"</td><td>처벌 수위</td><td>실행</td></tr>");
		    if(data==null){
		    	$("#viewer").append("<tr><td colspan='5'></td></tr>");
		    }else{
		    $("#viewer").html("");
		    for(let vo of data){
		    	if(vo.bno==0){
		    		$("#viewer").append("<tr><td>댓글</td><td>"+vo.nickname+"</td><td>"+"신고자 나중에"+"</td><td><select></select></td><td><a href=''>처리</a></td></tr>");
			    }else if(vo.cno==0){
			    	$("#viewer").append("<tr><td>게시글</td><td>"+vo.nickname+"</td><td>"+"신고자 나중에"+"</td><td><select></select></td><td><a href=''>처리</a></td></tr>");
				}else{
					console.log("실패");
			    }
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
