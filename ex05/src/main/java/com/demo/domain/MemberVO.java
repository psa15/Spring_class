package com.demo.domain;

import lombok.Data;

@Data
public class MemberVO {

	//id, pw, name, phone, address, gender, email
	private String id;
	private String pw;
	private String name;
	private String phone;
	private String address;
	private String gender;
	private String email;
}
