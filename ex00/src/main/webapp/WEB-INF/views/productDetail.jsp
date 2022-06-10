<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>상품 이름: ${product.productName}</p>
	<%--SampleController3.java의
		 model.addAttribute("product", product);의  "product"를 의미
		 ${product}는 ProductVO.java의 구조를 가지고 있음
		  ProductVO 클래스의 필드명 productName 임
		  ${product.productName} : getProductName()메소드를 의미--%>
	<p>상품 가격: ${product.price}</p><%--getPrice()메소드를 가리킴 --%>
</body>
</html>