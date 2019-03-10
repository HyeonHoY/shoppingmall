package com.project.sm.board;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.project.sm.service.BoardService;
import com.project.sm.vo.BoardVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/tx-context.xml"
})
@WebAppConfiguration
@Slf4j
public class UpdateBoard {
	
	@Inject
	BoardService service;
	
	@Test
	public void test() {
		
		BoardVO board = new BoardVO();
		
		board.setBoardNum(470);
		board.setBoardSubject("z 변경");
		board.setBoardContent("내용 z");
		
		service.updateBoard(board);
		log.info("상세 정보 : "+service.viewBoard(470));
	}
}
