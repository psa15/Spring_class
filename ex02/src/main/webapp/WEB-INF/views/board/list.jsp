<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>Pricing example · Bootstrap v4.6</title>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/pricing/">

    

    <!-- Bootstrap core CSS -->
<link href="/resources/css/bootstrap.min.css" rel="stylesheet">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

    
    <!-- Custom styles for this template -->
    <link href="/resources/css/pricing.css" rel="stylesheet">

	<script>
		$(document).ready(function(){
			//페이지 번호 클릭하면 동작하는 기능
			$("li.page-item a.page-link").on("click", function(e){
				//a태그는 클릭하면 걸린 링크로 이동, 우리는 파라미터값으로 제공해야 함
				//e : 이벤트 변수
				e.preventDefault(); //태그의 기본특성을 제거 <a>태그의 링크기능을 제거
				let url = "list?pageNum=" + $(this).attr("href") + "&amount=10"; 
					location.href=url;

			});
		});
	</script>
  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<%@include file="/WEB-INF/views/include/Carousel.jsp" %>

<div class="container">
  <h3>게시판 글목록</h3>
  <table class="table table-hover">
	  <thead>
	    <tr>
	      <th scope="col">글번호</th>
	      <th scope="col">제목</th>
	      <th scope="col">작성자</th>
	      <th scope="col">등록일</th>
	    </tr>
	  </thead>
	  <tbody>
	  <c:forEach items="${list}" var="board">
	    <tr>
	    <!-- BoardVO클래스의 필드명으로 코딩했지만, 호출은 getter메소드가 사용됨 -->
	    <%-- html 주석인 <!-- -->를 사용할 때 서버관련 코드는 작성 불가 
	    	 ${} : html주석은 서버에서도 보이기 때문에 jsp주석인 여기 안에 설명을 달아야 한다.--%>
	      <th scope="row"><c:out value="${board.bno}" /></th>
	      <td><a href="/board/get?bno=${board.bno}"><c:out value="${board.title}" /></a></td>
	      <td><c:out value="${board.writer}" /></td>
	      <td><fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
	    </tr>
	   </c:forEach> 
	   
	  </tbody>
	</table>
	<nav aria-label="...">
	  <ul class="pagination justify-content-center">
	  
	  	<%-- 이전표시 --%>
	  	<c:if test="${pageMaker.prev}">
		    <li class="page-item">
		      <a class="page-link" href="${pageMaker.startPage-1}">이전</a>
		    </li>
	    </c:if>
	    
	    <%-- 페이지 번호 표시 ( 1 2 3 4 5) --%>
	    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
	    	<li class='page-item ${pageMaker.cri.pageNum == num ? "active" : ""}'><a class="page-link" href="${num}">${num}</a></li>
	    </c:forEach>
	    <%--
	    	${pageMaker.cri.pageNum == num ? "active" : ""}
    	 	 - 현재 페이지와 num이 같으면 활성화(파랗게 칠해지는 거)
    	 	 - active가 현재페이지 파랗게 보여주는 키워드임 
	     --%>
	     
	    <%-- 
	    <li class="page-item active" aria-current="page">
	      <span class="page-link">2</span>
	    </li>
	    <li class="page-item"><a class="page-link" href="#">3</a></li>
	    --%>
	    
	    <%-- 다음표시 --%>
	    <c:if test="${pageMaker.next}">
		    <li class="page-item">
		      <a class="page-link" href="${pageMaker.endPage +1}">다음</a>
		    </li>
	    </c:if>
	    
	  </ul>
	</nav>

  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    
  </body>
</html>

