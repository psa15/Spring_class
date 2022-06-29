package com.demo.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.demo.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/upload/*")
public class UploadController {

	@GetMapping("/uploadForm")
	public void uploadForm() {
		
	}
	
	/*
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile) {
		/*
		 MultipartFile 인터페이스 : servlet-context.xml의 파일 업로드 bean 설정에 의해 사용 가능
		 - MultipartFile: 파일 하나일 때
		 - MultipartFile[] : 파일 여러개(form태그의 multiple 속성)
		 
		for (MultipartFile multipartFile: uploadFile) {
			log.info("==============================");
			log.info("파일이름: " + multipartFile.getOriginalFilename());
			log.info("파일 크기: " + multipartFile.getSize());
		}
	}
	*/
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile) {
		
		String uploadFolder = "C:\\Dev\\upload";
		
		for (MultipartFile multipartFile: uploadFile) {
			log.info("==============================");
			log.info("파일이름: " + multipartFile.getOriginalFilename());
			log.info("파일 크기: " + multipartFile.getSize());
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			
			try {
				multipartFile.transferTo(saveFile); //파일복사(업로드)
				//transferTo() : 실제 파일을 저장시켜주는 메소드인데 파라미터의 타입이 File이어서 49번 라인 작성
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
		}
	}
	
	//AJAX이용한 파일 업로드
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
	}
	
	/*
	 produces = {MediaType.APPLICATION_JSON_UTF8_VALUE} : 이 메소드를 실행한 결과를 json형태로 변환
	 ResponseEntity<List<AttachFileDTO>> : ajax를 사용하겠다 + 파일 여러개여서 List<>
	 */
	@ResponseBody //@Controller 클래스 안에서 이 메소드만 리턴값을 json으로 변환할 때 사용
	@PostMapping(value = "/uploadAjaxAction", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxAction(MultipartFile[] uploadFile){
		ResponseEntity<List<AttachFileDTO>> entity = null;
		
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>(); //List는 인터페이스라 List를 구현한 클래스인 ArrayList로 객체 생성
		
		String uploadFolder = "C:\\Dev\\upload";
		
		String uploadFolderPath = getFolder(); //"2022\06\29"
		
		File uploadPath = new File(uploadFolder, uploadFolderPath); // C:\\Dev\\upload\\2022\06\29
		
		if(uploadPath.exists() == false) {
			//경로의 폴더가 존재하지 않으면 폴더들 모두 생성
			uploadPath.mkdirs();
		}
		
		//향상된 for문
		for(MultipartFile multipartFile : uploadFile ) {
			
			AttachFileDTO attachFileDTO = new AttachFileDTO(); //파일 정보 받는 목적
			
			String uploadFileName = multipartFile.getOriginalFilename();
			attachFileDTO.setFileName(uploadFileName);
			
			//중복되지 않는 문자열 생성
			UUID uuid = UUID.randomUUID();
			
			uploadFileName = uuid.toString() + "_" + uploadFileName;
		}
		
		return entity;
	}
	
	//날짜를 이용한 업로드 폴더 생성 및 폴더 이름 반환 메소드
	private String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		//현재 시스템의 날짜
		Date date = new Date();
		
		String str = sdf.format(date); //"2022-6-29" 저장됨
		
		//File.separator : 응용체제에 따라 다른 파일경로 구분자를 반환하여 -를 구분자로 대체 -> 운영체제에 영향받지 않고 동작하게
		//윈도우(\) : c:\temp\...  리눅스(/) /home/etc/..
		return str.replace("-", File.separator); // "2022-06-29" -> "2022\06\29"
	}
	
	//이미지 파일여부를 체크
	private boolean checkImageType(File saveFile) {
		
		boolean isImage = false;
		
		try {
			String contentType = Files.probeContentType(saveFile.toPath());
			//contentType : 현재 업로드 된 파일의 정보가 들어감 ( text/html, text/plain, image 등)
			
			isImage = contentType.startsWith("image");
			//contentType.startsWith("image") : image로 시작하면 true 반환
			
		} catch (IOException e) {
			e.printStackTrace();
		}
				
		return isImage; 
	}
}
