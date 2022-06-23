package com.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
		
		ResponseEntity<String> entity = null;
		
		int count = service.inert(vo);
		
		//일반적인 요청은 서버측에서 상태코드값을 함께 보내는데, 
		//ajax로 요청하여 값을 받은 경우에는 상태코드 값이 진행이 되지 않을 때가 있어 ResponseEntity<>클래스를 사용하여 명시적으로 상태코드 보내주는 것
		return count == 1 ? new ResponseEntity<String>("success", HttpStatus.OK) 
							: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR) ; 
	}
}
