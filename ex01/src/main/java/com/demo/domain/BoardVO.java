package com.demo.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/*
@Setter
@Getter
@ToString
@NoArgsConstructor //매개변수 없는 생성자
@AllArgsConstructor //매개변수 있는 생성자
*/
@Data
public class BoardVO {
	
	//bno, writer, title, content, viewcnt, regdate 컬럼 존재
	
	private int bno;
	private String writer;
	private String title;
	private String content;
	private int viewcnt;
	private Date regdate;

	
}
