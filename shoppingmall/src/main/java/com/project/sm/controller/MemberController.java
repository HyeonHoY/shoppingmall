package com.project.sm.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.sm.service.LoginService;
import com.project.sm.service.MemberService;
import com.project.sm.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 회원관련 컨트롤러 Controller의 기능을 어노테이션으로 대체
 * @author a
 */
@Controller
@RequestMapping("/member")
@Slf4j
public class MemberController {

   // 서비스의 모든 기능을 쓰기 위해 의존 주입 어노테이션인 @Inject 사용
   @Inject
   MemberService service;
   
   // 회원정보 삭제 후 회원의 세션 정보가 남아있어서 로그아웃 서비스를 사용하기 위해 LoinService 매서드 사용
   @Inject
   LoginService loginService;
   
   /**
    * 회원 가입 페이지
    * member_login.jsp 168
    * 
    * @return   회원 가입 페이지인 member/member_join.jsp 페이지로 이동
    */
   @RequestMapping("write.do")
   public String writeMember(Model model) {
	   
      log.info("form test");
      
      if (!model.containsAttribute("memberValid")) {
         model.addAttribute("memberValid", new MemberVO());
      }

      return "/member/member_join";// form.jsp
   }
   
   
   /**
    * 
    * @param memberVO
    * @param result
    * @param ra
    * @param model
    * @return
    */
   @RequestMapping(value="/joinValid.do", method=RequestMethod.POST)
   public String joinValid(@Valid @ModelAttribute("memberValid") MemberVO memberVO, 
		   				   BindingResult result,
		   				   RedirectAttributes ra,
		   				   Model model) {
	   
      log.info("joinValid.do joinValid");

      if (result.hasErrors()) {
         log.error("error!!!!!");
         log.error("form error redirect page!");

         // 날짜 관련 오류
         log.error("날짜 : " + result.getFieldValue("birthday"));
         log.error("날짜 오류 : " + result.getFieldErrors("birthday"));

         // 생일 필드 에러 메시지
         if (result.hasFieldErrors("birthday")) {

            log.error("생일 정보 에러 있음 !!");

            List<FieldError> birthdayErrList = result.getFieldErrors("birthday");

            log.error("생일 필드 기정(default) 오류값 : "
                  + birthdayErrList.get(birthdayErrList.size() - 1).getDefaultMessage());

            String msg = birthdayErrList.get(birthdayErrList.size() - 1).getDefaultMessage();

            if (msg.trim().equals("반드시 값이 있어야 합니다.")) {
               ra.addFlashAttribute("birthday_error",
                     birthdayErrList.get(birthdayErrList.size() - 1).getDefaultMessage());
            } else {
               ra.addFlashAttribute("birthday_error", "잘못된 생년월일 형식입니다. 다시 입력하십시오");
            } //

         } // 생일 점검 끝

         // 오류값 객체 전송
         ra.addFlashAttribute("org.springframework.validation.BindingResult.memberValid", result);

         // VO 입력값 전송
         ra.addFlashAttribute("memberValid", memberVO);

         return "redirect:/member/write.do";
      } // 오류점검 끝

      MemberVO member = new MemberVO(memberVO);
      /*model.addAttribute("memberValid", member);*/
      model.addAttribute("msg", "회원가입을 축하합니다!");
      /*model.addAttribute("return_page", "login/login.do");*/
      log.info(member.toString());

      // Service/DAO 저장 (생략)
      service.insertMember(member);
      return "/member/success";
   }
   
   
   //아이디 중복 점검 
   @ResponseBody // ajax사용하여 호출한 부분으로 보내주기 위한 어노테이션
   @RequestMapping("idCheck.do")
   public String idCheck(HttpServletRequest request) throws Exception {
      log.info("MemberController idCheck");

      String id = request.getParameter("id");
      String idCheck = service.idCheck(id);
      log.info("MemberController idCheck : " + idCheck);
      String result = "0";

      if (idCheck != null) {
         result = "1";
      }
      return result;
   }
   
   
   /**
    * 세션에 저장된 아이디의 회원정보 창에서 삭제 버튼을 눌렀을 때 동작하는 컨트롤러
    * 
    * @param model      세션에 저장된 id 값을 모델에 저장
    * @param session   세션에 저장된 id 값을 가져오기 위한 객체
    * 
    * @return         member/member_delete.jsp 페이지로 이동
    */
   @RequestMapping("delete.do")
   public String deleteMember(Model model, HttpSession session) {
      
	  log.info("MemberController deleteMember");
	   
	  MemberVO member = service.viewMember((String)session.getAttribute("id")); 

	  log.info("MemberController deleteMember member : "+member);
	  
	  model.addAttribute("member",member);
	  
      model.addAttribute("id", session.getAttribute("id"));
      
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
   public String deleteExecution(@RequestParam("pw") String pw, HttpSession session) {
      
	  log.info("MemberController deleteException");
	   
	  String id = (String)session.getAttribute("id");
	  
      log.info("id : "+id+", pw : "+pw);
      MemberVO member = new MemberVO();
      
      member.setId(id);
      member.setPw(pw);
      
      boolean flag = service.deleteMember(member);
      
      if(flag) {
         loginService.logout(session);
         return "redirect:/";
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
		   					  Model model, 
		   					  HttpSession session) {   
      
      MemberVO member = service.viewMember((String)session.getAttribute("id"));
      
      String phone[] = member.getPhone().split("-");
	  String email[] = member.getEmail().split("\\@");
	  String address[] = member.getAddress().split("\\*");
		
      model.addAttribute("menu", menu);
      log.info("MemberController viewMember member : "+member);
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
   public String phoneChange(@ModelAttribute MemberVO member, 
		   					 HttpSession session) {
      
	  log.info("MemberController phoneChange member : "+member);
      
      member.setId((String)session.getAttribute("id"));
      String pw = member.getPw();
      log.info("pw : "+pw);
      boolean result = service.phoneChange(member);
      
      log.info("result : "+result);
      
      if(result) {
         return "redirect:/login/view.do?pw="+pw;
      } else {
         return "redirect:/member/update.do";
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
   public String emailChange(@ModelAttribute MemberVO member, 
		   					 HttpSession session) {
      
	  log.info("MemberController emailChange member : "+member);
	 
	  String pw = member.getPw();
	  
	  log.info("pw : "+pw);
      
	  member.setId((String)session.getAttribute("id"));
      
      boolean result = service.emailChange(member);
      
      if(result) {
    	  return "redirect:/login/view.do?pw="+pw;
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
   public String addressChange(@ModelAttribute MemberVO member, 
		   					   HttpSession session) {
      
	  log.info("MemberController addressChange member : "+member);
		 
	  String pw = member.getPw();
		  
	  log.info("pw : "+pw);
	   
      member.setId((String)session.getAttribute("id"));
      
      boolean result = service.addressChange(member);
      
      if(result) {
    	  return "redirect:/login/view.do?pw="+pw;
         
      } else {
         return "redirect:/member/update.do";
      }

   }
   
}