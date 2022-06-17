package com.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.domain.MemberVO;
import com.demo.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	//MemberMapper인터페이스 객체 주입
	@Autowired
	private MemberMapper mapper;
	
	@Override
	public void insert(MemberVO mvo) {
		mapper.insert(mvo);
		
	}

}
