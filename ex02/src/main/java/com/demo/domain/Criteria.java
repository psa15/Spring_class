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
	
	//검색기능
	public String[] getTypeArr() {
		return type == null? new String[] {} : type.split("");
	}
	
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();	
	}
}
