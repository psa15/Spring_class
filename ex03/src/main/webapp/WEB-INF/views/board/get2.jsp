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

    <%-- 게시판 js--%>
    <script>
      $(document).ready(function(){
        
        let openForm = $("#openForm");

        //수정버튼 클릭시 동작구문
          $("#btn-modify").on("click", function(){
            //console.log("수정버튼 클릭"); 확인 완료 후 주석걸음

            /*수정 폼 주소 - 필요 없어짐
            //location.href="수정폼주소?bno=" + 글번호;
            let bno = $("#bno").val(); //입력양삭의 값을 읽어옴, val()메소드는 입력양식(input, selectarea, textarea)에만 사용
            location.href="modify?bno=" + bno;
            */

            openForm.submit();

          });
          //코드를 수정하고 이클립스에서 한 번 파일을 열어서 확인해야 한다.

        //삭제버튼 클릭시 동작구문
          $("#btn-remove").on("click", function(){
            //console.log("삭제버튼 클릭"); 확인 완료
            let bno = $("#bno").val();
            if(!confirm(bno + "번 글을 삭제하시겠습니까?")) return;
            //확인 누르면 if(!true) 여서 false로 작용하여 삭제됨
            location.href="remove?bno=" + bno;
          });

        //목록버튼 클릭시 동작구문 <button type="button" id="btn-list" class="btn btn-info">목록</button>
          $("#btn-list").on("click", function(){

            //필요없는 글번호 삭제
            openForm.find("input[name='bno']").remove();
            /*
            name="bno"가 두 개 존재
              - 하나는 openForm태그, 
              - 또 하나는 <div>의 글번호
                하지만 openForm이 <form>태그를 참조하여 딱 제거하고 싶은 <input>태그의 글번호 정보만 제거
            */
            //console.log("delete");
            
            //주소 변경
            openForm.attr("action", "/board/list");

            openForm.submit();
          });
      });
    </script>

    <%--댓글 작업--%>
    <script>
      $(document).ready(function(){

        //"Reply Write" 클릭하면 댓글 모달 대화상자 띄우기
        $("#btn_replyWrite").on("click", function(){
          $("#replyModal").modal('show');
        });

        //Save 눌렀을 때 댓글 저장
        $("#btn_replySave").on("click", function(){

          let replyer = $("#replyer").val(); //팝업 창의 replyer 데이터를 읽어와 replyer 변수에 저장
          let reply = $("#reply").val();

          //rno(시쿼스), bno(get.jsp에 있음- ${board.bno}), reply(받아옴), replyer(받아옴), replydate(시스템처리), updatedate(시스템처리)
          
          //자바스크립트 Object 구문 {키:값}          
          let replyObj = { bno:${board.bno }, replyer:replyer, reply:reply }; //표시는 에러인데 실제는 아님
          //{bno : 글번호, replyer : replyer변수의 값으로 해석, reply : reply변수로 해석} - 자바스크립트 문법에서 이렇게 인식,
          //{이름 : 변수로서 해석}

          //Object문법을 json 문자열 방식으로
          //서버측에 보낼 데이터를 JSON문법구조의 문자열로 변환작업
          let replyStr = JSON.stringify(replyobj);
          console.log(replyStr);

          $.ajax({
            type: 'post',
            url: '/replies/new',

            //header에 보낼 데이터가 어떤 형식인지 명시
            headers: {
            	"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"
            },

            //넘어오는 데이터가 텍스트다 : controller의 리턴값 "success" 를 의미
            dataType: 'text',
            data: replyStr,
            success: function(result) {
              //이게 반응되려면 서버측에서 정확한 상태코드 값이 200번이라고 보내줘야 함
              //result에 success가 들어가게 됨
              //콜백함수: 내가 함수를 하나 호출했어 그 결과가 다시 다른 함수를 호출?
              if(result == "success"){
                alert("댓글 데이터 삽입 성공");
              }
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
  <h3>게시판 글읽기</h3>
  	  <div class="form-group">
	    <label for="bno">글번호</label>
	    <input type="text" class="form-control" id="bno" name="bno" readonly value="${board.bno}">
	  </div>
	  <div class="form-group">
	    <label for="title">제목</label>
	    <input type="text" class="form-control" id="title" name="title" readonly value="${board.title}">
	    <%-- BoardVO.java 안의 필드명을 name에 적기 --%>
	  </div>
	  <div class="form-group">
	    <label for="content">내용</label>
	    <textarea class="form-control" id="content" rows="3" name="content" readonly>${board.content}</textarea>
	  </div>
	  <div class="form-group">
	    <label for="writer">작성자</label>
	    <input type="text" class="form-control" id="writer" name="writer" readonly value="${board.writer}">
	  </div>
	  <div class="form-group">
	    <label for="regdate">등록일</label>
	    <input type="text" class="form-control" id="regdate" name="regdate" readonly value="<fmt:formatDate value="${board.regdate}" pattern="yyyy-MM-dd hh:mm:ss"/>">
	  </div>
	  <button type="button" id="btn-modify" class="btn btn-info">수정</button>
	  
	  <button type="button" id="btn-list" class="btn btn-info">목록</button>

	<form id="openForm" action="/board/modify" method="get">
		<%-- 수정 이 작동되면 form 태그의 내용이 전달되게 --%>
		<input type="hidden" name="bno" value="${board.bno}">
		<input type="hidden" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" name="amount" value="${cri.amount}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
	</form>

  <!-- 댓글 목록 출력 위치-->
  <div class="row"> <!-- 부트스트랩에서 제공하는 선택자 row : 테이블처럼 한 행을 의미-->
    
    <!-- 댓글 쓰기-->
    <div class="xol-12">
      <button type="button" id="btn_replyWrite" class="btn btn-info"> Reply Write </button>
    </div>
    
    <!--댓글 목록-->
    <div class="row">
      <div class="col-12"><!--12개 중 12개 한 줄을 다 쓰겠다-->
          <div id="replyList">

          </div>

      </div>
    </div>
    
  </div>


  <%@include file="/WEB-INF/views/include/footer.jsp" %>
</div>
    
<!-- Modal Dialog (댓글쓰기 팝업창)-->
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
            <input type="text" class="form-control" id="replyer" name="replyer">
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

