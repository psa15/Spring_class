package com.demo.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TodoDTO {
	
	private String title;
	
	//설정을 안하면 : 기본인 2022/06/15 로 파라미터값 주기 
	//사용: 2022-06-15 로 파라미터 값 줘야함
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date dueDate;
}
