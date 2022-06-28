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

			let actionForm = $("#actionForm");
			//id가 actionForm인  form태그를 참조, 전역변수로 선언

			//페이지 번호 클릭하면 동작하는 기능
			$("li.page-item a.page-link").on("click", function(e){
				//a태그는 클릭하면 걸린 링크로 이동, 우리는 파라미터값으로 제공해야 함
				//e : 이벤트 변수
				e.preventDefault(); //태그의 기본특성을 제거 지금은 <a>태그의 링크기능을 제거
									
				/* 검색기능이 추가되어 아래구문 사용 X
					let url = "list?pageNum=" + $(this).attr("href") + "&amount=10"; 
					location.href=url;
				*/

							
				//현재 선택한 페이지번호 변경작업 <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				actionForm.find("input[name='pageNum']").val($(this).attr("href")); //find() : actionForm이 폼태그를 참조하고, 폼태그의 하위 태그들을 찾고자할 때 쓰는 메소드
				
				//뒤로가기 누를 때 글번호가 주소에 저장되어 페이지 번호를 눌러도 유지되는 것을 지우는 코드
				//글번호 저장된 태그는 주소가 변하는 순간 사라지기 때문에(list페이지가 새로고침????)
				actionForm.find("input[name='bno']").remove();

				//목록에서 제목을 클릭할 때 주소를 /board/get으로 변경헤 놔서 뒤로가기로 페이지목록으로 돌아가면 그대로 유지되는 것
				actionForm.attr("action", "/board/list");
				

				actionForm.submit(); //<form>태그 내용 전송
			});

			//목록에서 제목을 클릭시 동작 (페이징 + 검색 파라미터 + 글번호)
			$("a.move").on("click", function(e) {

				e.preventDefault(); //a태그를 클릭하면 동작하는 기능이 e인데 e의 기본 동작을 못하게 하는 것

				//a태그의 href에는 글번호 값이 있음
				let bno = $(this).attr("href"); //$(this) = $("a.move")

				actionForm.find("input[name='bno']").remove();
				//추가된 input태그가 캐쉬에 남지 않게 삭제

				//actionForm 의 정보 + 글번호 추가하자
				//DOM 작업
				actionForm.append("<input type='hidden' name='bno' value='" + bno + "'>"); //actionForm에 추가
				actionForm.attr("action", "/board/get");

				actionForm.submit();
			
			});
		});
	</script>
  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<%@include file="/WEB-INF/views/include/Carousel.jsp" %>

<div class="container">
  <h3>게시판 글목록</h3>
  
  <form id="searchForm" action="/board/list" method="get">
  <%-- 검색 단추를 누르면  --%>
    <select name="type">
		 <option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : ''}" />>--</option> 
		 <option value="T" <c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : ''}" />>제목</option> <%-- Title --%>
		 <option value="C" <c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : ''}" />>내용</option> <%-- Content --%>
		 <option value="W" <c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : ''}" />>작성자</option> <%-- Writer --%>
		 <option value="TC" <c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : ''}" />>제목  or 내용</option>
		 <option value="TW" <c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : ''}" />>제목  or 작성자</option>
		 <option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW' ? 'selected' : ''}" />>제목  or 작성자  or 내용</option>
  	</select>
  	<input type="text" name="keyword" value="${pageMaker.cri.keyword}">
  	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
  	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
  	<button class="btn btn-info">Search</button>
  </form>


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
	      <td><a class="move" href="${board.bno}"><c:out value="${board.title}" /></a></td>
		  <%-- 제목을 클릭하면 바로 링크가 걸려서 게시물로 이동하는 것이 아니라, jquery를 사용하여 actionForm이 전송되게 하는 것 --%>
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
	  
	  <form id="actionForm" action="/board/list" method="get">
			<%-- 페이지 번호 클릭시 list주소로 보낼 파라미터 작업 - model 덕분에 ${pageMaker.cri.___} 사용 가능 --%>
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<input type="hidden" name="type" value="${pageMaker.cri.type}">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
			<%-- 한 번 검색하면 list()메소드에 Criteria cri 에 값이 들어가게 되어 위 사용 가능 --%>
		</form>
	</nav>

  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    
  </body>
</html>

