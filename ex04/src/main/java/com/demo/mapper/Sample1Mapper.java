package com.demo.mapper;

import org.apache.ibatis.annotations.Insert;

//스프링이 시작하면서 Sample1Mapper 인터페이스를 대신하는 Proxy클래스가 bean으로 생성
public interface Sample1Mapper {

	@Insert("insert into TBL_SAMPLE1(col1) values(#{data})")
	public int insertCol1(String data); //sql mapper 사용 X
}
