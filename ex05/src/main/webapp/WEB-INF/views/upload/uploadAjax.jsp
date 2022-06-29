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
    <div class="bigPictureWrapper">
        <div class="bigPicutre"></div>
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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        //클라이언트에서 유효성검사
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
        let uploadResult = $(".uploadResult ul");

        $(document).ready(function(){
            $("#uploadBtn").on("click", function(){

                let formData = new FormData(); //form태그에 해당하는 의미
                
                //<input type="file" name="uploadfile" multiple> 참조, 아래 선택자가 복수개념(inputFile에 여러개가 있을 수 있다)
                let inputFile = $("input[name='uploadFile']");
                
                //선택된 파일들의 정보를 참조
                let files = inputFile[0].files; //input[name='uploadFile'] 여러개 중 첫번째 태그의(inputFile[0]) 파일 정보(.files)
                console.log(files);

                //파일 크기와 확장자를 체크
                for(let i=0; i<files.length; i++) {
                    if(!checkExtension(files[i].name, files[i].size)){
                        //checkExtension 이 false : 업로드 불가 가 !로 true가 됨 -> 문제가 있다면
                        return false;
                    }
                    formData.append("uploadFile", files[i]);
                }

                //ajax
                $.ajax({
                    url: '/uploadAjaxAction',
                    processData: false, //기본값: true, false의 의미 : key:value값의 구조를 Query String으로 변환 ex. 주소?name=홍길동&age=100
                    contentType: false, 
                    //기본값: true, false의 의미 : "application/x-www-form-urlencoded;charset=UTF-8"(true일 때) -> "multipart/form-data" 인코딩을 사용하여 전송.
                    //multipart/form-data : 데이터를 보내는 방식으로 데이터를 파트별로 잘라 보낸 후 나중에 취합하는 방법
                    data: formData, //클라이언트에서 서버측에 전송하는 데이터(파일정보)
                    type: 'POST',
                    dataType: 'json', //스프링쪽에서 넘어오는 데이터 포맷(result변수에 들어오는 값이 json문법으로)
                    success: function(result) {

                        console.log(result);

                        //result변수의 내용을 참조하여, 화면에 업로드 된 파일정보를 출력하는 작업
                    }
                });
            });
        });
    </script>
</body>
</html>