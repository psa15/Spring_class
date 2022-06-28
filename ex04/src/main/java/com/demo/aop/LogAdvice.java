package com.demo.aop;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

//AOP기능 구현 클래스 : 핵심 로직이 아닌 부가적인 작업내용을 대상으로 만든 클래스
@Aspect
@Component //일반클래스를 bean생성시 선언하는 어노테이션 - logAdvice bean 생성됨
@Log4j
public class LogAdvice {

	//메소드가 어떤 경우에 작동되게 할 것인지 설정 작업 -> aspectj문법
	@Before("execution(* com.demo.service.SampleService*.*(..))") //어떤 경우 이전에 동작되게 할 것
	public void logBefore() {
		log.info("=======================");
	}
	
	@Before("execution(* com.demo.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		//doAdd()메소드를 호출할 때 사용했던 파라미터값을 확인하고 싶을 때
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
}
