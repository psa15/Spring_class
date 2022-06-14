package com.demo.mapper;

import org.apache.ibatis.annotations.Select;

/*
 Mapper Interface : Mapper XML 파일의 SQL구문을 실행하는 기능을 담당
 TimeMapper 클래스가 Mapper Interface 역할을 하려면 설정 필요
 	- root-context.xml에서 작업 (6월14일 src/test/java - com.demo.mapper패키지 정리본 참고)
 */
public interface TimeMapper {
	
	@Select("select sysdate from dual")
	public String getTime();
	
	public String getTime2();
}
