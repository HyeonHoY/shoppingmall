package com.project.sm.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.project.sm.service.LoginService;
import com.project.sm.service.MemberService;
import com.project.sm.vo.MemberVO;

import lombok.extern.slf4j.Slf4j;

/**
 * login 관련 컨트롤러 Controller의 기능을 어노테이션으로 대체
 * 
 * @author a
 *
 */
@Controller
@RequestMapping("/login")
@Slf4j
public class LoginController {

   
   // 로그인 서비스의 모든 기능을 사용하기 위해 의존 주입 어노테이션인 @Inject 사용
   @Inject
   LoginService service;

   
   /**
    * 회원정보 조회 시 세션에 저장된 아이디와 사용자가 입력한 비밀번호가 일치할 경우 일치하는 회원의 모든 정보를 불러오기 위해
    * MemberService 사용.
    */
   @Inject
   MemberService memberService;

   
   /**
    * login 화면 전환을 위한 매서드
    * 
    * @return 로그인 화면 쇼핑몰 jsp 파일
    */
   @RequestMapping(value = "login.do")
   public String login(@RequestParam("num") int num,
		   			   @RequestParam(value="boardKinds", required=false, defaultValue="0") int boardKinds,
		   			   Model model) {
      /*
       * if(msg.equals("failure")) { model.addAttribute("result","회원 정보가 존재하지 않습니다.");
       * }
       */
      model.addAttribute("num", num);
      model.addAttribute("boardKinds", boardKinds);
      
      
      return "/member/member_login";
   }

   
   /**
    * shoppingmall_login.jsp에서 인자로 전달받은 로그인 정보(id, pw)가 데이터베이스에 저장된 정보와 일치하는 지 확인하는
    * 매서드
    * 
    * model의 정보와 view의 정보를 한번에 저장할 수 있는 ModelAndView 매서드를 사용함
    * 
    * @param member  폼의 id와 pw의 값을 전달 받기 위해 @ModelAttribute를 사용하여 전달받음.
    * @param session 전달받은 인자와 데이터베이스에 저장된 정보가 일치할 경우 세션에 저장하기 위해 사용
    * 
    * @return 모델 정보와 view 정보를 동시에 리턴해주는 ModelAndView
    */
   @RequestMapping(value = "loginCheck.do", method = RequestMethod.POST)
   public String loginCheck(@ModelAttribute MemberVO member, HttpSession session,
		   					@RequestParam("num") int num,
		   					@RequestParam(value="boardKinds", required=false, defaultValue="0") int boardKinds,
		   					Model model) {

      log.info("LoginController loginCheck");
      log.info("member : " + member);

      int result = service.loginCheck(member, session);

      log.info("result = " + result);

      if (result == 1) {
         //model.addAttribute("msg", "succese");
         if (num == 1) {
        	 if(session.getAttribute("role").equals("role_admin")) {
        		 return "redirect:/admin/admin.do?num=1";
        	 }
            return "redirect:/";
         } else if (num == 2 && boardKinds>0) {
            return "redirect:/board/write.do/boardKinds/"+boardKinds;
         } else if (num == 3) {
            return "redirect:/board/list.do/boardKinds/"+boardKinds;
         }
      }//if
      
      log.info("false");
      model.addAttribute("msg", "failure");
      model.addAttribute("num",1);
      
      return "/member/member_login";
   }
   
   /**
    * @return check/memeber_pwCheck.jsp로 이동한다.
    */
   @RequestMapping(value = "info_pwCheck.do")
   public String pwCheck(Model model, HttpSession session, MemberVO member) {

      MemberVO memberVO = memberService.viewMember((String) session.getAttribute("id"));

      log.info("LoginController pwCheck");

      log.info("MemberVO : " + memberVO);

      model.addAttribute("member", memberVO);

      return "/info/info_pwCheck";
   }

   
   /**
    * member_pwCheck.jsp 페이지에서 입력받은 인자(pw)와 데이터 베이스의 정보가 일치할 경우 model에 인자의 모든 데이터를
    * 저장하여 view에 뿌려주는 역할을 함.
    * 
    * @param pw      폼에서 입력받은 파라미터(폼에서 입력받은 데이터가 1개 이므로 @RequestParam을 사용)
    * @param session 세션에 저장된 파라미터(세션에 저장된 정보를 가져오기 위해 사용)
    * @param model   매서드에 저장 된 인자들을 view로 데이터를 전달하기 위해 Model 매서드 사용
    * 
    * @return true일 경우 check/member_view.jsp, false일 경우 login/pwCheck.do 매서드로 이동
    */
   @RequestMapping(value = "view.do")
   public String pwCheckResult(@RequestParam String pw, HttpSession session, Model model) {

      log.info("LoginController pwCheckResult");

      MemberVO member = new MemberVO();

      member.setPw(pw);

      log.info("member = " + member);

      String id = (String) session.getAttribute("id");

      member.setId(id);

      int result = service.loginCheck(member, session);

      if (result == 1) {
         log.info("true");

         model.addAttribute("dto", memberService.viewMember(id));

         return "/info/info_view";

      } else {
         log.info("false");
         return "redirect:/login/pwCheck.do";
      }
   }

