<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="../../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<style>
    body {
        background-color: #f5f5f5; /* 페이지 전체 배경색 */
    }

    table {
        border-collapse: collapse;
        width: 100%;
    }

    th, td {
        border: 1px solid #dddddd;
        text-align: center;
        height: 100px;
        position: relative;
    }

    th {
        background-color: #f2f2f2;
    }

    .disabled {
        color: #a9a9a9;
    }

    .navigation {
        text-align: center;
        margin-bottom: 10px;
    }

    .navigation button {
        padding: 5px 10px;
        cursor: pointer;
    }

    /* 오늘 날짜의 셀 배경색 */
    .today {
        background-color: #eaf7ea; /* 연두색 배경 */
    }

    /* 각 숫자(일자)를 왼쪽 위로 위치시키는 스타일 */
    td span {
        position: absolute;
        top: 0; /* 상단으로 위치 조정 */
        left: 0; /* 좌측으로 위치 조정 */
    }

    /* 일정 표시 스타일 */
.event {
	display: none;
    color: black;
    font-weight: bold;
    background-color: #b3b68a;
    padding: 5px; /* 일정의 패딩을 조절하여 크기를 조절했습니다. */
    border-radius: 5px; /* 일정의 테두리를 둥글게 만들었습니다. */

    /* 수정된 부분 */
    position: absolute;
    bottom: 0; /* 아래로 정렬 */
    left: 0; /* 왼쪽 정렬 */
    right: 0; /* 오른쪽 정렬 */
    text-align: center; /* 텍스트 가운데 정렬 */
    margin: auto; /* 수평 가운데 정렬 */
    z-index: 999;
    width: 400px;
     box-shadow: 5px 3px 5px rgba(0, 0, 0, 0.3);
}
    td {
        position: relative;
    }

    td span {
        position: absolute;
        top: 0; /* 상단으로 위치 조정 */
        left: 0; /* 좌측으로 위치 조정 */
    }
    th:nth-child(7), td:nth-child(7) {
    color: blue; /* 토요일 텍스트 색상을 파란색으로 설정 */
}

th:nth-child(1), td:nth-child(1) {
    color: red; /* 일요일 텍스트 색상을 빨간색으로 설정 */
}


/* 해당 열 내의 span 요소의 색상을 변경하는 스타일을 추가합니다 */
th:nth-child(1) span, td:nth-child(1) span {
    color: red; /* 일요일의 span 색상을 빨간색으로 설정 */
}
th:nth-child(7) span, td:nth-child(7) span {
    color: blue; /* 토요일의 span 색상을 파란색으로 설정 */
}




</style>
  <c:if test="${empty user}">
		<script>
                    // 사용자가 비어 있으면 로그인 페이지로 자동 이동
                    window.location.href = "/login/login";
                </script>
             </c:if>
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
   <h2>월간 식단표</h2>
  <div>
  <p>*메뉴를 확인하고 싶은 날짜를 클릭하세요</p>
  </div>
