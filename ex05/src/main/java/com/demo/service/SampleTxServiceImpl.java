package com.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.mapper.Sample1Mapper;
import com.demo.mapper.Sample2Mapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SampleTxServiceImpl implements SampleTxService {

	/*
	 주입 Annotation
	 1) @Autowired(스프링프레임워크 제공) 혹은 
	 2) @Inject(자바제공) 를 사용 
	 3) -> 지금은 롬복 제공 어노테이션 사용
	 */
	@Setter(onMethod_ = {@Autowired}) //onMethod_ : jdk1.8에서만 언더바 사용
	private Sample1Mapper mapper1;
	
	@Setter(onMethod_ = {@Autowired})
	private Sample2Mapper mapper2;
	
	@Transactional //트랜잭션 어노테이션
	@Override
	public void addData(String value) {
		//addData메소드 안에서 2개의 작업
		
		log.info("mapper1...");
		//작업1
		mapper1.insertCol1(value); //500바이트
		
		log.info("mapper2...");
		//작업2
		mapper2.insertCol2(value); //50바이트
		
		log.info("end...");

	}

}
