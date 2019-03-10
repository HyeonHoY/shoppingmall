package com.project.sm.order;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.project.sm.mapper.OrderMapper;
import com.project.sm.vo.OrderVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/tx-context.xml"
})
@WebAppConfiguration
public class InsertOrder {

	@Inject
	SqlSession session;
	
	@Test
	public void test() {
		
		OrderVO order = new OrderVO();
		order.setId("spring12");
		order.setProductId("아이디");
		order.setPurchaseCount(2);
		order.setPurchasePrice(20000);
		
		session.getMapper(OrderMapper.class).orderInsert(order);
	}
}
