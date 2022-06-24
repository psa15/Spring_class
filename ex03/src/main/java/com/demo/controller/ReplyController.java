package com.demo.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.demo.domain.Criteria;
import com.demo.domain.PageDTO;
import com.demo.domain.ReplyPageDTO;
import com.demo.domain.ReplyVO;
import com.demo.service.ReplyService;

import lombok.extern.log4j.Log4j;

/*
 이 컨트롤러 클래스는 jsp파일 사용 X (@RestController사용해서)
 모든 매핑주소는 ajax요청으로 사용
 */
@RestController
@RequestMapping("/replies/*")
@Log4j
public class ReplyController {
	
	@Autowired
	private ReplyService service;
	
	//댓글 저장하기 메소드
	//댓글 데이터는 JSON문자열 형식으로 전송되어 옴. 
	//{"bno":5120, "replyer":"user01","reply":"댓글테스트"} --> ReplyVO vo로 변환시켜 줄 때
	//앞에 @RequestBody 어노테이션 필요
	//consumes = "application/json" : 클라이언트에서 보내오는 데이터의 성격을 명시(지금은 json이라는 의미) - 이 성격으로 데이터가 들어오지 않으면 에러
	//produces = {MediaType.TEXT_PLAIN_VALUE} : 서버에서 클라이언트에게 보내는 데이터의 포맷을 명시
	@PostMapping(value = "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		//ajax형태로 데이터를 받기 때문에 제대로 된 구문인지 확인 위해 ResponseEntity<String> 사용?
		//produces: create()메소드의 실행 결과를 ajax에 전송할 때의 데이터타입이 text이다
		
		ResponseEntity<String> entity = null;
		
		int count = service.insert(vo);
		
		//일반적인 요청은 서버측에서 상태코드값을 함께 보내는데, 
		//ajax로 요청하여 값을 받은 경우에는 상태코드 값이 진행이 되지 않을 때가 있어 ResponseEntity<>클래스를 사용하여 명시적으로 상태코드 보내주는 것
		return count == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR); 
	}
	
	/*
	 1)댓글목록 데이터, 2)페이징정보를 JSON포맷으로 클라이언트에게 리턴해주는 작업
	 두 가지를 한번에 보내기 위해서 Map 컬렉션을 사용 (Hashmap의 부모 인터페이스)
	 
	주소 : /pages/{bno}/{page}
    	- 주소의 일부분을 메소드의 파라미터값으로 사용하고자 할 경우
        	- ex) /page/1/1
         테스트주소 : http://localhost:9090/replies/pages/5120/1.JSON
	 */
	@GetMapping(value = "/pages/{bno}/{page}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Map<String, Object>> getList(@PathVariable("bno") Long bno,
														@PathVariable("page") int page) {
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		/* 아래처럼 하면 service.getListPage(cri, bno)를 두 번 호출하게 되어 한 번 호출한 결과를 사용하자
		//1)댓글 목록 작업 - Criteria를 파라미터로 받지 않고, 수동으로 받아 쓰기
		Criteria cri = new Criteria(page, 5); //page : 클릭된 페이지 번호, 5 : 5개씩 불러오기
		map.put("list", service.getListPage(cri, bno).getList()); //map.put("키", 값)
		
		//2)페이징 정보 작업 - 1 2 3 4 5 처리 -> ajax로 부분업데이트! 본문내용은 그대로고 댓글 페이지만 불러오기
		PageDTO pageDTO = new PageDTO(cri, service.getListPage(cri, bno).getReplyCnt());
		map.put("pageMaker", pageDTO);
		*/
		
		//1)댓글 목록 작업 - Criteria를 파라미터로 받지 않고, 수동으로 받아 쓰기
		Criteria cri = new Criteria(page, 5);
		ReplyPageDTO replyObj = service.getListPage(cri, bno);
		
		map.put("list", replyObj.getList());
		
		//2)페이징 정보 작업 - 1 2 3 4 5 처리 -> ajax로 부분업데이트! 본문내용은 그대로고 댓글 페이지만 불러오기
		PageDTO pageDTO = new PageDTO(cri, replyObj.getReplyCnt());
		map.put("pageMaker", pageDTO);
				
		//entity 객체
		entity = new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
		//ResponseEntity<Map<String,Object>>(@Nullable Map<String, Object> body, HttpStatus status)
		
		return entity;
	}
}
