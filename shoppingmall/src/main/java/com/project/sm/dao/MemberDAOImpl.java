package com.project.sm.dao;

import java.util.List;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.sm.mapper.MemberMapper;
import com.project.sm.vo.MemberResultVO;
import com.project.sm.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public void insertMember(MemberVO member) {
		
		sqlSession.getMapper(MemberMapper.class).insertMember(member);
		sqlSession.getMapper(MemberMapper.class).insertMemberRole(member);
	}
	
	@Override
	public String idCheck(String id) {
		
		return sqlSession.getMapper(MemberMapper.class).idCheck(id);
	}

	@Override
	public MemberVO viewMember(String id) {
		
		return sqlSession.getMapper(MemberMapper.class).viewMember(id);
	}
	
	/*@Override
	public int idCheck(String id) {
		
		return sqlSession.getMapper(MemberMapper.class).idCheck(id);
	}*/

	@Override
	public List<MemberVO> listMember() {
		
		return sqlSession.getMapper(MemberMapper.class).listMember();
	}
	
	@Override
	public List<MemberVO> searchMember(String searchOption, String keyword) {
		
		return sqlSession.getMapper(MemberMapper.class).searchMember(searchOption, keyword);
	}
	
	/*@Override
	public List<MemberVO> viewAllMember(int start, int end) {
		
		return sqlSession.getMapper(MemberMapper.class).viewAllMember(start, end);
	}*/
	
	@Override
	public List<MemberResultVO> viewAllMember(int start, int end) {
		
		return sqlSession.getMapper(MemberMapper.class).viewAllMember(start, end);
	}
	
	/*@Override
	public List<MemberVO> combineListMember(int start, int end, String searchOption, String keyword) {
		
		return sqlSession.getMapper(MemberMapper.class).combineListMember(start, end, searchOption, keyword);
	}*/
	
	@Override
	public List<MemberResultVO> combineListMember(int start, int end, String searchOption, String keyword) {
		
		System.out.println(start +""+ end +""+ searchOption +""+keyword);
		return sqlSession.getMapper(MemberMapper.class).combineListMember(start, end, searchOption, keyword);
	}
	
	@Override
	public int memberCount() {
		return sqlSession.getMapper(MemberMapper.class).memberCount();
	}

	@Override
	public int searchMemberCount(String searchOption, String keyword) {
		
		return sqlSession.getMapper(MemberMapper.class).searchMemberCount(searchOption, keyword);
	}	
	@Override
	public void deleteMember(MemberVO member) {
		
		log.info("MemberDAOImpl deleteMember");
		
		System.out.println(1);
		sqlSession.getMapper(MemberMapper.class).deleteMember(member);
		System.out.println(2);
	}

	@Override
	public void deleteMemberRole(String id) {
		log.info("MemberDAOImpl deleteMemberRole");
		sqlSession.getMapper(MemberMapper.class).deleteMemberRole(id);
	}

	@Override
	public void phoneChange(MemberVO member) {
		
		log.info("MemberDAOImpl phoneChange");
		log.info("member : "+member);
		sqlSession.getMapper(MemberMapper.class).phoneChange(member);
	}
	
	@Override
	public void emailChange(MemberVO member) {
		
		sqlSession.getMapper(MemberMapper.class).emailChange(member);
	}
	
	@Override
	public void addressChange(MemberVO member) {
		sqlSession.getMapper(MemberMapper.class).addressChange(member);
	}

	@Override
	public void updateRole(String id, String role) {
		log.info("MemberDAOImpl updateRole");
		log.info("id : "+id+", role : "+role);
		sqlSession.getMapper(MemberMapper.class).updateRole(id,role);
	}

	@Override
	public String viewRole(String id) {
		log.info("MemberDAOImpl viewRole");
		log.info("id : "+id);
		return sqlSession.getMapper(MemberMapper.class).viewRole(id);
	}	
}
