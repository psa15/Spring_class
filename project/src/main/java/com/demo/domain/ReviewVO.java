package com.demo.domain;

import java.util.Date;

import lombok.Data;

//TBL_REVIEW
@Data
public class ReviewVO {

	//r_num, m_id, p_num, r_content, r_score, r_regdate
	private Long r_num;	//리뷰글 번호
	private String m_id;	//회원 id
	private int p_num;		//상품 번호
	private String r_content;	//리뷰 내용
	private int r_score;	//리뷰 평점
	private Date r_regdate;	//리뷰 작성일
}
