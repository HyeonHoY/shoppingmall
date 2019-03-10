package com.project.sm;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.util.StringUtils;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/root-context.xml",
	    "file:src/main/webapp/WEB-INF/spring/tx-context.xml"
})
@WebAppConfiguration
@Slf4j
public class StringCount {
	
	@Test
	public void test() {
		
		String x = "d,dd,ddd,dddd";
		
		int count = StringUtils.countOccurrencesOf(x, ",");
		log.info("z = "+x.indexOf(","));
		
		String[] y = StringUtils.delimitedListToStringArray(x, ",");
		
		for(int i=0; i<count; i++) {
			log.info("y = "+y[i]); 
		}
		
	}
}
