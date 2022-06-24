package com.demo.service;

import com.demo.domain.Criteria;
import com.demo.domain.ReplyPageDTO;
import com.demo.domain.ReplyVO;

public interface ReplyService {

	int insert(ReplyVO vo);
	
	//댓글목록
	ReplyPageDTO getListPage(Criteria cri, Long bno);
}
