package com.demo.domain;

import java.util.Date;

import lombok.Data;

//rno, bno, reply, replyer, replydate, updatedate
@Data
public class ReplyVO {

	private Long rno;
	private Long bno;
	
	private String reply;
	private String replyer;
	
	private Date replydate;
	private Date updatedate;
}
