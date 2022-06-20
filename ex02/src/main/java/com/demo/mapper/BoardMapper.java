package com.demo.mapper;

import java.util.List;

import com.demo.domain.BoardVO;

public interface BoardMapper {

	//abstract method
	void insert(BoardVO vo);
	
	List<BoardVO> getList();
	//데이터 한개 행이 BoardVO 객체 하나를 의미하므로 List 사용
	
	BoardVO get(Long bno);
	//글 번호 값이 넘어오는데 sql구문을 호출하는 mapper 인터페이스에서 파라미터를 호출
	//특정 데이터 행 하나를 원하기 때문에 BoardVO 사용
	
	void modify(BoardVO vo);
	
	void remove(Long bno);
}
