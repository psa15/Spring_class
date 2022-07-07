package com.demo.domain;

import java.util.Date;

import lombok.Data;

//TBL_PRODUCT테이블
@Data
public class ProductVO {
	/*
	 p_num, f_ct_code, s_ct_code, p_name, p_cost, p_discount,  p_company,
	 p_detail, p_image, p_amount, p_buy_ok, p_regdate, p_updatedate
	 */
	private Long p_num;		//상품 번호
	private int f_ct_code;	//1차 카테고리 코드
	private int s_ct_code;	//2차 카테고리 코드
	private String p_name;	//상품명
	private int p_cost;		//상품가격
	private int p_discount;	//상품의 할인율
	private String p_company;	//상품 개발사
	private String p_detail;	//상품 상세정보
	private String p_image;		//상품 이미지
	private int p_amount;	//상품 남은 수량
	private boolean p_buy_ok;	//상품 구매 가능 여부
	private Date p_regdate;		//상품 등록 날짜
	private Date p_updatedate;	//상품 정보 수정 날짜
}
