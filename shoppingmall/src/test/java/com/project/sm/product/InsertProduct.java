package com.project.sm.product;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.project.sm.service.ProductService;
import com.project.sm.vo.ProductVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/tx-context.xml"
})
@WebAppConfiguration
@Slf4j
public class InsertProduct {
	
	@Autowired
	ProductService service;
	
	@Test
	public void test() {
		
		ProductVO product = new ProductVO("품번2233",
										  "메인 카테고리221d",
										  "서브 카테고리221d",
										  "상품명22DWDWD",
										  15000,
										  50);
		
		product.setProductTitleImg("z");
		product.setProductExplainImg("z");
		
		try {
			service.insertProduct(product);
		} catch(Exception e) {
			e.printStackTrace();
		}
		log.info("상품 인자 확인##########################\n"+service.viewProduct("품번2233"));
	}
}
