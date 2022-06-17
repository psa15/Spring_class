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
  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<%@include file="/WEB-INF/views/include/Carousel.jsp" %>

<div class="container">
  <h3>회원가입하기</h3>
  <form method="post" action="register">
	  <div class="form-group">
	    <label for="userid">아이디</label>
	    <input type="text" class="form-control" id="userid" name="userid">
	    <%-- BoardVO.java 안의 필드명을 name에 적기 --%>
	  </div>
	  <div class="form-group">
	    <label for="passwd">비밀번호</label>
	    <input type="password" class="form-control" id="passwd" name="passwd">
	  </div>
	  <div class="form-group">
	    <label for="username">이름</label>
	    <input type="text" class="form-control" id="username" name="username">
	  </div>
	  <div class="form-group">
	    <label for="addr">주소</label>
	    <input type="text" class="form-control" id="addr" name="addr">
	  </div>
	  <div class="form-group">
	    <label for="username">전화번호</label>
	    <input type="tel" class="form-control" id="tel" name="tel">
	  </div>
	  <button type="submit" class="btn btn-primary">제출</button>
	</form>

  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    
  </body>
</html>

