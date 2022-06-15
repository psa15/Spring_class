<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("button").click(function(){
			$("#result").load("/sample3/demo");
		});
	});
</script>
</head>
<body>
	<h3>AJAX 기본 예제</h3>
	<div id="result">
		<h2>스프링 프레임워크</h2> <%-- click버튼을 누르면 서버에서 변경된 내용을 반영?? --%>
	</div>
	<button>click</button>
</body>
</html>