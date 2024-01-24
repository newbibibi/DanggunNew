<%@page import="org.spring.domain.BoardVO"%>
<%@page import="org.spring.domain.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><%@ page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
// Check if the userVO is present in the session and contains a non-empty nickname
UserVO userVO = (UserVO) session.getAttribute("user");

if (userVO == null || userVO.getNickname() == null || userVO.getNickname().isEmpty()) {
	// Log the details for debugging
	System.out.println("Redirecting to login page. User: " + userVO);
	System.out.println("Nickname: " + (userVO != null ? userVO.getNickname() : "null"));

	response.sendRedirect("/login/login"); // Redirect to the login page if userVO or nickname is not present
}
String nickname = userVO.getNickname();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>

<%@include file="../includes/header.jsp"%>
<style>
.btn-post {
	border: none; /* Remove border */
	border-radius: 5px;
	background-color: transparent;
	/* Remove background color */
	padding: 0; /* Remove padding */
	cursor: pointer;
	background-color: transparent;
}

/* Optionally, you can add some styling for hover effect or other states */
.btn-post:hover {
	background-color: #32894c;
	color: white;
}

.rotate180 {
	transform: rotate(180deg); /* 180도 회전 설정 */
}/* 모달 배경 오버레이에 대한 스타일 */
    #reportModalB, #reportModalC {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.4);
    }

    /* 모달 내용에 대한 스타일 */
    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
    }

    /* 닫기 버튼에 대한 스타일 */
    .close-btn {
        margin-top: 10px;
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        cursor: pointer;
    }

    .close-btn:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
	<section id="main-container" class="main-container">
		<div class="container">
			<div class="panel-body"
				style="display: block; justify-content: space-between; align-items: center; text-align: right;">
				<div class="recon-top">
					<h1 style="margin-right: 10px; text-align: left;">
						<span>${board.title}</span>
					</h1>

					<p>
						<span><fmt:formatDate value="${board.regDate}"
								pattern="yyyy-MM-dd HH:mm:ss" /></span> <span
							style="margin-left: 10px;">조회수: ${board.views}</span> <span
							style="margin-left: 10px;">좋아요: ${board.likes}</span>
					</p>
				</div>
			</div>


			<!--  <p>
				작성자: <span> <c:choose>
						<c:when test="${board.anonymous == 1}">익명</c:when>
						<c:otherwise>${board.nickname}</c:otherwise>
					</c:choose></span>
			</p>-->
			<!--<c:if test="${not empty imageList}">
			<div class="image-gallery">
				<c:forEach items="${imageList}" var="imageUrl">
					<img src="../../resources/boardImage/${imageUrl}" alt="게시글 이미지" />
				</c:forEach>
			</div>
		</c:if>-->

			<div class="recon-body" style="padding-top: 0 !important;">

				<button class="btn-post" id="reportBtnB" type="button"
					style="float: right;">신고</button>
				<br> <br>

				<div style="margin-bottom: 20px">${board.content}</div>

				<div>

					<div style="display: flex; justify-content: center">


						<c:choose>
							<c:when test="${liked == -1}">
								<form action="/board/like" method="post"
									style="text-align: center">
									<input type="hidden" name="like" value="like"> <input
										type="hidden" name="bno" value="${board.bno}"> <input
										type="hidden" name="likestatus" value="1">
									<button class="btn likebtn" type="submit">
										<img class="rotate180"
											src="../../resources/board/free-icon-dislike-179760.png"
											width="30px"> ${board.likes}
									</button>
								</form>
								<form action="/board/like" method="post"
									style="text-align: center">
									<input type="hidden" name="like" value="like"> <input
										type="hidden" name="bno" value="${board.bno}"> <input
										type="hidden" name="likestatus" value="0">
									<button class="btn likebtn" type="submit">
										<img src="../../resources/board/free-icon-dislike-179760.png"
											width="30px"> ${board.dislikes}
									</button>
								</form>
							</c:when>
							<c:when test="${liked == 0}">

								<button class="btn likebtn">
									<img class="rotate180"
										src="../../resources/board/free-icon-dislike-179760.png"
										width="30px"> ${board.likes}
								</button>

								<form action="/board/like" method="post"
									style="text-align: center">
									<input type="hidden" name="like" value="unlike"> <input
										type="hidden" name="bno" value="${board.bno}"> <input
										type="hidden" name="likestatus" value="0">
									<button class="btn likebtn" type="submit">
										<img class="rotate180"
											src="../../resources/board/free-icon-like-179756.png"
											width="30px"> ${board.dislikes}
									</button>
								</form>
							</c:when>
							<c:otherwise>
								<form action="/board/like" method="post"
									style="text-align: center">
									<input type="hidden" name="like" value="unlike"> <input
										type="hidden" name="bno" value="${board.bno}"> <input
										type="hidden" name="likestatus" value="1">
									<button class="btn likebtn" type="submit">
										<img src="../../resources/board/free-icon-like-179655.png"
											width="30px"> ${board.likes}
									</button>
								</form>

								<button class="btn likebtn">
									<img src="../../resources/board/free-icon-dislike-179760.png"
										width="30px"> ${board.dislikes}
								</button>

							</c:otherwise>
						</c:choose>


					</div>
					<a style="float: left" href="/board/list">목록으로</a>
					<div style="display: flex; flex-direction: row-reverse;">

						<c:if test="${user != null}">
							<c:set var="userRole" value="${user.admin}" />
							<c:if test="${user.nickname eq board.nickname}">
								<form action="/board/update" method="post">
									<input type="hidden" name="bno" value="${board.bno}" /> <span>
										/ </span>
									<button class="btn-post" type="submit">&nbsp;수정</button>
								</form>
							</c:if>
							<c:if test="${userRole == 1 || user.nickname eq board.nickname}">


								<form action="/board/delete" method="post"
									style="margin: auto 0 0 auto;"
									onsubmit="return confirm('정말 삭제하시겠습니까?');">
									<input type="hidden" name="bno" value="${board.bno}">
									<button class="btn-post" type="submit">삭제</button>
								</form>
							</c:if>
						</c:if>
					</div>
				</div>
			</div>

			<div id="commentForm">
				<h3>
					댓글 달기<span style="font-size: 17px;">[${board.commentCnt}]</span>
				</h3>
				<form action="/board/commentAdd" method="post">
					<input type="hidden" name="bno" value="${board.bno}" /> <input
						type="hidden" name="nickname" value=<%=nickname%> />
					<textarea name="content"
						style="width: 100%; height: 10vh; resize: none;" required></textarea>
					<div style="display: flex; justify-content: flex-end;">
						<input type="checkbox" id="isAnonymous" name="isAnonymous"
							value="1"> <label style="margin: 10px;" for="isAnonymous">익명으로
							작성하기</label>
						<button class="btn-primary" type="submit">댓글 등록</button>
					</div>
				</form>
			</div>

			<div id="reportModalB" class="modal"">
				<div class="modal-content">
					<h2>신고하기</h2>
					<form action="/board/report" method="post">
						<input type="hidden" name="bno" value="${board.bno}"> <input
							type="hidden" name="nickname" value="${board.nickname}">
						<input type="hidden" name="reporter" value="d"><br> <label
							for="reason">신고 이유:</label> <select name="reason" id="reason">
							<option value="광고">광고</option>
							<option value="도배">도배</option>
							<option value="음란물">음란물</option>
							<option value="욕설">욕설</option>
							<option value="개인정보침해">개인정보침해</option>
							<option value="저작권침해">저작권침해</option>
							<option value="기타">기타</option>
						</select><br> <br> <label>세부 사항:</label>
						<textarea name="details"></textarea>
						<br>
						<button class="btn-post" type="submit">신고 제출</button>
					</form>
					<button class="close-btn" type="button"
						onclick="document.getElementById('reportModalB').style.display='none'">닫기</button>
				</div>
			</div>


			<!-- 댓글 목록 -->
			<div id="commentList">
				<h3>댓글</h3>
				<c:forEach items="${comments}" var="comment">
					<c:if test="${comment.parentCno == 0}">
						<div class="commentItem">

							<div class="commentInfo">
								<span class="authorName"> <c:out
										value="${comment.isAnonymous == 1 ? '익명' : comment.nickname}" /></span>

								<div style="padding: 10px;" class="commentContent${comment.cno}"
									id="commentContent${comment.cno}">${comment.content}</div>
								<div id="editForm${comment.cno}" style="display: none;">
									<form onsubmit="return updateComment(${comment.cno});">
										<input type="hidden" name="cno" value="${comment.cno}" /> <input
											type="text" id="editContent${comment.cno}" name="content"
											value="${comment.content}" required />
										<button class="btn-post" type="submit">수정 완료</button>
									</form>
								</div>

								<!-- 대댓글 -->
								<button class="btn-post" type="button"
									onclick="toggleReplyForm(${comment.cno})">답글</button>
								<span> / </span>


								<button class="btn-post" id="reportBtnC${comment.cno}"
									type="button" onclick="showReportForm(${comment.cno})">신고</button>
								<!-- 싫어요 버튼 -->
								<button class="btn-post" type="button" style="float: right;"
									onclick="likeComment(${comment.cno}, 0)">👎
									${comment.dislikes}</button>
								<!-- 좋아요 버튼 -->
								<button class="btn-post" type="button" style="float: right;"
									onclick="likeComment(${comment.cno}, 1)">👍
									${comment.likes} /</button>
								<!-- 댓글 삭제 버튼 -->
								<c:if test="${user != null}">
									<c:set var="userRole" value="${user.admin}" />

									<c:if test="${userRole == 1 || user.nickname eq board.nickname}">
										<form action="/board/cmtDelete" method="post" style=""
											onsubmit="return confirm('정말 삭제하시겠습니까?');">
											<input type="hidden" name="bno" value="${board.bno}">
											<input type="hidden" name="cno" value="${comment.cno}">
											<button class="btn-post" type="submit">삭제</button>

											<!-- 수정 -->
											<c:if test="${user.nickname eq board.nickname}">
												<span> / </span>
												<button class="btn-post" type="button"
													onclick="editComment(${comment.cno})">수정</button>
											</c:if>
										</form>
									</c:if>
								</c:if>






								<div id="reportModalC${comment.cno}" class="modal"
									style="display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0.4);">
									<div class="modal-content"
										style="background-color: #fefefe; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 80%;">
										<h2>신고하기</h2>
										<form action="/board/report" method="post">
											<input type="hidden" name="cno" value="${comment.cno}">
											<input type="hidden" name="nickname"
												value="${board.nickname}"> <input type="hidden"
												name="reporter" value="d"><br> <label
												for="reason">신고 이유:</label> <select name="reason"
												id="reason">
												<option value="광고">광고</option>
												<option value="도배">도배</option>
												<option value="음란물">음란물</option>
												<option value="욕설">욕설</option>
												<option value="개인정보침해">개인정보침해</option>
												<option value="저작권침해">저작권침해</option>
												<option value="기타">기타</option>
											</select><br> <br> <label>세부 사항:</label>
											<textarea name="details"></textarea>
											<br>
											<button class="btn-post" type="submit">신고 제출</button>
										</form>
										<button class="close-btn" type="button"
											onclick="document.getElementById('reportModalC${comment.cno}').style.display='none'">닫기</button>
									</div>
								</div>





								<!-- 대댓글, 수정, 삭제 등 추가 기능에 대한 링크나 버튼을 여기에 추가할 수 있습니다. -->
								<div id="replyForm${comment.cno}" style="display: none;">
									<form action="/board/commentAdd" method="post">
										<input type="hidden" name="nickname" value=<%=nickname%> /> <input
											type="hidden" name="bno" value="${board.bno}" /> <input
											type="hidden" name="parentCno" value="${comment.cno}">
										<textarea name="content" required></textarea>
										<input type="checkbox" name="isAnonymous" value="1"
											id="isAnonymous"> <label for="anonymous">익명으로
											댓글 작성</label>
										<button class="btn-primary" type="submit">등록</button>
									</form>
								</div>
							</div>
						</div>
					</c:if>
					<!-- 대댓글 표시 -->
					<c:forEach items="${comments}" var="reply">
						<c:if test="${reply.parentCno == comment.cno}">
							<div style="background-color: #f2f2f2;">
								<div class="commentItem" style="margin-left: 30px;">
									<!-- 대댓글을 댓글보다 안쪽으로 들여쓰기 -->

									<div class="commentInfo${reply.cno}">
										⤷<span class="authorName"> <c:out
												value="${reply.isAnonymous == 1 ? '익명' : reply.nickname}" /></span>
										<div style="padding: 10px;" class="commentContent${reply.cno}"
											id="commentContent${reply.cno}">${reply.content}</div>
										<div id="editForm${reply.cno}" style="display: none;">
											<form onsubmit="return updateComment(${reply.cno});">
												<input type="hidden" name="cno" value="${reply.cno}" /> <input
													type="text" id="editContent${reply.cno}" name="content"
													value="${reply.content}" required />
												<button class="btn-post" type="submit">수정 완료</button>
											</form>
										</div>
										<!-- 대댓글 -->
										<button class="btn-post" type="button"
											onclick="toggleReplyForm(${reply.cno})">답글</button>
										<span> / </span>
										<button class="btn-post" id="reportBtnR${reply.cno}"
											type="button" onclick="showReportForm(${reply.cno})">신고</button>
										<!-- 싫어요 버튼 -->

										<button class="btn-post" type="button"
											onclick="likeComment(${reply.cno}, 0)" style="float: right;">👎
											${reply.dislikes}</button>
										<!-- 좋아요 버튼 -->

										<button class="btn-post" type="button"
											onclick="likeComment(${reply.cno}, 1)" style="float: right;">👍
											${reply.likes} /</button>
										<!-- 수정 -->



										<div id="reportModalC${reply.cno}" class="modal"
											style="display: none; position: fixed; z-index: 1; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0.4);">
											<div class="modal-content"
												style="background-color: #fefefe; margin: 15% auto; padding: 20px; border: 1px solid #888; width: 80%;">
												<h2>신고하기</h2>
												<form action="/board/report" method="post">
													<input type="hidden" name="cno" value="${reply.cno}">
													<input type="hidden" name="nickname"
														value="${board.nickname}"> <input type="hidden"
														name="reporter" value="d"><br> <label
														for="reason">신고 이유:</label> <select name="reason"
														id="reason">
														<option value="광고">광고</option>
														<option value="도배">도배</option>
														<option value="음란물">음란물</option>
														<option value="욕설">욕설</option>
														<option value="개인정보침해">개인정보침해</option>
														<option value="저작권침해">저작권침해</option>
														<option value="기타">기타</option>
													</select><br> <br> <label>세부 사항:</label>
													<textarea name="details"></textarea>
													<br>
													<button class="btn-post" type="submit">신고 제출</button>
												</form>
												<button class="close-btn" type="button"
													onclick="document.getElementById('reportModalC${reply.cno}').style.display='none'">닫기</button>
											</div>
										</div>
										<c:if test="${user != null}">
											<c:set var="userRole" value="${user.admin}" />

											<c:if
												test="${userRole == 1 || user.nickname eq board.nickname}">
												<form action="/board/cmtDelete" method="post"
													onsubmit="return confirm('정말 삭제하시겠습니까?');">
													<input type="hidden" name="bno" value="${board.bno}" /> <input
														type="hidden" name="cno" value="${reply.cno}" />
													<button class="btn-post" type="submit">삭제</button>

													<c:if test="${user.nickname eq board.nickname}">
														<span> / </span>
														<button class="btn-post" type="button"
															onclick="editComment(${reply.cno})">수정</button>
													</c:if>
												</form>
											</c:if>
										</c:if>





										<div id="replyForm${reply.cno}" style="display: none;">
											<form action="/board/commentAdd" method="post">
												<input type="hidden" name="nickname" value=<%=nickname%> />
												<input type="hidden" name="bno" value="${board.bno}" /> <input
													type="hidden" name="parentCno" value="${comment.cno}">
												<textarea name="content" required></textarea>
												<input type="checkbox" name="isAnonymous" value="1"
													id="isAnonymous"> <label for="anonymous">익명으로
													댓글 작성</label>
												<button class="btn-post" type="submit">등록</button>
											</form>
										</div>
									</div>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</c:forEach>
			</div>
		</div>
	</section>
	<%@include file="../includes/footer.jsp"%>

	<script>