<%
    // 요청 파라미터에서 연도와 월 가져오기
    String yearParam = request.getParameter("year");
    String monthParam = request.getParameter("month");

    int year, month;

    // 파라미터가 없으면 현재 연도와 월 사용
    if (yearParam == null || monthParam == null) {
        java.util.Calendar cal = java.util.Calendar.getInstance();
        year = cal.get(java.util.Calendar.YEAR);
        month = cal.get(java.util.Calendar.MONTH) + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
    } else {
        year = Integer.parseInt(yearParam);
        month = Integer.parseInt(monthParam);
    }

    // 오늘 날짜 구하기
    java.util.Calendar cal = java.util.Calendar.getInstance();
    int todayYear = cal.get(java.util.Calendar.YEAR);
    int todayMonth = cal.get(java.util.Calendar.MONTH) + 1;
    int todayDay = cal.get(java.util.Calendar.DAY_OF_MONTH);

    // 이전 달, 다음 달 계산
    cal = java.util.Calendar.getInstance();
    cal.set(year, month - 1, 1);
    cal.add(java.util.Calendar.MONTH, -1);
    int prevYear = cal.get(java.util.Calendar.YEAR);
    int prevMonth = cal.get(java.util.Calendar.MONTH) + 1;

    cal = java.util.Calendar.getInstance();
    cal.set(year, month - 1, 1);
    cal.add(java.util.Calendar.MONTH, 1);
    int nextYear = cal.get(java.util.Calendar.YEAR);
    int nextMonth = cal.get(java.util.Calendar.MONTH) + 1;

    // 달력의 첫째 날의 요일과 마지막 날짜 구하기
    cal.set(year, month - 1, 1);
    int firstDayOfWeek = cal.get(java.util.Calendar.DAY_OF_WEEK);
    int lastDayOfMonth = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);

    // 이전 달의 마지막 날짜 구하기
    cal.add(java.util.Calendar.MONTH, -1);
    int lastDayOfPrevMonth = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);

    // 다음 달의 첫째 날짜 구하기
    cal.add(java.util.Calendar.MONTH, 2);
    int firstDayOfNextMonth = cal.get(java.util.Calendar.DAY_OF_WEEK);
%>

<div class="navigation">
    <button onclick="location.href='?year=<%= prevYear %>&month=<%= prevMonth %>'" <%= (prevMonth < 1) ? "disabled" : "" %>><</button>
    <span><%= year %>년 <%= month %>월</span>
    <button onclick="location.href='?year=<%= nextYear %>&month=<%= nextMonth %>'" <%= (nextMonth > 12) ? "disabled" : "" %>>></button>
</div>

<table>
    <tr>
        <th>일</th>
        <th>월</th>
        <th>화</th>
        <th>수</th>
        <th>목</th>
        <th>금</th>
        <th>토</th>
    </tr>
    <%
    // 첫째 주의 공백 채우기
    out.print("<tr>");
    for (int i = 1; i < firstDayOfWeek; i++) {
        // 일요일인 경우
        if (i == 1) {
            out.print("<td class='disabled'><span style='color: #a9a9a9;'>" + (lastDayOfPrevMonth - firstDayOfWeek + i + 1) + "</span></td>");
        } else {
            out.print("<td class='disabled'><span>" + (lastDayOfPrevMonth - firstDayOfWeek + i + 1) + "</span></td>");
        }
    }

    // 달력 출력
    int day = 1;
    while (day <= lastDayOfMonth) {
        if (firstDayOfWeek > 7) {
            firstDayOfWeek = 1;
            out.print("</tr><tr>");
        }

        // 오늘 날짜인 경우 클래스 추가
        String cellClass = (year == todayYear && month == todayMonth && day == todayDay) ? "today" : "";
        out.print("<td class='" + cellClass + "' data-date='" + year + "-" + month + "-" + day + "'><span>" + day + "</span><div class='event'><div class='mevent'></div><div class='levent'></div><div class='devent'></div></div></td>");

        day++;
        firstDayOfWeek++;
    }

 // 마지막 주의 나머지 공백 채우기
    int remainingDays = 7 - (firstDayOfWeek - 1); // 첫째 주의 남은 일수 계산
    for (int i = 1; i <= remainingDays; i++) {
        String textColor = (firstDayOfWeek % 7 == 0) ? "color: #a9a9a9;" : "";
        out.print("<td class='disabled'><span style='" + textColor + "'>" + i + "</span></td>");
        firstDayOfWeek++;
    }
