package com.project.sm.reply;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.project.sm.mapper.ReplyMapper;
import com.project.sm.vo.ReplyVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/root-context.xml"
})
@WebAppConfiguration
@Slf4j
public class UpdateReply {

	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void test() {
		
		log.info("update");
		
		ReplyVO reply = new ReplyVO(136, 123, "바꾸기");
		
		sqlSession.getMapper(ReplyMapper.class).updateReply(reply);
	}
}
