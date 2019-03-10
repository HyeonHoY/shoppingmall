package com.project.sm.vo;

import java.util.Date;

import lombok.Data;

@Data
public class MemberResultVO {

	private String id;
	private String pw;
	private String name;
	private String gender;
	private String email;
	private String phone;
	private String zip;
	private String address;
	private Date birthday;
	private String joindate;
	private String updatedate;
	private String role;
	
}
