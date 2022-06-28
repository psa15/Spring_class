package com.demo.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor //모든 필드를 파라미터로 하는 생성자 메소드 생성
public class ReplyPageDTO {

	//댓글 개수
	private int replyCnt; //댓글 페이징정보를 구성하기 위한 데이터 개수
	
	//댓글 목록
	private List<ReplyVO> list;

	//파라미터가 있는 생성자
	/*
	public ReplyPageDTO(int replyCnt, List<ReplyVO> list) {
		super();
		this.replyCnt = replyCnt;
		this.list = list;
	}
	*/
	
	
}
