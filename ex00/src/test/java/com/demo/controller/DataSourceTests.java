package com.demo.controller;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/*
 root-context.xml파일의 datasource bean 설정 테스트
 */
@RunWith(SpringJUnit4ClassRunner.class) //spring 환경 적용
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})//지정된 파일 읽기
//톰캣이 하는 행위를 만드는 가상환경 생성 (Runwith과 ContextConfiguration)
//<bean>태그의 id bean(객체)를 생성
public class DataSourceTests {

	private static final Logger logger = LoggerFactory.getLogger(DataSourceTests.class);
	
	@Autowired //메모리상에 dataSource bean이 ds에 주입(대입)
	private DataSource ds;
	
	@Test
	public void testConnection() throws Exception {
		try(Connection conn = ds.getConnection()) {
			logger.info("connection succeed" + conn);
		}catch (Exception ex) {
			ex.printStackTrace();
		}
	}

}
