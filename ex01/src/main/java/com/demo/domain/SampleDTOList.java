package com.demo.domain;

import java.util.ArrayList;
import java.util.List;

import lombok.Data;

//파라미터 목적 : 클라이언트에서 SampleDTOList클래스 파라미터를 여러개 전송되어 올 때

@Data
public class SampleDTOList {

	//SampleDTO를 멤버로 사용
	private List<SampleDTO> list;
	
	//생성자메소드
	public SampleDTOList() {
		list = new ArrayList<SampleDTO>();
	}
	
	
}
