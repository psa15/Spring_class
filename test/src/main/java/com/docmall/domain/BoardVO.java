package com.docmall.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	//bno, title, content, writer, regdate
	
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	
	//lombok라이브러리 이용하여 디폴트 생성자, getter, setter 메소드, toString
}
