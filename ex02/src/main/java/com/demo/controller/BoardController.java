package com.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.demo.domain.BoardVO;
import com.demo.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
public class BoardController {

	
	@Autowired
	//다형성
	private BoardService service;
	
	@GetMapping("/write")
	public void write() {
		
	}
	
	@PostMapping("/write")
	public String write(BoardVO vo) {
		
		service.insert(vo);
		//제출하기 클릭 시 sql문 실행되어 데이터베이스에 삽입
		
		//제출하기 클릭하면 목록으로 넘어가야 함
		//공통경로 포함한 주소 작성
		return "redirect:/board/list";
	}
	
	//페이징 및 검색기능 추가할 예정
	//board/list 주소 요청으로 list.jsp에 데이터 전달작업을 하고자 할 경우 메소드의 파라미터로 Model model 추가 필요
	@GetMapping("/list")
	public void list(Model model) {
		List<BoardVO> list = service.getList();
		
		//list 주소가 호출됐을 때 list.jsp가 실행되고, 데이터를 출력하고 싶으면 Model 사용
		model.addAttribute("list", list);
		//model.addAttribute("jsp에서 참조할 이름", 리스트);
	}
	
	//게시물 읽기 : get.jsp + 수정폼 : modify.jsp
	@GetMapping(value = {"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, Model model) {
		log.info("글번호: " + bno);
		
		BoardVO board = service.get(bno);
		model.addAttribute("board", board);
		
	}
	@PostMapping("/modify")
	public String modify(BoardVO vo) {
		
		//수정내용 로그
		log.info("수정내용: " + vo.toString());
		
		service.modify(vo);
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("bno") Long bno) {
		
		log.info("삭제할 번호: " + bno);
		
		service.remove(bno);
		
		return "redirect:/board/list";
	}
}
