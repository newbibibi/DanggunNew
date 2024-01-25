<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../includes/header.jsp" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
	<div id="banner-area" class="banner-area" style="background-color: rgb(50 137 76)">
  <div class="banner-text">
    <div class="container">
        <div class="row">
          <div class="col-lg-12">
              <div class="banner-heading">
                <h1 class="banner-title">공지사항</h1>
              </div>
          </div><!-- Col end -->
        </div><!-- Row end -->
    </div><!-- Container end -->
  </div><!-- Banner text end -->
</div><!-- Banner area end --> 
<section id="main-container" class="col-x">
   	
   			<button onclick="locate()">글작성</button>
   		
		<form id="searchForm notice-nav" action="/center/notice/noticeList" class="sg" name="type" method="get">
		    <label>
		        <input type="radio" class="category-radio" name="shuffle-filter" value="AA"  ${pageMaker.cri.type == '' || pageMaker.cri.type == 'AA' || pageMaker.cri.type == null? 'checked' : ''}> 전체
		    </label>
		    <label>
		        <input type="radio" class="category-radio" name="shuffle-filter" value="NN"  ${pageMaker.cri.type == 'NN' ? 'checked' : ''}> 공지
		    </label>
		    <label>
		        <input type="radio"  class="category-radio" name="shuffle-filter" value="FF" ${pageMaker.cri.type == 'FF' ? 'checked' : ''} > 점검
		    </label>
		</form>
		
		
		
			<div class="tableset">
				<div class="tableset-inner">
					<table class="tableset-table table table-hover">
						<tbody></tbody>
					</table>
				</div>
			</div>
      
		<div class="pagiset-ctrl pagiset-list">
			<ul class="pagination">
				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous"><a
						href="${pageMaker.startPage -1 }">이전</a></li>
				</c:if>
				<c:forEach var="num" begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }">
					<li
						class="paginate_button ${pageMaker.cri.pageNum ==num?'active':'' }">
						<a href="${num }">${num }</a>
					</li>
				</c:forEach>
				<c:if test="${pageMaker.next }">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage +1 }">다음</a></li>
				</c:if>
			</ul>
		</div>
		<form id="actionForm" action="/center/notice/noticeList" name="test"
			method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
			<input type="hidden" name="type" value="${pageMaker.cri.type }">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword }">
		</form>
	
</section>
	
	
	<script type="text/javascript">
	function locate() {
	    window.location.href = "/center/notice/noticeRegister";
	}
	 
	
	 
	$(document).ready(function() {
				
				loadTableData($("#actionForm").find(
				"input[name='type']").val())
				$("#actionForm input[name='pageNum']").val("1");
				
	            $(".category-radio").change(function () {
	                
	            	 var selectedValue = $("input[name='shuffle-filter']:checked").val();

	                 // searchForm의 값을 actionForm으로 복사
	                 $("#actionForm input[name='type']").val(selectedValue);

	                 // actionForm 전송
	                 $("#actionForm").submit();
	            	var selectedCategory = '';

	                if ($(this).val() === "AA") {
	                    selectedCategory = 'AA';
	                } else if ($(this).val() === "NN") {
	                    selectedCategory = 'NN';
	                } else if ($(this).val() === "FF") {
	                    selectedCategory = 'FF';
	                }
	               

	                console.log(selectedCategory);
	                loadTableData(selectedCategory);
	                
	                $(this).parent("label").addClass("active");
	               
	            	
	            });
	            

				function loadTableData(d) {
					$("input[name='shuffle-filter']:checked").parent("label").addClass("active");
					$.ajax({
						url : "/center/notice/noticeList",
						type : "POST",
						dataType : "json",
						data : {
							pageNum : $("#actionForm").find(
							"input[name='pageNum']").val(),
							amount : $("#actionForm").find(
									"input[name='amount']").val(),
							type: d,
						},
						success : function(data) {
							let boardTbody = $("tbody");
							boardTbody.empty();
							
							$.each(data, function(index, sale) {
								
								let regDate = new Date(sale.regDate);
			                    // numeric: 숫자 형식, 2-digit: 두자리 숫자 형식
			                    let options = {
			                        year: "numeric",
			                        month: "2-digit",
			                        day: "2-digit",
			                   
			                    };
								if(sale.category == "NN"){
									var cat = "공지"
								} else if (sale.category == "FF"){
									var cat = "점검"
								}
			                    let formatDate = regDate.toLocaleString("ko-KR", options);

								
								let row = $("<tr>").addClass("cut");
								let div = $("<div>").addClass("catn").text(cat);
								let category = $("<td>").addClass("short").append(div);
								let h5 = $("<h4>").text(sale.title)
								let title = $("<td>").append(h5);
		                        row.append(category);
								row.append(title)
								row.append($("<td>").addClass("short").text(formatDate));

								let url = "/center/notice/get?nno=" + sale.nno;

								row.click(function() {
								  window.location.href = url; 
								});
								
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
					
					$(".not").on(
							"click",
							function(e) {
								console.log(e);
								
							});
					
				}// loadTableData 함수 선언 종료
					
					$(document).on("click",function(e){
						console.log(e.target);
						
					})
			}); // $(document).ready 함수 선언 종료
			
	</script>
<%@ include file="../../includes/footer.jsp" %>