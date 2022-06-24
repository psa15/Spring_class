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
    
    <!-- Include Handlebars from a CDN -->
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

        //댓글 모달대화상자 띄우기
        $("#btn_replyWrite").on("click", function(){
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

  <!-- 핸들바 템플릿 : 댓글 목록작업 -->
    <!-- bootstrap 참고
    	가져오는 데이터가 여러개일 때 {{#each .}} 사용
		<script>안에 적으니까 오류남 아 당연하네 스크립트는 주석이 // 니까.... -->
	<script id="reply-template" type="text/x-handlebars-template">
  
    {{#each .}}
      <div class="form-group">
        <label for="replyer">작성자</label>
        <input type="hidden" id="rno" name="rno" value="{{rno}}">
        <input type="text" class="form-control" id="replyer" value="{{replyer}}" readonly>
      </div>
      <div class="form-group">
        <label for="reply">등록일: {{replydate}}</label>
        <textarea class="form-control" id="reply" rows="3" readonly>{{reply}}</textarea>
      </div>  
    {{/each}}
	</script>

    <script>
      //3) 댓글 목록 요청 작업(댓글 + 페이징)
      let bno = ${board.bno}; //el문법 - 본문 글번호
      let replyPage =1;

      let url = "/replies/pages/" + bno + "/" + replyPage + ".json"; //댓글 목록 및 페이지 정보 요청 주소
      
      getPage(url); //서버측으로 코드를 받아옴 (1차 데이터)

      //댓글목록출력작업
      /* 함수만드는 법
      1)
      function 함수명() {

      }
      2)
      let 변수명 = function() {  }
      */
      let printData = function(replyData, target, templateObj){
        //replyData : 댓글 목록 데이터, target : 댓글이 삽입될 태그 위치, templateObj : 핸들바 템플릿 참조 객체
        
        //핸들바 템플릿 컴파일
        let template = Handlebars.compile(templateObj.html());
        //핸들바 템플릿에 데이터를 바인딩하여 html  생성
        let html = template(replyData); //스프링에서 넘어온 데이터(replyData)가 html에 전달
        //댓글이 삽입될 태그 위치에 혹시나 있을지도 모르는 태그를 깔끔하게 삭제
        target.empty();
        //생성된 html을 target에 주입
        target.append(html);
      }


      //ajax구문으로 요청하는 작업
      function getPage(url) {

        //ajax 메소드 - $.getJSON : 결과값을 JSON으로 요청하겠다
        $.getJSON(url, function(data){          
          //console.log(data);
          
          // data.list : 댓글 목록데이터, data.pageMaker : 댓글 페이징 정보 -> data안에 있음
          printData(data.list, $("#replyList"), $("#reply-template"));
          //target : 밑에 댓글 목록 삽입될 위치 태그의 id
        }); 

        //댓글 목록 출력기능 함수

        //댓글 페이징 기능
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
    </div>
  </div>



  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</div>

<!--Modal Dialog-->
<div class="modal fade" id="replyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">New Reply</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="replyer" class="col-form-label">Replyer:</label>
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
        <button type="button" id="btn_replySave" class="btn btn-primary">Save</button>
      </div>
    </div>
  </div>
</div>
    
  </body>
</html>

