<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:if test="${user.admin != 1}">
		<script>
                    
                    window.location.href = "/login/main";
                </script>
             </c:if>
	<div id="banner-area" class="banner-area" style="background-color: rgb(50 137 76)">
  <div class="banner-text">
    <div class="container">
        <div class="row">
          <div class="col-lg-12">
              <div class="banner-heading">
                <h1 class="banner-title">관리자페이지</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb justify-content-center">
                      <li class="breadcrumb-item"><a href="/admin/userManage">유저관리</a></li>
                      <li class="breadcrumb-item"><a href="/admin/report">신고확인</a></li>
                      <li class="breadcrumb-item"><a href="/admin/adminFqna">고객문의</a></li>
                    </ol>
                </nav>
              </div>
          </div><!-- Col end -->
        </div><!-- Row end -->
    </div><!-- Container end -->
  </div><!-- Banner text end -->
</div><!-- Banner area end --> 
<section id="main-container" class="main-container">
   <div class="container">
<h2>고객문의사항</h2>
		<div class="shuffle-btn-group">
		<form id="searchForm" action="/admin/adminFqna" method="get">
			<select id="type" class="" name="type">
				<option value=""
					<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>전체</option>
				<option value="O"
					<c:out value="${pageMaker.cri.type == 'O'?'selected':''}"/>>해결</option>
				<option value="X"
					<c:out value="${pageMaker.cri.type == 'X'?'selected':''}"/>>미해결</option>
			</select>
		</form>
			
		</div>
	
<div class="tableset container-md">
      	<div class="tableset-inner">
      		<table class="tableset-table table table-hover">
      			<colgroup>
      				<col>
      				<col>
      				<col>
      				<col>
      			</colgroup>
      			<thead class="thead-border-top">
      				<tr>
      					<th class="#"><span>제목</span></th>
      					<th class="short"><span>작성자</span></th>
      					<th class="short"><span>답변유무</span></th>
      					<th class="short"><span>작성일</span></th>
      				</tr>
      			</thead>
      			<tbody>
      				
      			</tbody>
      		</table>
      		<nav class="pagiset pagiset-circ">
    
    <div class="pagiset-ctrl paginate_button">
    <c:if test="${pageMaker.prev }"><a class="fas fa-angle-left pagiset-link pagiset-prev" href="${pageMaker.startPage - 1 }"></a></c:if>
        
    </div>
    <div class="pagiset-list paginate_button ${pageMaker.cri.pageNum ==num?'active':'' }">
        <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
            <a class="pagiset-link ${pageMaker.cri.pageNum == num ? 'active-fill' : ''}" href="${num }">${num }</a>
        </c:forEach>
    </div>
    <div class="pagiset-ctrl paginate_button">
    <c:if test="${pageMaker.next }">
    <a class="fas fa-angle-right pagiset-link pagiset-next" href="${pageMaker.endPage + 1 }"></a>
    </c:if>
        
    </div>
    
</nav>

      	</div>
      </div>


   </div>
</section>
<form id="actionForm" action="/admin/adminFqna" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
		<input type="hidden" name="type" value="${pageMaker.cri.type }">
		<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		<input type="hidden" name="nickname"
			value="${pageMaker.cri.nickname }">
	</form>
	<script type="text/javascript">
		$(document).ready(
				function() {
					loadTableData();
					console.log(result);

					function loadTableData() {
						$.ajax({
							url : "/admin/adminFqnaList",
							type : "POST",
							dataType : "json",
							data : {
								pageNum : $("#actionForm").find(
										"input[name='pageNum']").val(),
								amount : $("#actionForm").find(
										"input[name='amount']").val(),
								type : $("#type").val()
							},
							success : function(data) {
								let boardTbody = $("tbody");
								if (data.length === 0) {
						            let boardThead = $("thead");
						            boardThead.empty();
						            boardThead.append("<tr><td>문의사항이 없습니다.</td></tr>");
						        }else{
								$.each(data, function(index, fqna) {
									let regDate = new Date(fqna.regDate);
									if (
					                        regDate.getDate() === currentDate.getDate() &&
					                        regDate.getMonth() === currentDate.getMonth() &&
					                        regDate.getFullYear() === currentDate.getFullYear()
					                    ) {
					                        // If the post was written today, show only hours and minutes
					                        options = {
					                            hour: "2-digit",
					                            minute: "2-digit"
					                        };
					                    } else {
					                        // If the post was not written today, show month and day
					                        options = {
					                            month: "2-digit",
					                            day: "2-digit"
					                        };
					                    }

					                    let formatDate = regDate.toLocaleString("ko-KR", options);
									let row = $("<tr>");
									let titleLink = $("<a>").attr("href","/admin/fqnaAnswer?qno="+fqna.qno).text(fqna.title);
									let titleTd = $("<td>").append(titleLink);
									row.append(titleTd);
									row.append($("<td>").text(fqna.nickname));
									if (fqna.answer === null) {
										row.append($("<td>").text("미답변"));
									} else {
										row.append($("<td>").text("답변"));
									}
									row.append($("<td>").text(formatDate));
									boardTbody.append(row);
								});
								}
							},
							error : function(e) {
								console.log(e);
							}
						});

						let actionForm = $("#actionForm");
						$(".paginate_button a").on(
								"click",
								function(e) {
									e.preventDefault();
									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));
									actionForm.submit();
								});

					}// loadTableData 함수 선언 종료

				}); // $(document).ready 함수 선언 종료
		$('#type').change(function() {
			$('#searchForm').submit();
		});
	</script>
<%@include file="../includes/footer.jsp"%>