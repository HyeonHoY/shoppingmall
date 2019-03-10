/**
 * 
 */
package com.project.sm.aop;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

/**
 * @author a
 *
 */
@Aspect
@Service
@Slf4j
public class BoardAdvice {

	// execution(* *..BoardDAOImpl.*(..))
	@Pointcut("execution(* *..BoardDAOImpl.*(..))")
	public void pointcutBoardAdvice() {

	}

	
	@Before("pointcutBoardAdvice()")
	public void adviceBefore(JoinPoint jp) {
		
		log.info("AOP Before : " + "인자" + Arrays.toString(jp.getArgs()) + "으로 " + 
				  jp.getSignature().getName() + " 메소드를 시작합니다.");
		
	}

	@After("pointcutBoardAdvice()")
	public void adviceAfter(JoinPoint jp) {
		
		log.info("AOP After : " + jp.getSignature().getName() + "메소드를 끝냈습니다.");
		
		log.info("************************** 게시판 모듈 종료 **************************");
		
		log.info("\n\n##############################################"
				+ "###############################################\n");
		
	}

	
	@Around("pointcutBoardAdvice()")
	public Object logAround(ProceedingJoinPoint pjp) {

		Object obj = null;

		try {
			
			log.info("\n\n##############################################" +
					 "###############################################\n");
			  
			log.info("************************** 게시판 모듈 시작 **************************");
			
			log.info("AOP Around begin : " + 
					  pjp.getSignature().getName() +
					  " 메소드를 시작합니다.");

			obj = pjp.proceed();
			// pjp.proceed(); // 타겟 객체의 원본 객체 실행
			// 주의사항) Object 리턴을 하지 않고 void 리턴일 경우는
			// 실행이 중단됨.

			log.info("AOP Around end : " + 
					  pjp.getSignature().getName() + 
					  " 메소드를 끝냈습니다.");

		} catch (Throwable e) {
			System.out.println("logAround Exception : " + e.getMessage());
		}

		return obj;
	}

	@AfterThrowing("pointcutBoardAdvice()")
	public void adviceAfterThrowing() {
		log.info("예외처리되었습니다.");
	}

} //