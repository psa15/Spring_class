package com.demo.service;

import static org.junit.Assert.*;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;

//톰캣 사용 X 작업하려다 보니 스프링 환경이 필요하여 작성
@RunWith(SpringJUnit4ClassRunner.class) //스프링 환경 구축
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
//데이터베이스 연동 설정(root-context.xml)구문들이 있음
//bean 생성

public class SampleTxServiceTests {

	//주입 어노테이션은 사용하기 전에 해당 클래스의 빈은 생성되어있어야 함
	@Setter(onMethod_ = {@Autowired})
	private SampleTxService service;
	
	@Test
	public void testLong() {
		
		String str = "012345678901234567890123456789012345678901234567890123456789"; //60바이트
		
		service.addData(str);
	}

}
