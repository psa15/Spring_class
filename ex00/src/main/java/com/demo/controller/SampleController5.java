package com.demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.demo.domain.ProductVO;

@Controller
public class SampleController5 {

	//클래스가 하는 행위를 log에 저장
	private static final Logger logger = LoggerFactory.getLogger(SampleController5.class);
	
	@RequestMapping("doJSON")
	public @ResponseBody ProductVO doJSON() {
		
		ProductVO vo = new ProductVO("상품 1", 30000);
		
		// 기본은 jsp가 실행되어 그 결과가 클라이언트의 브라ㅜ저에게 전송
		//리턴값이 객체 - 객체가 참조하는 값을 클라이언트의 브라우저에게 JSON포맷으로 보내고라 할 때 @ResponseBody 사용
		//vo -> JSON 데이터 포맷으로 변환작업 : jackson-databind 라이브러리가 백그라운드에서 작업
		return vo; //jsp 사용 안되고 vo객체가 전송됨
	}
	
	
	
}
