package com.project.sm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.sm.dao.ReplyDAO;
import com.project.sm.vo.ReplyVO;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author a
 *
 */
@Service
@Slf4j
public class ReplyServiceImpl implements ReplyService {

	@Inject
	ReplyDAO dao;
	
	@Override
	public void insertReply(ReplyVO reply) {
		
		dao.insertReply(reply);
	}

	@Override
	public ReplyVO getReply(int replyNo) {

		return dao.getReply(replyNo);
	}
	
	// 페이지처리 X
	@Override
	public List<ReplyVO> listReply(int boardNum) {
		
		return dao.listReply(boardNum);
	}

	// 페이지처리 O
	@Override
	public List<ReplyVO> listReplyPageing(int boardNum, int start, int end) {
		
		return dao.listReplyPageing(boardNum, start, end);
	}
	
	@Override
	public int listReplyCount(int boardNum) {
		
		return dao.listReplyCount(boardNum);
	}
	
	@Override
	public boolean updateReply(ReplyVO reply) {
		
		boolean flag = false;
		
		try {
			System.out.println("1");
			dao.updateReply(reply);
			flag = true;
			
		} catch (Exception e) {
			System.out.println("2");
			log.error("실패");
			flag = false;
		}
		System.out.println("3");
		
		return flag;
	}

	@Override
	public boolean deleteReply(int replyNo, int boardNum) {
		
		boolean result = false;
		
		if(dao.deleteReply(replyNo, boardNum)) {
			result = true;
		} else {
			result =false;
		} 
		
		return result;
	}

}
