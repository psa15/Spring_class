package com.demo.domain;

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
}
