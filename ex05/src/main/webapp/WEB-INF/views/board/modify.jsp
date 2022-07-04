<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>Pricing example · Bootstrap v4.6</title>

    <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/pricing/">

    <!-- jquery 라이브러리 삽입 - 실제로는 파일을 따로 만들어 include-->
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>

    <!-- Bootstrap core CSS -->
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">


    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

    <!--파일 첨부 스타일-->
    <style>
      .uploadResult {
        width: 100%;
        background-color: gray;
      }
      
      .uploadResult ul {
        display: flex;
        flex-flow: row;
        justify-content: center;
        align-items: center;
      }
      
      .uploadResult ul li {
        list-style: none;
        padding: 10px;
      }
      
      .uploadResult ul li img {
        width: 100px;
      }
    </style>
    <style>
      .bigPictureWrapper {
        position: absolute;
        display: none;
        justify-content: center;
        align-items: center;
        top:0%;
        width:100%;
        height:100%;
        background-color: gray; 
        z-index: 100;
      }
      
      .bigPicture {
        position: relative;
        display:flex;
        justify-content: center;
        align-items: center;
      }
    </style>
    
    <!-- Custom styles for this template -->
    <link href="/resources/css/pricing.css" rel="stylesheet">

    <script>
      $(document).ready(function(){

        let formObj = $("#modifyForm");

        $("#btn-remove").on("click", function(){
          //console.log("click"); //위까지 잘 동작되는지 확인 위한 코드
          
          if(!confirm("게시물을 삭제하겠습니까?")) return;
          //console.log("click");
          //확인 : if(!true) 가 되어 false로 삭제되어야 함(페이지 정보 함께 전송)
          formObj.attr("action", "/board/remove");

          formObj.submit();
          
        });

        //목록 버튼 클릭하면 동작하는 기능
        $("#btn-list").on("click", function(){
          
          formObj.attr("method", "get");
          formObj.attr("action", "/board/list");

          /*
          get방식으로 바뀌는 순간 게시판의 내용들이 다 파라미터값으로 저장이 됨
          http://localhost:9090/board/list?bno=5099&title=테스트+게시물+데이터&content=테스트+게시물+데이타&writer=user01&pageNum=1&amount=10&type=W&keyword=user01
          이런식으로, 그래서 나는 다 지움
          
          formObj.find("input[name='bno']").remove();
          formObj.find("input[name='title']").remove();
          formObj.find("textarea[name='content']").remove();
          formObj.find("input[name='writer']").remove();
          */
          
          //페이징, 검색 필드정보
          let pageNumTag = $("input[name='pageNum']").clone(); 
          //pageNumTag안에 <input type="hidden" name="pageNum" value="${cri.pageNum}"> 전체가 복사됨
          let amountTag = $("input[name='amount']").clone();
          let typeTag = $("input[name='type']").clone();
          let keywordTag = $("input[name='keyword']").clone();

          //잘 복사되었는지 확인
          console.log(pageNumTag);
          console.log(amountTag);
          console.log(typeTag);
          console.log(keywordTag);

          //다 지우기
          formObj.empty();

          //필요한 것만 다시 붙이기
          formObj.append(pageNumTag);
          formObj.append(amountTag);
          formObj.append(typeTag);
          formObj.append(keywordTag);

          formObj.submit();
        });
      });
    </script>

    <!--파일 업로드-->
    <script>
      //클라이언트에서 유효성검사 - 정규식 문법 : 문자열을 대상으로 패턴문법을 이용하여 패턴 일치 여부를 확인
      let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); //sh: 리눅스 실행파일, exe:설치파일(?) 등을 막는 것
      let maxSize = 5 * 1024 * 1024; //5mb

      //파일정보가 출력되는 태그 위치변수 
      //선택자 태그가 인식 X, 해당태그가 앞에 작성이 안되어 있어서 브라우저가 읽은 정보가 없음
      //let uploadResult = $(".uploadResult ul");

      //업로드 파일크기, 확장자 확인 함수
      function checkExtension(fileName, fileSize) {
          if(fileSize >= maxSize) {
              alert("파일 크기 용량 초과");
              return false;
          }

          if(regex.test(fileName)) {
              //파일 명에 정규식과 일치하는 것이 있는지 test
              alert("해당 종류의 파일은 업로드 불가")
              //일치하는 것이 있다면 업로드 X -> false
              return false;
          }

          return true;
      }

      //파일정보 출력하는 함수
      //uploadResultArr 파라미터 : 파일들에 대한 정보
      function showUploadFile(uploadResultArr) {
          //변수에 파일정보를 읽어오기
          let str = ""; //파일정보를 html태그와 함께 구성

          //.each() 메소드를 사용하기 위해서는 uploadResultArr가 배열이나 컬렉션이어야 함
          $(uploadResultArr).each(function(i, obj){
              //i : 순번 0부터 시작, obj : 파일 정보를 참조하는 객체
              
            console.log("파일정보 로그");

            //파일정보를 나타내는 "data-이름" 형식의 이름은 대소문자 구분하지 않음 : 브라우저에서 확인시 소문자로 처리됨
            //jquery구문에서 data()메소드 사용시 소문자로 파라미터를 사용

              if(obj.image == false) { //일반파일
                  //let fileCalPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName; //인코딩 작업 필요
                  //                    날짜폴더              문자열           업로드된 파일명
                  //날짜폴더 + 문자열 + 업로드된 파일명을 서버에서 가져오려는 것

                  let fileCalPath = encodeURIComponent(obj.uploadPath) + "/" + obj.uuid + "_" + obj.fileName;

                  //console.log("일반파일경로: " + fileCalPath); //경로처리 오류가 많이 나서 테스트
                  
                  //파일정보와 이미지 결합
                  str += "<li><div><a href='download?fileName=" + fileCalPath 
                          + "'><img src='/resources/img/attach.png'>" + obj.fileName 
                          + "</a><span style='cursor:pointer;' data-uuid='" + obj.uuid + "' data-uploadpath='" + obj.uploadPath + "' data-filename='" + obj.fileName + "' data-filetype='" + obj.image + "'> x </span></div></li>";
                  //.uploadResult 태그의 <ul> 태그에 삽입할거임

              }else { //이미지파일 - 썸네일 이미지를 사용해야함!

                  let fileCalPath = encodeURIComponent(obj.uploadPath) + "/" + "s_" + obj.uuid + "_" + obj.fileName; //썸네일 이미지 파일
                  let originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName; //원본이미지 경로

                  console.log(originPath); // \ 변경 전

                  //역슬래시를 슬래시로 변환
                  originPath = originPath.replace(new RegExp(/\\/g), "/");
                  
                  console.log(originPath); // \ 변경 후

                  //<ul>태그 안에 넣을거리 <li>태그로 시작
                  //\" : "" 안에 또 ""를 사용하고 싶을 때
                  //javascript:showImage('" + originPath + "') : 상세보기 함수
                  str += "<li><a href=\"javascript:showImage('" + originPath + "')\"><img src='/upload/display?fileName=" + fileCalPath + "'></a>"
                              + "<span style='cursor:pointer;' data-uuid='" + obj.uuid + "' data-uploadpath='" + obj.uploadPath + "' data-filename='" + obj.fileName + "' data-filetype='" + obj.image + "'> x </span></li>";
              }   
              
          });

          $(".uploadResult ul").append(str);
      }

    $(document).ready(function(){

      //<input type="file"> onChange이벤트 파일이 변경되었을 때 실행되는 이벤트
      //1)파일첨부 이벤트
      $("input[type='file']").change(function(){
        
        //console.log("파일선택");

        let formData = new FormData();
        let inputFile = $("input[name='uploadfile']"); //multiple 성격으로 다수의 파일
        let files = inputFile[0].files; //multiple 성격 때문에 들어간 코드

        for(let i=0; i<files.length; i++){
          if(!checkExtension(files[i].name, files[i].size)) {
            return false;
          }

          formData.append("uploadFile", files[i]); //"uploadFile": 스프링에서 사용할 이름
          //for문 추가 완
        }

        //ajax호출
        $.ajax({
          url: '/upload/uploadAjaxAction', //상대주소('uploadAjaxAction')를 쓰니까 /board/uploadAjaxAction 되어 있어서 절대주소 사용
          processData: false,
          contentType: false,
          data: formData,
          type: 'POST',
          dataType: 'json',
          success: function(result){
            //파일 정보 넘어옴
            console.log(result);

            showUploadFile(result);
          }
        });

      });

      //2)제출버튼 클릭시(파일정보 추가)
      let formObj = $("#modifyForm");

      //글쓰기 전송버튼
      $("button[type='submit']").on("click", function(e){
        e.preventDefault(); //submit기능 취소

        /*첨부된 파일정보 태그작업추가*/
        let str = "";
        
        //첨부된 파일의 개수만큼 해당 선택자의 태그가 존재한다.
        $(".uploadResult ul li").each(function(i, obj){

          let fileObj = $(obj).find("span");
          //li태그 아래 span태그를 찾아가야 value로 참조가 가능함

          //console.dir(fileObj); //fileObj객체의 속성정보를 출력, 요소를 JSON형태의 트리구조로 보여줌

          //BoardAttachVO 클래스 참조 
          str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + fileObj.data("uuid") + "'>";
          str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + fileObj.data("uploadpath") + "'>";
          str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + fileObj.data("filename") + "'>";
          str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + fileObj.data("filetype") + "'>";
        });
        formObj.append(str);
        //기존게시판 정보와 파일정보가 합쳐짐

        formObj.submit();
      });

      //파일 삭제
      //$("정적태그").on("click", "동적태그",function(){})
      $(".uploadResult").on("click", "ul li span",function(){
          console.log("삭제 이벤트 진행");

          let attachLi = $(this).parent(); //span태그의 부모 li

          //<span data-file="파일명", data-type="file">을 읽어오기
          let targetFile = $(this).data("uploadpath") + "/" + $(this).data("uuid") + "_" +  $(this).data("filename");
          let type = $(this).data("filetype");

          //console.log("파일명: " + targetFile);
          //console.log("파일형식: " + type);

          $.ajax({
              url: '/upload/deletefile',
              data: {fileName:targetFile, type:type}, //js object문법 : {key:value, key:value} -> {파라미터명:value, 파라미터명:value} 
              dataType: 'text', //스프링에서 넘어오는 리턴값(result의 값이 text형식이다)
              type: 'post', 
              success: function(result){
                  alert(result);

                  //$(this) 지원 X
                  attachLi.remove(); //업로드 이미지 출력되는 위치의 li태그를 제거한다.
              }
          });
      });
    });
    </script>
  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<%@include file="/WEB-INF/views/include/Carousel.jsp" %>