   /**
    * 세션에 저장된 모든 데이터를 없애기 위한 매서드 LoginService 클래스의 logout 매서드를 가져와 세션을 끈다.
    * 
    * @param session 세션 정보를 끄기 위해 사용
    * 
    * @return 로그아웃 후 메인 페이지로 반환
    */
   @RequestMapping("logout.do")
   public ModelAndView logout(HttpSession session) {
      
      service.logout(session);
      
      ModelAndView mav = new ModelAndView();
      mav.setViewName("redirect:/");
      mav.addObject("msg", "logout");
      
      return mav;
   }

   
   /**
    * 로그인 페이지에서 아이디 찾기를 눌렀을 때 이동하는 페이지
    * 
    * @return /inquiry/inquiry_id.jsp 페이지로 이동
    */
   @RequestMapping("inquiryId.do")
   public String idFind() {
      return "/inquiry/inquiry_id";
   }

   
   /**
    * 로그인 페이지에서 비밀번호 찾기를 눌렀을 때 이동하는 페이지
    * 
    * @return /inquiry/inquiry_pw.jsp 페이지로 이동
    */
   @RequestMapping("inquiryPw.do")
   public String pwFind() {
      return "/inquiry/inquiry_pw";
   }

   
   /**
    * find/member_idFound.jsp에서 입력받은 폼의 인자(name, phone)값이 데이터베이스에 저장된 데이터와 일치한지
    * 확인하는 매서드
    * 
    * @param member 폼에서 입력받은 값을 저장하기 위해 @ModelAttribute 사용
    *
    * @return 데이터베이스에 저장된 데이터가 일치할 경우 Model의 기능과 비슷한 기능을 갖는 addObject 매서드에 입력받은 값을
    *         "userId"라는 키에 입력받은 아이디를 값으로 저장. 일치하지 않을 경우 "아이디를 찾을 수 없습니다."라는 문자열을
    *         값으로 갖는 userId 저장
    * 
    */
   @RequestMapping("idFindCheck.do")
   public ModelAndView idFindCheck(@ModelAttribute MemberVO member, Model model) {
      ModelAndView mav = new ModelAndView();
      String result = service.idFind(member);

      if (result != null) {
         mav.setViewName("/inquiry/inquiry_id_result");
         mav.addObject("userId", "아이디 : " + result);
      } else {
         mav.setViewName("/inquiry/inquiry_id_result");
         mav.addObject("userId", "아이디를 찾을 수 없습니다.");
      }
      return mav;
   }

   /**
    * find/member_pwFind.jsp에서 입력받은 폼의 인자(id, name)값이 데이터베이스에 저장된 데이터와 일치한지 확인하는
    * 매서드
    * 
    * @param member 폼에서 입력받은 값을 저장하기 위해 @ModelAttribute 사용
    *
    * @return 폼에서 입력받은 값과 데이터베이스에 저장된 값이 일치할 경우 forgot/member_update.jsp 페이지에서
    *         비밀번호를 바꾼다. 일치하지 않을 경우 다시 인자를 입력하는 forgot/member_pwFind.jsp 페이지로 이동한다.
    */
   @RequestMapping("pwFindCheck.do")
   public ModelAndView pwFindCheck(@ModelAttribute MemberVO member, Model model) {
      ModelAndView mav = new ModelAndView();
      String result = service.pwFind(member);
      if (result != null) {
         mav.setViewName("/inquiry/inquiry_pw_update");
         mav.addObject("userId", member.getId());
      } else {
         mav.setViewName("/inquiry/inquiry_pw");
         mav.addObject("msg","failure");
      }
      return mav;
   }

   /**
    * 비밀번호 찾기를 눌렀을 때 폼에서 입력받은 인자(id, name)와 데이터베이스에 저장된 인자가 일치할 경우 비밀번호를 바꾸는 매서드
    * 
    * @param member pwFindCheck에서 입력받은 인자의 아이디와 사용자가 폼에서 입력한 비밀번호를 저장하기
    *               위해 @RequestParam이 아닌 @ModelAttribute를 사용
    * 
    * @return 비밀번호를 바꾼 후 로그인 페이지로 이동
    */
   @RequestMapping("updatePw.do")
   public String updatePw(@ModelAttribute MemberVO member) {
      log.info("MemberController updatePW member" + member);
      service.updatePw(member);
      return "redirect:/login/login.do?num=1";
   }

}