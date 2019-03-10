package com.project.sm.dao;

import javax.servlet.http.HttpSession;

import com.project.sm.vo.MemberRoleVO;
import com.project.sm.vo.MemberVO;

public interface LoginDAO {
	// 회원 로그인 체크
	public int loginCheck(MemberVO member);
		
	// 회원 로그인 정보
	public MemberVO viewMember(MemberVO member);
		
	// 회원 로그아웃 ==> DAO 영역에서는 생략 가능
	public void logout(HttpSession httpSession);
	
	public String idFind(MemberVO member);
	
	public String pwFind(MemberVO member);

	public void updatePw(MemberVO member);
	
	public MemberRoleVO viewRoleMember(String id);
}
