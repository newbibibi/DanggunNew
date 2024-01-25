<%@ include file="../../includes/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
		<script src="../../../resources/js/calendar/js"></script>
		<div id="calendar">
    <div id="calendar_header">
      <i class="icon-chevron-left">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" class="h-[24px] w-[24px] self-center cursor-pointer text-main2">
        <path fill-rule="evenodd" d="M12.707 5.293a1 1 0 010 1.414L9.414 10l3.293 3.293a1 1 0 01-1.414 1.414l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 0z" clip-rule="evenodd"></path></svg></i>          <h1></h1>
      <i class="icon-chevron-right">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true" class="h-[24px] w-[24px] self-center cursor-pointer text-main2 cursor-pointer">
          <path fill-rule="evenodd" d="M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z" clip-rule="evenodd"></path></svg></i>         </div>
    <div id="calendar_weekdays"></div>
    <div id="calendar_content"></div>
  </div>
  <div id="myModal1" class="modal1">
    <form class="modal1-content">
      <input type="text" class="title" id="title" name="title" placeholder="제목 입력" value="">
      <input type="date" class="s" value="" readonly="readonly"> ~
      <input type="date" class="e" value="" readonly="readonly">
      <button type="button" id="subbtn">보내기</button>
    </form>
  </div>
		<a href="/user/myCalendar/scheduleRegister">이동하기</a>
		<script type="text/javascript">
		
	$(document).ready(function() {
		
		loadTableData(); // Ajax 실행 함수 호출
	
		
		function loadTableData() {
	        // Ajax : 비동기 통신 
	        // - 프로세스의 완료를 기다리지 않고 동시에 여러 작업을 처리 
	        // - 전체 페이지를 새로고침 하지 않고 필요한 부분만을 업데이트 할 수 있다
	        // - 자원과 시간을 절약, 깜박거리거나 멈추지 않고 부드럽게 작동
	        $.ajax({
	            url: "/user/myCalendar/mySchedule", // 요청할 서버 uri 지정
	            type: "POST", //요청 방식 지정
	            dataType: "json", // 서버 응답의 데이터 타입(대표적:json,xml)
	            data: {
	                nickname: $("#nickname").find("input[name='nickname']").val()
	            },
	            success: function(data) {
	                console.log(data);
			
	                let boardTbody = $("#boardTable tbody");

	                // Ajax가 반환한 데이터를 '순회'(=='반복자')하여 처리
	                // for( let item of items) -> items == data, item == board 역할
	                $.each(data, function(index, board) {
	                    // 날짜 형태로 전환
	                    let startDate = new Date(board.startDate);
	                    let endDate = new Date(board.endDate);
	                    // numeric: 숫자 형식, 2-digit: 두자리 숫자 형식
	                    let options = {
	                        year: "numeric",
	                        month: "2-digit",
	                        day: "2-digit",
	                   
	                    };
	                    let sformatDate = startDate.toLocaleString("ko-KR", options);
	                    let eformatDate = endDate.toLocaleString("ko-KR", options);
	                    // 데이터를 순회하여 테이블 목록을 불러와 테이블 바디에 추가
	                    // 동적으로 데이터 처리
	                    let row = $("<tr>");
	                    row.append($("<td>").text(board.calNo));
	                    let titleLink = $("<a>").attr("href","/user/myCalendar/modifySchedule?calNo="+board.calNo).text(board.content);
                        let titleTd = $("<td>").append(titleLink);
                        row.append(titleTd);
	                    row.append($("<td>").text(board.nickname));
	                    row.append($("<td>").text(sformatDate));
	                    row.append($("<td>").text(eformatDate));

	                    boardTbody.append(row);

	                });
	            },
	            error: function(e) {
	                console.log(e);
	                console.log(nickname.value)
	            }
	        });

	    } // -- loadTableData 함수 선언 종료

	}); // // -- $(document).ready 함수 선언 종료
