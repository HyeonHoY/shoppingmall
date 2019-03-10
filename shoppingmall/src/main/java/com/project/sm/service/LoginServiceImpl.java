package com.project.sm.service;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.project.sm.dao.LoginDAO;
import com.project.sm.vo.MemberRoleVO;
import com.project.sm.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 로그인 관련 Service 클래스
 * 데이터의 접근을 담당하는 DAO를 가져와 기능을 부여해주는 클래스이다.
 * Service의 기능을 담당하는 @Service 어노테이션 사용
 * 
 * @author a
 */
@Service
@Slf4j
public class LoginServiceImpl implements LoginService {

	/**
	 * DAO의 모든 기능을 사용하기 위해 의존 주입을 대신 해주는 @Inject 어노테이션 사용 
	 */
	@Inject
	LoginDAO dao;
	
	@Inject
	CartService cartService;
	
	/**
	 * DAO의 loginCheck를 가져와 부가 기능을 넣어주는 클래스
	 */
	@Override
	public int loginCheck(MemberVO member, HttpSession session) {
		
		log.info("loginCheck");
		
		int result = dao.loginCheck(member);
		
		if(result == 1) {
			MemberRoleVO mvo = viewRoleMember(member.getId());
			
			session.setAttribute("id", member.getId());
			session.setAttribute("name", member.getName());
			session.setAttribute("role", mvo.getRole());
			log.info("countCart = "+cartService.countCart(member.getId()));
			session.setAttribute("cartCount", cartService.countCart(member.getId()));
			
		}
		
		return result;
	}

	/**
	 * DAO의 viewMember를 가져와 부가 기능을 넣어주는 클래스
	 */
	@Override
	public MemberVO viewMember(MemberVO vo) {
		return dao.viewMember(vo);
	}
	
	/**
	 * 세션에서 저장된 모든 정보를 무효화하는 기능을 담당하는 매서드
	 */
	@Override
	public void logout(HttpSession session) {
		session.invalidate();
	}

	/**
	 * DAO의 pwFind 매서드를 가져와 부가 기능을 넣어주는 매서드
	 */
	@Override
	public String pwFind(MemberVO member) {
		String result = dao.pwFind(member);
		log.info("result : "+member);
		return result;
	}
	
	/**
	 * DAO의 idFind 매서드를 가져와 부가 기능을 넣어주는 매서드
	 */
	@Override
	public String idFind(MemberVO member) {
		String result = dao.idFind(member);
		log.info("result : "+member);
		return result;
	}
	
	/**
	 * DAO의 updatePw 매서드를 가져와 부가 기능을 넣어주는 매서드
	 */
	@Override
	public void updatePw(MemberVO member) {
		dao.updatePw(member);
	}

	@Override
	public MemberRoleVO viewRoleMember(String id) {
		return dao.viewRoleMember(id);
	}
}
