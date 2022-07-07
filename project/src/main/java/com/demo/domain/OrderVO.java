package com.demo.domain;

import java.util.Date;

import lombok.Data;

//TBL_ORDER
@Data
public class OrderVO {

	/*
	 ord_code, m_id, ord_name, ord_post, ord_addr, ord_addr_d, 
	 ord_tel, ord_totalcost, ord_date
	 */
	private Long ord_code;	//주문번호
	private String m_id;	//회원 ID
	private String ord_name;	//받는 사람 이름
	private String ord_post;	//받는 사람 우편번호
	private String ord_addr;	//받는 사람 기본 주소
	private String ord_addr_d;	//받는 사람 상세 주소
	private String ord_tel;		//받는 사람 전화번호
	private int ord_totalcost;	//총 주문 금액
	private Date ord_date;		//주문한 날짜
}
