package com.demo.domain;

import java.util.Date;

import lombok.Data;

//TBL_MEMBER 테이블
@Data
public class MemberVO {

	/*
	 m_id, m_name, m_passwd, m_postnum, m_addr, m_addr_d, m_tel, 
	 m_email, m_email_accept, m_point, m_regdate, m_updatedate, 
	 m_lastdate
	 */
	private String m_id; //회원 id
	private String m_name;	//회원 이름
	private String m_passwd; //회원 비밀번호
	private int m_postnum;	//우편번호
	private String m_addr;	//기본 주소
	private String m_addr_d;	//상세 주소
	private String m_tel;	//전화번호
	private String m_email;	//이메일
	private boolean m_email_accept;	//이메일 수신 여부
	private int m_point;	//적립금
	private Date m_regdate;	//가입일
	private Date m_updatedate;	//수정일
	private Date m_lastdate;	//최근 접속시간
	
}
