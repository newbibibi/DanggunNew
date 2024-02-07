<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 상대경로를 유일하게 쓰는 곳 -->
<%@include file="../includes/header.jsp"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

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
  .activePage{
  	font-weight: bolder;
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
  text-align: left;
}
  
thead {
  font-weight: bold !important;
  color: #fff !important;
  background: #73685d !important;
}
  
 td, th {
  padding: 1em .5em !important;
  vertical-align: middle !important;
  text-align:center !important;
}
  
 td {
  border-bottom: 1px solid rgba(0,0,0,.1) !important;
  background: #fff !important; 
}

	option {
	text-align: center;
}

@media all and (max-width: 768px) {
    
  table, thead, tbody, th, td, tr {
    display: block;
  }
  
  th {
    text-align: center !important;;
  }
  
  table {
    position: relative; 
    padding-bottom: 0;
    border: none;
    box-shadow: 0 0 10px rgba(0,0,0,.2);
  }
  
  thead {
    float: left;
    white-space: nowrap;
  }
  
  tbody {
    overflow-x: auto;
    overflow-y: hidden;
    position: relative;
    white-space: nowrap;
  }
  
  tr {
    display: inline-block;
    vertical-align: center !important;;
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
					<h2 style="text-align: left;">회원 목록</h2>
						<table id="viewer" class="table table-striped table-bordered table-hover">

						</table>
						<div><select name="type" style="height:31px;">
						<option value="all" selected="selected">전체</option>
						<option value="i">아이디</option>
						<option value="n">닉네임</option>
						<option value="e">이메일</option>
						<option value="b">정지 여부(Y/N)</option>
						</select> <input type="text" name="keyword" class="form-control-sm"><input type="button" onclick="search()" value="검색"></div>
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
	paging(1);
});
	function search(){
		paging(1);
	}
	
	function baned(nick){
		let banDate;
		if($("."+nick).val()!=0){
			banDate=new Date(new Date().getTime() + ($("."+nick).val()*24*60*60*1000+(60*1000*60*9)));
		}else{
			banDate=null;
		}
		$.ajax({
			  url: '/admin/baned',
			  method: 'POST',
			  contentType: 'application/json',
			  data: JSON.stringify({"nickname":nick,"no":0,"gubun":"없음", "baned":banDate}),
			  success: function(data) {
			  	paging(1);
			  },
			  error: function(xhr, status, error) {
			    console.log(error);
			  }
			});
	}
	
	function paging(num){
		let viewer=$("#viewer");
		viewer.html("");
		let th=["아이디","닉네임","이메일","정지 여부", "정지 기간", "정지/해제", "실행"];
		let tr=$("<tr>");
		for (let i = 0; i < th.length; i++) {
			  let td = $("<th>").text(th[i]);
			  tr.append(td);
		}
		viewer.append($("<thead>").append(tr));
		$.ajax({
		    url: '../admin/userList',
		    method: 'POST',
		    data: {
		        pageNum: num,
		        type: $("[name='type']").val(),
		        keyword: $("[name='keyword']").val()
		    },
		    dataType: 'json',
		    success: function(response) {
		        console.log(response);
		        if(response.userList!=null){
		        for (let list of response.userList) {
		            let tr = $("<tr>");
		            let value = "<td>" + list.id + "</td>" + "<td>" + list.nickname + "</td>"+ "<td>" + list.email + "</td>" + "<td>" + (list.baned == null ? "N" : "Y") + "</td>" + "<td>" + (list.baned == null ? "N" : moment(list.baned).format('YYYY-MM-DD HH:mm:ss')) + "</td>" + "<td><select class=" + list.nickname + "><option value=0>정지 해제</option><option value=3>3일</option><option value=7>7일</option><option value=15>15일</option><option value=30>30일</option><option value=5000>5000일</option></select></td><td><a href=javascript:baned('" + list.nickname + "')>실행</a>";
		            tr.append(value);
		            $("#viewer").append(tr);
		        }
		        let tr = $("<tr></tr>"); let td = $("<td colspan=9></td>"); tr.append(td);
		        let pm = response.pageMaker; let p = "";
	            p += pm.prev ? "<a href='javascript:paging(" + (pm.startPage-1) + ")'>이전</a>&nbsp;" : "";
		        for (let i = pm.startPage; i < response.pageMaker.endPage + 1; i++) {
		        	p += i==num ? "<a class='activePage' href=javascript:paging(" + i + ")>" + i + "</a> " :"<a href=javascript:paging(" + i + ")>" + i + "</a> ";
		        }
		        p += pm.next ? "&nbsp;<a href='javascript:paging(" + (pm.endPage+1) + ")'>다음</a>" : "";
	            td.append(p);
	            $("#viewer").append(tr);
		    }
		    else{
		    	$("#viewer").append("<tr><td colspan=7>검색된 유저가 없습니다.</td></tr>");	
		    }
		    },
		    error: function(xhr, status, error) {
		        // 요청이 실패했을 때 실행할 코드
		        $("#viewer").append("<tr><td colspan=7>검색된 유저가 없습니다.</td></tr>");	
		        console.log("AJAX 요청 실패:", error);
		    }
		});
	}

</script>

<%@include file="../includes/footer.jsp"%>
