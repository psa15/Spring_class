<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>게시판 글쓰기</h3>
	<form method="post" action="write"> <%-- action="write" 만 적어도, action="/sample2/write"로 적어도 됨 --%>
		<dl>
			<dd>
				<label>제목</label>
				<input type = "text" name = "title"> 
				<%-- SampleContent2.java의 post방식 write()메소드의 파라미터가 BoardVO를 데이터타입으로 가지고 있기 때문에
					 파라미터 값을 뜻하는 name에는 BoardVO클래스의 필드명으로 설정 --%>
			</dd>
			<dd>
				<label>내용</label>
				<input type = "text" name = "content">
			</dd>
			<dd>
				<label>작성자</label>
				<input type="text" name="writer">
			</dd>
			<dd>
				<input type="submit" value="글저장">
			</dd>
		</dl>
	</form>
</body>
</html>