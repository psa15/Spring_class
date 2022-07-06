package com.demo.service;

import java.util.List;

import com.demo.domain.MemberVO;

public interface MemberService {

	void insert(MemberVO vo);
	
	List<MemberVO> getMemberList();
	
	
}
