package com.demo.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.domain.BoardAttachVO;
import com.demo.domain.BoardVO;
import com.demo.domain.Criteria;
import com.demo.mapper.BoardAttachMapper;
import com.demo.mapper.BoardMapper;
import com.demo.mapper.ReplyMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardMapper mapper;
	
	@Autowired
	private ReplyMapper replyMapper;
	
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
		if(vo.getAttachList() != null || vo.getAttachList().size() > 0) {
			//첨부파일 개수만큼 반복(forEach)
			vo.getAttachList().forEach(attach -> {
				//attach -> : attach(매개변수)
				attach.setBno(vo.getBno());
				attachMapper.insert(attach);
			});
		}
		//vo.getAttachList() 파일첨부 정보
		
		
	}

	@Override
	public List<BoardVO> getList() {
		
		return mapper.getList();
	}

	@Override
	public BoardVO get(Long bno) {
		
		//게시물 정보
		BoardVO board = mapper.get(bno);
		
		//파일정보 - BoardVO 클래스에 파일정보 추가됨(7/4)
		List<BoardAttachVO> attachList = attachMapper.getFiles(bno);
		board.setAttachList(attachList);
		
		return board;
	}

	@Transactional
	@Override
	public void modify(BoardVO vo) {
		
		/*
		 기존 첨부파일은 모두 삭제
		 첨부파일을 신규로 추가(기존 + 새 파일)
		 */
		attachMapper.deleteFiles(vo.getBno());
		
		//첨부파일이 없을 경우 - 위의 insert메소드에서 가져옴 - return이 되면 기존 파일까지 다 삭제됨
		if(vo.getAttachList() != null || vo.getAttachList().size() > 0) {
			//첨부파일 개수만큼 반복(forEach)
			vo.getAttachList().forEach(attach -> {
				//attach -> : attach(매개변수)
				attach.setBno(vo.getBno());
				attachMapper.insert(attach);
			});
		}
		
		
		mapper.modify(vo);
		
	}

	@Transactional
	@Override
	public void remove(Long bno) {
		
		//댓글 데이터 삭제 - ReplyMapper 객체 생성
		//replyMapper.delete(rno); rno가 아닌 bno로 전체 댓글이 삭제되어야 함
		replyMapper.deleteByBno(bno);
		
		// 첨부파일 데이터 삭제
		//업로드 파일 삭제
		attachMapper.deleteFiles(bno);	
		
		//게시판 삭제
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
