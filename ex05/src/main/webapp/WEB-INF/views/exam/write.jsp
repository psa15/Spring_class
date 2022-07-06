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

    
     </head>
  <body>
    

<div class="container">
  <h3>게시판 글쓰기</h3>
  <form method="post" action="write">
  	<div class="form-group">
	    <label for="board_name">작성자</label>
	    <input type="text" class="form-control" id="board_name" name ="board_name"> 
	  </div>
	  <div class="form-group">
	    <label for="board_title">제목</label>
	    <input type="text" class="form-control" id="board_title" name ="board_title">
	  </div>
	  <div class="form-group">
	    <label for="board_content">내용</label>
	    <textarea class="form-control" id="board_content" rows="3" name ="board_content"></textarea>
	  </div>
	  
	  <button type="submit" class="btn btn-primary">제출</button>
	</form>

</div>


    
  </body>
</html>