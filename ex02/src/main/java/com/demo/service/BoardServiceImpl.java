package com.demo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.demo.domain.BoardVO;
import com.demo.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardMapper mapper;
	
	@Override
	public void insert(BoardVO vo) {
		mapper.insert(vo);
		
	}

	@Override
	public List<BoardVO> getList() {
		
		return mapper.getList();
	}

	@Override
	public BoardVO get(Long bno) {
		
		return mapper.get(bno);
	}

	@Override
	public void modify(BoardVO vo) {
		mapper.modify(vo);
		
	}

	@Override
	public void remove(Long bno) {
		mapper.remove(bno);
		
	}

}
