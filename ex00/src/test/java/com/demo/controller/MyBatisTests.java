package com.demo.controller;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class MyBatisTests {
	
	@Inject
	private SqlSessionFactory sqlFactory;
	
	@Test
	public void testFactory() {
		System.out.println(sqlFactory); //fm대로라면 logger 생성해서 해야함
	}
	
	@Test
	public void testSession() throws Exception {
		try(SqlSession session = sqlFactory.openSession()) {
			System.out.println(session);
		}catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
