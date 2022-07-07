package com.demo.domain;


import java.util.Date;

import lombok.Data;

//TBL_BOARD
@Data
public class BoardVO {

	//b_num, m_id, b_title, b_content, b_regdate
	private Long b_num;		//게시판 번호(시퀀스)
	private String m_id;	//회원 id
	private String b_title;	//게시글 제목
	private String b_content;	//게시글 내용
	private Date b_regdate;		//게시글 작성 날짜
}
