package com.demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class SampleController4 {
	
	//log
	private static final Logger logger = LoggerFactory.getLogger(SampleController4.class);
	
	@RequestMapping("doE")
	public String doE(RedirectAttributes rttr) {
		/*
		RedirectAttributes 인터페이스
		 중간 작업 : 
		 	대표적인 작업 
		 		db연동(회원가입(insert), 회원삭제(delete), 회원수정(update))을 마치고 
		 		다른 주소로 이동 시, 파라미터를 제공하는 목적으로 사용
		 */
		
		logger.info("doE called...");
		
		//이동할 주소에 제공할 파라미터 정보 rttr.addAttribute("키", 값);
		rttr.addAttribute("msg", "Hello");
		//rediredct:주소 이 주소에서 msg를 사용 가능
		
		//다른 주소로 이동하는 구문 - "redirect:/주소"; -> 구문 사용 시 메서드 리턴타입이 String
		return "redirect:/doF";
	}
	
	@RequestMapping("doF")
	public void doF(String msg) {
		logger.info("doF called..." + msg);
	}
	
	@RequestMapping("doG")
	public String doG(RedirectAttributes rttr) {
		
		//doH매핑주소에 호출되는 메소드의 파라미터로 참조가 된다
		rttr.addAttribute("name", "김지원");
		rttr.addAttribute("age", 29);
		
		return "redirect:/doH"; //http://localhost:9090/doH?name=%3F%3F%3F&age=29 - doH로 주소를 호출하고 싶다면 이렇게 다 쳐야함
	}
	
	@RequestMapping("doH")
	public void doH(String name, int age) {
		logger.info("이름은? " + name);
		logger.info("나이는? " + age);
	}
}
