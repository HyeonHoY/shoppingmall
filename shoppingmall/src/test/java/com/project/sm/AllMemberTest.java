package com.project.sm;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.project.sm.dao.MemberDAO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/root-context.xml"
})
@WebAppConfiguration
@Slf4j
public class AllMemberTest {
	
	@Inject
	private MemberDAO dao;
	
	@Test
	public void test() {
		
		log.info("allMember = " + dao.viewAllMember(1, 8));
	}
}
