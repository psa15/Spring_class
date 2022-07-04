package com.demo.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.demo.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@RequestMapping("/upload/*")
public class UploadController {

	/* 1. <form> 방식을 이용한 업로드*/
	@GetMapping("/uploadForm")
	public void uploadForm() {
		
	}
	
	/* 클라이언트가 파일 업로드까지만
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
	
	//클라이언트가 업로드한 파일을 서버에 저장
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
	
	/* 2. AJAX이용한 파일 업로드 방식 */
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		
	}
	
	/*
	 작업 전 AttachFileDTO 클래스 준비되어야 함
	 produces = {MediaType.APPLICATION_JSON_UTF8_VALUE} : 이 메소드를 실행한 결과를 json형태로 변환
	 ResponseEntity<List<AttachFileDTO>> : ajax를 사용하겠다 + 파일 여러개여서 List<>
	 (MultipartFile[] uploadFile)
	 	- uploadFile : uploadAjax.jsp의 
	 					<!--파일 선택-->
					    <div class="uploadDiv"> <!--style 태그에서 사용할 용도가 아닌 jquery에서 접근 용도-->
					        <input type="file" name="uploadfile" multiple>
					    </div> 여기의 name uploadfile이 아니라
					    
					    let inputFile = $("input[name='uploadfile']");
                		let files = inputFile[0].files; //input[name='uploadFile'] 여러개 중 첫번째 태그의(inputFile[0]) 파일 정보(.files)
                        for(let i=0; i<files.length; i++) {
		                    if(!checkExtension(files[i].name, files[i].size)){
		                        return false;
		                    }
		                    formData.append("uploadFile", files[i]);
		                     	여기의 "uploadFile" 을 의미한다.
		                }
		 - form태그는 name의 값이 그대로 파라미터에 들어옴
	 */
	@ResponseBody //@Controller 클래스 안에서 이 메소드만 리턴값을 json으로 변환할 때 사용
	@PostMapping(value = "/uploadAjaxAction", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxAction(MultipartFile[] uploadFile){
		//1) 뼈대 -> return entity; 까지
		ResponseEntity<List<AttachFileDTO>> entity = null;
		
		//2) List컬렉션 객체까지 생성하여 뼈대 완성
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>(); //List는 인터페이스라 List를 구현한 클래스인 ArrayList로 객체 생성
		
		String uploadFolder = "C:\\Dev\\upload";
		
		String uploadFolderPath = getFolder(); //"2022\06\29"
		
		//File 객체 생성 - if문으로 디렉토리가 존재하는지 확인하기 위해 
		//File 클래스 : 파일과 디렉토리(폴더)를 관리
		File uploadPath = new File(uploadFolder, uploadFolderPath); // C:\\Dev\\upload\\2022\06\29
		
		if(uploadPath.exists() == false) {
			//경로의 폴더가 존재하지 않으면 폴더들 모두 생성
			uploadPath.mkdirs();
		}
		
		//향상된 for문
		for(MultipartFile multipartFile : uploadFile ) {
			//업로드하고자 한느 파일정보를 저장목적
			AttachFileDTO attachFileDTO = new AttachFileDTO(); //파일 정보 받는 목적
			
			//1) 파일정보 : 클라이언트 파일 이름
			String uploadFileName = multipartFile.getOriginalFilename();
			attachFileDTO.setFileName(uploadFileName);
			
			//중복되지 않는 고유의 문자열 생성
			UUID uuid = UUID.randomUUID();
			
			//업로드할 때 중복되지 않는 파일이름을 생성
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			//uploadFileName = 고유의문자열.toString() + "_" + 클라이언트쪽에서 서버에 보낸 파일명;
			
			try {
				//실제 중복되지 않는, 유일한 파일이름으로 객체 생성
				File saveFile = new File(uploadPath, uploadFileName);
				//File uploadPath = new File(uploadFolder, uploadFolderPath); // C:\\Dev\\upload\\2022\06\29
				//uploadFileName = uuid.toString() + "_" + uploadFileName;
				
				//파일 업로드(파일 복사됨)
				multipartFile.transferTo(saveFile);//클라이언트 쪽에서 서버에 보낸 파일명과 서버에 저장된 파일명은 다르다
				
				//2)파일정보 구성 : 중복되지 않는 고유의 문자열(93b9cd80-5f17-4453-9b49-e228bfb878bf 이런형태)
				attachFileDTO.setUuid(uuid.toString());
				
				//3)파일정보 구성 : 업로드 날짜폴더 경로
				attachFileDTO.setUploadPath(uploadFolderPath);
				
				//4)파일정보 구성: 이미지 또는 일반파일 여부 확인
				if(checkImageType(saveFile)) {
					attachFileDTO.setImage(true);
					//image : true - 이미지, false - 이미지 X 파일, (기본값이 false임) 
					
					/*이미지파일이기 때문에 썸네일 작업 
					 	-> 원본이미지를 대상으로 사본 이미지를 만들어 해상도의 손실을 줄이고, 크기를 작게 작업
					 FileOutputStream : 복사할거라 출력스트림 클래스 사용
					 	- 출력스트림 객체 생성만 해도 파일은 생성되나 크기가 0byte
					*/
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
					/*
					 Thumbnailator.createThumbnail(is, os, width, height);
						 Parameters:
							 is: The InputStream from which to obtainimage data. - 원본파일
							 os: The OutputStream to send thumbnail data to. - 사본파일
							 width: The width of the thumbnail.
							 height: The height of the thumbnail.
						multipartFile.getInputStream(): 입력스트림으로 읽어온 것!
					 */
					
					
				}
			list.add(attachFileDTO);
			//for문으로 파일 개수만큼 돌아가기 때문에 list컬렉션에 추가해주기
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		entity = new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
		
		return entity; //list가 json으로 변환되어 리턴 -> 이 정보가 uploadAjax의 ajax작업 result에 들어감
	}
	
	//날짜를 이용한 업로드 폴더 생성 및 폴더 이름 반환 메소드
	//하나의 폴더 안에 너무 많은 파일이 업로드 되지 않게 년/월/일 폴더 생성
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
	
	@GetMapping("/display")
	@ResponseBody //리턴되는 데이터를 그대로 브라우저에 전달(json으로 반환 X)
	public ResponseEntity<byte[]> getFile(String fileName){
		//String fileName : 클라이언트로부터 받아오는 것, 날짜 폴더명을 포함한 파일경로
		
		log.info("fileName은?: " + fileName);
		
		ResponseEntity<byte[]> entity = null;
		
		File file = new File("C:\\Dev\\upload\\" + fileName);
		//파일이니까 File클래스, fileName에 문제가 있으면 객체 생성 X
		
		log.info("file 경로: " + file);
		
		try {
			//헤더작업: 브라우저에 보내는 byte[]의 데이터가 이미지 MIME타입이라는 정보제공을 위해
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			//Files.probeContentType(path) : 마임타입에 대한 정보 리턴
			//header.add(headerName, headerValue); : headerName : 정해져 있음
			
			entity = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			//copyToByteArray(file) : 리턴타입이 byte[]
			
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		
		return entity; //결과데이터+헤더+상태코드를 구성으로 사용 가능
	}
	
	//일반파일이 업로드 됐을 때 클릭하면 다운로드, a태그여서 getmapping
	//다운로드할 때 produces = {MediaType.APPLICATION_OCTET_STREAM_VALUE}
	//ResponseEntity<Resource> : Resource인터페이스 - org.springframework.core.io
	@GetMapping(value = "/download", produces = {MediaType.APPLICATION_OCTET_STREAM_VALUE})
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		//@RequestHeader("User-Agent") : 클라이언트가 사용하는 것이 브라우저인지, 기기인지 어떤종류의 브라우저, 무슨 기기 등의 정보
		//사용자의 브라우저 정보를 확인하여 선택적 작업 가능
		
		ResponseEntity<Resource> entity = null;
		
		//FileSystemResource : 자원관리 해주는 클래스?
		Resource resource = new FileSystemResource("C:\\Dev\\upload\\" + fileName);
		
		if(resource.exists() == false) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename(); //"C:\\Dev\\upload\\" + fileName
		
		//클라이언트가 보낸 파일명
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		// _(언더바) 뒤쪽에 오는 이름이 클라이언트가 업로드한 이름
		
		HttpHeaders headers = new HttpHeaders();
		
		String downloadName = null;
		
		try {
			
			downloadName = new String(resourceOriginalName.getBytes("utf-8"), "ISO-8859-1");
			//서버측의,,,,? 바이트 배열로 보내는거?
			
			headers.add("Content-Disposition", "attachment; filename=" + downloadName);
			//Content-Disposition : 웹페이지 자체이거나 웹페이지의 일부인지, 아니면 attachment로써 다운로드 되거나 로컬에 저장될 용도록 쓰이는 것인지를 알려주는 헤더
			//웹페이지냐, 파일이냐를 알려주는거
		}catch (Exception ex) {
			ex.printStackTrace();
		}
		
		entity = new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
		return entity;
	}
	
	//파일삭제
	@PostMapping("/deletefile")
	@ResponseBody //리턴되는 데이터를 그대로 브라우저에 전달(json으로 반환 X)
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		
		ResponseEntity<String> entity = null;
		
		log.info("deleteFile: " + fileName);
		
		File file;
			
		try {
			/*
			 fileName : 2022%5C07%5C01/s_8f59f3b4-96d0-4ac5-97ca-f09fc2359491_geewon2.jpg
			 - 이렇게 인코딩된 파일이름이 들어와 자바에서 디코딩으로 원래 문자열로 변환해야 함
			 - URLEncoder, URLDecoder
			 - URLDecoder.decode(fileName,  "UTF-8") : 예외발생
			 */	
			//원본파일 + 썸네일 파일 삭제
			file = new File("C:\\Dev\\upload\\" + URLDecoder.decode(fileName,  "UTF-8"));			
			file.delete();
			
			//원본 이미지 삭제
			if(type.equals("true")) {
				String originFileName = file.getAbsolutePath().replaceAll("s_", "");
				//file.getAbsolutePath() : "C:\\Dev\\upload\\" + URLDecoder.decode(fileName,  "UTF-8") 이 경로를 다 가져옴
				//.replaceAll("s_", "") : 썸네일 이미지파일명에서 s_를 지우기
				
				log.info("originFileName: " + originFileName);
				
				file = new File(originFileName);
				file.delete();
								
				return new ResponseEntity<String>("success", HttpStatus.OK);
			}
			
			
			
		}catch (Exception ex) {
			ex.printStackTrace();
			
			//삭제하고자 하는 파일명이 존재하지 않을 경우
			return new ResponseEntity<String>("error", HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
