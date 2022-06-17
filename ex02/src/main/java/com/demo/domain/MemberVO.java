package com.demo.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {

	//userid, passwd, username, addr, tel, reg_date
	
	private String userid;
	private String passwd;
	private String username;
	private String addr;
	private String tel;
	private Date reg_date;
	
}
