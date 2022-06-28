<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.88.1">
    <title>Pricing example · Bootstrap v4.6</title>

    <!-- <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script> -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- 핸들바 작업1. Include Handlebars from a CDN -->
	  <script src="https://cdn.jsdelivr.net/npm/handlebars@latest/dist/handlebars.js"></script>


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

    
    <!-- Custom styles for this template -->
    <link href="/resources/css/pricing.css" rel="stylesheet">

    <script>
      //1.게시판작업
      $(document).ready(function(){

        let operForm = $("#operForm");
        
        //수정버튼 클릭시 동작구문. 	<button type="button" id="btn_modify" class="btn btn-primary">Modify</button>
          $("#btn_modify").on("click", function(){
            //console.log("수정버튼 클릭"); //이클립스에서 해당파일을 읽어주어야 한다.
            // 수정폼 주소
            //let bno = $("#bno").val();  // 입력양식 태그의 값을 읽어옴.
            //location.href = "modify?bno=" + bno;


            operForm.submit();


          });

        //제거버튼 클릭시 동작구문. <button type="button" id="btn_remove" class="btn btn-danger">Remove</button>
          $("#btn_remove").on("click", function(){
            //console.log("제거버튼 클릭");
            //제거주소
            let bno = $("#bno").val();
            if(!confirm(bno + "번 글을 삭제하겠습니까?")) return;

            location.href = "remove?bno=" + bno;
          });


        //목록버튼 클릭시 동작구문
        $("#btn_list").on("click", function(){
          operForm.find("input[name='bno']").remove();
          operForm.attr("action", "/board/list");

          operForm.submit();
        });

      });
    </script>

    <script>
      //2.댓글작업
      $(document).ready(function(){

        //댓글 페이지번호 클릭 동적인 태그에 이벤트 설정할 경우, 다이렉트로 기능 X
          /*
          $("ul.paginateion li a").on("click", function(e){
            e.preventDefault
            console.log("click");
          });
          */
          $("#replyPaging").on("click", "ul.pagination li.page-item a", function(e){
            e.preventDefault();
            //console.log("click");

            replyPage = $(this).attr("href");
            let url = "/replies/pages/" + bno + "/" + replyPage + ".json"; //댓글 목록 및 페이지 정보 요청 주소
            //console.log(url);

            getPage(url);
          });

        //댓글 목록에서 수정버튼 클릭시 - 동적으로 생성된 태그
        $("#replyList").on("click","input[name='btnModalModify']", function(){
          //console.log("댓글 수정");

          //내용 준비하기 - 선택된 댓글 내용 읽어와서 모달대화상자에 보여주기
          let rno = $(this).parents("div.box-body").find("input[name='rno']").val();
          //console.log(rno);
          let replyer = $(this).parents("div.box-body").find("input[name='replyer']").val();
          let reply = $(this).parents("div.box-body").find("textarea[name='reply']").val();
          let replydate = $(this).parents("div.box-body").find("span").html("{{prettifyDate updatedate}}"); //span태그는 입력양식이 아니어서 html()

          /*test
          console.log(rno);
          console.log(replyer);
          console.log(reply);
          console.log(replydate);
          */

          //modal dialog의 내용을 수정
          $("#replyTitle").html("Modify Reply");
          $("#rno").val(rno); //$("#rno").val(rno); : 값 변경, $("#rno").val(); : 값 읽어오기
          $("#reply").val(reply);
          $("#replyer").val(replyer);

          //버튼
          $(".btnModal").hide(); //모달대화상자의 버튼 3개를 모두 보이지 않게 한다
          $("#btn_replyModify").show(); // Modify버튼만 보이게 하기

          //팝업창 부르기
          $("#replyModal").modal('show');
        });

        //모달 대화상자에서 수정버튼 클릭
        $("#btn_replyModify").on("click", function(){
          
          //댓글 저장하기 부분 복사
          let rno = $("#rno").val(); //댓글번호
          let reply = $("#reply").val(); //댓글내용

          //자바스크립트 Object구문
          let replyObj = { rno:rno, reply:reply };
          
          //서버측에 보낼 데이터를 JSON문법구조의 문자열로 변환작업
          let replyStr = JSON.stringify(replyObj);

          console.log(replyStr);

          //웹 브라우저는 GET, POST방식만 지원, 스프링에서 PUT요쳥으로 인식되기 위해 헤더 요청을 변경
          $.ajax({
            type: 'PUT',
            url: '/replies/modify/' + rno,
            headers: {
              "Content-Type" : "application/json", "X-HTTP-Method-Override" : "PUT"
            },
            dataType: 'text', //매핑주소의 리턴값
            data: replyStr, 
            success: function(result) {
              if(result == "success"){
                alert("댓글 데이타 수정 성공");

                //modal dialog의 내용을 처음상태로 변경(초기화)
                $("#replyTitle").html("New Reply");
                $("#rno").val(""); //$("#rno").val(rno); : 값 변경, $("#rno").val(); : 값 읽어오기
                $("#reply").val("");
                $("#replyer").val("");

                //버튼
                $(".btnModal").hide(); //모달대화상자의 버튼 3개를 모두 보이지 않게 한다
                $("#btn_replySave").show(); // Modify버튼만 보이게 하기

                //팝업창 부르기
                $("#replyModal").modal('hide');

                //화면 갱신
                let url = "/replies/pages/" + bno + "/" + replyPage + ".json"; //댓글 목록 및 페이지 정보 요청 주소
                //console.log(url);
                getPage(url);
              }
            }
          });
        });

        //댓글 목록에서 삭제버튼 클릭시
        $("#replyList").on("click","input[name='btnModalDelete']", function(){
          //console.log("댓글 삭제");

          //내용 준비하기 - 선택된 댓글 내용 읽어와서 모달대화상자에 보여주기
          let rno = $(this).parents("div.box-body").find("input[name='rno']").val();
          //console.log(rno);
          let replyer = $(this).parents("div.box-body").find("input[name='replyer']").val();
          let reply = $(this).parents("div.box-body").find("textarea[name='reply']").val();
          let replydate = $(this).parents("div.box-body").find("span").html(); //span태그는 입력양식이 아니어서 html()

          /*test
          console.log(rno);
          console.log(replyer);
          console.log(reply);
          console.log(replydate);
          */

          //modal dialog의 내용을 수정
          $("#replyTitle").html("Delete Reply");
          $("#rno").val(rno); //$("#rno").val(rno); : 값 변경, $("#rno").val(); : 값 읽어오기
          $("#reply").val(reply);
          $("#replyer").val(replyer);

          //버튼
          $(".btnModal").hide(); //모달대화상자의 버튼 3개를 모두 보이지 않게 한다
          $("#btn_replyDelete").show(); // Modify버튼만 보이게 하기

          //팝업창 부르기
          $("#replyModal").modal('show');
        });

        //모달 대화상자에서 삭제버튼 클릭
        $("#btn_replyDelete").on("click", function(){
          
          //댓글 저장하기 부분 복사
          let rno = $("#rno").val(); //댓글번호

          //웹 브라우저는 GET, POST방식만 지원, 스프링에서 DELETE요쳥으로 인식되기 위해 헤더 요청을 변경
          $.ajax({
            type: 'DELETE',
            url: '/replies/delete/' + rno,
            headers: {
              "Content-Type" : "application/json", "X-HTTP-Method-Override" : "DELETE"
            },
            dataType: 'text', //매핑주소의 리턴값
            //data: replyStr, 
            success: function(result) {
              if(result == "success"){
                alert("댓글 데이타 삭제 성공");

                //modal dialog의 내용을 처음상태로 변경(초기화)
                $("#replyTitle").html("New Reply");
                $("#rno").val(""); //$("#rno").val(rno); : 값 변경, $("#rno").val(); : 값 읽어오기
                $("#reply").val("");
                $("#replyer").val("");

                //버튼
                $(".btnModal").hide(); //모달대화상자의 버튼 3개를 모두 보이지 않게 한다
                $("#btn_replySave").show(); // Modify버튼만 보이게 하기

                //팝업창 부르기
                $("#replyModal").modal('hide');

                //화면 갱신
                let url = "/replies/pages/" + bno + "/" + replyPage + ".json"; //댓글 목록 및 페이지 정보 요청 주소
                //console.log(url);
                getPage(url);
              }
            }
          });
        });


        //댓글 모달대화상자 띄우기
        $("#btn_replyWrite").on("click", function(){
          $(".btnModal").hide(); //모달대화상자의 버튼 3개를 모두 보이지 않게 한다
          $("#btn_replySave").show();
          $("#replyModal").modal('show');
        });


        //댓글저장하기
        $("#btn_replySave").on("click", function(){

          let replyer = $("#replyer").val();
          let reply = $("#reply").val();

          //자바스크립트 Object구문
          let replyObj = { bno:${board.bno }, replyer:replyer, reply:reply };
          
          //서버측에 보낼 데이터를 JSON문법ㅂ구조의 문자열로 변환작업{"bno":5120, "replyer":"user01", "reply":"댓글테스트"}
          let replyStr = JSON.stringify(replyObj);

          console.log(replyStr);

          $.ajax({
            type: 'post',
            url: '/replies/new',
            headers: {
              "Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"
            },
            dataType: 'text', //매핑주소의 리턴값
            data: replyStr, //{"bno":5120, "replyer":"user01", "reply":"댓글테스트"} : bno, reply, replyer는 ReplyVO클래스에서 참조된 것
            success: function(result) {
              if(result == "success"){
                alert("댓글 데이타 삽입 성공");
              }
            }
          });

        });

      });
    </script>

  <!-- 핸들바 작업2. 핸들바 템플릿 : 댓글 목록작업 -->
    <!-- bootstrap 참고
    	가져오는 데이터가 여러개일 때 {{#each .}} 사용
		<script>안에 적으니까 오류남 아 당연하네 스크립트는 주석이 // 니까.... -->
	<script id="reply-template" type="text/x-handlebars-template">
    
    {{#each .}}
    <div class="box-body">
      <div class="form-group row">
        <label for="replyer" class="col-3 col-form-label">작성자</label>
        <div class="col-5">
          <input type="text" name="rno" value="{{rno}}" readonly>
          <input type="text" class="form-control" name="replyer" value="{{replyer}}" readonly>
        </div>
          <label for="reply" class="col-4 col-form-label">등록일: <span>{{prettifyDate updatedate}}</span></label>       
      </div>
      <div class="form-group row">
        <div class="col-8">
          <textarea class="form-control" name="reply" rows="3" readonly>{{reply}}</textarea>
        </div>
        <div class="col-4">
          <input type="button" name="btnModalModify" value="수정"><br>
          <input type="button" name="btnModalDelete" value="삭제">
        </div>
      </div>
    </div>
    <hr>
    {{/each}}
	</script>

  <script>
    //핸들바 작업3.(선택사항) 핸들바 안에서 사용할 사용자 정의 Helper
    //용도: 댓글 작성일 밀리세컨드 데이터를 날짜 포맷으로 변환(2022/06/27)
    //Handlebars.registerHelper("함수명", function(템플릿에서 사용할 값)
    Handlebars.registerHelper("prettifyDate", function(timeValue){
      
      const date = new Date(timeValue); //timeValue가 밀리세컨드로 들어와 있음 new Date(밀리세컨드형식)
      return date.getFullYear() + "/" + (date.getMonth() + 1) + "/" + date.getDate();
    });
  </script>


    <script>
      //3) 댓글 목록 요청 작업(댓글 + 페이징)
      let bno = ${board.bno}; //el문법 - 본문 글번호
      let replyPage =1; //1번부터 가져와야하니까

      let url = "/replies/pages/" + bno + "/" + replyPage + ".json"; //댓글 목록 및 페이지 정보 요청 주소
      
      getPage(url); //서버측으로 코드를 받아옴 (1차 데이터)

      //1)댓글목록출력작업
      /* 함수만드는 법
      1)
      function 함수명() {

      }
      2)
      let 변수명 = function() {  }
      */
      //핸들바 작업4
      let printData = function(replyData, target, templateObj){
        //replyData : 댓글 목록 데이터, target : 댓글이 삽입될 태그 위치, templateObj : 핸들바 템플릿 참조 객체
        
        //핸들바 템플릿 컴파일
        let template = Handlebars.compile(templateObj.html());
        //핸들바 템플릿에 데이터를 바인딩하여 html  생성
        let html = template(replyData); //스프링에서 넘어온 데이터(replyData)가 html에 전달
        //댓글이 삽입될 태그 위치에 혹시나 있을지도 모르는 태그를 깔끔하게 삭제
        target.empty();
        //생성된 html을 target의 자식으로 주입
        target.append(html); 
      }

      //2)댓글 페이징 출력작업 함수
      let printPaging = function(pageMaker, target){
        //function(페이징 정보, 출력될 위치)
        /* jstl에서 작성하던 페이징 정보를 js에서 jquery 문법으로 작업 중
        <nav aria-label="Page navigation example">
          <ul class="pagination">
            <li class="page-item"><a class="page-link" href="#">Previous</a></li>
            <li class="page-item"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">Next</a></li>
          </ul>
        </nav>
        */
       let pagingStr = '<nav aria-label="Page navigation example">';
           pagingStr += '<ul class="pagination">'; //+=로 누적중

            //이전표시
            if(pageMaker.prev) {
              pagingStr += '<li class="page-item"><a class="page-link" href="' + (pageMaker.startPage - 1);
              pagingStr += '">Previous</a></li>';
            }
            
            //페이지 번호 표시
            for(let i=pageMaker.startPage; i<=pageMaker.endPage; i++) {
              strClass = (pageMaker.cri.pageNum == i) ? 'active': ''; //현재페이지 활성화 style
              pagingStr += '<li class="page-item ' + strClass + '"><a class="page-link" href="' + i + '">' + i + '</a></li>';
            }

            //다음표시
            if(pageMaker.next) {
              pagingStr += '<li class="page-item"><a class="page-link" href="' + (pageMaker.endPage + 1);
              pagingStr += '">Next</a></li>';
            }
       
           pagingStr += '</ul>';
           pagingStr += '</nav>';

           //페이징 번호 위치에 추가 - target변수가 가리키는 위치에 pagingStr변수의 내용 삽입
           target.html(pagingStr);
      }

      

      //ajax구문으로 요청하는 작업 함수 - 댓글 목록을 요청하는 메인 시작함수
      function getPage(url) {

        //ajax 메소드 - $.getJSON : 결과값을 JSON으로 요청하겠다(json형태로 나한테 데이터 보내라)
        $.getJSON(url, function(data){          
          //console.log(data);
          //url : 댓글 목록 주소
          //이 작업을 하기 전에 getList()주소가 제대로 작동하는지 확인
          
          //댓글 목록 출력기능 함수
          // data.list : 댓글 목록데이터, data.pageMaker : 댓글 페이징 정보 -> data안에 있음
          printData(data.list, $("#replyList"), $("#reply-template"));
          //target : 밑에 댓글 목록 삽입될 위치 태그의 id
          
          //댓글 페이징출력기능 함수
          printPaging(data.pageMaker, $("#replyPaging"));
        });      

      }
    
    </script>
  </head>
  <body>
    
<%@ include file="/WEB-INF/views/include/header.jsp" %>

<%@ include file="/WEB-INF/views/include/Carousel.jsp" %>


<div class="container">
  <h3>게시판 글읽기</h3>
	  <div class="form-group">
	    <label for="title">번호</label>
	    <input type="text" class="form-control" id="bno" name="bno" readonly value="${board.bno }">
	  </div>
	  <div class="form-group">
	    <label for="title">제목</label>
	    <input type="text" class="form-control" id="title" name="title" readonly value="${board.title }">
	  </div>
	  <div class="form-group">
	    <label for="content">내용</label>
	    <textarea class="form-control" id="content" rows="3" name="content" readonly>${board.content }</textarea>
  	  </div>
	  <div class="form-group">
	    <label for="writer">작성자</label>
	    <input type="text" class="form-control" id="writer" name="writer" readonly value="${board.writer }">
	  </div>
	  <div class="form-group">
	    <label for="writer">등록일</label>
	    <input type="text" class="form-control" id="regdate" name="regdate" readonly value="<fmt:formatDate value="${board.regdate }" pattern="yyyy-MM-dd hh:ss"/>">
	  </div>
	<button type="button" id="btn_modify" class="btn btn-primary">Modify</button>
	<button type="button" id="btn_list" class="btn btn-primary">List</button>
	
	<form id="operForm" action="/board/modify" method="get">
		<input type="hidden" name="bno" value="${ board.bno}">
		<input type="hidden" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" name="amount" value="${cri.amount}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
	</form>

  <div class="row">
    <div class="col-12">
      <button type="button" id="btn_replyWrite" class="btn btn-primary">Reply Write</button>
    </div>
  </div>

  <!--댓글 목록-->
  <div class="row">
    <div class="col-12">
      <div id="replyList">

      </div>
      <div id="replyPaging">

      </div>
    </div>
  </div>



  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>

<!--Modal Dialog-->
<div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="replyTitle">New Reply</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="replyer" class="col-form-label">Replyer:</label>
            <input type="hidden" class="form-control" id="rno" name="rno">
            <input type="text" class="form-control" id="replyer" name="replyer"><%-- 값을 읽어오는 것 --%>
          </div>
          <div class="form-group">
            <label for="reply" class="col-form-label">Reply:</label>
            <textarea class="form-control" id="reply" name="reply"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="btn_replySave" class="btn btn-primary btnModal">Save</button>
        <button type="button" id="btn_replyModify" class="btn btn-primary btnModal">Modify</button>
        <button type="button" id="btn_replyDelete" class="btn btn-primary btnModal">Delete</button>
      </div>
    </div>
  </div>
</div>
    
  </body>
</html>

