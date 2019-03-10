package com.project.sm;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.sm.service.ProductService;
import com.project.sm.vo.ProductVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Inject
	ProductService productService;
	
	
	/**
	 * 초기화면 경로
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		
		return "redirect:/home";
	}
	
	
	/**
	 * 초기 메인화면
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Model model,
					   HttpSession session) {
		
		List<ProductVO> productList = new ArrayList<>();
		
		productList = productService.getAllProductList();
		
		List<String> sub = new ArrayList<>();
		
		sub = productService.viewSubCategory("상의");
		
		model.addAttribute("productList", productList);
		session.setAttribute("sub", sub);
		
		
		return "/main_layout/shoppingmall_main";
	}
	
}
