package com.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.demo.domain.Criteria;
import com.demo.domain.ReplyVO;

public interface ReplyMapper {
	
	//mapper xml 파일에서 insert, delete, update구문이 실행이 반영된 데이터 행수를 리턴
	int insert(ReplyVO vo);
	
	//댓글 목록
	//mapper interface 메소드의 파라미터가 2개이상일 경우 @Param 어노테이션 사용!!!!
	List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
	//검색 기능(페이징 파라미터) 때문에 Criteria, 글번호(본문글) bno
	
	//댓글 목록 불러오는데 필요한 본문글을 참조하는 댓글의 개수
	int getCountByBno(Long bno);
	
	//댓글 수정
	int update(ReplyVO vo);
	
	//댓글 삭제
	int delete(Long rno);
	
}
