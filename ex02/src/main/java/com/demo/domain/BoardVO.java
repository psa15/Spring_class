package com.demo.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	//테이블명: TBL_BOARD, 컬럼명: bno, title, content, writer, regdate
	//클래스명은 테이블명과 달라도 됨, 필드는 테이블 컬럼명과 동일하게 하면 작업이 편해짐
	
	private Long bno; //Long wrapper클래스
	private String title;
	private String content;
	private String writer;
	private Date regdte;
	
	//lombok라이브러리 사용
}
