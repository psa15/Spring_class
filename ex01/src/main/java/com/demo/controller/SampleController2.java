package com.demo.controller;


import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.demo.domain.BoardVO;
import com.demo.domain.SampleDTO;
import com.demo.domain.SampleDTOList;
import com.demo.domain.TodoDTO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j //롬복제공 로그기능 어노테이션
@RequestMapping("/sample2/") //sample2로 시작하는 모든 요청에 대하여 이 클래스가 요청을 처리한다는 의미
public class SampleController2 {
	
	//사용자 앙이디와 비번 입력받음 - BoardVO 클래스 이용
	
	//게시판 글쓰기 폼    /sample2/write.jsp 경로에 파일 존재해야 함
	@GetMapping("/write") 
	public void write() {
		
	}
	
	//게시판 입력데이터 처리 메소드 - 글저장을 클릭하면 처리될 주소
	@PostMapping("/write") //url 매핑 주소를 같은 걸 써도 상관 없음(@GetMapping("/write")은 get방식이기 때문)
	public String write(BoardVO vo) {
		//method overloading으로 write()은 오류가 나지만 파라미터값을 주면 사용 가능
		//파라미터를 BoardVO클래스의 필드로 설정 <input type = "text" name = "필드명"> ->setter메소드 작동
		
		log.info("게시판 데이타: " + vo.toString()); //vo.toString() -> vo 만 작성해도 됨(.toString() 생략 가능)
				//log.info: log4j의 logger.info 
		return"";
	}
	
	/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
	
	//파라미터를 Collection으로 사용하는 경우 - @RequestParam("ids") 사용
	//동일한 파라미터로 여러개의 값이 전송되는 경우
	//주소: http://localhost:9090/sample2/ex02List?ids=111&ids=222&ids=333
	@GetMapping("/ex02List")
	public String ex02List(@RequestParam("ids") ArrayList<String> ids) { //ArrayList<Integer> ids도 가능(값이 숫자라)
		
		log.info(ids);
		
		return "/sample2/ex02List";
	}
	
	//파라미터를 Array로 사용하는 경우
	//동일한 파라미터로 여러개의 값이 전송되는 경우
	//주소: http://localhost:9090/sample2/ex02Array?ids=111&ids=222&ids=333
	@GetMapping("/ex02Array")
	public String ex02Array(@RequestParam("ids") String[] ids) {//기본이 String, int[] ids도 가능 -> 묵시적 형변환 일어남
		
		log.info("array ids: " + Arrays.toString(ids));
		
		return "/sample2/ex02Array";
	}
	
	//클라이언트에서 SampleDTOList클래스의 파라미터로 정보가 여러개 전송되어 올 때
	//주소: http://localhost:9090/sample2/ex02Bean?list[0].name=홍길동&list[0].age=100&list[1].name=홍길동&list[1].age=100
	//주소: http://localhost:9090/sample2/ex02Bean?list%5B0%5D.name=홍길동&list%5B0%5D.age=100&list%5B1%5D.name=홍길동&list%5B1%5D.age=100
	//list[0] : List<SampleDTO>컬렉션의 첫번째 SampleDTO
	@RequestMapping("ex02Bean")
	public String ex02Bean(SampleDTOList lst) {
		
		log.info("list dtos: " + lst);
		
		return "/sample2/ex02Bean";
	}
	
	//ex02Bean 테스트 메소드
	//http://localhost:9090/sample2/ex02Bean?list%5B0%5D.name=홍길동&list%5B0%5D.age=100&list%5B1%5D.name=홍길동&list%5B1%5D.age=100
	//위의 주소를 인코딩변환하여 호출하는 매핑주소
	@GetMapping("/ex02BeanTest")
	public void ex02BeanTest() {
		
	}
	
	//주소: http://localhost:9090/sample2/ex03?title=test&dueDate=2022/06/15 (기본 지원)
	//주소: http://localhost:9090/sample2/ex03?title=test&dueDate=2022-06-15 - dueDate필드에 @DateTimeFormat(pattern="yyyy-MM-dd")사용시 "-"만 지원
	@GetMapping("/ex03")
	public String ex03(TodoDTO todo) {
		
		log.info("todo: " + todo);
		
		return "/sample2/ex03";
	}
	
	//주소: http://localhost:9090/sample2/ex04?name=김지원&age=100&page=1
	@GetMapping("/ex04")
	public String ex04(SampleDTO dto, @ModelAttribute("page") int page, Model model) {
		//SampleDTO : name, age 필드
		
		//jsp파일에 데이터 전달하는 방법	
		/*
		 1) SampleDTO dto -> 파라미터 값을 사용
		 	- SampleDTO클래스에 name과 age 필드가 있기 때문에 쿼리스트링에 사용, setter메서드가 작동하여 SampleDTO dto에 할당됨
		 	- jsp 사용 이름 : SampleDTO클래스의 첫글자만 소문자로 변경 sampleDTO
		 */
		
		// 2) int page 에 들어온 값을 @ModelAttribute("page") 이용하여 파라미터값 사용
		
		// 3) Model model 객체에 데이터를 추가 (model객체 : 데이터 전달자 - jsp파일에 "board"라는 이름으로 데이터를 전달)
		//BoardVO클래스에 파라미터가 있는 생성자 추가
		BoardVO vo = new BoardVO(1, "이은오", "나의 해방일지", "해방하는 날까지", 1, new Date());
		model.addAttribute("board", vo);
		//model.addAttribute("jsp에서 참조할 이름", attributeValue)
		
		// /sample2/ex04.jsp파일에 데이터 3개를 전달(
		return "/sample2/ex04";
	}
	
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		/*@ResponseBody : 일반적으로 리턴값이 문자열이면 jsp파일명을 의미하지만, 
						  return타입에 @ResponseBody를 사용하면 return값(객체)을 JSON으로 변환하여 클라이언트(브라우저)로 보낸다.
						    단, pom.xml에 JSON 기능을 제공하는 라이브러리(jackson-databind)가 존재해야 함
						  JSON 데이터 구조 : {"name":"김지원","age":29}
						  	-> 자바스크립트에서 사용 (Object문법이용)
						  	-> 참고: https://www.w3schools.com/js/js_json_objects.asp
						  */
		SampleDTO dto = new SampleDTO();
		dto.setAge(29);
		dto.setName("김지원");
		
		return dto;
	}
}
