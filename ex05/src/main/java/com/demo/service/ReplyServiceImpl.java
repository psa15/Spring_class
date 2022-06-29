package com.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.domain.Criteria;
import com.demo.domain.ReplyPageDTO;
import com.demo.domain.ReplyVO;
import com.demo.mapper.ReplyMapper;

import lombok.AllArgsConstructor;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired //기억!!!!!!!!! 주입 필요!!!!!!!!!
	private ReplyMapper mapper;

	/*
	**@Transactional**
    	- 댓글 저장과 replycnt 개수 계산이 같이 성공해야 하기 때문에 추가
	 */
	@Transactional
	@Override
	public int insert(ReplyVO vo) {
		//게시판에 replycnt 컬럼에 댓글 카운트 작업
		mapper.replyCountUpdate(vo.getBno());
		
		return mapper.insert(vo);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		
		//mapper.getCountByBno(bno) : 부모글을 참조하는 댓글 개수
		//mapper.getListWithPaging(cri, bno) : 부모글을 참조하는 댓글 목록
		//ReplyPageDTO 클래스의 @AllArgsConstructor어노테이션에 의해 만들어진 생성자
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}

	@Override
	public int update(ReplyVO vo) {
		return mapper.update(vo);
	}

	@Override
	public int delete(Long rno) {
		return mapper.delete(rno);
	}
	
}
