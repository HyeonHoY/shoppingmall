package com.project.sm.reply;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.project.sm.dao.ReplyDAO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
	    

})
@WebAppConfiguration
@Slf4j
public class DeleteReply {

	@Autowired
	// SqlSession  sqlSession;
	ReplyDAO dao;
	@Test
	public void test() {
		
		log.info("############################################");
		
		assertFalse(dao.deleteReply(0, 0));
		assertTrue(dao.deleteReply(227, 33));
	}
}
