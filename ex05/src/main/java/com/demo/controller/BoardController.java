package com.demo.controller;

import java.lang.ProcessBuilder.Redirect;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.demo.domain.BoardAttachVO;
import com.demo.domain.BoardVO;
import com.demo.domain.Criteria;
import com.demo.domain.PageDTO;
import com.demo.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller //jsp를 반환하는 기능
@Log4j
@RequestMapping("/board/*")
public class BoardController {

	
	@Autowired
	//다형성
	private BoardService service;
	
	@GetMapping("/write")
	public void write() {
		
	}
	
	//HTTP 400 상태코드 : 클라이언트에서 보내는 데이터가 메서드의 파라미터에 적합하지 않을 경우 발생
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
	1)처음에는 스프링이 Criteria cri = new Criteria(); 작업을 내부적으로 해줌 
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
		int total = service.getTotalCount(cri); //데이터베이스 테이블의 토탈 데이터행 개수
		
		log.info("total: " + total);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		//pageDTO의 모든 필드의 값을 갖게 됨 -> PageDTO클래스는 setter가 필요 없음
		model.addAttribute("pageMaker", pageDTO);
		//jsp에서 데이터를 사용하기 위해 model 사용
		//pageMaker : startPage, endPage, prev, next, total, cri(pageNum, amount, type, keyword)
		
	}	
	
	/*
	 1)@ModelAttribute("cri") Criteria cri : cri파라미터로 전송되어 온 값을 그대로 JSP파일에 전달하여 사용하고자 할 경우
	 2) Model model : 메소드 안에서 수동으로 데이터작업하여, JSP에 전달하고자 할 경우 (대부분 DB내용을 jsp에 전달 시 사용)
	 */
	//게시물 읽기 : get.jsp + 수정폼 : modify.jsp
	@GetMapping(value = {"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("글번호: " + bno);
		
		//댓글 목록작업 존재X - get.jsp에서 ajax로 진행함
		//(ajax로 진행안했을 때 댓글 목록작업 추가할 위치) - model데이터로 추가하여 jsp로 보여주면 됨
		
		BoardVO board = service.get(bno); //게시물과 파일정보작업 포함됨 (7/4)
		
		//uploadPath의 \를 /로 변환하여 모델에 추가
		List<BoardAttachVO> attachList = board.getAttachList();
		for(int i=0; i<attachList.size(); i++) {
			BoardAttachVO attachVO = attachList.get(i);
			attachVO.setUploadPath(attachVO.getUploadPath().replace("\\", "/"));
			//.replace("\\", "/") : "\\" \두개인 이유는 앞의 \는 \를 의미하고 뒤의 \는 "가 "의 의미라는 것
		}
		
		model.addAttribute("board", board);		
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO vo, Criteria cri, RedirectAttributes rttr) {
		//BoardVO 객체가 기본 생성자를 통해 객체를 생성하고 setter메소드로 데이터를 얻는 일을 스프링이 해줌
		//수정내용 로그
		log.info("수정내용: " + vo.toString());
		
		service.modify(vo);
		
		/* /board/list 주소에 4개의 파라미터 정보가 추가되어 진다.
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		*/
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, Criteria cri) {
		
		log.info("삭제할 번호: " + bno);
		
		service.remove(bno);
		
		return "redirect:/board/list" + cri.getListLink();
	}
}
