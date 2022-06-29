package com.demo.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	//bno, title, content, writer, regdate, replycnt (추가됨)
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	
	//replycnt 컬럼 추가
	private int replycnt;
}
