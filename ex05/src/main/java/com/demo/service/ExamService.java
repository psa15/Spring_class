package com.demo.service;

import java.util.List;

import com.demo.domain.Board;

public interface ExamService {

	//목록보여주기
	List<Board> getList();
	
	void insert(Board vo);
	
	Board get(Long board_idx);
	
}
