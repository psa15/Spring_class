<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC Driver 테스트</title>
</head>
<body>
<H3>JDBC Driver 테스트</H3>
<%
	Connection conn = null;
	
	try{
		//데이터 베이스 연결정보
		String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbld = "ezen";
		String dbPass = "1234";
		
		//oracle회사에서 제공하는 오라클 db에 접속하기 위한 Driver 의 정보
		Class.forName("oracle.jdbc.OracleDriver");
		conn = DriverManager.getConnection(jdbcUrl, dbld, dbPass);
		
		//SQL구문 실행작업
		
		out.println("연결 성공");
		
	} catch(Exception ex) {
		ex.printStackTrace();
	}
	
%>
</body>
</html>