%>
</table>
   <div style="margin-top:10px;" class="accordion accordion-group accordion-classic" id="construction-accordion">
        <div class="card">
        	<div class="card-header p-0 bg-transparent" id="heading0">
        		<h2 class="mb-0">
        			<button class="btn btn-block text-left collapsed" type="button" data-toggle="collapse" data-target="#collapse0" aria-expanded="false" aria-controls="collapse0">식품알레르기 유발식품표 확인</button>
        		</h2>
        	</div>
        	<div class="collapse" id="collapse0" aria-labelledby="heading0" data-parent="#construction-accordion" style="">
        		<div class="card-body">1.난류 2.우유 3.메밀 4.땅콩 5.대두 6.밀 7.고등어 8.게 9.새우 10.돼지고기 </br>11.복숭아 12.토마토 13.아황산류 14.호두 15.닭고기 16.쇠고기 17.오징어 18.조개류(굴, 전복, 홍합 포함) 19.잣</div>
        	</div>
        </div>
    </div>
</div>
</section>

<script type="text/javascript">
		$(document).ready(
				function() {
					loadTableData();
					console.log(result);
					 $('.event').hide();

				        // 호버 시 이벤트 표시
					 $('td').click(function () {
						 
    // 현재 클릭된 <td> 요소에서 .event 클래스를 가진 하위 요소를 찾습니다.
    var eventElement = $(this).find('.event');

    // 만약 현재 <td> 요소에서 .event 클래스를 가진 하위 요소가 보이지 않는 상태이면 보이도록 설정하고,
    // 보이는 상태이면 숨기도록 설정합니다.
    if (eventElement.is(':hidden')) {
    	$('.event').hide();
        eventElement.show();
    } else {
        eventElement.hide();
    }
});

					 function loadTableData() {
					        $.ajax({
					            url: "/center/information/menuList",
					            type: "POST",
					            dataType: "json",
					            data: {},
					            success: function(data) {
					                // 데이터를 반복하면서 해당 날짜에 이벤트를 추가합니다
					                $.each(data, function(index, meal) {
					                    var eventDate = new Date(meal.date);

					                    // 이벤트에 해당하는 테이블 셀을 찾습니다
					                    var cell = $("td").filter(function() {
					                        var cellDate = new Date($(this).data("date")); // 각 td에 data-date 속성이 있다고 가정합니다
					                        return (
					                            cellDate.getDate() === eventDate.getDate() &&
					                            cellDate.getMonth() === eventDate.getMonth() &&
					                            cellDate.getFullYear() === eventDate.getFullYear()
					                        );
					                    });

					                    // 셀을 찾으면 이벤트를 추가합니다
					                    if (cell.length > 0) {
					                        // 찾은 셀 안에 이미 이벤트가 있는지 확인합니다
					                        var eventDiv = cell.find(".event");

					                        // 이미 이벤트가 있는 경우에는 해당 이벤트에 meal.morning, meal.lunch, meal.dinner을 추가합니다
					                        if (eventDiv.length > 0) {
					                        	if(meal.morning !== undefined && meal.morning !== null && meal.morning !== ''){
					                        		eventDiv.find('.mevent').append("</br>"+meal.morning);
					                        	}
					                        	if(meal.lunch !== undefined && meal.lunch !== null && meal.lunch !== ''){
					                        		eventDiv.find('.levent').append("</br>"+meal.lunch);
					                        	}
					                        	if(meal.dinner !== undefined && meal.dinner !== null && meal.dinner !== ''){
					                        		eventDiv.find('.devent').append("</br>"+meal.dinner);
					                        	}
					                            
					                        } else {
					                            // 이벤트가 없는 경우에는 새로운 이벤트를 생성하여 각각의 meal을 추가합니다
					                            cell.append("<div class='event'><div class='mevent'>" + meal.morning + "</div><div class='levent'>" + meal.lunch + "</div><div class='devent'>" + meal.dinner + "</div></div>");
					                        }
					                    }
					                });
					            },
					            error: function(e) {
					                console.log(e);
					            },
					        });
					    

					}// loadTableData 함수 선언 종료
					
				}); // $(document).ready 함수 선언 종료

	</script>
<%@include file="../../includes/footer.jsp"%>