<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<div id="banner-area" class="banner-area" style="background-color: rgb(50 137 76)">
  <div class="banner-text">
    <div class="container">
        <div class="row">
          <div class="col-lg-12">
              <div class="banner-heading">
                <h1 class="banner-title">정보게시판</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb justify-content-center">
                      <li class="breadcrumb-item"><a href="/center/information/mealSchedule">식단표</a></li>
                      <li class="breadcrumb-item"><a href="/center/information/benefit">혜택</a></li>
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
   <h2>군인 혜택</h2>
   <c:if test="${empty user}">
		<script>
                    // 사용자가 비어 있으면 로그인 페이지로 자동 이동
                    window.location.href = "/login/login";
                </script>
             </c:if>
   <form id="searchForm" action="/center/information/benefit"
			method="get">
			<div class="">
				<select id="type" class="" name="type">
					<option value=""
						<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>전체</option>
					<option value="S"
						<c:out value="${pageMaker.cri.type == 'S'?'selected':''}"/>>서울</option>
					<option value="G"
						<c:out value="${pageMaker.cri.type == 'G'?'selected':''}"/>>경기</option>
					<option value="W"
						<c:out value="${pageMaker.cri.type == 'W'?'selected':''}"/>>강원</option>
					<option value="C"
						<c:out value="${pageMaker.cri.type == 'C'?'selected':''}"/>>충청</option>
					<option value="L"
						<c:out value="${pageMaker.cri.type == 'L'?'selected':''}"/>>전라</option>
					<option value="Y"
						<c:out value="${pageMaker.cri.type == 'Y'?'selected':''}"/>>경상</option>
					<option value="J"
						<c:out value="${pageMaker.cri.type == 'J'?'selected':''}"/>>제주</option>
				</select>
				<p style="color:rgb(50 137 76);float: right;">*초록색의 게시글은 프로모션상품이 존재하며 클릭 시 확인할 수 있습니다.</p>
			</div>
		</form>
		<table class="tableset-table table table-hover">
      			<colgroup>
      				<col>
      				<col>
      				<col>
      				<col>
      			</colgroup>
      			<thead class="thead-border-top">
      				<tr>	
	      				<th><span>지역</span></th>
						<th><span>혜택대상</span></th>
						<th><span>혜택종류</span></th>
						<th><span>혜택내용</span></th>
						<th><span>혜택시작일</span></th>
						<th><span>전화번호</span></th>
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
		<form id="actionForm" action="/center/information/benefit"
			method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="type" value="${pageMaker.cri.type }">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		</form>
   </div>
</section>

	<script type="text/javascript">
		$(document).ready(
				function() {
					loadTableData();
					console.log(result);

					function loadTableData() {
						$.ajax({
							url : "/center/information/getList",
							type : "POST",
							dataType : "json",
							data : {
								pageNum : $("#actionForm").find(
										"input[name='pageNum']").val(),
								amount : $("#actionForm").find(
										"input[name='amount']").val(),
								type : $("#type").val()
							},
							success: function(data) {
							    let boardTbody = $("tbody");
							    $.each(data, function(index, sale) {
							        let row = $("<tr>");
							        if (sale.homepage !== null && sale.homepage !== '') {
							            row.css({
							                "cursor": "pointer",
							                "color": "rgb(50 137 76)" // 연두색으로 글자색 변경
							            });
							            row.on("click", function() {
							                openPop(sale.homepage);
							            });
							        }
							        row.append($("<td>").text(sale.area));
							        row.append($("<td>").text(sale.item));
							        row.append($("<td>").text(sale.salename));
							        row.append($("<td>").text(sale.detail));
							        row.append($("<td>").text(sale.start));
							        row.append($("<td>").text(sale.phone));
							        boardTbody.append(row);
							    });
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
						


						function openPop(url) {
							var popup = window.open(url, '팝업창',
									'width=700px,height=800px');
						}

					}// loadTableData 함수 선언 종료
					
				}); // $(document).ready 함수 선언 종료
				$('#type').change(function() {
					$('#searchForm').submit();
				});
	</script>
<%@include file="../../includes/footer.jsp"%>