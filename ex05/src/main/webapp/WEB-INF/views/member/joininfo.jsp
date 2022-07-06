<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<span>입력된 정보 : </span><br>
	<c:forEach items="${list}" var="board">
		id 파라미터 : ${board.id}<br>
		pw 파라미터 : ${board.pw}<br>
		name 파라미터 : ${board.name}<br>
		phone 파라미터 : ${board.phone}<br>
		address 파라미터 : ${board.address}<br>
		gender 파라미터 : 
			<c:if test="${board.gender =='M'}">
		      	male<br>
		      </c:if>
		      <c:if test="${board.gender =='F'}">
		      	female<br>
		      </c:if>		      
		email 파라미터 : ${board.email}<br>
	</c:forEach>
	회원가입 되었습니다!
	
</body>
</html>