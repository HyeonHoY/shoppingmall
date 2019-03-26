package com.project.sm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.project.sm.service.FileUploadService;
import com.project.sm.service.LoginService;
import com.project.sm.service.MemberService;
import com.project.sm.service.OrderService;
import com.project.sm.service.ProductService;
import com.project.sm.vo.MemberResultVO;
import com.project.sm.vo.MemberVO;
import com.project.sm.vo.OrderVO;
import com.project.sm.vo.ProductVO;

import lombok.extern.slf4j.Slf4j;

/**
 * interceptor를 이용한 계정 권한 별 접근제한 컨트롤러
 * 
 * servlet-context.xml에서 매핑 주소를 admin/**로 지정
 * admin/**로 접근할 경우 LoginInterceptor 클래스의 preHandle 매서드가 true or false를 반환해준다.
 * true 반환 시 url 주소로 입력한 admin/** 매핑 주소를 가지고 있는 컨트롤러에 접근할 수 있다.
 * 
 * @author a
 *
 */
@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {
	
	
	@Inject
	MemberService service;
	
	
	// 회원정보 삭제 후 회원의 세션 정보가 남아있어서 로그아웃 서비스를 사용하기 위해 LoinService 매서드 사용
    @Inject
    LoginService loginService;
	
    
    @Inject
    ProductService productService;

    @Inject
    OrderService orderService;

    /**
	 *  fileUpload metadata wiring
	 */
	@Inject
	private FileSystemResource productImageUploadResource;
    
	@Inject
	FileUploadService fileUploadService;
    
	/**
	 * 관리자 메인 페이지 이동
	 * @return
	 */
	@RequestMapping("admin.do")
	public String adminPage(@RequestParam("num") int num,
			   				Model model) {
		
		log.info("adminPage");
		
		model.addAttribute("num", num);
		
		if(num==1) {
			return "/admin/main/admin_main";
		} else {
			return "redirect:/sm/";
		}
	}
	
	/**
	 * 상품 관련 리스트 
	 * @param model 장품 전체 리스트 저장
	 * @param num 관리지 여부 확인
	 * @return
	 */
	@RequestMapping("adminProductList.do")
	public String adminProductList(Model model,
									@RequestParam("num") int num) {
		
		log.info("상품 전체 리스트");
		
		List<ProductVO> productList = productService.getAllProductList();
		log.info("productList = "+productList);
		
		model.addAttribute("productList", productList);
		model.addAttribute("num", num);
		
		if(num==4) {
			return "/admin/product/admin_product_list";
		} else {
			return "redirect:/admin/main/admin_main";
		}
		
	}
	
	
	/**
	 * 상품 등록 페이지 이동
	 * @return
	 */
	@RequestMapping("registrationPage.do")
	public String registrationPage(Model model) {
		
		log.info("registrationPage(상품 등록 페이지 이동)");
		
		int num = 4;
		
		model.addAttribute("num", num);
		
		return "/admin/product/admin_product_registration_page";
	}
	
	@RequestMapping(value = "productRegistration.do", method = RequestMethod.POST)
	public String productRegistration(@RequestParam Map<String, String> map,
									  @RequestParam("productExplainImg") MultipartFile productExplainImg,
									  @RequestParam("productTitleImg") MultipartFile productTitleImg) {

		log.info("################################################################");
		log.info("productRegistration(상품 등록 페이지)");
		
		// vo에 인자 저장 부분
		int price = new Integer(map.get("productPrice"));
		int stock = new Integer(map.get("productStock"));
		
		ProductVO product = new ProductVO(map.get("productId"), map.get("mainCategory"), 
										  map.get("subCategory"), map.get("productName"),price, stock);
		product.setProductTitleImg(productTitleImg.getOriginalFilename());
		product.setProductExplainImg(productExplainImg.getOriginalFilename());
		
		String path = productImageUploadResource.getPath()+product.getProductId()+"/";
		log.info("폴더 경로 = "+path);
		
		// 폴더가 없을 경우 생성
		fileUploadService.checkFolder(path);
		
		// 원본 파일 생성
		fileUploadService.writeFile(path+product.getProductTitleImg(), productTitleImg);
		fileUploadService.writeFile(path+product.getProductExplainImg(), productExplainImg);
		
		// 썸네일 파일 생성
		fileUploadService.boardThumbnail(100, 100, path, product.getProductTitleImg());
		fileUploadService.boardThumbnail(100, 100, path, product.getProductExplainImg());
		
		productService.insertProduct(product);
		log.info("product = "+product);
		
		return "redirect:/admin/adminProductList.do?num=4";
	}
	
	@ResponseBody
	@RequestMapping(value="updateDelivery", produces="application/json; charset=UTF-8")
	public String updateDelivery(@RequestParam("orderNum") int orderNum,
								 @RequestParam("delivery") String delivery) throws JsonProcessingException {
		
		String msg = "";
		
		log.info("orderNum = "+orderNum);
		log.info("delivery = "+delivery);
		
		if(orderService.updateDelivery(orderNum, delivery)) {
			msg = "success";
		} else {
			msg = "false";
		}
		
		return new ObjectMapper().writeValueAsString(msg);
	}
	
	/**
	 * 상품 등록 후 상품 전체리스트로 이동
	 * @return
	 */
//	@RequestMapping(value = "productRegistration.do", method = RequestMethod.POST)
//	public String productRegistration(@RequestParam Map<String, String> map,
//			  						  @RequestParam("productImg") MultipartFile multipartFile) {

	@RequestMapping(value = "orderList.do")
	public String orderList(@RequestParam("num") int num,
							Model model) {

		List<OrderVO> order = orderService.orderList();
		List<MemberVO> member = new ArrayList<>();
		
		for(int i=0; i<order.size(); i++) {
			String id = order.get(i).getId();
			member.add(service.viewMember(id));
		}

		model.addAttribute("num", num);
		model.addAttribute("order", order);
		model.addAttribute("member", member);
		model.addAttribute("count", order.size());
		
		return "/admin/order/admin_order_list";
	}
	
	@ResponseBody
	@RequestMapping(value = "productUpdate.do", produces="application/json; charset=UTF-8")
	public String productUpdate(@ModelAttribute ProductVO product) throws JsonProcessingException {
	
		log.info("product = "+product);
		
		productService.updateProduct(product);
			
		ProductVO product2 = productService.viewProduct(product.getProductId());
		
		String discountRate = String.valueOf(product2.getDiscountRate());
		String stock = String.valueOf(product2.getProductStock());
		
		String[] data = {discountRate, stock};
		
		return new ObjectMapper().writeValueAsString(data);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 관리자 계정으로 접속 시 모든 멤버의 속성을 볼 수 있는 매서드
	 * 페이지 처리를 위해 int형 변수인 start, end를 사용
	 * 
	 * @param model	페이지 처리 변수인 start와 end 그리고 모든 회원정보를 가지고 있는 list를 저장한다.
	 * @param start		
	 * @param end
	 * @return 		member/member_all.jsp 페이지로 반환
	 */
	@RequestMapping("allMember.do")
	public String allMember(Model model,
							@RequestParam(value="start",required=false,defaultValue="1") int start,
							@RequestParam(value="end",required=false,defaultValue="10") int end,
							@RequestParam("num") int num) {
		
		if(start < 1) {
			start = 1;
			end = 10;
		}
		
		int countMember = service.memberCount();
		
		if(start > countMember) {
			start -= 10;
			end -= 10;
		}
		
		List<MemberResultVO> list = service.viewAllMember(start, end);
		
		log.info("AnotherController security list");
		
		model.addAttribute("num", num);
		model.addAttribute("rownum", start);
		model.addAttribute("count", countMember);
		model.addAttribute("list", list);
		log.info("List : "+list);
		
		return "/admin/member/admin_member_all";
	}
	
	
	/**
	 * 모든 멤버의 속성을 검색하는 매서드
	 * 기능 : 페이지 처리, 검색
	 * 
	 * @param model			view 페이지에 map을 전달해주기 위해 사용
	 * @param start			페이지를 하기 위해 사용
	 * @param end			
	 * @param searchOption	view 페이지의 select 태그의 옵션을 선택받은 변수
	 * @param keyword		사용자가 검색한 내용을 받는 변수
	 * @return
	 */
	@RequestMapping("search/list.do")
	public String combineListMember(Model model,
									@RequestParam(value="start",required=false,defaultValue="1") int start,
									@RequestParam(value="end",required=false,defaultValue="10") int end,
									@RequestParam(value="searchOption",required=false,defaultValue="") String searchOption,
									@RequestParam(value="keyword",required=false,defaultValue="") String keyword) {
		
		log.info("start : " + start + " end : " + end);
		log.info("searchOption : " + searchOption + " keyword : " + keyword);
		
		if(start < 1) {
			start = 1;
			end = 10;
		}

		int allCount = service.memberCount();
		int count = service.searchMemberCount(searchOption, keyword);
		
		log.info("1");
		
		if(start > count) {
			start -= 10;
			end -= 10;
		}
		
		System.out.println(start);
		System.out.println(end);
		
		List<MemberResultVO> list = service.combineListMember(start, end, searchOption, keyword);
		Map<String, Object> map = new HashMap<>();
		
		map.put("searchOption", searchOption);
		map.put("keyword", keyword);
		map.put("start", start);
		map.put("count", count);
		map.put("list", list);
		map.put("allCount", allCount);
		
		model.addAttribute("map", map);
		
		return "/admin/member_all";
	}
	
	
	/**
	 * 관리자가 사용자의 상세정보를 확인하기 위한 매서드
	 * 
	 * @param model		회원 리스트의 id의 회원 정보를 모델에 저장
	 * @param id		관리자가 볼 수 있는 회원 리스트에서 id를 클릭하였을 때의 값
	 * @return
	 */
	@RequestMapping("view.do")
	public String viewMember(Model model,
			@RequestParam(value="id",required=false,defaultValue="") String id) {
		
		model.addAttribute("dto", service.viewMember(id));
		
		return "/info/info_view";
	}
	
	
///////////////////////////////////////////////////////////////////////////////////////
	//관리자 수정
	/**
    * 관리자 리스트에서 회원 아이디의 상세정보 창에서 삭제 버튼을 눌렀을 때 동작하는 컨트롤러
    * 
    * @param model      세션에 저장된 id 값을 모델에 저장
    * @param session   세션에 저장된 id 값을 가져오기 위한 객체
    * 
    * @return         member/member_delete.jsp 페이지로 이동
    */
   @RequestMapping("delete.do")
   public String deleteMember(@RequestParam("id") String id,
		   					  Model model, 
		   					  HttpSession session) {
      
	  log.info("AnotherController deleteMember");
	   
	  MemberVO member = service.viewMember(id); 

	  log.info("AnotherController deleteMember member : "+member);
	  
	  model.addAttribute("member",member);
	  
      model.addAttribute("id", id);
      
      return "/member/member_delete";
   }
   
   
   /**
    * 회원 탈퇴 창에서 세션에 저장된 아이디와 폼에 입력된 비밀번호의 정보가 일치하는지 확인하는 컨트롤러
    * 
    * 
    * @param pw      폼에서 입력받은 pw의 값을 받기위해 @RequestParam 어노테이션 사용
    * @param session   세션에 저장된 아이디 값을 가져오기위한 객체
    * 
    * @return         회원정보가 일치할 경우 초기 화면으로 리턴 아니면 회원탈퇴 페이지로 리턴
    */
   @RequestMapping("deleteExecution.do")
   public String deleteExecution(@RequestParam("id") String id, 
		   						 HttpSession session) {
      
	   log.info("AnotherController deleteException");
	   
	  MemberVO memberVO = service.viewMember(id);

	  log.info("memberVO : "+memberVO);
	  
	  MemberVO member = new MemberVO();
	  
	  member.setId(id);
	  member.setPw(memberVO.getPw());
	  
	  log.info("#######################################################################");
	  log.info("id : "+id+" , pw : "+memberVO.getPw());
	  log.info("#######################################################################");
      
      boolean flag = service.deleteMember(member);
      
      if(flag) {
         //loginService.logout(session);
         return "redirect:/admin/allMember.do";
      } else {
         
         return "redirect:/member/delete.do";
      }
   }
   
   /**
    * 회원정보를 수정하는 컨트롤러
    * URL 주소를 get 방식으로 받아서 menu의 값을 저장한다.
    * 
    * menu의 값의 따라 같은 .jsp 페이지이지만 주소를 수정하는 페이지와 연락처를 수정하는 페이지로 나뉘어진다.
    * 
    * @param menu      get방식으로 받아서 연락처를 수정하는 url 주소인지, 주소지를 수정하는 url 주소인지 구분
    * @param model      model에 어떤 url 주소인지 판별해주는 menu 변수와 회원의 값(phone, email, address 등)을 저장
    * @param session   member에 세션에 저장된 id의 모든 회원정보를 저장하기 위해 사용
    
    * @return         member/member_update.jsp 페이지         
    */
   @RequestMapping(value="update.do")
   public String updateMember(@RequestParam(value="menu", required=false, defaultValue="1") int menu,
		   					  @RequestParam("id") String id,
		   					  Model model, 
		   					  HttpSession session) {   
      
      MemberVO member = service.viewMember(id);
      
      String phone[] = member.getPhone().split("-");
	  String email[] = member.getEmail().split("\\@");
	  String address[] = member.getAddress().split("\\*");
      
      model.addAttribute("menu", menu);
      log.info("AnotherController updateMember member : "+member);
      model.addAttribute("member",member);
      if(menu==2) {
         model.addAttribute("phone", phone);
      } else if(menu==3) {
         model.addAttribute("email", email);
      } else if(menu==4) {
         model.addAttribute("address", address);
      }
      
      return "/member/member_update";
   }
   
   
   /**
    * update.do의 매핑주소에서 menu의 값이 2일 경우 member/member_update.jsp 페이지는
    * 핸드폰 번호를 수정하는 페이지로 변환된다.
    * 
    * @param member   view 페이지의 사용자가 바꿀 핸드폰 번호를 입력받는 폼과 변경할 회원의 패쓰워드 확인을 받는 폼을 저장   
    * @param session   세션에 저장된 아이디 저장
    
    * @return         성공적으로 수정할 경우 초기화면 리턴 실패했을 경우 핸드폰 번호를 수정하는 컨트롤러로 이동         
    */
   @RequestMapping("phoneChange.do")
   public String phoneChange(@RequestParam("id") String id,
		   					 @ModelAttribute MemberVO member, 
		   					 HttpSession session) {
      
	  log.info("AnotherController phoneChange member : "+member);
      
	  MemberVO memberVO = service.viewMember(id);

	  log.info("memberVO : "+memberVO);
	  
	  member.setId(id);
	  member.setPw(memberVO.getPw());
	  
	  log.info("#######################################################################");
	  log.info("id : "+id+" , pw : "+memberVO.getPw());
	  log.info("#######################################################################");
	  
	  boolean result = service.phoneChange(member);
      
      log.info("result : "+result);
      
      if(result) {
         return "redirect:/admin/view.do?id="+id;
      } else {
         return "redirect:/admin/update.do";
      }
   }
   
   /**
    * update.do의 매핑주소에서 menu의 값이 3일 경우 member/member_update.jsp 페이지는
    * 이메일을 수정하는 페이지로 변환된다.
    * 
    * @param member   사용자가 변경할 이메일 정보를 입력받는 폼의 정보와 회원 비밀번호를 입력받는 폼을 member의 속성에 저장   
    * @param session   세션에 저장된 아이디 저장
    * 
    * @return         성공적으로 수정할 경우 초기화면 리턴 실패했을 경우 이메일을 수정하는 컨트롤러로 이동   
    */
   @RequestMapping("emailChange.do")
   public String emailChange(@RequestParam("id") String id,
		   					 @ModelAttribute MemberVO member, 
		   					 HttpSession session) {
      
	  log.info("AnotherController emailChange member : "+member);
	 
	  MemberVO memberVO = service.viewMember(id);

	  log.info("memberVO : "+memberVO);
	  
	  member.setId(id);
	  member.setPw(memberVO.getPw());
	  
	  log.info("#######################################################################");
	  log.info("id : "+id+" , pw : "+memberVO.getPw());
	  log.info("#######################################################################");
      
      boolean result = service.emailChange(member);
      
      if(result) {
    	 return "redirect:/admin/view.do?id="+id;
      } else {
         return "redirect:/member/update.do";
      }
   }

   /**
    * update.do의 매핑주소에서 menu의 값이 4일 경우 member/member_update.jsp 페이지는
    * 주소를 수정하는 페이지로 변환된다.
    * 
    * @param member   사용자가 변경할 주소 정보를 입력받는 폼의 정보와 회원 비밀번호를 입력받는 폼을 member의 속성에 저장   
    * @param session   세션에 저장된 아이디 저장
    * 
    * @return         성공적으로 수정할 경우 초기화면 리턴 실패했을 경우 주소를 수정하는 컨트롤러로 이동   
    */
   @RequestMapping("addressChange.do")
   public String addressChange(@RequestParam("id") String id,
		   					   @ModelAttribute MemberVO member, 
		   					   HttpSession session) {
      
	  log.info("AnotherController addressChange member : "+member);
		 
	  MemberVO memberVO = service.viewMember(id);

	  log.info("memberVO : "+memberVO);
	  
	  member.setId(id);
	  member.setPw(memberVO.getPw());
	  
	  log.info("#######################################################################");
	  log.info("id : "+id+" , pw : "+memberVO.getPw());
	  log.info("#######################################################################");
      
      boolean result = service.addressChange(member);
      
      if(result) {
    	 return "redirect:/admin/view.do?id="+id;
      } else {
         return "redirect:/member/update.do";
      }

   }
   
   
/////////////////////////////////////////////////////////////////////////////////////////	
   
   
	@ResponseBody
    @RequestMapping(value="roleUpdate.do", produces="application/json; charset=UTF-8")
    public String roleUpdate(@RequestParam Map<String, String> map) throws JsonProcessingException {

      service.updateRole(map.get("id"), map.get("role"));
      String role = service.viewRole(map.get("id"));
   
      return new ObjectMapper().writeValueAsString(role);
   }
}