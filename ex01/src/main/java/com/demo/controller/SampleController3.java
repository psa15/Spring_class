package com.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/sample3")
public class SampleController3 {
	
	@GetMapping("/getAjax")
	public String getAjax() {
		//jsp페이지로 가는 주소
		
		return "/sample3/getAjax";
	}
	
	@RequestMapping("/demo")
	public String demo( ) {
		//click버튼을 클릭했을 때 매핑 주소
		return "/sample3/demo";
	}
}
