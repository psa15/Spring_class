package com.demo.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
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
	//@Before("") () 안의 메소드가 호출되기 전에 아래 구문을 실행해라
	@Before("execution(* com.demo.service.SampleService*.*(..))") //어떤 경우 이전에 동작되게 할 것
	public void logBefore() {
		log.info("=======================");
	}
	
	@Before("execution(* com.demo.service.SampleService*.doAdd(String, String)) && args(str1, str2)")
	public void logBeforeWithParam(String str1, String str2) {
		//&& args(str1, str2) : doAdd()메소드를 실행될 때 사용한 파라미터값을 확인하고 싶을 때
		log.info("str1: " + str1);
		log.info("str2: " + str2);
	}
	
	//target메소드(com.demo.service.SampleService*.*(..))가 실행될 때 예외발생이 되면 호출됨
	@AfterThrowing(pointcut = "execution(* com.demo.service.SampleService*.*(..))", throwing = "exception")
	public void logException(Exception exception) {
		log.info("Exception.......");
		log.info("exception: " + exception);
	}
	
	@Around("execution(* com.demo.service.SampleService*.*(..))")
	public Object logTime(ProceedingJoinPoint pjp) {
		
		long start = System.currentTimeMillis();
		
		log.info("Target: " + pjp.getTarget()); //Target메소드의 객체
		log.info("Param: " + Arrays.toString(pjp.getArgs())); //target메소드의 파라미터 정보
		
		Object result = null;
		
		try {
			result = pjp.proceed(); //target메소드로 제어가 넘어간다.
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		long end = System.currentTimeMillis();
		
		log.info("Time: " + (end - start));
		
		return result;
	}
}
