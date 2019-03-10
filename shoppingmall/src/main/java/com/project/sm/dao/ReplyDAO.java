package com.project.sm.dao;

import java.util.List;


import com.project.sm.vo.ReplyVO;

public interface ReplyDAO {

	public void insertReply(ReplyVO reply);
	
	public ReplyVO getReply(int replyNo);
	
	// 댓글 페이지 처리 X
	public List<ReplyVO> listReply(int boardNum);
	
	// 댓글 페이지 처리 O
	public List<ReplyVO> listReplyPageing(int boardNum, int start, int end);
	
	public int listReplyCount(int boardNum);
	
	public void updateReply(ReplyVO reply);
	
	public boolean deleteReply(int replyNo, int boardNum);
	
	public boolean hasReplyByBoardNumAndReplyNo(int replyNo , int boardNum);
}
