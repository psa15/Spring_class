<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>파일 업로드</h3>
	
	<%--file업로드 관련 태그를 사용시 
			- form의 요청방식은 반드시 post여야 한다.
			- 인코딩은 enctype="multipart/form-data" 사용
			      ※인코딩 기본값 : enctype="application/x-www-form-urlencoded"--%>
			      
	<form method="post" action="/sample3/exUploadPost" enctype="multipart/form-data">
		<input type="file" name="files"><br>
		<input type="file" name="files"><br>
		<input type="file" name="files"><br>
		<input type="file" name="files"><br>
		<input type="file" name="files"><br>
		
		<%--name이 같다 = 동일한 파라미터를 클라이언트에서 전달 했을 때 스프링으로 받는 방법 : 배열, Collection 사용 --%>
		<input type="submit" value="파일업로드">		
	</form>
</body>
</html>