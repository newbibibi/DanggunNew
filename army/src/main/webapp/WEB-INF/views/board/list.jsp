<%@page import="org.spring.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
// Check if the userVO is present in the session and contains a non-empty nickname
UserVO userVO = null;
userVO = (UserVO) session.getAttribute("user");
String nickname = null;
if (userVO == null || userVO.getNickname() == null || userVO.getNickname().isEmpty()) {
	// Log the details for debugging
	response.sendRedirect("/login/login"); // Redirect to the login page if userVO or nickname is not present
}else{
	nickname = userVO.getNickname();
}
%>
<!-- 테이블 -->
<style>
    .tableset-table td {
        max-width: 100px; /* 원하는 최대 너비로 설정 */
        overflow: hidden;
        text-overflow: ellipsis; /* 텍스트가 너무 길 때 "..."을 붙입니다 */
        white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 설정합니다 */
    }
</style>
<div id="banner-area" class="banner-area"
	style="background-color: rgb(50, 137, 76)">
	<div class="banner-text">
		<div class="container">
			<div class="row">
				<div class="col-lg-12">
					<div class="banner-heading">
						<h1 class="banner-title">커뮤니티</h1>
						<nav aria-label="breadcrumb">
							<ol class="breadcrumb justify-content-center">
								<li class="breadcrumb-item"><a
									href="/board/list?category=best">BEST</a></li>
								<li class="breadcrumb-item"><a
									href="/board/list?category=ssul">썰</a></li>
								<li class="breadcrumb-item"><a
									href="/board/list?category=tip">팁</a></li>
								<li class="breadcrumb-item"><a
									href="/board/list?category=free">자유</a></li>
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
<!-- Banner area end -->


<section id="main-container" class="main-container">
	<div class="container">
		<h2>${pageMaker.cri.category} 게시판</h2>
		

		<form id="searchForm" action="/board/list" method="get">
			<div class="form-group col-xs-4">
				<select id="type" class="form-control formcol" name="type" style="float: left;">
					<option value="All"
						<c:out value="${pageMaker.cri.type == 'All'?'selected':''}"/>>전체</option>
					<option value="title"
						<c:out value="${pageMaker.cri.type == 'title'?'selected':''}"/>>제목</option>
					<option value="content"
						<c:out value="${pageMaker.cri.type == 'content'?'selected':''}"/>>내용</option>
					<option value="nickname"
						<c:out value="${pageMaker.cri.type == 'nickname'?'selected':''}"/>>작성자</option>
					<option value="TC"
						<c:out value="${pageMaker.cri.type == 'TC'?'selected':''}"/>>제목+내용</option>

				</select> <select id="category" class="form-control" name="category"
					style="display: none;">
					<option value="best"
						<c:out value="${pageMaker.cri.category == 'best'?'selected':''}"/>>베스트</option>
					<option value="ssul"
						<c:out value="${pageMaker.cri.category == 'ssul'?'selected':''}"/>>썰</option>
					<option value="tip"
						<c:out value="${pageMaker.cri.category == 'tip'?'selected':''}"/>>팁</option>
					<option value="free"
						<c:out value="${pageMaker.cri.category == 'free'?'selected':''}"/>>자유</option>
				</select>
				<div class="col-xs-6" style="float: right; padding-top: 13px;">
				<div class="form-group input-group">
					<input type='text' name='keyword'
						value='<c:out value="${pageMaker.cri.keyword}"/>' /> <input
						type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
					<input type="hidden" name="amount" value="${pageMaker.cri.amount }">

					<span class="input-group-btn">
						<button class="btn btn-default">검색</button>
					</span>
				</div>
			</div>
			
			</div>
		</form>
		<table id="boardTable" class="tableset-table table table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>추천수</th>

				</tr>
			</thead>
			<tbody>


			</tbody>
			
		</table>
		<button id="regBtn" type="button" style="float: right;">글 작성</button>
		<nav class="pagiset pagiset-circ">
			<div class="pagiset-ctrl paginate_button">
				<c:if test="${pageMaker.prev }">
					<a class="fas fa-angle-left pagiset-link pagiset-prev"
						href="${pageMaker.startPage - 1 }"></a>
				</c:if>

			</div>
			<div
				class="pagiset-list paginate_button ${pageMaker.cri.pageNum ==num?'active':'' }">
				<c:forEach var="num" begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }">
					<a
						class="pagiset-link ${pageMaker.cri.pageNum == num ? 'active-fill' : ''}"
						href="${num }">${num }</a>
				</c:forEach>
			</div>
			<div class="pagiset-ctrl paginate_button">
				<c:if test="${pageMaker.next }">
					<a class="fas fa-angle-right pagiset-link pagiset-next"
						href="${pageMaker.endPage + 1 }"></a>
				</c:if>

			</div>

			<form id="actionFrom" action="/board/list" method="get">
				<input type="hidden" name="pageNum"
					value="${pageMaker.cri.pageNum }"> <input type="hidden"
					name="amount" value="${pageMaker.cri.amount }"> <input
					type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
				<input type="hidden" name="type" value="${pageMaker.cri.type }">
				<input type="hidden" name="category"
					value="${pageMaker.cri.category }">
			</form>
		</nav>
	</div>

