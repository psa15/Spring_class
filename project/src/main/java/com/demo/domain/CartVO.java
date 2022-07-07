package com.demo.domain;

import lombok.Data;

//TBL_CART테이블
@Data
public class CartVO {

	//cart_code, p_num, m_id, cart_amount
	private Long cart_code; 	//장바구니 코드
	private int p_num;			//상품 번호
	private String m_id;		//회원 id
	private int cart_amount;	//구매 수량
}
