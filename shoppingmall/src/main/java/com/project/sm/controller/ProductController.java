package com.project.sm.controller;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.sm.service.BoardService;
import com.project.sm.service.CartService;
import com.project.sm.service.MemberService;
import com.project.sm.service.OrderService;
import com.project.sm.service.ProductService;
import com.project.sm.vo.BoardVO;
import com.project.sm.vo.MemberVO;
import com.project.sm.vo.OrderVO;
import com.project.sm.vo.PageVO;
import com.project.sm.vo.ProductVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/product")
public class ProductController {

	@Inject
	ProductService service;
	
	@Inject
	OrderService orderService;
	
	@Inject
	MemberService memberService;
	
	@Inject
	CartService cartService;
	
	@Inject
	BoardService boardService;
	
	
	/*@RequestMapping("list.do")
	public String productList(Model model) {
		
		log.info("상품 전체 리스트");
		
		List<ProductVO> productList = service.getAllProductList();
		model.addAttribute("productList", productList);
		
		return "/product/product_list";
	}
	
	@RequestMapping("view.do")
	public String productView(@RequestParam("id") String id, Model model) {
		
		ProductVO product = service.viewProduct(id);
		log.info("상품 상세 정보 : "+product);
		model.addAttribute("product", product);
		
		return "/product/product_view";
	}*/
	
	
	/**
	 * 
	 * @param model
	 * @param subCategory
	 * @param page
	 * @return
	 */
	@RequestMapping("{subCategory}")
	public String viewProductBySubCategory(Model model,
										   @PathVariable("subCategory") String subCategory,
										   @RequestParam(value="page", 
														 required=false, defaultValue="1") int page) {
		
		log.info(" ##### ProductController viewProductListBySubCategory ##### ");
		log.info("서브 카테고리 : " + subCategory);
		page = (page==0) ? 1 : page;
		
		int pageLimit = 16;
		int pagingStep = 10;
		
		int count = service.getAllProductCount();
		List<ProductVO> productList = service.productPageProcessingList(page, pageLimit, subCategory);
		
		int maxPage = (int)((double)count/pageLimit + 0.95);
		int startPage = (((int) ((double)page/pagingStep + 0.9)) - 1) * pagingStep + 1;
		int endPage = startPage + pagingStep - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		// 페이지 처리하는 VO를 생성 후 model에 넣어주기 위해 생성
		PageVO pageVO = new PageVO();
		pageVO.setPage(page);
		pageVO.setListCount(count);
		pageVO.setMaxPage(maxPage);
		pageVO.setStartPage(startPage);
		pageVO.setEndPage(endPage);
		
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("productList", productList);
		model.addAttribute("subCategory", subCategory);
		
		return "/product/product_list";
	}
	
	
	/**
	 * 
	 * @param model
	 * @param productId
	 * @return
	 */
	@RequestMapping("detail/{productId}")
	public String productDetail(Model model,
			   					@PathVariable("productId") String productId) {
		
		ProductVO product = service.viewProduct(productId);
		
		log.info("상품 상세 정보 : "+product);
		
		List<BoardVO> reviews = boardService.articlePageProcessingList(1, 10, 2, productId);
		List<BoardVO> inquirys = boardService.articlePageProcessingList(1, 10, 3, productId);
		
		model.addAttribute("product", product);
		model.addAttribute("reviews", reviews);
		model.addAttribute("inquirys", inquirys);
		log.info("reviews = "+boardService.articlePageProcessingList(1, 10, 2, productId));
		  
		return "/product/product_detail";
		
	}
	
	
	@ResponseBody
	@RequestMapping(value="buyProduct.do", produces="application/json; charset=UTF-8")
	public String buyProduct(@ModelAttribute("form1") MemberVO member,
							 @RequestParam("call_massage") String msg,
							 @RequestParam("productId") String[] productId,
							 @RequestParam("purchaseCount") int[] purchaseCount,
							 @RequestParam("purchasePrice") int[] purchasePrice,
							 HttpSession session) throws JsonProcessingException {
		
		
		log.info("member = " +member);
		log.info("msg = " +msg);
		log.info("count = "+productId.length);

		String id = (String)session.getAttribute("id");
		String result = "error";
		
		OrderVO order = new OrderVO();
		
		for(int i=0; i<productId.length; i++) {
			order.setId(id);
			order.setProductId(productId[i]);
			order.setPurchaseCount(purchaseCount[i]);
			order.setPurchasePrice(purchasePrice[i]);
			
			if(orderService.orderInsert(order)) {
				result = "success";
				// cartService.deleteCart(cart);
			} else {
				result = "error";
				return new ObjectMapper().writeValueAsString(result);
			}
			
			order = new OrderVO();
		}
		
		return new ObjectMapper().writeValueAsString(result);
	}
	
	@RequestMapping("productOrderPage.do")
	public String productOrderPage(@RequestParam("productId") String[] productId,
								   @RequestParam("purchaseCount") int[] purchaseCount, 
								   @RequestParam("purchasePrice") int[] purchasePrice, Model model,
								   HttpSession session) {
		
		log.info("#######################################################");
		log.info("listProductId = "+productId.length);
		log.info("listPurchaseCount = "+purchaseCount.length);
		log.info("order = "+purchasePrice.length);
		
		// 주문 VO
		OrderVO order = new OrderVO();
		List<OrderVO> orderList = new ArrayList<>();
		
		// 상품 VO
		ProductVO product = new ProductVO();
		List<ProductVO> productList = new ArrayList<>();
		
		for(int i=0; i<productId.length; i++) {
			
			order.setProductId(productId[i]);
			order.setPurchaseCount(purchaseCount[i]);
			order.setPurchasePrice(purchasePrice[i]);
			
			product = service.viewProduct(productId[i]);
			
			orderList.add(order);
			productList.add(product);
			
			order = new OrderVO();
			product = new ProductVO();
		}
		
		log.info("list = "+orderList);
		
		String id = (String)session.getAttribute("id");
		
		model.addAttribute("orderList", orderList);
		model.addAttribute("productList", productList);
		model.addAttribute("member", memberService.viewMember(id));
		
		return "/product/product_order_page";
	}
	
	@RequestMapping("orderHistory.do")
	public String orderHistory(HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("id");

		List<OrderVO> orders = orderService.memberOrderList(id);
		List<ProductVO> products = new ArrayList<>();
		
		for(int i=0; i<orders.size(); i++) {
			products.add(service.viewProduct(orders.get(i).getProductId()));
		}
		
		model.addAttribute("orders", orders);
		model.addAttribute("products", products);
		
		return "/product/product_order_history";
	}
}
