package com.demo.domain;

import lombok.Getter;
import lombok.ToString;

//[이전] 1	2	3	4	5	[다음] 
//jsp에서 위의 형태를 만들기 위한 정보 구성
/*
 	    1	2	3	4	5	[다음] - 첫번째 블럭
  [이전] 6	7	8	9	10	[다음] - 두번째 블럭
 */
@Getter
@ToString
//jsp에서 가져다 쓸 용도이기 때문에 setter 필요 없음
public class PageDTO {
	
	//1	2	3	4	5 [다음] 중 startPage : 1, endPage : 5
	private int startPage; //각 블럭의 시작페이지 번호 저장
	private int endPage; //각 블럭의 마지막페이지 번호 저장
	
	//이전, 다음 표시 여부
	private boolean prev, next;
	
	//테이블의 총 데이터 개수
	private int total;
	
	//criteria
	private Criteria cri; //pageNum, amount, type, keyword

	//매개변수가 있는 생성자 정의
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;	
		
		int pageSize = 5; // 1	2	3	4	5 블럭마다 불러올 페이지 개수
		int endPageInfo = pageSize - 1; // 4
		
		//(int)	ceil(1 / 5.0) * 5
		this.endPage = (int) Math.ceil((cri.getPageNum() / (double) pageSize)) * pageSize;
		/*
		 cri.getPageNum() : 현재 페이지 번호, ceil : 올림
		 pageNum이 1 ~ 5 범위에 해당되면 endPage 변수의 값이 동일하게 된다.
		 pageNum이 6이면 endPage 변수의 값이 달라진다.
		 1 ~ 5 범위의 페이지를 어떤 것을 눌러 서버에서 다시 실행되어 결과를 가져와도 startPage는 1로, endPage는 5로 일정하게 만들어서 for문으로 만들기 위해...
		  다음 단추를 클릭하여 6 ~ 10 페이지를 클릭하게 되면 startPage는 6로, endPage는 10으로 고정
		 getPageNum() 값만 달라지는 것!
		*/
		this.startPage = this.endPage - endPageInfo; //첫번째 블럭 startPage = 5 - 4 = 1
		
		/*
		 만약 데이터가 부족해서 페이지 10까지 못채운다면?(42개라면)
		 1 2 3 4 5
		 6 7 8 9       까지만 가능 
		 */ 
		//실제 데이터 수로 전체 페이지수를 구하기
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		/*
		 cri.getAmount() : 각 페이지마다 출력할 페이지 건수
		 total * 1.0 : double형으로 만들기
		 ceil: 나머지가 존재한다는 것은 소수점이 존재 한다는 것이고 그래서 몫+1 하기 위해 올림 사용
		*/
		
		//realEnd와 규칙성으로 만든 endPage 비교
		if(realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		
		//이전, 다음 표시여부
		this.prev = this.startPage > 1; //startPage가 1보다 크다면 prev(이전버튼)가 true -> 나타남
		this.next = this.endPage < realEnd;//endPage가 realEnd보다 작다면 next(다음버튼)가 true -> 나타남
		
		
	}
}
