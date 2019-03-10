package com.project.sm.board;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.project.sm.dao.BoardDAO;
import com.project.sm.vo.BoardVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/tx-context.xml"
})
@WebAppConfiguration
public class InsertBoard {

	@Inject
	BoardDAO dao;
	
	@Test
	public void test() {
		
		BoardVO board = new BoardVO("spring2", "ㅌㅅㅌ", "ㅌㅅㅌ");
		
		dao.insertBoard(board);
	}
}
