package com.demo.mapper;

import java.util.List;

import com.demo.domain.BoardAttachVO;

public interface BoardAttachMapper {

	//첨부파일 추가
	void insert(BoardAttachVO vo);
	
	//게시물 정보에 파일정보 추가를 위한 메소드
	List<BoardAttachVO> getFiles(Long bno);
	
	//기존 파일 삭제
	void deleteFiles(Long bno);
}
