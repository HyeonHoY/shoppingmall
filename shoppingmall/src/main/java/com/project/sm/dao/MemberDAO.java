package com.project.sm.dao;

import java.util.List;

import com.project.sm.vo.MemberResultVO;
import com.project.sm.vo.MemberVO;

public interface MemberDAO {
	
	public MemberVO viewMember(String id);
	
	public String idCheck(String id);
	
	public List<MemberVO> listMember();
	public List<MemberVO> searchMember(String searchOption, String keyword); 
	/*public List<MemberVO> viewAllMember(int start, int end);*/
	public List<MemberResultVO> viewAllMember(int start, int end);
	/*public List<MemberVO> combineListMember(int start, int end,
			String searchOption, String keyword);*/		
	public List<MemberResultVO> combineListMember(int start, int end,
			String searchOption, String keyword);		
	
	public int memberCount();
	
	public int searchMemberCount(String searchOption, String keyword);
	
	public void insertMember(MemberVO member);
	
	public void deleteMember(MemberVO member);
	
	public void deleteMemberRole(String id);
	
	public void updateRole(String id, String role);
	
	public String viewRole(String id);
	
	public void phoneChange(MemberVO member);
	
	public void emailChange(MemberVO member);
	
	public void addressChange(MemberVO member);
}