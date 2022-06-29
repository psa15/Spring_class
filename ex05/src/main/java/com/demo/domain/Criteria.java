package com.demo.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

//페이지 정보필드 : 현재 페이지, 페이지마다 출력 건수
//검색 필드 : 검색 종류, 검색어
@Getter
@Setter
@ToString
public class Criteria {

	//페이지 정보필드
	private int pageNum; // 편재 페이지 번호
	private int amount; // 게시물 출력개수
	
	//검색 필드
	private String type; //검색 종류(제목, 내용, 작성자 등)
	private String keyword; //검색어
	
	//기본생성자 작업 - pageNum과 amount를 미리 지정하자
	public Criteria() {
		this(1,10);
		//this : Criteria(int pageNum, int amount)생성자를 의미
	}

	//매개변수가 있는 생성자 정의
	public Criteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	//검색기능. 메소드명 규칙: get대문자___() ->  xml mapper파일에서 사용될 메소드명
	public String[] getTypeArr() {
		
		//type이 null이라는 것은 검색버튼을 누르지 않았다는 것.
		//type에 TW값이 들어가면 type.split("")이 작동됨, {"TW"} -> {"T", "W"}
		return type == null? new String[] {} : type.split("");
	}
	
	//주소에 Criteria클래스 파라미터 추가해주는 메소드 -> ?pageNum=값1&amount=값2&type=값3&keyword=값4
	public String getListLink() {
		
		//메소드 체이닝 문법
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();	
	}
}
