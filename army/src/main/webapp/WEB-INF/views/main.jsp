<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 상대경로를 유일하게 쓰는 곳 -->
<%@include file="includes/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:if test="${empty user}">
		<script>
                    // 사용자가 비어 있으면 로그인 페이지로 자동 이동
                    window.location.href = "/login/login";
                </script>
             </c:if>
<div class="banner-carousel banner-carousel-1 mb-0">
  <div class="banner-carousel-item" style="background-image:url(../../../resources/images/slider-main/movie.png)">
    <div class="slider-content text-right">
        <div class="container h-100">
          <div class="row align-items-center h-100">
              <div class="col-md-12">
                <h2 class="slide-title" data-animation-in="slideInDown">군 할인 혜택</h2>
                <h3 class="slide-sub-title" data-animation-in="fadeIn">영화관 할인혜택</h3>
                <p class="slider-description lead" data-animation-in="slideInRight">현역 병사라면 누구나!</p>
                <div data-animation-in="slideInLeft">
                    
                    <a href="/center/information/benefit" class="slider btn btn-primary border" aria-label="learn-more-about-us">확인하기</a>
                </div>
              </div>
          </div>
        </div>
    </div>
  </div>

  <div class="banner-carousel-item" style="background-image:url(../../../resources/images/slider-main/국군.png)">
    <div class="slider-content">
        <div class="container h-100">
          <div class="row align-items-center h-100">
              <div class="col-md-12 text-center">
                <h2 class="slide-title" data-animation-in="slideInLeft">국군의 날</h2>
                <h3 class="slide-sub-title" data-animation-in="slideInRight">군 장병 할인 혜택</h3>
                <p data-animation-in="slideInLeft" data-duration-in="1.2">
                    
                    <a href="/center/information/benefit" class="slider btn btn-primary border">자세히 보기</a>
                </p>
              </div>
          </div>
        </div>
    </div>
  </div>

  <div class="banner-carousel-item" style="background-image:url(../../../resources/images/slider-main/할인23.png)">
    <div class="slider-content text-left">
        <div class="container h-100">
          <div class="row align-items-center h-100">
              <div class="col-md-12">
                <h2 class="slide-title-box" data-animation-in="slideInDown">군 할인 혜택</h2>
                <h3 class="slide-title" data-animation-in="fadeIn">현역 병사라면 누구나</h3>
                <h3 class="slide-sub-title" data-animation-in="slideInLeft">군 장병 할인 혜택</h3>
                <p data-animation-in="slideInRight">
                    <a href="/center/information/benefit" class="slider btn btn-primary border">자세히 보기</a>
                </p>
              </div>
          </div>
        </div>
    </div>
  </div>

  
</div>

<section class="call-to-action-box no-padding">
  <div class="container">
    <div class="action-style-box">
        <div class="row align-items-center">
          <div class="col-md-8 text-center text-md-left">
              <div class="call-to-action-text">
                <h3 class="action-title">모두가 함께쓰는 커뮤니티 게시판</h3>
              </div>
          </div><!-- Col end -->
          <div class="col-md-4 text-center text-md-right mt-3 mt-md-0">
              <div class="call-to-action-btn">
                <a class="btn btn-dark" href="/board/list">바로 가기</a>
              </div>
          </div><!-- col end -->
        </div><!-- row end -->
    </div><!-- Action style box -->
  </div><!-- Container end -->
</section><!-- Action end -->

  <div class="container">
  <div class="text-center rounded p-4 ">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">맞춤 혜택(관심지역:
                        <c:if test="${user.region == null}">없음)</c:if>
                        <c:if test="${user.region == 'S'}">서울)</c:if>
                        <c:if test="${user.region == 'G'}">경기도)</c:if>
                        <c:if test="${user.region == 'W'}">강원도)</c:if>
                        <c:if test="${user.region == 'C'}">충청도)</c:if>
                        <c:if test="${user.region == 'L'}">전라도)</c:if>
                        <c:if test="${user.region == 'Y'}">경상도)</c:if>
                        <c:if test="${user.region == 'J'}">제주도)</c:if>
                        </h6>
                        <a href="/center/information/benefit">더 보기</a>
                    </div>
                    <div class="table-responsive">
                        <table id="mainbenefit" class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col" class="short">지역</th>
                                    <th scope="col">혜택목록</th>
                                    <th scope="col" class="short">혜택내용</th>
                                    <th scope="col" class="short">전화번호</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                        
                    </div>
                </div>
  </div>
        </div><!-- Col end -->
	<section id="news" class="news">
  <div class="container">
    <div class="row text-center">
        <div class="col-12">
          <h2 class="section-title">your army</h2>
          <h3 class="section-sub-title">Utility Services</h3>
        </div>
    </div>
    <!--/ Title row end -->

    <div class="row">
        <div class="col-lg-4 col-md-6 mb-4">
          <div class="latest-post">
              <div class="latest-post-media">
                <a href="/user/myCalendar/mySchedule" class="latest-post-img">
                    <img loading="lazy" class="img-fluid" src="../../../resources/images/news/calendar.PNG" alt="img">
                </a>
              </div>
              <div class="post-body">
                <h4 class="post-title">
                    <a href="/user/myCalendar/mySchedule" class="d-inline-block">오늘의 일정 확인하기</a>
                </h4>
                <div class="latest-post-meta">
                    <span class="post-item-date">
                      <i class="fa fa-clock-o"></i>
                    </span>
                </div>
              </div>
          </div><!-- Latest post end -->
        </div><!-- 1st post col end -->

        <div class="col-lg-4 col-md-6 mb-4">
          <div class="latest-post">
              <div class="latest-post-media">
                <a href="/center/information/mealSchedule" class="latest-post-img">
                    <img loading="lazy" class="img-fluid" src="../../../resources/images/news/food2.png" alt="img">
                </a>
              </div>
              <div class="post-body">
                <h4 class="post-title">
                    <a href="/center/information/mealSchedule" class="d-inline-block">오늘의 메뉴 확인하기</a>
                </h4>
                <div class="latest-post-meta">
                    <span class="post-item-date">
                      <i class="fa fa-clock-o"></i>
                    </span>
                </div>
              </div>
          </div><!-- Latest post end -->
        </div><!-- 2nd post col end -->

        <div class="col-lg-4 col-md-6 mb-4">
          <div class="latest-post">
              <div class="latest-post-media">
                <a href="/center/cscenter/faq" class="latest-post-img">
                    <img loading="lazy" class="img-fluid" src="../../../resources/images/news/center.PNG" alt="img">
                </a>
              </div>
              <div class="post-body">
                <h4 class="post-title">
                    <a href="/center/cscenter/faq" class="d-inline-block">FAQ</a>
                </h4>
                <div class="latest-post-meta">
                    <span class="post-item-date">
                      <i class="fa fa-clock-o"></i> 자주묻는 질문
                    </span>
                </div>
              </div>
          </div><!-- Latest post end -->
        </div><!-- 3rd post col end -->
    </div>
    <!--/ Content row end -->


  </div>
  <!--/ Container end -->
