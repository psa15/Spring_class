package com.demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.demo.domain.ProductVO;

@Controller
public class SampleController3 {
	
	private static final Logger logger = LoggerFactory.getLogger(SampleController3.class);
	
	@RequestMapping("doD")
	public String doD(Model model) {
		
		//db에 연결해야하지만 지금은 수동으로
		ProductVO product = new ProductVO("스프링 프레임워크 책", 40000);
		
		model.addAttribute("product", product);
		//model.addAttribute("이름", product); 이름은 아무거나 써도 됨
		//"product"라는 이름으로 product객체의 정보가 productDetail.jsp에 전달
		
		return "productDetail";
	}
}
