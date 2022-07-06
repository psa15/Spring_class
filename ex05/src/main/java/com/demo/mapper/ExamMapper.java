package com.demo.mapper;

import java.util.List;

import com.demo.domain.Board;

public interface ExamMapper {

	//목록보여주기
	List<Board> getList();
	
	//게시글 추가하기
	void insert(Board vo);
	
	//목록에서 제목 클릭시 게시글 보이기
	Board get(Long board_idx);
	
	//조회수 올라가기
	void hitCount(Long board_idx);
}
