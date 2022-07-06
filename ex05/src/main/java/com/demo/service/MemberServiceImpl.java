package com.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.domain.MemberVO;
import com.demo.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberMapper mapper;

	@Override
	public void insert(MemberVO vo) {
		mapper.insert(vo);
		
	}

	@Override
	public List<MemberVO> getMemberList() {
		return mapper.getMemberList();
	}
}
