package com.project.sm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.sm.vo.MemberResultVO;
import com.project.sm.vo.MemberVO;

public interface MemberMapper {

	/**
	 * 회원가입 매서드
	 * 
	 * @param member	회원 정보 
	 * @return			회원가입 성공
	 */
	public void insertMember(MemberVO member);
	
	public String idCheck(String id);
	
	/**
	 * 회원가입 시 그 회원의 등급을 넣어주는 매서드
	 */
	public int insertMemberRole(MemberVO member);
	
	public List<MemberVO> listMember();
	
	public List<MemberVO> searchMember(
			@Param("searchOption")String searchOption, @Param("keyword")String keyword);
	
	/**
	 * 모든 회원 정보를 리턴해주는 매서드
	 * 
	 * @param start	페이지 처리를 위한 int형 변수
	 * @param end
	 * @return		모든 회원정보 리턴
	 */
	public List<MemberResultVO> viewAllMember(@Param("start")int start, @Param("end")int end);
	
	/*public List<MemberVO> combineListMember(@Param("start")int start, @Param("end")int end,
			@Param("searchOption")String searchOption, @Param("keyword")String keyword);*/
	
	public List<MemberResultVO> combineListMember(@Param("start")int start, @Param("end")int end,
			@Param("searchOption")String searchOption, @Param("keyword")String keyword);
	
	/**
	 * 회원정보를 리턴해주는 매서드
	 * @param id	회원 id
	 * @return		입력받은 id의 회원정보 리턴
	 */
	public MemberVO viewMember(String id);
	
	/**
	 * 모든 회원이 몇명인지 확인하는 매서드
	 * 
	 * @return 	회원 수
	 */
	public int memberCount();
	
	public int searchMemberCount(
			@Param("searchOption")String searchOption, @Param("keyword")String keyword);
	
	/**
	 * 회원 탈퇴 매서드
	 * 
	 * @param member	회원탈퇴 시 입력받는 id, pw를 member에 저장
	 */
	public void deleteMember(MemberVO member);
	
	/**
	 * 회원 탈퇴 시 그 회원의 등급 정보를 삭제하는 매서드
	 * 
	 * @param id	회원 id
	 */
	public void deleteMemberRole(String id);
	
	public void updateRole(@Param("id") String id, @Param("role") String role);

	public String viewRole(String id);
	
	/**
	 * 핸드폰 번호를 바꾸는 매서드
	 * 
	 * @param member	핸드폰 번호를 바꾸는 인자, 어떤 회원인지를 알려주는 id, 그 회원의 pw
	 */
	public void phoneChange(MemberVO member);
	
	/**
	 * 이메일을 바꾸는 매서드
	 * 
	 * @param member	이메일을 바꾸는 인자, 어떤 회원인지를 알려주는 id, 그 회원의 pw
	 */
	public void emailChange(MemberVO member);
	
	/**
	 * 주소를 바꾸는 매서드
	 * 
	 * @param member	주소를 바꾸는 인자, 어떤 회원인지를 알려주는 id, 그 회원의 pw
	 */
	public void addressChange(MemberVO member);
}
