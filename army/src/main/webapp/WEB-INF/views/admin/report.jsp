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
  .modal-dialog {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
    margin: 0 auto;
  }
  
  body {
  padding:1.5em;
  background: #f5f5f5
}

  .activePage{
  	font-weight: bolder;
  }

body {
  padding:1.5em;
  background: #f5f5f5
}

table {
  border: 1px #a39485 solid;
  font-size: .9em;
  box-shadow: 0 2px 5px rgba(0,0,0,.25);
  width: 100%;
  border-collapse: collapse;
  border-radius: 5px;
  overflow: hidden;
}

th {
  vertical-align: middle !important;
  text-align: center !important;
  }
  
thead {
  font-weight: bold;
  color: #fff;
  background: #73685d;
}
  
 td, th {
  padding: 1em .5em;
    vertical-align: middle !important;
  text-align: center !important;
}
  
 td {
  border-bottom: 1px solid rgba(0,0,0,.1);
  background: #fff;
}
option{
	text-align: center;
}

 td>select{
 	width:95%;
 }
 th:first-child {
	min-width : 1vw;
}
 th:nth-child(2) {
	min-width : 3vw;
}
 th:nth-child(3) {
	min-width : 12vw;
}
 th:nth-child(4) {
	min-width : 17vw;
}
 th:nth-child(5) {
	min-width: 6vw;
}
 th:nth-child(6) {
	min-width : 4vw;
}
 th:nth-child(7) {
	min-width : 4vw;
}
 th:nth-child(8) {
	min-width : 8vw;
}
 th:nth-child(9) {
	min-width : 8vw;
}
 th:nth-child(10) {
	min-width: 5vw;
}
 @media all and (max-width: 768px) {
    
  table, thead, tbody, th, td, tr {
    display: block;
  }
  
  th {
    text-align: center;
  }
  
  table {
    position: relative; 
    padding-bottom: 0;
    border: none;
    box-shadow: 0 0 10px rgba(0,0,0,.2);
  }
  
  thead {
    float: left;
     white-space: normal;
  }
  
  tbody {
    overflow-x: auto;
    overflow-y: hidden;
    position: relative;
    white-space: normal;
  }
  
  tr {
    display: inline-block;
    vertical-align: middle;
  }
  
  th {
    border-bottom: 1px solid #a39485;
  }
  
  td {
    border-bottom: 1px solid #e5e5e5;
  }
  
  
  }

</style>
<div id="banner-area" class="banner-area"
	style="background-color: rgb(50, 137, 76)">
	<div class="banner-text">
		<div class="container" >
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
						<table id="viewer" class="table table-striped table-bordered table-hover">

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

<div id="view" class="modal fade" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content" style="height: 90vh; width:50vw">
      <div class="modal-header">
        <h5 class="modal-title">상세 보기</h5>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      <div class="modal-body" style="width:100%; height:65vh;">
     	 <iframe id="modalIframe" src="" style="width:100%; height: 100%; zoom:0.7;"></iframe>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript">
$("document").ready(()=>{
	report(1);
	$('[data-toggle="tooltip"]').tooltip();
});
function baned(nick,no,gubun){ // 번호와 게시글 댓글 구분
	let banDate;
	if($("[name="+no+gubun+"punishment]").val()!=0){
		banDate=new Date(new Date().getTime() + ($("[name="+no+gubun+"punishment]").val()*24*60*60*1000+(60*1000*60*9)));
	}else{
		banDate=null;
	}
	$.ajax({
		  url: '/admin/baned', // 요청을 보낼 서버의 URL을 입력하세요.
		  method: 'POST', // 요청 메서드를 선택하세요(GET, POST, 등).
		  contentType: 'application/json',
		  data: JSON.stringify({"nickname":nick,"no":no,"gubun":gubun+"no", "baned":banDate}), // 요청에 포함될 데이터를 객체 형태로 입력하세요.
		  success: function(data) {
		  	console.log(data);
		  	report(1);
		  },
		  error: function(xhr, status, error) {
		    console.log(error); // 에러 메시지를 출력하거나 에러 처리를 수행하세요.
		  }
		});
}

function modalBoard(bno){
	console.log(bno);
	$("#modalIframe").attr("src", "../board/view/"+bno);
	$("#view").modal("show");

}

function checkedExcute(){
	$("[type=checkbox]:checked").each(function(){
		let value=$(this).val().split("/");
		baned(value[2],value[1],value[0]);
	});
}

$("body").on("change","[name='sel']", function() {
	if ($("[name='sel']").prop("checked")) {
		$("[type='checkbox']").prop("checked", true);
	} else {
		$("[type='checkbox']").prop("checked", false);
	}
	});

