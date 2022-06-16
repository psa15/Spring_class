package com.demo.controller;

import java.util.ArrayList;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/sample3")
public class SampleController3 {
	
	@GetMapping("/getAjax")
	public String getAjax() {
		//jsp페이지로 가는 주소
		
		return "/sample3/getAjax";
	}
	
	@RequestMapping("/demo")
	public String demo( ) {
		//click버튼을 클릭했을 때 매핑 주소
		return "/sample3/demo";
	}
	
	/*
	 ResponseEntity<> : ajax작업과 함께 사용
	 	- 서버에서 클라이언트로 결과를 보낼 때
	 		1)응답 데이터
	 		2)헤더 정보
	 		3)Http 상태 코드	3가지 정보를 관리
	 	- 응답 데이터 : 클라이언트의 요청에 따른 서버측의 행위에 따른 결과
	 	- 헤더 정보 : 헤더 + 데이터, 응답 데이터 이외의 부가적인 정보를 요청(request)과 응답(response)에서 사용
	 	- 상태 코드 : 200, 404, 500 자주 볼거임
	 */
	
	@GetMapping("/ex07")
	public ResponseEntity<String> ex07() {
				
		ResponseEntity<String> entity = null;
		//ResponseEntity<String>(데이터타입) entity(변수)
		
		//1) 응답 데이터 : json포맷 : {"name" : "김지원"}
		String msg = "{\"name\" : \"김지원\"}"; // \자동생성됨
		
		//2)헤더 정보 : 부가적인 정보
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json;charset=utf-8");
		//msg데이터를 브라우저에서 ("Content-Type", "application/json;charset=utf-8") 이 성격대로 해석
		
		//3)HttpStatus.OK : 상태 코드, 데이터 상실, 변경 등을 조금이라도 예방하려고 
		//클라이언트에서 서버측에서 정상적으로 넘어온 데이터라고 인식하게 하기 위해
		entity = new ResponseEntity<String>(msg, header, HttpStatus.OK);
		
		return entity;
	}
	
	/* 파일 업로드*/
	//파일 업로드 폼
	@GetMapping("/exupload")
	public void exupload() {
		log.info("exupload called...");
	}
	
	//파일 업로드 처리 담당 주소 - 파일업로드 form태그의 요쳥방법이 post기 때문에 @PostMapping
	//설정 작업 필요 - pom.xml에 추가
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
		for(int i=0; i<files.size(); i++) {
			log.info("-----------------------");
			log.info("name: " + files.get(i).getOriginalFilename());
			log.info("size: " + files.get(i).getSize());
		}
	}
	
}
