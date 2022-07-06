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
    <style>
        table, tr, td {
            border: 1px solid black;
        }
        tr, td {
            padding: 15px;
        }
    </style>
    
</head>
<body>
	<h3>게시판 글목록</h3>
	<table>
	  <thead>
	    <tr>
	      <td>번호</td>
	      <td>이름</td>
	      <td>제목</td>
	      <td>날짜</td>
	      <td>조회수</td>
	    </tr>
	  </thead>
	  <tbody>
	  <c:forEach items="${list}" var="board">
	    <tr>
	      <td><c:out value="${board.board_idx}" /></td>
	      <td><c:out value="${board.board_name}" /></td>
	      <td><a class="move" href="/exam/get?board_idx=${board.board_idx}"><c:out value="${board.board_title}" /></a></td>
	      <td><fmt:formatDate value="${board.board_date}" pattern="yyyy-MM-dd"/></td>
	      <td><c:out value="${board.board_hit}" /></td>
	    </tr>
	   </c:forEach>
	   
	   <tr>
	   	<td colspan="5"> <a href="/exam/write">글작성</a> </td>
	   </tr> 
	   
	  </tbody>
	</table>
</body>
</html>