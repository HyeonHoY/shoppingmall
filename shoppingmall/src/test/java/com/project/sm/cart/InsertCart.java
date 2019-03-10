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
public class InsertCart {

	@Inject
	SqlSession sqlSession;
	
	@Test
	public void test() {
		
		CartVO cart = new CartVO();
		
		cart.setMemberId("spring20"); 
		cart.setProductId("3333333");
		cart.setCartCount(1);
//		
//		Map map = new HashMap<>();
//		map.put("v_member_id", "spring13");
//		map.put("v_product_id", "3333333");
//		map.put("v_cart_count", 1);
		
		// log.info("결과 값 = "+sqlSession.getMapper(CartMapper.class).insertCart("spirng15", "3333333", 1));
		// log.info("결과 값 = "+sqlSession.getMapper(CartMapper.class).insertCart(map));
		
		boolean flag = false;
		
		try {
			// sqlSession.getMapper(CartMapper.class).insertCart("spirng19", "3333333", 1);
			sqlSession.getMapper(CartMapper.class).insertCart(cart);
			flag = true;
		} catch(Exception e) {
			e.printStackTrace();
			flag = false;
		}
		log.info("flag = "+flag);
	}
}
