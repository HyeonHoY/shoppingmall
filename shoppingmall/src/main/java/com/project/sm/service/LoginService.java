package com.project.sm.service;

import javax.servlet.http.HttpSession;

import com.project.sm.vo.MemberRoleVO;
import com.project.sm.vo.MemberVO;

public interface LoginService {
	
	public int loginCheck(MemberVO member, HttpSession session);
	
	public MemberVO viewMember(MemberVO member);
	
	public void logout(HttpSession session);
	
	public String idFind(MemberVO member);
	
	public String pwFind(MemberVO member);

	void updatePw(MemberVO member);
	
	public MemberRoleVO viewRoleMember(String id);
}
