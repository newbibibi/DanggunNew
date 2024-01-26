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
<div class="col-x">
	<div class="nogheader">
	<h2>
		<span class="scatn">
			<c:if test="${vo.category=='NN'}">
				공지 
			</c:if>
			<c:if test="${vo.category=='FF'}">
				점검 
			</c:if>
		</span>
		
		<span>
			${vo.title }
		</span>
	</h2>
		<div class="article_date">
			${vo.regDate }
		</div>
	</div>
	<div class="ncon">
		${vo.content }
	</div>
	<c:if test="${user.admin == 1 }">
	<button type="button" ><a href="/center/notice/modify?nno=${vo.nno }">수정</a></button>
	</c:if>
</div>
	
<script type="text/javascript">
	console.log("${vo}");
</script>
<%@ include file="../../includes/footer.jsp" %>