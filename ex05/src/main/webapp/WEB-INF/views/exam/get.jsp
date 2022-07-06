<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootstrap core CSS -->
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container">
  <h3>게시판 글읽기</h3>
	  <div class="form-group">
	    <label for="board_idx">번호</label>
	    <input type="text" class="form-control" id="board_idx" name="board_idx" readonly value="${board.board_idx }">
	  </div>
	  <div class="form-group">
	    <label for="board_title">제목</label>
	    <input type="text" class="form-control" id="board_title" name="board_title" readonly value="${board.board_title }">
	  </div>
	  <div class="form-group">
	    <label for="board_content">내용</label>
	    <textarea class="form-control" id="board_content" rows="3" name="board_content" readonly>${board.board_content }</textarea>
  	  </div>
	  <div class="form-group">
	    <label for="board_name">작성자</label>
	    <input type="text" class="form-control" id="board_name" name="board_name" readonly value="${board.board_name }">
	  </div>
	  <div class="form-group">
	    <label for="board_date">등록일</label>
	    <input type="text" class="form-control" id="board_date" name="board_date" readonly value="<fmt:formatDate value="${board.board_date }" pattern="yyyy-MM-dd hh:ss"/>">
	  </div>
	<button type="button" id="btn_modify" class="btn btn-primary">Modify</button>
	<button type="button" id="btn_list" class="btn btn-primary">List</button>
	
  </div>
</body>
</html>