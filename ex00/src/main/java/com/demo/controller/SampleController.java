package com.demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SampleController {
	
	//로그 설정
	//SampleController클래스의 메소드가 동작되는 것을 모니터링 하기 위한 목적
	private static final Logger logger = LoggerFactory.getLogger(SampleController.class);
	
	//@RequestMapping("웹브라우저 사용할 주소")
	@RequestMapping("doA") 
	//doA()메소드를 호출하기 위한 주소를 생성, 주소는 뭘 쓰든 상관 X, 
	//근데 없으면 클라이언트(브라우저)에서 호출 X
	public void doA() {
		logger.info("doA called...."); //실행 됐는지 확인
		//logger.info - system.out.println()메소드와 같은 기능
		//리턴값이 void면 매핑주소가 jsp파일명이 된다. 매핑주소 doA가 jsp파일명이 됨
		// servlet-context.xml의 설정구문 참조  /WEB-INF/views/ + doA + .jsp ->/WEB-INF/views/doA.jsp
	}
	
	@RequestMapping("doB") //대소문자 구분
	public void doB() {
		logger.info("doB called...");
	}
}
