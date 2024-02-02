<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="../../includes/header.jsp" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
.accordion-group .card-body img {
    max-width: 300px;
}
</style>
    <div id="banner-area" class="banner-area" style="background-color: rgb(50 137 76)">
  <div class="banner-text">
    <div class="container">
        <div class="row">
          <div class="col-lg-12">
              <div class="banner-heading">
                <h1 class="banner-title">고객센터</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb justify-content-center">
                      <li class="breadcrumb-item"><a href="/center/cscenter/faq">FAQ</a></li>
                      <li class="breadcrumb-item"><a href="/center/cscenter/fqna">1:1문의</a></li>
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
   <c:if test="${empty user}">
		<script>
                    // 사용자가 비어 있으면 로그인 페이지로 자동 이동
                    window.location.href = "/login/login";
                </script>
             </c:if>
             <h2>자주묻는 질문</h2>
   <div class="shuffle-btn-group">
   <label class="active" for="all">
        <input type="radio" name="shuffle-filter" class="category-radio" id="all" value="all" checked="checked">전체
    </label>
    <label class="" for="account">
        <input type="radio" name="shuffle-filter" class="category-radio" id="account" value="account" >계정/보안
    </label>
    <label for="homepage" class="">
        <input type="radio" name="shuffle-filter" class="category-radio" id="homepage" value="homepage">홈페이지
    </label>
</div>
   <div class="accordion accordion-group accordion-classic" id="construction-accordion">
        </div>
    </div>
    </section>
    <script type="text/javascript">
        $(document).ready(function () {
        	
            initialLoad();

            $(".category-radio").change(function () {
            	var selectedCategory = '';

                if ($(this).val() === "homepage") {
                    selectedCategory = 'H';
                } else if ($(this).val() === "account") {
                    selectedCategory = 'A';
                }

                loadTableData(selectedCategory);
                $(".shuffle-btn-group label").removeClass("active");
                $(".shuffle-btn-group label input").removeAttr("checked");
                $(this).parent("label").addClass("active");
                $(this).attr("checked", "checked");
            });

            function initialLoad() {
            	var initialCategory = '';
                loadTableData(initialCategory);
                $(".shuffle-btn-group label:first").addClass("active");
                $(".shuffle-btn-group label:first input").attr("checked", "checked");
            }

            function loadTableData(category) {
            	$.ajax({
                    url: "/center/cscenter/faqList",
                    type: "POST",
                    dataType: "json",
                    data: {
                        category: category
                    },
                    success: function (data) {
                        var faqul = $("#construction-accordion"); // Assuming this is the container where you want to append your FAQ items

                        // Clear previous content
                        faqul.empty();

                        $.each(data, function (index, faq) {
                            // Create card div
                            var card = $("<div>").addClass("card");

                            // Create card header div
                            var cardHeader = $("<div>").addClass("card-header p-0 bg-transparent").attr("id", "heading" + index);

                            // Create h2 element
                            var h2 = $("<h2>").addClass("mb-0");

                            // Create button element
                            var button = $("<button>")
                                .addClass("btn btn-block text-left collapsed")
                                .attr({
                                    "type": "button",
                                    "data-toggle": "collapse",
                                    "data-target": "#collapse" + index, // Use a unique identifier for each FAQ
                                    "aria-expanded": "false",
                                    "aria-controls": "collapse" + index
                                })
                                .text("Q "+faq.title);

                            // Append button to h2
                            h2.append(button);

                            // Append h2 to card header
                            cardHeader.append(h2);

                            // Create collapse div
                            var collapseDiv = $("<div>")
                                .addClass("collapse")
                                .attr({
                                    "id": "collapse" + index, // Use the same unique identifier as in the button
                                    "aria-labelledby": "heading" + index,
                                    "data-parent": "#construction-accordion"
                                })
                                .html("<div class='card-body'>" + faq.content + "</div>"); // Use .html() to include HTML content

                            // Append card header and collapse div to card
                            card.append(cardHeader);
                            card.append(collapseDiv);

                            // Append the card to the FAQ container
                            faqul.append(card);
                        });
                    },
                    error: function (e) {
                        console.log(e);
                    }
                });
            }
            
        });
    </script>
<%@include file="../../includes/footer.jsp"%>