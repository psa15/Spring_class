package com.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo.domain.Board;
import com.demo.service.ExamService;

@Controller
@RequestMapping("/exam/*")
public class ExamController {

	@Autowired
	private ExamService service;
	
	//게시글 목록
	@GetMapping("/list")
	public void list(Model model) {
		List<Board> llist = service.getList();
		model.addAttribute("list", llist);
	}
	
	//게시글 작성
	@GetMapping("/write")
	public void write() {
		
	}
	
	@PostMapping("/write")
	public String write(Board vo) {
		System.out.println(" vp = = " + vo.toString());
		
		service.insert(vo);
		return "redirect:/exam/list";
	}
	
	//게시글 상세보기 - 게시글 클릭하면 조회수 올라가는 것도 추가
	@GetMapping("/get")
	public void get(@RequestParam("board_idx") Long board_idx, Model model) {
		Board board = service.get(board_idx);
		model.addAttribute("board", board);
	}
}