<div class="container">
  <h3>게시판 수정하기</h3>
  <form id="modifyForm" method="post" action="modify">
  	  <div class="form-group">
	    <label for="bno">번호</label>
	    <input type="text" class="form-control" id="bno" name="bno" readonly value="${board.bno}">
	  </div>
	  <div class="form-group">
	    <label for="title">제목</label>
	    <input type="text" class="form-control" id="title" name="title" value="${board.title}">
	    <%-- BoardVO.java 안의 필드명을 name에 적기 --%>
	  </div>
	  <div class="form-group">
	    <label for="content">내용</label>
	    <textarea class="form-control" id="content" rows="3" name="content">${board.content}</textarea>
	  </div>
	  <div class="form-group">
	    <label for="writer">작성자</label>
	    <input type="text" class="form-control" id="writer" name="writer" readonly value="${board.writer}">
	  </div>
	  <button type="submit" class="btn btn-info">수정하기</button>
	  <button type="button" id="btn-remove" class="btn btn-info">삭제</button>
	  <button type="button" id="btn-list" class="btn btn-info">목록</button>
	  
	  	<%-- 페이지 정보 
	  	<input type="hidden" name="bno" value="${board.bno}">
	  	 글번호 인풋태그는 이미 존재하기 때문에 있으면 안됨
	  	--%>
    
		<input type="hidden" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" name="amount" value="${cri.amount}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
		
	</form>
 
  <!--파일 첨부 목록(bootstrap 활용)-->
  <div class="row">
    <div class="col-12">
      <div class="box-header with-border">
        <h3 class="box-title">Files</h3>
      </div>
      <div class="box-body">
      <!--파일 선택-->
      <div class="uploadDiv"> <!--style 태그에서 사용할 용도가 아닌 jquery에서 접근 용도-->
        <input type="file" name="uploadfile" multiple>
      </div>
        <!--업로드된 파일 정보 출력 위치-->
        <div class="uploadResult">
          <ul>
          	<c:forEach items="${board.attachList}" var="attachVO">
          		<c:if test="${attachVO.fileType == true}"> <!-- db상에서는 1이지만 자동으로 true로 형변환 됨 -->
	          		<li>          			
	          			<a href="javascript:showImage('${attachVO.uploadPath}${attachVO.uuid}_${attachVO.fileName})">
	          				<img src='/upload/display?fileName=${attachVO.uploadPath}/${attachVO.uuid}_${attachVO.fileName}'> 파일명 : ${attachVO.fileName}
	          			</a>
	          			<span style="cursor:pointer;" data-uuid="s_${attachVO.uuid}" data-uploadpath="${attachVO.uploadPath}" data-filename="${attachVO.fileName}" data-filetype="${attachVO.fileType}"> x  </span>
	          		</li>
          		</c:if>
          		<c:if test="${attachVO.fileType == false}">
	          		<li>          			
	          			<a href="javascript:showImage('${attachVO.uploadPath}${attachVO.uuid}_${attachVO.fileName})">
	          				<img src='/resources/img/attach.png'> 파일명 : ${attachVO.fileName}
	          			</a>
	          			<span style="cursor:pointer;" data-uuid="${attachVO.uuid}" data-uploadpath="${attachVO.uploadPath}" data-filename="${attachVO.fileName}" data-filetype="false"> x  </span>
	          		</li>
          		</c:if>
          	</c:forEach>
          </ul>
        </div>
      </div>
    </div>
  </div>
	

  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    
  </body>
</html>

