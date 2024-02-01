<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <footer id="footer" class="footer bg-overlay">
    

    <div class="copyright">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-md-12">
            <div class="copyright-info text-center">
              <span>Copyright &copy; <script>
                  document.write(new Date().getFullYear())
                </script>, Designed &amp; Developed by <a href="#">TeamDangGoon</a></span>
            </div>
          </div>

          <div class="col-md-12">
            <div class="copyright-info text-center">
              <span>Distributed by <a href="#">TeamDangGoon</a></span>
            </div>
          </div>

          <div class="col-md-12">
            <div class="footer-menu text-center">
              <ul class="list-unstyled mb-0">
                <li><a href="/board/list">Comunity</a></li>
                <li><a href="/user/myCalendar/mySchedule">Calendar</a></li>
                <li><a href="/center/cscenter/faq">Faq</a></li>
                <li><a href="/center/notice/noticeList">Notice</a></li>
                <li><a href="/center/information/mealSchedule">Meal Schedule</a></li>
              </ul>
            </div>
          </div>
        </div><!-- Row end -->

        <div id="back-to-top" data-spy="affix" data-offset-top="10" class="back-to-top position-fixed">
          <button class="btn btn-primary" title="Back to Top">
            <i class="fa fa-angle-double-up"></i>
          </button>
        </div>

      </div><!-- Container end -->
    </div><!-- Copyright end -->
  </footer><!-- Footer end -->


  <!-- Javascript Files
  ================================================== -->

  <!-- initialize jQuery Library -->
  
  </div><!-- Body inner end -->
  <script type="text/javascript">
    var currentDate = new Date();
    var x = "${user.armygroup}";
    var startDate = new Date('${user.enlisting}');
    var firstP = new Date(startDate);
    firstP.setMonth(startDate.getMonth() + 2);
    var secondP = new Date(startDate);
    secondP.setMonth(startDate.getMonth() + 8);
    var lastP = new Date(startDate);
    lastP.setFullYear(startDate.getFullYear() + 1);
    lastP.setMonth(startDate.getMonth() + 2);
	
    if(currentDate>lastP){
    	document.getElementById("promotionDates").innerText = "없음";
    	document.getElementById("currentRank").innerText = "병장";
    }else if(currentDate>secondP){
    	var ptimeDif = lastP.getTime() - currentDate.getTime();
        var pdayDif = ptimeDif / (1000 * 60 * 60 * 24);
        var premains = Math.floor(pdayDif);
        var presult = "D - " + premains.toString();
        document.getElementById("promotionDates").innerText = presult;
    	document.getElementById("currentRank").innerText = "상병";
    }else if(currentDate>firstP){
    	var ptimeDif = secondP.getTime() - currentDate.getTime();
        var pdayDif = ptimeDif / (1000 * 60 * 60 * 24);
        var premains = Math.floor(pdayDif);
        var presult = "D - " + premains.toString();
        document.getElementById("promotionDates").innerText = presult;
    	document.getElementById("currentRank").innerText = "일병";
    }else {
    	var ptimeDif = firstP.getTime() - currentDate.getTime();
        var pdayDif = ptimeDif / (1000 * 60 * 60 * 24);
        var premains = Math.floor(pdayDif);
        var presult = "D - " + premains.toString();
        document.getElementById("promotionDates").innerText = presult;
    	document.getElementById("currentRank").innerText = "이등병";
    }
    
    
    console.log(x);
    console.log(startDate.getDate());
    console.log(dayDif);
    switch (x) {
        case "earth":
        	var endDate = new Date(startDate);
            endDate.setFullYear(startDate.getFullYear() + 1);
            endDate.setMonth(startDate.getMonth() + 6);
            var timeDif = endDate.getTime() - currentDate.getTime();
            var dayDif = timeDif / (1000 * 60 * 60 * 24);
            var remains = Math.floor(dayDif);
            var result = "D - " + remains.toString();
            if (remains == 0) {
                result = "D - Day";
            } else if (remains < 0) {
                result = "전역자";
            }
            console.log(remains);
            document.getElementById("remainDates").innerText = result;
            break;
        case "sea":
        	var endDate = new Date(startDate);
            endDate.setFullYear(startDate.getFullYear() + 1);
            endDate.setMonth(startDate.getMonth() + 8);
            var timeDif = endDate.getTime() - currentDate.getTime();
            var dayDif = timeDif / (1000 * 60 * 60 * 24);
            var remains = Math.floor(dayDif);
            var result = "D - " + remains.toString();
            if (remains == 0) {
                result = "D - Day";
            } else if (remains < 0) {
                result = "전역자";
            }
            document.getElementById("remainDates").innerText = result;
            break;
        case "fly":
        	var endDate = new Date(startDate);
            endDate.setFullYear(startDate.getFullYear() + 1);
            endDate.setMonth(startDate.getMonth() + 9);
            var timeDif = endDate.getTime() - currentDate.getTime();
            var dayDif = timeDif / (1000 * 60 * 60 * 24);
            var remains = Math.floor(dayDif);
            var result = "D - " + remains.toString();
            if (remains == 0) {
                result = "D - Day";
            } else if (remains < 0) {
                result = "전역자";
            }
            document.getElementById("remainDates").innerText = result;
            break;
    }
    console.log(endDate);
</script>
  </body>

  </html>