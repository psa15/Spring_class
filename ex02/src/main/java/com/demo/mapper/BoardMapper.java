package com.demo.mapper;

import java.util.List;

import com.demo.domain.BoardVO;
import com.demo.domain.Criteria;

public interface BoardMapper {

	//abstract method
	void insert(BoardVO vo);
	
	/*리스트*/
	List<BoardVO> getList();
	//데이터 한개 행이 BoardVO 객체 하나를 의미하므로 List 사용
	
	//현재는 검색기능 포함 - Criteria클래스에서 필드 4개 다 사용
	List<BoardVO> getListWithPaging(Criteria cri);
	//오라클에서 페이징으로 만든 뼈대의 pageNum과 amount 파라미터가 Criteria 클래스에 존재
	//Criteria : pageNum, amount, type, keyword
	
	//pageDTO클래스에서 total 값 - 검색기능 포함
	//Criteria클래스에서 검색필드 2개만 사용
	int getTotalCount(Criteria cri);
	
	
	BoardVO get(Long bno);
	//글 번호 값이 넘어오는데 sql구문을 호출하는 mapper 인터페이스에서 파라미터를 호출
	//특정 데이터 행 하나를 원하기 때문에 BoardVO 사용
	
	void modify(BoardVO vo);
	
	void remove(Long bno);

	
}
