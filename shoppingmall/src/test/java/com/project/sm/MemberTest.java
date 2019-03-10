package com.project.sm;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
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
public class MemberTest {

	@Autowired
	private LoginDAO dao;

	@Test
	public void test() {
		log.info("test");

		MemberVO member = new MemberVO();
		
		member.setId("spring123");
		member.setPw("123456");
		
		log.info("loginCheck" + dao.loginCheck(member));
		
	}
}
