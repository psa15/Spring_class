package com.demo.domain;

import lombok.Data;

@Data
public class AttachFileDTO {
//Data Transfer Object - VO랑 기능은 비슷한데 VO는 테이블을 구조로
	
	private String uuid; //중복되지 않는 파일명 생성할 목적
	private String uploadPath; //날짜를 이용한 업로드 폴더명
	private String fileName; //클라이언트에서 보낸 파일명
	private boolean image; //이미지 파일구분 / true : 이미지, false : 이미지 X 파일
}
