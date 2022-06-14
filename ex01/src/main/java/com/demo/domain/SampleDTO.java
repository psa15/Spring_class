package com.demo.domain;

import lombok.Data;

//스프링에서 사용하는 데이터 관리 목적으로 사용하는 클래스는 getter, setter 메서드가 반드시 존재해야 한다.
@Data
public class SampleDTO {

	private String name;
	private int age;
	
	
}
