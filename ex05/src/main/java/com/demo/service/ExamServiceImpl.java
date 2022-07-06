package com.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.domain.Board;
import com.demo.mapper.ExamMapper;

@Service
public class ExamServiceImpl implements ExamService {

	@Autowired
	private ExamMapper mapper;
	
	@Override
	public List<Board> getList() {
		return mapper.getList();
	}

	@Override
	public void insert(Board vo) {
		mapper.insert(vo);
		
	}

	@Transactional
	@Override
	public Board get(Long board_idx) {
		
		//조회수
		mapper.hitCount(board_idx);
		
		return mapper.get(board_idx);
		
	}

}
