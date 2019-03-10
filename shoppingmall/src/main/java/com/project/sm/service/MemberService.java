package com.project.sm.service;

import java.util.List;

import com.project.sm.vo.MemberResultVO;
import com.project.sm.vo.MemberVO;

public interface MemberService {

	public MemberVO viewMember(String id);

	public String idCheck(String id);
	
	public List<MemberVO> listMember();	
	public List<MemberVO> searchMember(String keyword, String searchOption);	
	/*public List<MemberVO> viewAllMember(int start, int end);*/
	public List<MemberResultVO> viewAllMember(int start, int end);
	/*public List<MemberVO> combineListMember(int start, int end,
			String searchOption, String keyword);*/
	public List<MemberResultVO> combineListMember(int start, int end,
			String searchOption, String keyword);
	
/*	public int idCheck(String id);*/
	
	public int memberCount();
	
	public int searchMemberCount(String searchOption, String keyword);
	
	public void insertMember(MemberVO member);

	public boolean deleteMember(MemberVO member);
	
	public void updateRole(String id, String role);
	
	public String viewRole(String id);
	
	public boolean phoneChange(MemberVO member);
	
	public boolean emailChange(MemberVO member);
	
	public boolean addressChange(MemberVO member);
}
