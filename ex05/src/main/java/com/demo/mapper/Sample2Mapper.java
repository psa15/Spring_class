package com.demo.mapper;

import org.apache.ibatis.annotations.Insert;

//스프링이 시작하면서 Sample2Mapper 인터페이스를 대신하는 Proxy클래스가 bean으로 생성
public interface Sample2Mapper {
	
	@Insert("insert into TBL_SAMPLE2(col2) values(#{data})")
	public int insertCol2(String data); //sql mapper 사용 X
}
