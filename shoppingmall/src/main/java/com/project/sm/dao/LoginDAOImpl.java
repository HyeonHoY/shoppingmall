package com.project.sm.dao;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.sm.mapper.LoginMapper;
import com.project.sm.vo.MemberRoleVO;
import com.project.sm.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
 * loginMapper 접근하기 위한 DAO
 * DAO(Data Access Object) : 데이터 접근 객체
 * DAO의 기능은 단순히 Mapper에 접근하기 위해 쓰인다.
 * 
 * @author a
 */
@Repository
@Slf4j
public class LoginDAOImpl implements LoginDAO {
	
	/**
	 * root-context에 저장된 dataSource(드라이버, url, id, pw가 저장되어있는 객체)와
	 * SqlSessionFactory에 패키지 타입, Mapper 경로의 정보를 갖고는 sqlSession 객체에 의존주입을
	 * 사용하여 Mapper에 저장되어있는 SQL문에 접근하여 실행할 수 있도록 한다.
	 */
	@Inject
	SqlSession sqlSession;

	@Override
	public int loginCheck(MemberVO member) {

		int result = sqlSession.getMapper(LoginMapper.class).loginCheck(member);
		
		log.info("result : " + result);
		
		return result;
	}

	@Override
	public MemberVO viewMember(MemberVO member) {
		return sqlSession.getMapper(LoginMapper.class).viewMember(member);
	}

	@Override
	public void logout(HttpSession httpSession) {
	}

	@Override
	public String pwFind(MemberVO member) {
		
		String result = sqlSession.getMapper(LoginMapper.class).pwFind(member);
		
		log.info(result);
		
		return result;
	}
	
	@Override
	public String idFind(MemberVO member) {
		
		String result = sqlSession.getMapper(LoginMapper.class).idFind(member);
		
		log.info(result);
		
		return result;
	}
	
	@Override
	public void updatePw(MemberVO member) {
		sqlSession.getMapper(LoginMapper.class).updatePw(member);
	}

	@Override
	public MemberRoleVO viewRoleMember(String id) {
		return sqlSession.getMapper(LoginMapper.class).viewMemberRole(id);
	}


}