function report(pageNum){
	console.log(pageNum);
	$.ajax({
		  url: '../admin/reportList', // 요청을 보낼 서버의 URL을 입력하세요.
		  method: 'GET', // 요청 메서드를 선택하세요(GET, POST, 등).
		  data: {"pageNum":pageNum}, // 요청에 포함될 데이터를 객체 형태로 입력하세요.
		  success: function(data) {
		    console.log(data); // 응답 데이터를 출력하거나 원하는 작업을 수행하세요.
		    $("#viewer").html("");
		    $("#viewer").append("<thead><tr><th><input type=checkbox name=sel></th><th>종류</th><th>제목</th><th>내용</th><th>게시자</th><th>"+"고발자"+"</th><th>신고 분류</th><th>신고 사유</th><th>처벌 수위</th><th><a href='javascript:checkedExcute()'>선택 실행</a></th></tr></thead>");
		    if(data.reportList==null || data.reportList.length==0){
		    	$("#viewer").append("<tr><td colspan=10>신고된 게시글이 없습니다.</td></tr>");
		    }else{
		    for(let vo of data.reportList){
		    	let title=vo.title==null?"X":vo.title.length>9 ? vo.title.substring(0,15)+"...":vo.title;
		    	let content=vo.content.length>49 ? vo.content.substring(0,50)+"...":vo.content;
		    	let reporter= vo.reporter.split("/");
		    	let reason= vo.reasons.split("/");
		    	let detail= vo.details.split("/");
		    	
		    	let tip1="";
		    	let tip2="";
		    	
		    	if(vo.bno==null){
		    		$("#viewer").append("<tr><td><input type=checkbox value=c/"+vo.cno+"/"+vo.nickname+
		    				"></td><td><a href='javascript:modalBoard("+vo.cbno+")'>댓글</a></td><td>"+title+"</td><td"+ (content.includes("...") ? " data-toggle=tooltip data-placement=top title='" + vo.content + "'" : "") +">"+content+"</td><td>"+vo.nickname+"</td><td data-toggle=tooltip data-placement=top title="+vo.reporter+">"+reporter[0]+" 외 "+(reporter.length-1)+"인"+"<td data-toggle=tooltip data-placement=top title="+vo.reasons+">"+reason[0]+"</td>"+"<td data-toggle=tooltip data-placement=top title="+vo.details+">"+detail[0]+"</td><td><select name="+vo.cno+"cpunishment><option value='0'>무죄</option><option value='3'>3일 정지</option><option value='7'>7일 정지</option><option value='15'>15일 정지</option><option value='30'>30일 정지</option><option value='5000'>5000일 정지</option></select></td><td><a href=javascript:baned('"+vo.nickname+"',"+vo.cno+",'c')>실행</a></td></tr>");
			    }else if(vo.cno==null){
			    	$("#viewer").append("<tr><td><input type=checkbox value=b/" + vo.bno + "/" + vo.nickname + "></td><td><a href='javascript:modalBoard("+vo.bno+")'>글</a></td><td" + (title.includes("...") ? " data-toggle=tooltip data-placement=top title='" + vo.title + "'" : "") + ">" + title + "</td><td" + (content.includes("...") ? " data-toggle=tooltip data-placement=top title='" + vo.content + "'" : "") + ">" + content + "</td><td>" + vo.nickname + "</td><td data-toggle=tooltip data-placement=top title='" + vo.reporter + "'>" + reporter[0] + " 외 " + (reporter.length - 1) + "인"+"</td><td data-toggle=tooltip data-placement=top title='" + vo.reasons + "'>" + reason[0] + "</td><td data-toggle=tooltip data-placement=top title="+vo.details+">"+detail[0]+"</td><td><select name=" + vo.bno + "bpunishment><option value='0'>무죄</option><option value='3'>3일 정지</option><option value='7'>7일 정지</option><option value='15'>15일 정지</option><option value='30'>30일 정지</option><option value='5000'>5000일 정지</option></select></td><td><a href=javascript:baned('" + vo.nickname + "'," + vo.bno + ",'b')>실행</a></td></tr>");
		    }else{
					console.log("실패");
			    }
		    }
		    let tr = $("<tr></tr>");
			let td = $("<td colspan=10></td>");
			tr.append(td);
		    for(let i=1; i<data.pageMaker.endPage+1; i++){
		    	let pm=data.pageMaker;
		    	let p="";
		    	p+=pm.prev ? "<a href='javascript:report(${"+pm.startPage+"})'>이전</a>" : "";
		    	p+=pageNum==i?"<a class='activePage' href=javascript:report("+i+")>"+i+" </a>":"<a href=javascript:report("+i+")>"+i+"</a>";
		    	p+=pm.next ? "<a href='javascript:report(${"+pm.endPage+"})'>다음</a>" : "";
		    	td.append(p);
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

