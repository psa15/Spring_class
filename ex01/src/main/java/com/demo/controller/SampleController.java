package com.demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo.domain.SampleDTO;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/sample/*") //공통경로 - sample로 시작하는 모든 주소를 의미함
//@Log4j
public class SampleController {
	
	private static final Logger logger = LoggerFactory.getLogger(SampleController.class); 
	//롬복 덕분에 직접 안쳐도 됨 @Log4j 이용하면 자동 생성되는데 지금은 에러남
	
	//주소 : /sample/doA  ->jsp 파일명
	@RequestMapping("doA")
	public void doA() {
		logger.info("/sample/doA");
	}
	//주소 : /sample/doB  ->jsp 파일명
	@RequestMapping("doB")
	public void doB() {
		logger.info("/sample/doB");
	}
	
	//sample로 시작하는 주소와 요청방식이 존재하지 않으면 아래 주소가 호출됨
	@RequestMapping("") // /sample/ 이 주소
	public void basic() {
		logger.info("basic called...");
	}
	
	@RequestMapping("/basicForm")
	public void basicForm() {
		logger.info("basicForm called...");
	}
	
	//매핑주소 여러개를 생성하여 하나의 메소드 호출
	//jsp 에서 updateform이랑 selectlist였나 아무튼 두 개 가 하나의 메소드를 호출 할 때 처럼 유용하게 사용
		@RequestMapping(value = {"/basicA","/basicB"})
	public void basicOnly() {
		logger.info("basicOnly called...");
	}
	
	//기본 요청방식이 get, post 둘 다 지원
		/*@RequestMapping("basicTwoMethod")
		public void basicTwoMethod() {
		logger.info("basicTwoMethod called...");
	}  ==
		@RequestMapping(value = "basicTwoMethod",method = {RequestMethod.GET, RequestMethod.POST})
		public void basicTwoMethod() {
		logger.info("basicTwoMethod called...");
	}*/
		
	//post방식만 사용하겠다
	//get 방식으로 호출 시 기본주소가 호출되고, 기본주소가 지정되어 있지 않으면 에러남
	@RequestMapping(value = "basicTwoMethod", method = RequestMethod.POST)
	public void basicTwoMethod() {
		logger.info("basicTwoMethod called...");
	}
	
	//spring framework 4.3이후
	@GetMapping("/basicOnlyGet") //get 요청방식만을 목적으로 존재   @PostMapping : post요청방식 주소 설정
	public void basicGet2() {
		logger.info("basicGet2 called...");
	}
	
	/* 
	 클라이언트에서 보내 온 데이터를 서버(스프링)에서 참조하는 방법
	 주소의 쿼리스트링이 같다. : ?name=김지원&age=100
	 	1) 클래스 사용
	 	2) 각각의 필드를 사용
	 */
	//1) 클래스 사용
	@GetMapping("/ex01") // http://localhost:9090/sample/ex01?name=김지원&age=100
	public String ex01(SampleDTO dto) {
		
		logger.info(dto.toString());
		
		return "/sample/ex01"; ///sample/ex01 : jsp 파일명
	}
	//2) 각각의 필드를 사용
	//참고. 파라미터가 기본데이터타입은 값을 제공하지 않으면 에러 발생
	@GetMapping("/ex02") // http://localhost:9090/sample/ex02?name=김지원&age=100
	public String ex02(String name, int age) {
		
		logger.info("이름은? " + name);
		logger.info("나이는? " + age);
		
		return "/sample/ex02"; //jsp파일명
	}
	
	//@RequestParam() : 클라이언트에서 전송해오는 파라미터명과 스프리의 메소드의 파라미터명이 불일치시 사용
	@GetMapping("/ex0201") // http://localhost:9090/sample/ex0201?uname=김지원&uage=100
	public String ex0201(@RequestParam("uname") String name, @RequestParam("uage") int age) {
		
		logger.info("이름은? " + name);
		logger.info("나이는? " + age);
		
		return "/sample/ex0201"; //jsp파일명
	}
	//public String ex0202(@RequestParam(value = "클라이언트쪽에서 보내는 이름") String name, int age){}
	//@RequestParam을 사용 시 파라미터에 반드시 값을 제공
	@RequestMapping("/ex0202")
	public String ex0202(@RequestParam(value = "name",required = false, defaultValue = "김지원") String name, 
			@RequestParam(value = "age", required = false, defaultValue = "0") int age) {
		
		logger.info("이름은? " + name);
		logger.info("나이는? " + age);
		
		return "/sample/ex0202";
	}
	
}
