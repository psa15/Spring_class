package com.demo.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

/*
 Exception(예외) : 프로그램 실행도중 발생하는 오류를 의미, 예외발생시 강제적인 종료가 된다.
 	1)예외 처리 : try - catch
 	2)예외전가 : 메소드정의시 옆에 throws Exception
 
 각 컨트롤러의 메서드에서 예외가 발새하면, 개별 메소드에서 예외작업을 했음
 	-> 모든 컨트롤러에서 예외가 발생이 되면, 
 	       각각 개별 컨트롤러 수준에서 예외처리를 하는 것이 아니라 
 	       공통 예외처리를 담당하는 클래스를 작업하자
 	       
 @ControllerAdvice 
 	- 공통 예외처리를 담당하는 클래스 앞에 사용
 	- 메소드 자체에서 예외 처리 (메소드 호출할 때 try-catch문(예외처리), throws Exception(예외전가))하는 것이 아니라
 	      이거를 클래스 하나를 만들어서 모든 Controller에서 발생하는 예외를 
 	      공통적으로 처리해주는 예외관련 클래스를 만들 떄 사용
 */
@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	
	//테스트 주소: http://localhost:9090/sample/ex02?name=김지원
	//@ExceptionHandler(Exception.class) : 모든 컨트롤러에서 모든 예외(Exception.class)가 발생하면 아래 메소드가 호출된다.
	@ExceptionHandler(Exception.class)
	public String except(Exception ex, Model model) {
		
		log.error("Exception..." + ex.getMessage());
		model.addAttribute("exception", ex);
		log.error(model.toString());
		
		return "/error/error_page";
	}
	
	//특정한 예외가 발생되면 처리되는 경우 (ex.요청주소가 존재하지 않을 경우) -> web.xml <init-param>설정 필요
	//HTTP 상태코드와 연결
	//테스트 주소1 : http://localhost:9090/sample/ex100000
	//테스트 주소2 : http://localhost:9090/ex100000  컨트롤러가 동작하는 주소를 사용 X
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(code = HttpStatus.NOT_FOUND)//HttpStatus.NOT_FOUND - 이것만 적으면 컨트롤러가 있어도 jsp파일 동작됨.
	public String handle404(NoHandlerFoundException ex) {
		
		
		return "/error/custom404";
	}
}
