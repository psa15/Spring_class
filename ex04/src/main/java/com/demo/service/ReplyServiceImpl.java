package com.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.domain.Criteria;
import com.demo.domain.ReplyPageDTO;
import com.demo.domain.ReplyVO;
import com.demo.mapper.ReplyMapper;

import lombok.AllArgsConstructor;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired //기억!!!!!!!!! 주입 필요!!!!!!!!!
	private ReplyMapper mapper;

	@Override
	public int insert(ReplyVO vo) {
		
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
