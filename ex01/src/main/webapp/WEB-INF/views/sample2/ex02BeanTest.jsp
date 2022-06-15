<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
	/*
	encodeURI( uri ) : URI에서 자주 사용하는 : ; / = ? & 등을 제외하고 인코딩하는 함수
	encodeURIComponent( uri ) : 모든 문자를 인코딩하는 함수
	decodeURI( uri ) : encodeURI의 결과물을 디코딩하는 함수
	decoudeURIComponent ( uri ) : encodeURIComponent의 결과물을 디코딩하는 함수
	*/
	
	/*
	<form>태그 안에 구성을 했다면
	<form method="post">
		<input type="text" name="list[0].name" value="김지원">
		<input type="text" name="list[0].age" value ="29">
		<input type="text" name="list[1].name" value="김지원">
		<input type="text" name="list[1].age" value="29">
	</form>
	*/
	
	//let queryString = encodeURIComponet("list[0].name=홍길동") + & + encodeURIComponet("list[0].age=100") + & + encodeURIComponet("list[1].name=홍길동") +& + encodeURIComponet("list[1].age=100");
	let queryString = "list[0].name=홍길동&list[0].age=100&list[1].name=홍길동&list[1].age=100";
	let url = encodeURI("http://localhost:9090/sample2/ex02Bean?" + queryString);
	alert(url);
	location.href= url;
</script>



</head>
<body>
</body>
</html>