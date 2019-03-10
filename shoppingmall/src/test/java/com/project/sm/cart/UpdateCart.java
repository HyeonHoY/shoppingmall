package com.project.sm.cart;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.project.sm.mapper.CartMapper;
import com.project.sm.vo.CartVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/tx-context.xml"
})
@WebAppConfiguration
@Slf4j
public class UpdateCart {

	@Inject
	SqlSession sqlSession;
	
	@Test
	public void test() {
		
		CartVO cart = new CartVO();	
		cart.setCartNum(34);
		cart.setCartCount(1);
		
		boolean flag = false;
		
		try {
			sqlSession.getMapper(CartMapper.class).updateCart(cart);
			flag = true;
		} catch(Exception e) {
			e.printStackTrace();
			flag = false;
		}
		log.info("flag = "+flag);
	}
}
