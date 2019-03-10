package com.project.sm.product;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.project.sm.mapper.ProductMapper;
import com.project.sm.service.OrderService;
import com.project.sm.vo.ProductVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/tx-context.xml"
})
@WebAppConfiguration
public class UpdateProduct {
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	SqlSession session;
	
	@Test
	public void test() {
		
		ProductVO product = new ProductVO();
		product.setProductId("231dd");
		product.setOrderCount(10);
		product.setProductStock(-10);
		
		session.getMapper(ProductMapper.class).updateProduct(product);
	}
}
