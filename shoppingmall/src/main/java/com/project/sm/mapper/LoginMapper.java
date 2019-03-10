package com.project.sm.mapper;

import com.project.sm.vo.MemberRoleVO;
import com.project.sm.vo.MemberVO;

public interface LoginMapper {

	/**
	 * 로그인 확인하는 매서드
	 * 
	 * @param member	id와 pw를 member에 저장
	 * @return			회원 정보의 id와 pw를 정확히 입력받았을 경우 1 아닐경우 0
	 */
	public int loginCheck(MemberVO member);
	
	/**
	 * 회원의 정보를 리턴해주는 매서드
	 * 
	 * @param member	id를 member에 저장
	 * @return			회원 정보를 리턴
	 */
	public MemberVO viewMember(MemberVO member);
	
	/**
	 * 회원 id를 찾는 매서드
	 * 
	 * @param member	name, phone을 member에 저장
	 * @return			회원 id 리턴
	 */
	public String idFind(MemberVO member);
	
	/**
	 * 회원 pw를 찾는 매서드
	 * 
	 * @param member	id, name을 member에 저장
	 * @return			회원 pw 리턴
	 */
	public String pwFind(MemberVO member);
	
	/**
	 * 회원 비밀번호를 바꾸는 매서드
	 */
	public void updatePw(MemberVO member);

	/**
	 * 회원 등급 정보를 확인하는 매서드
	 * 
	 * @param id	회원 등급을 확인할 id
	 * @return		회원 등급 정보 리턴
	 */
	public MemberRoleVO viewMemberRole(String id);
}
