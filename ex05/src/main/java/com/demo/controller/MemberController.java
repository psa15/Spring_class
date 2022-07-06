package com.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo.domain.MemberVO;
import com.demo.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	private MemberService service;
	
	//회원가입
	@GetMapping("/join")
	public void insert() {
	
	}
	@PostMapping("/join_ok")
	public String insert(MemberVO vo) {
		
		service.insert(vo);
		
		return "redirect:/member/joininfo";
	}
	
	//정보 불러오기
	@GetMapping("/joininfo")
	public void get(MemberVO vo, Model model) {
		
		model.addAttribute("list", service.getMemberList());
	}
}
