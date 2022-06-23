package com.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.domain.ReplyVO;
import com.demo.mapper.ReplyMapper;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired //기억!!!!!!!!! 주입 필요!!!!!!!!!
	private ReplyMapper mapper;

	@Override
	public int inert(ReplyVO vo) {
		
		return mapper.inert(vo);
	}
	
}
