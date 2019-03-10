package com.project.sm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.sm.dao.MemberDAO;
import com.project.sm.vo.MemberResultVO;
import com.project.sm.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

	@Inject
	MemberDAO dao;
	
	@Override
	public void insertMember(MemberVO member) {
			
		dao.insertMember(member);
	}

	@Override
	public String idCheck(String id) {
		
		return dao.idCheck(id);
	}
	
	@Override
	public MemberVO viewMember(String id) {
		
		return dao.viewMember(id);
	}

	/*@Override
	public int idCheck(String id) {
		
		return dao.idCheck(id);
	}*/

	@Override
	public int memberCount() {
		
		return dao.memberCount();
	}
	
	@Override
	public int searchMemberCount(String searchOption, String keyword) {
		
		return dao.searchMemberCount(searchOption, keyword);
	}	
	
	@Override
	public List<MemberVO> listMember() {
		
		return dao.listMember();
	}
	
	@Override
	public List<MemberVO> searchMember(String keyword, String searchOption) {
		
		return dao.searchMember(searchOption, keyword);
	}
	
	/*@Override
	public List<MemberVO> viewAllMember(int start, int end) {
		
		return dao.viewAllMember(start, end);
	}*/
	
	@Override
	public List<MemberResultVO> viewAllMember(int start, int end) {
		
		return dao.viewAllMember(start, end);
	}
	

	/*@Override
	public List<MemberVO> combineListMember(int start, int end, String searchOption, String keyword) {
		
		return dao.combineListMember(start, end, searchOption, keyword);
	}*/
	
	@Override
	public List<MemberResultVO> combineListMember(int start, int end, String searchOption, String keyword) {
		
		return dao.combineListMember(start, end, searchOption, keyword);
	}
	
	@Override
	public boolean deleteMember(MemberVO member) {
		
		boolean flag = false;
		
		log.info("MemberServiceImpl deleteMember");
		
		try {
			
			dao.deleteMember(member);
			log.info("0");
			
		} catch (Exception e) {
			try {
			
				
				dao.deleteMemberRole(member.getId());
			
				dao.deleteMember(member);
			
				flag = true;
			
				
			} catch(Exception se) {
			
				se.printStackTrace();
			}
			
			log.info("deleteMember SE : ");
			e.printStackTrace();
		} 
		return flag;
	}

	@Override
	public boolean phoneChange(MemberVO member) {
		
		log.info("MemberServiceImpl phoneChange");
		log.info("member : "+member);
		boolean flag = false;
		
		try {
			dao.phoneChange(member);
			flag = true;
			
		} catch(Exception e) {
			flag=false;
			System.out.println("MemberServiceImpl phoneChange E : ");
			e.printStackTrace();
		}
		return flag;
	}
	
	@Override
	public boolean emailChange(MemberVO member) {
		
		boolean flag = false;
		
		try {
			dao.emailChange(member);
			flag = true;
			
		} catch(Exception e) {
			
			flag=false;
			System.out.println("MemberServiceImpl emailChange E : ");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public boolean addressChange(MemberVO member) {
		
		boolean flag = false;
		
		try {
			dao.addressChange(member);
			flag = true;
			
		} catch(Exception e) {
			flag=false;
			System.out.println("MemberServiceImpl addressChange E : ");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public void updateRole(String id, String role) {
		log.info("MemberServiceImpl updateRole");
		log.info("id : "+id+", role : "+role);
		dao.updateRole(id,role);
	}

	@Override
	public String viewRole(String id) {
		log.info("MemberServiceImpl viewRole");
		log.info("id : "+id);
		return dao.viewRole(id);
	}

}
