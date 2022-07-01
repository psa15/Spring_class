package com.demo.domain;

import lombok.Data;

@Data
public class BoardAttachVO {
	//uuid, uploadpath, filename, filetype, bno
	
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	
	private Long bno;
}
