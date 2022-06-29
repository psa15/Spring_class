package com.demo.service;

import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SampleServiceImpl implements SampleService {

	@Override
	public Integer doAdd(String str1, String str2) throws Exception {

		
		Integer result = Integer.parseInt(str1) + Integer.parseInt(str2);
		
		//long end = System.currentTimeMillis();
		
		//log.info(end - start);		
		return result;
	}

}
