package com.demo.domain;

import java.util.Date;

import lombok.Data;

//rno, bno, reply, replyer, replydate, updatedate
//테이블 구조를 가진 클래스 : VO - Value Object
@Data
public class ReplyVO {

	private Long rno;
	private Long bno;
	
	private String reply;
	private String replyer;
	
	private Date replydate;
	private Date updatedate;
}
