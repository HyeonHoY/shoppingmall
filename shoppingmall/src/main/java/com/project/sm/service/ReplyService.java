package com.project.sm.service;

import java.util.List;

import com.project.sm.vo.ReplyVO;

/**
 * 
 * @author a
 *
 */
public interface ReplyService {
	
	public void insertReply(ReplyVO reply);
	
	public ReplyVO getReply(int replyNo);
	
	// 페이지처리 X
	public List<ReplyVO> listReply(int boardNum);
	
	// 페이지처리 O
	public List<ReplyVO> listReplyPageing(int boardNum, int start, int end);
	
	public int listReplyCount(int boardNum);
	
	public boolean updateReply(ReplyVO reply);
	
	public boolean deleteReply(int replyNo, int boardNum);
}
