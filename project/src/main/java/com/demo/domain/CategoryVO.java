package com.demo.domain;

import lombok.Data;

//TBL_CATEGORY 테이블
@Data
public class CategoryVO {

	//ct_code, ct_p_code, ct_name
	private Long ct_code;	//현재 카테고리 코드
	private int ct_p_code;	//부모 카테고리 코드
	private String ct_name;	//카테고리 명
}
