package com.demo.controller;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.demo.mapper.TimeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class TimeMapperTests {

	private static final Logger logger = LoggerFactory.getLogger(TimeMapperTests.class);
	
	@Inject
	private TimeMapper timeMapper;
	
	@Test
	public void testGetTime() {
		logger.info("timeMapper 인터페이스 이름: " + timeMapper.getClass().getName());
		logger.info("timeMapper 인터페이스 getTime()메소드 : " + timeMapper.getTime());
	}
	
	@Test
	public void testGetTime2() {
		logger.info("getTime2()");
		logger.info(timeMapper.getTime2());
	}

}
