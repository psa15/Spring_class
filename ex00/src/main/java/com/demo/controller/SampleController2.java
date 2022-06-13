package com.demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SampleController2 {

	//로그설정
	private static final Logger logger = LoggerFactory.getLogger(SampleController2.class);
	
	//요청 시 메소드의 파라미터를 제공해야 문제가 생기지 않는다.
	//http://localhost:9090/doC?name=user01&age=100
	//기본주소/요청주소?파라미터1=값1&파라미터2=값2
	//? 뒤를 쿼리 스트링이라고 함
	@RequestMapping("doC") 
	public String doC(@ModelAttribute("name") String name,@ModelAttribute("age") int age) {
		
		logger.info("doC called..." + name);
		logger.info("doC called..." + age);
		
		//파라미터msg, age변수의 값을 result.jsp파일명에서 참조할 경우
		//String doC(@ModelAttribute("이름") String msg, int age)
		//일반적으로 이름은 변수명이랑 똑같게
		
		return "result"; //리턴값이 String인 경우에는 리턴값 "result"가 jsp파일명이 됨
	}
}
