package com.demo.mapper;

import com.demo.domain.ReplyVO;

public interface ReplyMapper {
	
	//mapper xml 파일에서 insert, delete, update구문이 실행이 반영된 데이터 행수를 리턴
	int inert(ReplyVO vo);
}
