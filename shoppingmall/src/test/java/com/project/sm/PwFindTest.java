package com.project.sm;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.project.sm.dao.LoginDAO;
import com.project.sm.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/root-context.xml"
})
@WebAppConfiguration
@Slf4j
public class PwFindTest {

	@Inject
	LoginDAO dao;
	
	@Test
	public void test() {
		
		MemberVO member = new MemberVO();
		
		member.setId("spring2");
		member.setName("스프링3213");
		
		log.info("pw = "+ dao.pwFind(member));
		
		if(dao.pwFind(member) == null) {
			log.info("비밀번호를 찾을 수 없습니다.");
		}
		
	}
}
