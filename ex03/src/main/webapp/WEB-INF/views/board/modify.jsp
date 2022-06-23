<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>Pricing example · Bootstrap v4.6</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/pricing/">

    <!-- jquery 라이브러리 삽입 - 실제로는 파일을 따로 만들어 include-->
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>

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

        let formObj = $("#modifyForm");

        $("#btn-remove").on("click", function(){
          //console.log("click"); //위까지 잘 동작되는지 확인 위한 코드
          
          if(!confirm("게시물을 삭제하겠습니까?")) return;
          //console.log("click");
          //확인 : if(!true) 가 되어 false로 삭제되어야 함(페이지 정보 함께 전송)
          formObj.attr("action", "/board/remove");

          formObj.submit();
          
        });

        //목록 버튼 클릭하면 동작하는 기능
        $("#btn-list").on("click", function(){
          
          formObj.attr("method", "get");
          formObj.attr("action", "/board/list");

          /*
          get방식으로 바뀌는 순간 게시판의 내용들이 다 파라미터값으로 저장이 됨
          http://localhost:9090/board/list?bno=5099&title=테스트+게시물+데이터&content=테스트+게시물+데이타&writer=user01&pageNum=1&amount=10&type=W&keyword=user01
          이런식으로, 그래서 나는 다 지움
          
          formObj.find("input[name='bno']").remove();
          formObj.find("input[name='title']").remove();
          formObj.find("textarea[name='content']").remove();
          formObj.find("input[name='writer']").remove();
          */
          
          //페이징, 검색 필드정보
          let pageNumTag = $("input[name='pageNum']").clone(); 
          //pageNumTag안에 <input type="hidden" name="pageNum" value="${cri.pageNum}"> 전체가 복사됨
          let amountTag = $("input[name='amount']").clone();
          let typeTag = $("input[name='type']").clone();
          let keywordTag = $("input[name='keyword']").clone();

          //잘 복사되었는지 확인
          console.log(pageNumTag);
          console.log(amountTag);
          console.log(typeTag);
          console.log(keywordTag);

          //다 지우기
          formObj.empty();

          //필요한 것만 다시 붙이기
          formObj.append(pageNumTag);
          formObj.append(amountTag);
          formObj.append(typeTag);
          formObj.append(keywordTag);

          formObj.submit();
        });
      });
    </script>
  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<%@include file="/WEB-INF/views/include/Carousel.jsp" %>

<div class="container">
  <h3>게시판 수정하기</h3>
  <form id="modifyForm" method="post" action="modify">
  	  <div class="form-group">
	    <label for="bno">번호</label>
	    <input type="text" class="form-control" id="bno" name="bno" readonly value="${board.bno}">
	  </div>
	  <div class="form-group">
	    <label for="title">제목</label>
	    <input type="text" class="form-control" id="title" name="title" value="${board.title}">
	    <%-- BoardVO.java 안의 필드명을 name에 적기 --%>
	  </div>
	  <div class="form-group">
	    <label for="content">내용</label>
	    <textarea class="form-control" id="content" rows="3" name="content">${board.content}</textarea>
	  </div>
	  <div class="form-group">
	    <label for="writer">작성자</label>
	    <input type="text" class="form-control" id="writer" name="writer" readonly value="${board.writer}">
	  </div>
	  <button type="submit" class="btn btn-info">수정하기</button>
	  <button type="button" id="btn-remove" class="btn btn-info">삭제</button>
	  <button type="button" id="btn-list" class="btn btn-info">목록</button>
	  
	  	<%-- 페이지 정보 
	  	<input type="hidden" name="bno" value="${board.bno}">
	  	 글번호 인풋태그는 이미 존재하기 때문에 있으면 안됨
	  	--%>
    
		<input type="hidden" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" name="amount" value="${cri.amount}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
		
	</form>
	

  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    
  </body>
</html>

