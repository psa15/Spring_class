package com.demo.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	//bno, title, content, writer, regdate, replycnt (추가됨)
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regdate;
	
	//replycnt 컬럼 추가
	private int replycnt;
	
	//파일첨부 클래스
	private List<BoardAttachVO> attachList;
	//<input type="hidden" name="attachList[0].title"> 같은 형식
	//게시판에 글쓰기 할 때 파일 첨부는 여러개 가능해서 List인터페이스 사용
}