//신고 버튼 클릭 이벤트
	
document.getElementById('reportBtnB').onclick = function() {
    document.getElementById('reportModalB').style.display = 'block';
}

function showReportForm(cno) {
    var reportModal = document.getElementById('reportModalC' + cno);

    if (reportModal.style.display === 'none' || reportModal.style.display === '') {
        reportModal.style.display = 'block';
    } else {
        reportModal.style.display = 'none';
    }
}


    // 대댓글 입력 폼을 표시하거나 숨기는 함수
    function toggleReplyForm(cno) {
    var form = document.getElementById('replyForm' + cno);
    var authorNameElement = document.querySelector('.commentInfo' + cno + ' .authorName'); // 각 대댓글에 대한 작성자 이름 요소 선택
    var textarea = form.querySelector('textarea');
    
    if (form.style.display === 'none' || form.style.display === '') {
        form.style.display = 'block';
        textarea.value = '@' + authorNameElement.innerText + ' '; // 작성자 이름을 입력창에 미리 채웁니다.
    } else {
        form.style.display = 'none';
    }
}




    function editComment(cno) {
        var commentContent = document.getElementById('commentContent' + cno);
        var form = document.getElementById('editForm' + cno);

        if (form.style.display === 'none' || form.style.display === '') {
            form.style.display = 'block';
            commentContent.style.display = 'none';
        } else {
            form.style.display = 'none';
            commentContent.style.display = 'block';
        }
    }

	

    // 댓글 수정 처리
    function updateComment(cno) {
        var editContent = document.getElementById('editContent' + cno).value;

        // AJAX 요청
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '/board/cmtUpdate');
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(JSON.stringify({
            cno: cno,
            content: editContent
        }));

        xhr.onload = function() {
            if (xhr.status === 200 || xhr.status === 201) {
                alert('댓글이 수정되었습니다.');
                location.reload(); // 페이지를 리로드하여 수정된 댓글을 보여줍니다.
            } else {
                console.error(xhr.responseText);
            }
        };

        return false; // 폼 제출 방지
    }
 // 댓글 숨기기/나타나기 토글 함수
 
   var userNickname = '<%=nickname%>';
   
 function likeComment(cno, no) {
	 
    $.ajax({
        url: '/board/likeComment',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            cno: cno,
            nickname: userNickname,
            likestatus: no
        }),
        success: function(data) {
            if (data.success) {
                const button = $(`button[onclick="likeComment(${cno})"]`);
                location.reload();
            } else {
                alert('좋아요 처리에 실패하였습니다.');
            }
        },
        error: function() {
            alert('서버와의 통신에 문제가 발생했습니다.');
        }
    });
}


</script>