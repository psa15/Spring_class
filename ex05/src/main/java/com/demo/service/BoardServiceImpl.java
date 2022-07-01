package com.demo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.domain.BoardVO;
import com.demo.domain.Criteria;
import com.demo.mapper.BoardAttachMapper;
import com.demo.mapper.BoardMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardMapper mapper;
	
	@Autowired
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void insert(BoardVO vo) {
		
		//mapper.insert(vo); 구버전
		
		//1)게시판 글쓰기
		//BoardVO vo 안에 파일첨부 정보가 다 들어있음
		//BoardVO클래스의 bno필드는 널상태
		mapper.insertSelectKey(vo);
		////BoardVO클래스의 bno필드에 시퀀스 값이 존재
		
		//bno값 확인(시퀀스 확인)
		log.info("글번호 :  " + vo.getBno());
		
		//2)파일첨부 정보 데이터 십입 
		//첨부파일이 없을 경우
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0)
			return;
		//첨부파일 개수만큼 반복(forEach)
		vo.getAttachList().forEach(attach -> {
			//attach -> : attach(매개변수)
			attach.setBno(vo.getBno());
			attachMapper.insert(attach);
		});
		//vo.getAttachList() 파일첨부 정보
		
		
	}

	@Override
	public List<BoardVO> getList() {
		
		return mapper.getList();
	}

	@Override
	public BoardVO get(Long bno) {
		
		return mapper.get(bno);
	}

	@Override
	public void modify(BoardVO vo) {
		mapper.modify(vo);
		
	}

	@Override
	public void remove(Long bno) {
		mapper.remove(bno);
		
	}

	@Override
	public List<BoardVO> getListWithPaging(Criteria cri) {
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(Criteria cri) {
	
		return mapper.getTotalCount(cri);
	}

}
