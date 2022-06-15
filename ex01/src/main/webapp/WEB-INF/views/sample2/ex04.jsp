<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>SampleDTO</h3>
	<p>name: ${sampleDTO.name}</p> <%--getter메소드로 가져오는 것 --%>
	<p>age: ${sampleDTO.age}</p>
	
	<h3>Page: ${page}</h3>
	
	<h3>게시판 정보</h3>
	<p>글번호: ${board.bno}</p> <%--getter작동 --%>
	<p>작성자: ${board.writer}</p>
	<p>제목: ${board.title}</p>
	<p>내용: ${board.content}</p>
	<p>조회수: ${board.viewcnt}</p>
	<p>등록일: <fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
</body>
</html>