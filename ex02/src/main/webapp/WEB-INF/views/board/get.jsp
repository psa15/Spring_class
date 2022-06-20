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
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <title>Pricing example · Bootstrap v4.6</title>

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
        
        //수정버튼 클릭시 동작구문
          $("#btn-modify").on("click", function(){
            //console.log("수정버튼 클릭"); 확인 완료 후 주석걸음

            //수정 폼 주소
            //location.href="수정폼주소?bno=" + 글번호;
            let bno = $("#bno").val(); //입력양삭의 값을 읽어옴, val()메소드는 입력양식(input, selectarea, textarea)에만 사용
            location.href="modify?bno=" + bno;
          });
          //코드를 수정하고 이클립스에서 한 번 파일을 열어서 확인해야 한다.

        //삭제버튼 클릭시 동작구문
          $("#btn-remove").on("click", function(){
            //console.log("삭제버튼 클릭"); 확인 완료
            let bno = $("#bno").val();
            if(!confirm(bno + "번 글을 삭제하시겠습니까?")) return;
            //확인 누르면 if(!true) 여서 false로 작용하여 삭제됨
            location.href="remove?bno=" + bno;
          });
        //목록버튼 클릭시 동작구문
      });
    </script>
  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<%@include file="/WEB-INF/views/include/Carousel.jsp" %>


<div class="container">
  <h3>게시판 글읽기</h3>
  	  <div class="form-group">
	    <label for="bno">글번호</label>
	    <input type="text" class="form-control" id="bno" name="bno" readonly value="${board.bno}">
	  </div>
	  <div class="form-group">
	    <label for="title">제목</label>
	    <input type="text" class="form-control" id="title" name="title" readonly value="${board.title}">
	    <%-- BoardVO.java 안의 필드명을 name에 적기 --%>
	  </div>
	  <div class="form-group">
	    <label for="content">내용</label>
	    <textarea class="form-control" id="content" rows="3" name="content" readonly>${board.content}</textarea>
	  </div>
	  <div class="form-group">
	    <label for="writer">작성자</label>
	    <input type="text" class="form-control" id="writer" name="writer" readonly value="${board.writer}">
	  </div>
	  <div class="form-group">
	    <label for="regdate">등록일</label>
	    <input type="text" class="form-control" id="regdate" name="regdate" readonly value="<fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd hh:mm:ss"/>">
	  </div>
	  <button type="button" id="btn-modify" class="btn btn-info">수정</button>
	  <button type="button" id="btn-remove" class="btn btn-info">삭제</button>
	  <button type="button" id="btn-list" class="btn btn-info">목록</button>



  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    
  </body>
</html>

