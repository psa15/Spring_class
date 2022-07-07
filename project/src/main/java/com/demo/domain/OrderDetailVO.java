package com.demo.domain;

import lombok.Data;

//TBL_ORDER_D
@Data
public class OrderDetailVO {

	//ord_code, p_num, ord_amount, ord_cost
	private Long ord_code;	//주문 번호
	private int p_num;		//상품 번호
	private int ord_amount;	//주문 수량
	private int ord_cost;	//주문 가격
}
