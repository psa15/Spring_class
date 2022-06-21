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
import com.demo.domain.Criteria;
import com.demo.domain.PageDTO;
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
	/*
	//페이징 및 검색기능 추가할 예정
	//board/list 주소 요청으로 list.jsp에 데이터 전달작업을 하고자 할 경우 메소드의 파라미터로 Model model 추가 필요
	@GetMapping("/list")
	public void list(Model model) {
		List<BoardVO> list = service.getList();
		
		//list 주소가 호출됐을 때 list.jsp가 실행되고, 데이터를 출력하고 싶으면 Model 사용
		model.addAttribute("list", list);
		//model.addAttribute("jsp에서 참조할 이름", 리스트);
	}
	*/
	/*
	1)스프링이 Criteria cri = new Criteria(); 작업을 내부적으로 해줌 
		-> 기본 생성자에 pageNum과 amount에 1과 10을 줌 -> 처음 목록에 들어가면 1페이지가 보이게 됨
	2) 스프링이 Criteria cri = new Criteria(); + setter메소드 동작
	- 페이지를 선택하면 <a href ="/board/list?pageNum=선택페이지번호&amount=10"> 가 동작되는 것
	*/
	@GetMapping("/list") 
	public void list(Criteria cri, Model model) {

		log.info("list: " + cri);
		
		//1) jsp(뷰)에서 보여줄 목록 데이터 가져오기
		List<BoardVO> list = service.getListWithPaging(cri);
		model.addAttribute("list", list);
		
		//2)jsp(뷰)에서 페이징 기능 구현(PageDTO 클래스) -> 1	2	3	4	5	[다음]
		int total = service.getTotalCount(); //데이터베이스 테이블의 토탈 데이터행 개수
		
		log.info("total: " + total);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		//pageDTO의 모든 필드의 값을 갖게 됨 -> PageDTO클래스는 setter가 필요 없음
		model.addAttribute("pageMaker", pageDTO);
		//jsp에서 데이터를 사용하기 위해 model 사용
		//pageMaker : startPage, endPage, prev, next 사용 가능 total, cir는?
		
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
		//BoardVO 객체가 기본 생성자를 통해 객체를 생성하고 setter메소드로 데이터를 얻는 일을 스프링이 해줌
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
