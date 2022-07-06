package com.demo.mapper;

import java.util.List;

import com.demo.domain.MemberVO;

public interface MemberMapper {

	void insert(MemberVO vo);
	
	List<MemberVO> getMemberList();
}