</section>


<script type="text/javascript">
	$(document)
			.ready(
					function() {

						loadTableData(); // Ajax 함수 호출

						let result = '${result}';
						console.log(result);

						checkModal(result);

						function checkModal(result) {
							if (result === '') {
								return;
							}

							if (result === "success") {
								$(".modal-body").html("정상적으로 처리 되었습니다.");
							} else if (parseInt(result) > 0) {
								$(".modal-body").html(
										parseInt(result) + "번 글이 등록 되었습니다.");
							}

							$("#myModal").modal("show");
						}

						$("#regBtn").click(function() {
						    var form = $('<form action="/board/register" method="post"></form>');
						    var categoryValue = $('#category').val();
						    form.append('<input type="hidden" name="nickname" value="<%=nickname %>">'); // 닉네임 추가
						    form.append('<input type="hidden" name="categoryval" value="' + categoryValue + '">');
						    $('body').append(form);
						    form.submit();
						});

						function loadTableData() {
						    $.ajax({
						        url: "/board/getList",
						        type: "POST",
						        dataType: "json",
						        data: {
						            pageNum: $("#actionFrom input[name='pageNum']").val(),
						            amount: $("#actionFrom input[name='amount']").val(),
						            type: $("#searchForm select[name='type']").val(),
						            keyword: $("#searchForm input[name='keyword']").val(),
						            category: $("#searchForm select[name='category']").val()
						        },
						        success: function (data) {
						        	 let boardTable = $("#boardTable");
						             let boardTbody = boardTable.find("tbody");
						             let boardThead = boardTable.find("thead");

						             boardTbody.empty(); // Clear the table body before adding new data
						             boardThead.empty(); // Clear the table header before adding new data

						             // Check if the selected category is "베스트"
						             let selectedCategory = $("#searchForm select[name='category']").val();
						             let isBestCategory = (selectedCategory === "best");

						             // Create the table header based on the category
						             let theadContent = '<tr><th>번호</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th><th>추천수</th>';

						             if (isBestCategory) {
						                 theadContent = '<tr><th>번호</th><th>카테고리</th><th>제목</th><th>작성자</th><th>작성일</th><th>조회수</th><th>추천수</th>';
						             }

						             theadContent += '</tr>';
						             boardThead.append(theadContent);
						           

						            $.each(data, function (index, list) {
						                var displayName = list.anonymous == 1 ? '익명' : list.nickname;
						                let regDate = new Date(list.regDate);
						                console.log(regDate);

						                let currentDate = new Date();
						                let options;

						                if (
						                    regDate.getDate() === currentDate.getDate() &&
						                    regDate.getMonth() === currentDate.getMonth() &&
						                    regDate.getFullYear() === currentDate.getFullYear()
						                ) {
						                    // 글이 오늘 쓰였으면 시간과 분만 표시
						                    options = {
						                        hour: "2-digit",
						                        minute: "2-digit"
						                    };
						                } else {
						                    // 글이 오늘 쓰이지 않았으면 월과 일 표시
						                    options = {
						                        month: "2-digit",
						                        day: "2-digit"
						                    };
						                }

						                let formatDate = regDate.toLocaleString("ko-KR", options);

						                let row = $("<tr>");
						                row.append($("<td>").text(list.bno));

						                let titleLink = $("<a>")
						                    .attr("href", "/board/view/" + list.bno)
						                    .text(list.title + '[' + list.commentCnt + ']');
						                let titleTd = $("<td>").append(titleLink);
						             // 데이터에 카테고리가 포함되어 있는지 확인
						                if (isBestCategory) {
						                    row.append($("<td>").text(list.category));
						                }
						                row.append(titleTd);
						                row.append($("<td>").text(displayName));
						                row.append($("<td>").text(formatDate));
						                row.append($("<td>").text(list.views));
						                row.append($("<td>").text(list.likes));

						                

						                boardTbody.append(row);
						            });
						        },
						        error: function (e) {
						            console.log(e);
						        }
						    });
						}



						let actionForm = $("#actionFrom");
						$(".paginate_button a").on(
								"click",
								function(e) {
									e.preventDefault();
									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));
									actionForm.submit();
								});

						let searchForm = $("#searchForm");

						$("#searchForm button").on("click", function(e) {
							if (!searchForm.find("option:selected").val()) {
								alert("검색종류를 선택하세요");
								return false;
							}

							searchForm.find("input[name='pageNum']").val("1");
							e.preventDefault();
							searchForm.submit();
						});
					});
</script>

</body>
</html>
<%@include file="../includes/footer.jsp"%>