</script>
<script>
$(function(){
  
  function c(){
    var ax = 0 ;
    p();
    var e=h();
    var r=0;
    var u=false;
    l.empty();
    while(!u){
      ax++;
      if(s[r]==e[0].weekday){
        u=true
      }else{
        l.append('<div class="blank '+ax +'"></div>');
        r++}
      }
      for(var c=0;c<42-r;c++){
        
        if(c>=e.length){
          l.append('<div class="blank '+ax+'"></div>')
        }else{
          var v=e[c].day;
          if(ax % 7 == 0||c == (e.length-1)){
            var m=g(new Date(t,n-1,v))?'<div id="'+ax+'" class="today day rowend">':'<div id="'+ax+'" class="day rowend">';
          } else if(ax % 7 == 1 || c == 0){
            var m=g(new Date(t,n-1,v))?'<div id="'+ax+'" class="today day rowstart">':'<div id="'+ax+'" class="day rowstart">';
          } else {
            var m=g(new Date(t,n-1,v))?'<div id="'+ax+'" class="today day">':'<div id="'+ax+'" class="day">';
          }
            l.append(m+"<input type='hidden' class='' value = 0><span class='day-number'>"+v+"</span><span class='abcontainer'></span></div>")
        }
        ax++;
      }
      var y=o[n-1];
      a.css("background-color",y).find("h1").text(i[n-1]+" "+t);
      f.find("div").css("color",y);
      l.find(".today").css("background-color",y);
      l.find(".today").find('.abcontainer').css("background-color",y)
      d()
    }
    function h(){
      var e=[];
      for(var r=1;r<v(t,n)+1;r++){
        e.push({day:r,weekday:s[m(t,n,r)]})
      }

      return e
    }
    function p(){
      f.empty();
      for(var e=0;e<7;e++){
        f.append("<div>"+s[e].substring(0,3)+"</div>")
      }
    }
    function d(){
      var t;
      var n=$("#calendar").css("width",e+"px");
      n.find(t="#calendar_weekdays").css("width",e+"px").find("div").css({width:e/7+"px",height:e/21+"px","line-height":e/21+"px"});
      n.find(" #calendar_content").css("width",e+"px").find("div").css({width:e/7+"px",height:e/7+"px"});
      n.find("#calendar_header").css({height:e*(1/7)+"px"}).find('i[class^="icon-chevron"]').css("line-height",e*(1/7)+"px")
    }
    function v(e,t){
      return(new Date(e,t,0)).getDate()
    }
    function m(e,t,n){
      return(new Date(e,t-1,n)).getDay()
    }
    function g(e){
      return y(new Date)==y(e)
    }
    function y(e){
      return e.getFullYear()+"-"+(e.getMonth()+1)+"-"+e.getDate()
    }
    function b(){
      var e=new Date;
      t=e.getFullYear();
      n=e.getMonth()+1
    }
    var e=700;
    var t=2013;
    var n=9;
    var r=[];
    var i=["JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"];
    var s=["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
    var o=["#16a085","#1abc9c","#c0392b","#27ae60","#FF6860","#f39c12","#f1c40f","#e67e22","#2ecc71","#e74c3c","#d35400","#2c3e50"];
    var u=$("#calendar");
    var a=u.find("#calendar_header");
    var f=u.find("#calendar_weekdays");
    var l=u.find("#calendar_content");
    b();
    c();
    a.find('i[class^="icon-chevron"]').css("cursor","pointer");
    a.find('i[class^="icon-chevron"]').on("click",function(){
      var e=$(this);
      var r=function(e){
        n=e=="next"?n+1:n-1;
        if(n<1){
          n=12;
          t--
        }else if(n>12){
          n=1;
          t++
        }
        c()
      };
      if(e.attr("class").includes("left")!=-1){
        r("previous")
      }else{
        r("next")
      }
      df();
      
      
    })
      
function df() {
setTimeout(function() {

  var dragging = false;
  var days = document.querySelectorAll('.day');

  function activateDay() {
    var activeElement = document.activeElement;
    var activeAItem = document.querySelector('.active-a');
    var activeBItem = document.querySelector('.active-b');
    if (activeAItem && activeBItem) {
      clearActiveDays();
      clearRange();
      activeElement.classList.add('active-a');
      
      return;
    }
    
    if (activeAItem) activeElement.classList.add('active-b');
    else activeElement.classList.add('active-a');

  }

  function clearActiveDays() {
    var activeAItem = document.querySelector('.active-a');
    var activeBItem = document.querySelector('.active-b');

    if (activeAItem) activeAItem.classList.remove('active-a');
    if (activeBItem) activeBItem.classList.remove('active-b');
  }

  function clearRange() {
    days.forEach(item => {
      item.classList.remove('range');
      z=''
      w=''
    });
  }

  function calculateRange() {
    var activeAIndex, activeBIndex;

    days.forEach((item, index) => {
      if (item.classList.contains('active-a')) activeAIndex = index;
      if (item.classList.contains('active-b')) activeBIndex = index;
    });
    var a = t + "-" + (n < 10 ? '0' + n : n) + "-" + ((activeAIndex+1) < 10 ? '0' + (activeAIndex+1) : (activeAIndex+1));
    var b = t + "-" + (n < 10 ? '0' + n : n) + "-" + ((activeBIndex+1) < 10 ? '0' + (activeBIndex+1) : (activeBIndex+1));
    if (activeAIndex < activeBIndex) {
      for (var i = activeAIndex; i <= activeBIndex; i++) {
        days[i].classList.add('range');
        var a = t + "-" + (n < 10 ? '0' + n : n) + "-" + ((activeAIndex+1) < 10 ? '0' + (activeAIndex+1) : (activeAIndex+1));
        var b = t + "-" + (n < 10 ? '0' + n : n) + "-" + ((activeBIndex+1) < 10 ? '0' + (activeBIndex+1) : (activeBIndex+1));
    
      }
    }
  
    if (activeAIndex > activeBIndex) {
      for (var i = activeAIndex; i >= activeBIndex; i--) {
        days[i].classList.add('range');
        var b = t + "-" + (n < 10 ? '0' + n : n) + "-" + ((activeAIndex+1) < 10 ? '0' + (activeAIndex+1) : (activeAIndex+1));
        var a = t + "-" + (n < 10 ? '0' + n : n) + "-" + ((activeBIndex+1) < 10 ? '0' + (activeBIndex+1) : (activeBIndex+1));
    
      }
    }
    
    if(!isNaN(activeBIndex)&&!isNaN(activeAIndex)) mo = 1;
    else mo = 0;
    dp(a,b)
    
  }
  var z;
  var w;
  function dp(s,e){
    z = s;
    w = e;
  }
 var mo;
  function startMove(item) {
    mo = 0;
    dragging = true;
    if(item.classList.contains('day-number')) item = item.parentNode
    var activeAItem = document.querySelector('.active-a');
    var activeBItem = document.querySelector('.active-b');
    if (!activeBItem && activeAItem) {
      if(item.classList.contains('active-a')){
        item.classList.add('active-b')
        calculateRange();
       
      } else {
        clearActiveDays();
        clearRange();
        item.classList.add('active-a');
      }
    } else {
      clearActiveDays();
      clearRange();
      item.classList.add('active-a');
    }
  }

  function move(item) {
    if (dragging) {
      var prevActiveB = document.querySelector('.active-b');
      clearRange();

      if (prevActiveB) prevActiveB.classList.remove('active-b');
      if (!item.classList.contains('active-a')) item.classList.add('active-b');

      calculateRange();
    
    }
  }

  window.addEventListener('mouseup', e => {
    dragging = false;
    if (mo == 1) {
      openModal();
      mo=0;
     }
  });

  days.forEach((item, index) => {

    item.addEventListener('mousedown', e => {
      startMove(e.target);
    });
    item.addEventListener('mousemove', e => {    
      move(item);
    }); 
  });

  window.addEventListener('keyup', e => {
    var key = e.keyCode;

    switch (key) {
      case 13:
        if(document.querySelector('.opened')){
          mSpan();
        }
        break;
    }
  });
  document.getElementById('subbtn').onclick =
  function mSpan() {

    var dateP = document.querySelectorAll('.active-a, .active-b, .range')
    var dateSet = new Set();

    dateP.forEach((item,i) =>{
      let countElement = item.children[0];
    if (countElement) {
        let classList = countElement.classList;
        dateSet.add(Array.from(classList));
      }
    })

    var dateArr = Array.from(dateSet);
    if(!(dateP[0].classList.contains('active-a'))&&dateP[0].classList.contains('active-b')){
      dateP[0].classList.remove('active-b')
      dateP[0].classList.add('active-a')
      dateP[dateP.length-1].classList.remove('active-a')
      dateP[dateP.length-1].classList.add('active-b')
    }

    var elementa = document.querySelector('.active-a');
    var elementb = document.querySelector('.active-b');

    var numA = null;
    var numB = null;
  
      var parsedNumber = parseInt(elementa.id);
      if (!isNaN(parsedNumber)) {
        numA = parsedNumber;
      }

      var parsedNumber = parseInt(elementb.id);
      if (!isNaN(parsedNumber)) {
        numB = parsedNumber;
      }
  
    var abDiff = numB - numA + 1;
    var nov;
    var ov;
    var num1 = false;
    var num2 = false;
    var num3 = false;
    var overNum = false;
    var iArr = [];
    var newSpan = document.createElement("div");
    if (document.querySelector(".active-a")&&document.querySelector(".active-b")) {
        if(numA == numB){
          dateArr.forEach((item)=>{
            if(item.includes('overNum')){
              overNum = true;
            }
            if(item.includes('num3')){
              num3 = true;
            }
            if(item.includes('num2')){
              num2 = true;
            }
            if(item.includes('num1')) {
              num1 = true;
            }
          })
          if(num1&&num2&&num3){   
            newSpan.classList.add('overNum')
            dateP[0].children[0].classList.add('overNum')
          } else {
            if(num3){
              if(num2){
                newSpan.classList.add('num1')
                dateP[0].children[0].classList.add('num1')
              } else if(num1){
                newSpan.classList.add('num2')
                dateP[0].children[0].classList.add('num2')
              } else {
                newSpan.classList.add('num1')
                dateP[0].children[0].classList.add('num1')
              }
            } else if(num2){
              if(num1){
                newSpan.classList.add('num3')
                dateP[0].children[0].classList.add('num3')
              }else{             
                newSpan.classList.add('num1')
                dateP[0].children[0].classList.add('num1')
              }
            } else if(num1){
              newSpan.classList.add('num2')
              dateP[0].children[0].classList.add('num2')
            } else {
              newSpan.classList.add('num1')
              dateP[0].children[0].classList.add('num1')
            }
          }
          newSpan.classList.add("sch-ab");
          newSpan.style.width = 100 + "px"
          newSpan.innerHTML = document.querySelector('.title').value;
          document.querySelector(".active-a").children[2].append(newSpan);
        } else {
          var cnt = 0;
          dateP.forEach((item, index) => {
            if(item.classList.contains('rowend')){
              cnt++;
              iArr.push(index +1);
             
            }
          })
          
          if(dateP[dateP.length-1].classList.contains('rowend')){
            cnt--;
            iArr.pop();
          }

          var slicedDate = [];
          
          var item2
          
          iArr.forEach((item,index) => {
            if(index == 0){
              slicedDate.push(dateArr.slice(0,item));
              item2 = item;
            } else if(index < iArr.length){
              slicedDate.push(dateArr.slice(item2,item));
              item2 = item;
            }
          })

          slicedDate.push(dateArr.slice(item2))
          var icnt = 0;
          if(cnt == 1){
            nov = (700-(((numA-1)%7)*100));
            ov = dateP.length*100 - nov;
            newSpan.style.width = (nov-15) + "px";
            newSpan.innerHTML = document.querySelector('.title').value;

            slicedDate[0].forEach((iitem)=>{
              if(iitem.includes('overNum')){
                overNum = true;
              }
              if(iitem.includes('num3')){
                num3 = true;
              }
              if(iitem.includes('num2')){
                num2 = true;
              }
              if(iitem.includes('num1')) {
                num1 = true;
              }
            })
            slicedDate[0].forEach((item)=>{
              if(num1&&num2&&num3){   
                newSpan.classList.add('overNum')
                dateP[icnt].children[0].classList.add('overNum')
              } else {
                if(num3){
                  if(num2){
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  } else if(num1){
                    newSpan.classList.add('num2')
                    dateP[icnt].children[0].classList.add('num2')
                  } else {
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  }
                } else if(num2){
                  if(num1){
                    newSpan.classList.add('num3')
                    dateP[icnt].children[0].classList.add('num3')
                  }else{             
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  }
                } else if(num1){
                  newSpan.classList.add('num2')
                  dateP[icnt].children[0].classList.add('num2')
                } else{
                  newSpan.classList.add('num1')
                  dateP[icnt].children[0].classList.add('num1')
                }
              }
            icnt++
          })
            newSpan.classList.add("sch-a");
            document.querySelector(".active-a").children[2].append(newSpan);
            var newSpan = document.createElement("div");
            overNum = false;
            num1 = false;
            num2 = false;
            num3 = false;

            slicedDate[1].forEach((iitem)=>{
              if(iitem.includes('overNum')){
                overNum = true;
              }
              if(iitem.includes('num3')){
                num3 = true;
              }
              if(iitem.includes('num2')){
                num2 = true;
              }
              if(iitem.includes('num1')) {
                num1 = true;
              }
            })
            slicedDate[1].forEach((item)=>{

              if(num1&&num2&&num3){   
                newSpan.classList.add('overNum')
                dateP[0].children[0].classList.add('overNum')
              } else {
                if(num3){
                  if(num2){
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  } else if(num1){
                    newSpan.classList.add('num2')
                    dateP[icnt].children[0].classList.add('num2')
                  } else {
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  }
                } else if(num2){
                  if(num1){
                    newSpan.classList.add('num3')
                    dateP[icnt].children[0].classList.add('num3')
                  }else{             
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  }
                } else if(num1){
                  newSpan.classList.add('num2')
                  dateP[icnt].children[0].classList.add('num2')
                } else {
                  newSpan.classList.add('num1')
                  dateP[icnt].children[0].classList.add('num1')
                }
              }
            icnt++
          })
            newSpan.classList.add("sch-b");
            newSpan.style.width = (ov -15) + "px";
            newSpan.innerHTML = document.querySelector('.title').value;
            dateP.forEach((item)=>{
              if(item.classList.contains('rowstart')) item.children[2].append(newSpan);
            })
          } else if (cnt == 0){
            //cnt = 0
            nov = ((abDiff)%7)*100;
            
             slicedDate[0].forEach((iitem)=>{
              if(iitem.includes('overNum')){
                overNum = true;
              }
              if(iitem.includes('num3')){
                num3 = true;
              }
              if(iitem.includes('num2')){
                num2 = true;
              }
              if(iitem.includes('num1')) {
                num1 = true;
              }
            })
            slicedDate[0].forEach((item)=>{
              if(num1&&num2&&num3){   
                newSpan.classList.add('overNum')
                dateP[icnt].children[0].classList.add('overNum')
              } else {
                if(num3){
                  if(num2){
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  } else if(num1){
                    newSpan.classList.add('num2')
                    dateP[icnt].children[0].classList.add('num2')
                  } else {
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  }
                } else if(num2){
                  if(num1){
                    newSpan.classList.add('num3')
                    dateP[icnt].children[0].classList.add('num3')
                  }else{             
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  }
                } else if(num1){
                  newSpan.classList.add('num2')
                  dateP[icnt].children[0].classList.add('num2')
                } else{
                  newSpan.classList.add('num1')
                  dateP[icnt].children[0].classList.add('num1')
                }
              }
            icnt++
          })

            newSpan.classList.add("sch-ab");
            newSpan.style.width = nov + "px";
            newSpan.innerHTML = document.querySelector('.title').value;
            document.querySelector(".active-a").children[2].append(newSpan);
          } else {
            //두 줄 이상
            slicedDate[0].forEach((iitem)=>{
              if(iitem.includes('overNum')){
                overNum = true;
              }
              if(iitem.includes('num3')){
                num3 = true;
              }
              if(iitem.includes('num2')){
                num2 = true;
              }
              if(iitem.includes('num1')) {
                num1 = true;
              }
            })
            slicedDate[0].forEach((item)=>{
              if(num1&&num2&&num3){   
                newSpan.classList.add('overNum')
                dateP[icnt].children[0].classList.add('overNum')
              } else {
                if(num3){
                  if(num2){
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  } else if(num1){
                    newSpan.classList.add('num2')
                    dateP[icnt].children[0].classList.add('num2')
                  } else {
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  }
                } else if(num2){
                  if(num1){
                    newSpan.classList.add('num3')
                    dateP[icnt].children[0].classList.add('num3')
                  }else{             
                    newSpan.classList.add('num1')
                    dateP[icnt].children[0].classList.add('num1')
                  }
                } else if(num1){
                  newSpan.classList.add('num2')
                  dateP[icnt].children[0].classList.add('num2')
                } else{
                  newSpan.classList.add('num1')
                  dateP[icnt].children[0].classList.add('num1')
                }
              }
            icnt++
          })

            nov = (700-(((numA-1)%7)*100));
            ov = dateP.length*100 - nov;
            newSpan.classList.add("sch-a");
            newSpan.style.width = nov + "px";
            newSpan.innerHTML = document.querySelector('.title').value;
            document.querySelector(".active-a").children[2].append(newSpan);
            cnt--;
            
            var rsInDateP = Array.from(dateP).filter(element => element.classList.contains('rowstart'));
            if(rsInDateP[0].classList.contains('active-a')){
              rsInDateP.shift();
            }
            rsInDateP.forEach((item,index)=>{
              overNum = false;
              num1 = false;
              num2 = false;
              num3 = false;
              if(cnt>=1){
                
                var newSpan = document.createElement("div");
                slicedDate[index+1].forEach((iitem)=>{
                  if(iitem.includes('overNum')){
                    overNum = true;
                  }
                  if(iitem.includes('num3')){
                    num3 = true;
                  }
                  if(iitem.includes('num2')){
                    num2 = true;
                  }
                  if(iitem.includes('num1')) {
                    num1 = true;
                  }
                })
                slicedDate[index+1].forEach((item)=>{
                  if(num1&&num2&&num3){   
                    newSpan.classList.add('overNum')
                    dateP[icnt].children[0].classList.add('overNum')
                  } else {
                    if(num3){
                      if(num2){
                        newSpan.classList.add('num1')
                        dateP[icnt].children[0].classList.add('num1')
                      } else if(num1){
                        newSpan.classList.add('num2')
                        dateP[icnt].children[0].classList.add('num2')
                      } else {
                        newSpan.classList.add('num1')
                        dateP[icnt].children[0].classList.add('num1')
                      }
                    } else if(num2){
                      if(num1){
                        newSpan.classList.add('num3')
                        dateP[icnt].children[0].classList.add('num3')
                      }else{             
                        newSpan.classList.add('num1')
                        dateP[icnt].children[0].classList.add('num1')
                      }
                    } else if(num1){
                      newSpan.classList.add('num2')
                      dateP[icnt].children[0].classList.add('num2')
                    } else{
                      newSpan.classList.add('num1')
                      dateP[icnt].children[0].classList.add('num1')
                    }
                  }
                icnt++
              })
                newSpan.classList.add("sch-r");
                newSpan.style.width = 685 + "px";
                ov = ov - 700;
                newSpan.innerHTML = document.querySelector('.title').value;
                item.children[2].append(newSpan);
                cnt--;
              } else {
                
                var newSpan = document.createElement("div");
                slicedDate[index+1].forEach((iitem)=>{
                  if(iitem.includes('overNum')){
                    overNum = true;
                  }
                  if(iitem.includes('num3')){
                    num3 = true;
                  }
                  if(iitem.includes('num2')){
                    num2 = true;
                  }
                  if(iitem.includes('num1')) {
                    num1 = true;
                  }
                })
                slicedDate[index+1].forEach((item)=>{
                  if(num1&&num2&&num3){   
                    newSpan.classList.add('overNum')
                    dateP[icnt].children[0].classList.add('overNum')
                  } else {
                    if(num3){
                      if(num2){
                        newSpan.classList.add('num1')
                        dateP[icnt].children[0].classList.add('num1')
                      } else if(num1){
                        newSpan.classList.add('num2')
                        dateP[icnt].children[0].classList.add('num2')
                      } else {
                        newSpan.classList.add('num1')
                        dateP[icnt].children[0].classList.add('num1')
                      }
                    } else if(num2){
                      if(num1){
                        newSpan.classList.add('num3')
                        dateP[icnt].children[0].classList.add('num3')
                      }else{             
                        newSpan.classList.add('num1')
                        dateP[icnt].children[0].classList.add('num1')
                      }
                    } else if(num1){
                      newSpan.classList.add('num2')
                      dateP[icnt].children[0].classList.add('num2')
                    } else{
                      newSpan.classList.add('num1')
                      dateP[icnt].children[0].classList.add('num1')
                    }
                  }
                icnt++
              })
                newSpan.classList.add("sch-b");
                newSpan.style.width = (ov-15) + "px";
                newSpan.innerHTML = document.querySelector('.title').value;
                item.children[2].append(newSpan);
              }
            })
          }
        }
      }
    closeModal();
    }

  function openModal() {
    document.getElementById('myModal1').style.display = 'flex';
    document.getElementById('myModal1').classList.add('opened')
    document.querySelector('.s').value = z;
    document.querySelector('.e').value = w;
  }
  
  function closeModal() {
    document.getElementById('myModal1').style.display = 'none';
    clearActiveDays();
    clearRange();
    document.getElementById('myModal1').classList.remove('opened')
  }
  document.getElementById('close').addEventListener("click",closeModal());
  
  window.onclick = function(event) {
    var modal = document.getElementById('myModal1');
    if (event.target === modal) {
      closeModal();
    }
  }
}, 10);
} 
df();
})
</script>
	<!-- Footer -->
<%@ include file="../../includes/footer.jsp" %>	
