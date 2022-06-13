package com.demo.controller;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

//오라클 데이터베이스 드라이버를 이용한 연결 테스트
public class JDBCTests {

	private static final Logger logger = LoggerFactory.getLogger(JDBCTests.class);
	
	private String url="jdbc:oracle:thin:@localhost:1521:xe";
	private String uid="ora_user";
	private String passwd = "1234";
	
	static {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			//파일 위치 : Maven Dependencies -> ojdbc8-21.5.0.0.jar -> oracle.jdbc.driver -> OracleDriver.class
			
		} catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		try(Connection conn = DriverManager.getConnection(url, uid, passwd)) {
			//try(~~~~~) {}
			//AutoCloseable 인터페이스를 Connection 인터페이스가 상속받음 -> try 안에 객체 생성하면 자동으로 close 해줌
			logger.info("connection succeeds!");
		}catch(Exception ex) {
			fail(ex.getMessage());
		}
	}
}
