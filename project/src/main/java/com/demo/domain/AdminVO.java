package com.demo.domain;

import java.util.Date;

import lombok.Data;

//TBL_ADMIN
@Data
public class AdminVO {
	//admin_id, admin_pw, admin_name, admin_lastdate
	private String admin_id;	//관리자 id
	private String admin_pw;	//관리자 비밀번호
	private String admin_name;	//관리자 이름
	private Date admin_lastdate;	//관리자 접속 시간
}
