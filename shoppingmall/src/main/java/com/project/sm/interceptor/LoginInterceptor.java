package com.project.sm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import lombok.extern.slf4j.Slf4j;

/**
 * interceptor 클래스
 * interceptor는 특정 URL로 요청 시 Controller로 가는 요청을 가로채는 역할을 함.
 * 
 * HandlerInterceptorAdapter라는 추상 클래스를 쉽게 사용할 수 있도록 구현하여 3가지 매서드를 제공 받는다.
 * 
 * @author a
 *
 */
@Component
@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter {

	/**
	 * Contoller로 요청이 들어가기 전에 수행되는 매서드
	 * 
	 * 세션에 아이디가 저장되어 있을 경우 true를 리턴하고 
	 * 저장되지 않았을 경우 초기화면을 응답하고 false를 리턴한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
							 HttpServletResponse response,
							 Object handler) throws Exception {
		
		boolean loginFlag = false;
		
		log.info("Login Interceptor");
		
		log.info("role = " + request.getSession().getAttribute("role"));
		
        if(request.getSession().getAttribute("id") != null){
        	
        	if(request.getSession().getAttribute("role").equals("role_admin")) {
    			log.info("관리자 계정.");
    			loginFlag = true;
    		}else {
    			log.info("관리자 계정이 아닙니다.");
    	        response.sendRedirect(request.getContextPath() +"/"); 
    	        loginFlag = false;
    		}
        
        } else {
	        	
	    	log.info("로그인 인증이 실패 하였습니다.");
	        response.sendRedirect(request.getContextPath() +"/"); 
	        loginFlag = false;
        }

        return loginFlag;
	}
	
	
	/*@Override
	public boolean preHandle(HttpServletRequest request,
							 HttpServletResponse response,
							 Object handler) throws Exception {
		
		boolean loginFlag = false;
		
		log.info("Login Interceptor");
			
        if(request.getSession().getAttribute("id") == "spring1"){
        	
    		log.info("관리자 계정 접근 !");
            loginFlag = true;
        
        } else {
	        	
	    	log.info("관리자 계정으로만 접근이 가능합니다.");
	        response.sendRedirect(request.getContextPath() +"/"); 
	        loginFlag = false;
        }

        return loginFlag;
	}*/
	
	
	@Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        
		super.postHandle(request, response, handler, modelAndView);
    }
 
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        super.afterCompletion(request, response, handler, ex);
    }
}