</section>
<!--/ News end -->
        
    </div><!-- Row end -->
  </div><!-- Container end -->



<section style="padding-top:30px;" id="project-area" class="project-area solid-bg">
  <div class="container">
    <div class="row text-center">
     
    </div>
    <!--/ Title row end -->

    <div class="row">
<div class="container-fluid pt-4 px-4">
				
                <div class="bg-light text-center rounded p-4">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">공지사항 게시판</h6>
                        <a href="/center/notice/noticeList">더 보기</a>
                    </div>
                    <div class="table-responsive">
                        <table id="mainnoticetable" class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col" class="short">카테고리</th>
                                    <th scope="col">제목</th>
                                    <th scope="col" class="short">작성일</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                        
                    </div>
                </div>
                <div class="bg-light text-center rounded p-4 ">
                    <div class="d-flex align-items-center justify-content-between mb-4">
                        <h6 class="mb-0">커뮤니티 게시판</h6>
                        <a href="/board/list">더 보기</a>
                    </div>
                    <div class="table-responsive">
                        <table id="mainboardtable" class="table text-start align-middle table-bordered table-hover mb-0">
                            <thead>
                                <tr class="text-dark">
                                    <th scope="col" class="short">카테고리</th>
                                    <th scope="col">제목</th>
                                    <th scope="col" class="short">추천</th>
                                    <th scope="col" class="short">작성일</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                        
                    </div>
                </div>
            </div>
      

    </div><!-- Content row end -->
    
  </div>
  <!--/ Container end -->
</section><!-- Project area end -->
<script type="text/javascript">
	$(document).ready(
			function() {
				loadTableData();

				function loadTableData() {
					
					$.ajax({
						url : "/main/boardlist",
						type : "POST",
						dataType : "json",
						data : {
						},
						success : function(data) {
							let boardTbody = $("#mainboardtable tbody");
							$.each(data, function(index, board) {
								let regDate = new Date(board.regDate);
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
								if(board.category == "ssul"){
									row.append($("<td>").text("썰"));
								}else if(board.category == "tip"){
									row.append($("<td>").text("팁"));
								}else if(board.category == "free"){
									row.append($("<td>").text("자유"));
								}else {
									row.append($("<td>").text("없음"));
								}
								let titleLink = $("<a>").attr(
										"href",
										"/board/view/"
												+ board.bno).text(board.title);
								let titleTd = $("<td>").append(titleLink);
								row.append(titleTd);
								row.append($("<td>").text(board.likes));
								
								row.append($("<td>").text(formatDate));
								boardTbody.append(row);
							});
						},
						error : function(e) {
							console.log(e);
						}
					});
					
					$.ajax({
						url : "/main/noticelist",
						type : "POST",
						dataType : "json",
						data : {
						},
						success : function(data) {
							let noticeTbody = $("#mainnoticetable tbody");
							$.each(data, function(index, notice) {
								let regDate = new Date(notice.regDate);
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
								if(notice.category == "NN"){
									row.append($("<td>").text("공지"));
								}else if(notice.category == "FF"){
									row.append($("<td>").text("점검"));
								}else{
									row.append($("<td>").text("없음"));
								}
								
								let titleLink = $("<a>").attr(
										"href",
										"/center/notice/get?nno="
												+ notice.nno).text(notice.title);
								let titleTd = $("<td>").append(titleLink);
								row.append(titleTd);
								
								row.append($("<td>").text(formatDate));
								noticeTbody.append(row);
							});
						},
						error : function(e) {
							console.log(e);
						}
					});
					
					$.ajax({
						url : "/main/benefitlist",
						type : "POST",
						dataType : "json",
						data : {
						},
						success : function(data) {
							let benefitTbody = $("#mainbenefit tbody");
							$.each(data, function(index, sale) {
								let row = $("<tr>");
						        row.append($("<td>").text(sale.area));
						        row.append($("<td>").text(sale.item));
						        row.append($("<td>").text(sale.detail));
						        row.append($("<td>").text(sale.phone));
						        benefitTbody.append(row);
								
							});
						},
						error : function(e) {
							console.log(e);
						}
					});


				}// loadTableData 함수 선언 종료

			}); // $(document).ready 함수 선언 종료
</script>

<%@include file="includes/footer.jsp"%>


 