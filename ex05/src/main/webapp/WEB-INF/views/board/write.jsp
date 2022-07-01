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

    
    <!-- Custom styles for this template -->
    <link href="/resources/css/pricing.css" rel="stylesheet">
    <%-- jquery 라이브러리 참조 --%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <%-- ajax작업을 위한 뼈대 --%>
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
                
                /*AttachFileDTO클래스 참조
                public class AttachFileDTO {                    
                    private String uuid; 
                    private String uploadPath; 
                    private String fileName; 
                    private boolean image;
                */
               console.log("파일정보 로그");

               //파일정보를 나타내는 "data-이름" 형식의 이름은 대소문자 구분하지 않음 : 브라우저에서 확인시 소문자로 처리됨
               //jquery구문에서 data()메소드 사용시 소문자로 파라미터를 사용

                if(!obj.image) { //일반파일
                    //let fileCalPath = obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName; //인코딩 작업 필요
                    //                    날짜폴더              문자열           업로드된 파일명
                    //날짜폴더 + 문자열 + 업로드된 파일명을 서버에서 가져오려는 것

                    let fileCalPath = encodeURIComponent(obj.uploadPath) + "/" + obj.uuid + "_" + obj.fileName;

                    //console.log("일반파일경로: " + fileCalPath); //경로처리 오류가 많이 나서 테스트
                    /*
                    - 일반파일경로: 2022\06\30/1ed7ef20-2ec0-471e-9e42-bc30ca56f325_PART6.pptx → 이 경로를 서버측에 요청하는 것
                        - 문제점 : / 로 주소가 이루어져야하는데 \로 이루어져있고, 특수문자가 있으면 인코딩작업도 해야함
                    */

                    //인코드 테스트
                    //console.log("일반파일경로: " + encodeURIComponent(fileCalPath));
                    //2022%5C06%5C30%2Fa145006e-3c6d-4762-b9fa-af6e6331eeab_PART6.pptx

                    /*
                    <a href='/download?fileName=" + fileCalPath : fileCalPath의 파일을 다운로드
                    */
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

            //.uploadResult 태그의 <ul> 태그에 삽입할거임 ->  let uploadResult = $(".uploadResult ul"); 이 구문으로 uploadResult 사용 가능
            //each 함수를 벗어나서 추가해야 함
            //each 안에 하면 첫번째 파일이 추가된 곳에 두번째 파일 태그가 덮어씌워짐
            //파일 정보가 삽입
            /*
            uploadResult.append(str);
            인식이 안된 이유: uploadResult 변수가 선언된 곳이 .uploadResult ul 태그보다 먼저 와서 브라우저가 읽은 정보가 없음
            $(".uploadResult ul").append(str);
            인식된 이유 : .ready()메소드는 태그를 끝까지 브라우저가 읽은 후 동작됨
            */
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
        let formObj = $("#boardForm");
      
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
            /*
            value값 : fileName - data-file 속성으로 가져오고, fileType - data-type으로 가져올 수 있음
            - 편하게 참조할 수 있도록 다듬기 
              - str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + 변수 + "'>";
              - 변수 : fileObj.data("")
                  - <span style="cursor:pointer;" data-uuid="9325618f-53ef-40f2-91e0-fbf0cb3e9cdf" data-uploadpath="2022\07\01" data-filename="2022%5C07%5C01/s_9325618f-53ef-40f2-91e0-fbf0cb3e9cdf_geewon2.jpg" data-filetype="image"> x </span>
                  - 여기에 data-이름 의 이름만 사용
                  - $(선택요소).data(데이터속성에 사용된 이름)
                    - "data-이름" 형태의 사용자 정의 속성에 사용된 값을 가져와 반환하는 메소드
            */
            str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + fileObj.data("uuid") + "'>";
            str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + fileObj.data("uploadpath") + "'>";
            str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + fileObj.data("filename") + "'>";
            str += "<input type='hidden' name='attachList[" + i + "].fileType' value='" + fileObj.data("filetype") + "'>";
          });
          formObj.append(str);
          //기존게시판 정보와 파일정보가 합쳐짐

          formObj.submit();
        });
      });
    </script>

  </head>
  <body>
    
<%@include file="/WEB-INF/views/include/header.jsp" %>

<%@include file="/WEB-INF/views/include/Carousel.jsp" %>

<div class="container">
  <div class="row">
    <div class="col-12">
      <h3>게시판 글쓰기</h3>
      <form id="boardForm" method="post" action="write">
        <div class="form-group">
          <label for="title">제목</label>
          <input type="text" class="form-control" id="title" name="title">
          <%-- BoardVO.java 안의 필드명을 name에 적기 --%>
        </div>
        <div class="form-group">
          <label for="content">내용</label>
          <textarea class="form-control" id="content" rows="3" name="content"></textarea>
        </div>
        <div class="form-group">
          <label for="writer">작성자</label>
          <input type="text" class="form-control" id="writer" name="writer">
        </div>
        <button type="submit" class="btn btn-primary">제출</button>
        <%-- 현재 폼태그의 제출버튼을 누르면 게시판 정보만 존재하고 파일정보는 없음 -> 제출버튼에 이벤트작업 --%>
      </form>
    </div>
  </div>
  <%-- ajax 방식을 사용하기 위한 태그 --%>
  <div class="row"> 
    <div class="col-12">
      <div>
        <h3>파일 첨부</h3>
      </div>
      <!--파일 선택-->
      <div class="uploadDiv"> <!--style 태그에서 사용할 용도가 아닌 jquery에서 접근 용도-->
        <input type="file" name="uploadfile" multiple>
      </div>

      <!--업로드된 파일 정보 출력 위치-->
      <div class="uploadResult">
          <ul>
            <!-- li 태그로 파일들이 들어감-->
          </ul>
      </div>
    </div>
  </div>

  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>


    
  </body>
</html>

