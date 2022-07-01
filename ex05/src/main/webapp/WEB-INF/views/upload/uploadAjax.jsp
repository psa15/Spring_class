<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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

</head>
<body>
    <h1>Upload with Ajax</h1>

    <!--원본 이미지 표시 위치-->
    <div class="bigPictureWrapper"> <!--css효과를 위한 태그-->
        <div class="bigPicutre"></div>  <!--실제 이미지가 보여질 태그-->
    </div>

    <!--파일 선택-->
    <div class="uploadDiv"> <!--style 태그에서 사용할 용도가 아닌 jquery에서 접근 용도-->
        <input type="file" name="uploadfile" multiple>
    </div>

    <!--업로드된 파일 정보 출력 위치-->
    <div class="uploadResult">
        <ul></ul>
    </div>

    <button id="uploadBtn">Upload</button>

	<%-- jquery 라이브러리 참조 --%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <script>
        //클라이언트에서 유효성검사 - 정규식 문법 : 문자열을 대상으로 패턴문법을 이용하여 패턴 일치 여부를 확인
        let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); //sh: 리눅스 실행파일, exe:설치파일(?) 등을 막는 것
        let maxSize = 5 * 1024 * 1024; //5mb

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

        let cloneObj = $(".uploadDiv").clone();
        /*
        cloneObj 안에 
        <div class="uploadDiv"> <!--style 태그에서 사용할 용도가 아닌 jquery에서 접근 용도-->
            <input type="file" name="uploadfile" multiple>
        </div>
	        가 들어있다.
        */

        //업로드 된 파일정보를 출력하는 태그를 참조
        //스프링에서 업로드 한 파일의 정보를 참조
        let uploadResult = $(".uploadResult ul");

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
                            + "</a><span style='cursor:pointer;' data-file=\'" + fileCalPath + "\' data-type='file'> x </span></div></li>";
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
                    str += "<li><a href=\"javascript:showImage('" + originPath + "')\"><img src='display?fileName=" + fileCalPath + "'></a>"
                                 + "<span style='cursor:pointer;' data-file=\'" + fileCalPath + "\' data-type=image> x </span></li>";
                }   
                
            });

            //.uploadResult 태그의 <ul> 태그에 삽입할거임 ->  let uploadResult = $(".uploadResult ul"); 이 구문으로 uploadResult 사용 가능
            //each 함수를 벗어나서 추가해야 함
            //each 안에 하면 첫번째 파일이 추가된 곳에 두번째 파일 태그가 덮어씌워짐
            uploadResult.append(str);
        }

        //썸네일 클릭하면 원본이미지 나오게
        //fileCalPath 파라미터 : 날짜 폴더경로를 포함한 원본이미지 파일명
        function showImage(fileCalPath) {
            //효과
            $(".bigPictureWrapper").css("display", "flex").show(); 

            //이미지 불러와서($(".bigPicutre").html("<img src='display?fileName=" + fileCalPath + "'>")) 
            //효과주기 : .animate({width: '100%', height: '100%'}, 1000);
            $(".bigPicutre").html("<img src='display?fileName=" + fileCalPath + "'>").animate({width: '100%', height: '100%'}, 1000);
        }

        $(document).ready(function(){
            $("#uploadBtn").on("click", function(){

                let formData = new FormData(); //form태그에 해당하는 의미
                //데이터를 key:value 형태로 관리(mdn사이트 참조)
                
                //<input type="file" name="uploadfile" multiple> 참조, name선택자가 복수개념(inputFile에 여러개가 있을 수 있다)
                let inputFile = $("input[name='uploadfile']");
                
                //선택된 파일들의 정보를 참조
                let files = inputFile[0].files; //input[name='uploadfile'] 여러개 중 첫번째 태그의(inputFile[0]) 파일 정보(.files)
                //files : s는 해당 태그에 multiple 속성이 있어서 복수 개념으로 들어간 것.
                
                console.log(files);

                //파일 크기와 확장자를 체크
                for(let i=0; i<files.length; i++) {
                    if(!checkExtension(files[i].name, files[i].size)){
                        //checkExtension 이 false : 업로드 불가 가 !로 true가 됨 -> 문제가 있다면
                        return false;
                    }
                    formData.append("uploadFile", files[i]);
                    //uploadFile : 업로드되는 파일정보를 전송시 사용하는 파라미터, 스프링에서 일치가 되어야 한다.
                }

                //ajax
                $.ajax({
                    url: '/upload/uploadAjaxAction',
                    processData: false, //기본값: true, false의 의미 : key:value값의 구조를 Query String으로 변환 ex. 주소?name=홍길동&age=100
                    contentType: false, 
                    //기본값: true, false의 의미 : "application/x-www-form-urlencoded;charset=UTF-8"(true일 때) -> "multipart/form-data" 인코딩을 사용하여 전송.
                    //multipart/form-data : 데이터를 보내는 방식으로 데이터를 파트별로 잘라 보낸 후 나중에 취합하는 방법
                    data: formData, //클라이언트에서 서버측에 전송하는 데이터(파일정보)
                    type: 'POST',
                    dataType: 'json', //스프링쪽에서 넘어오는 데이터 포맷(result변수에 들어오는 값이 json문법으로)
                    success: function(result) {

                        console.log("파일정보" + result[0].fileName);
                        //result: 파일정보[object Object],[object Object]
                        //result[0] : 파일정보[object Object]
                        //result[0].fileName : 파일정보PART6.pptx  -> AttachFileDTO 클래스의 필드를 보고 작성

                        //result변수의 내용을 참조하여, 화면에 업로드 된 파일정보를 출력하는 작업
                        showUploadFile(result);
                    }
                });
            });

            //파일 삭제
            //$("정적태그").on("click", "동적태그",function(){})
            $(".uploadResult").on("click", "ul li span",function(){
                console.log("삭제 이벤트 진행");

                //<span data-file="파일명", data-type="file">을 읽어오기
                let targetFile = $(this).data("file");
                let type = $(this).data("type");

                console.log("파일명: " + targetFile);
                console.log("파일형식: " + type);

                $.ajax({
                   url: 'deletefile',
                   data: {fileName:targetFile, type:type}, //js object문법 : {key:value, key:value} -> {파라미터명:value, 파라미터명:value} 
                   dataType: 'text', //스프링에서 넘어오는 리턴값(result의 값이 text형식이다)
                   type: 'post', 
                   success: function(result){
                        alert(result);
                   }
                });
            });
        });
    </script>
</body>
</html>