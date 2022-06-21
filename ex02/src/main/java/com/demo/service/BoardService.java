package com.demo.service;

import java.util.List;

import com.demo.domain.BoardVO;
import com.demo.domain.Criteria;

public interface BoardService {
	void insert(BoardVO vo);
	
	//특별하지 않으면 Mapper인터페이스의 메소드를 복사
	List<BoardVO> getList();
	
	List<BoardVO> getListWithPaging(Criteria cri);
	
	int getTotalCount();
	
	BoardVO get(Long bno);
	
	void modify(BoardVO vo);
	
	void remove(Long bno);
	
	
}
