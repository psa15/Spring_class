package com.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.demo.domain.MemberVO;
import com.demo.service.MemberService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {

	//register(MemberVO mvo)메소드에서 insert()메소드 호출하기 위한 객체 주입
	@Autowired
	private MemberService service; //다형성 이용
	
	//회원가입 폼, 매핑주소와 메소드명 : register
	@GetMapping("/register")
	public void register() {
		
	}
	
	//회원가입 저장, 매핑주소와 메소드명 : register
	@PostMapping("/register")
	public String register(MemberVO mvo) {
		
		//MemberServiceImpl클래스의 insert()메소드 호출
		service.insert(mvo);
		
		return "redirect:/목록";
	}
}
