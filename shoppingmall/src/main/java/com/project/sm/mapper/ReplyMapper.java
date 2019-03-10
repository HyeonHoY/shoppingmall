/**
 * 
 */
package com.project.sm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.sm.vo.ReplyVO;

/**
 * 게시판 Mapper
 * @author a
 *
 */
public interface ReplyMapper {
	
	public void insertReply(ReplyVO reply);
	
	public ReplyVO getReply(@Param("replyNo") int replyNo);
	
	// 댓글 페이지 처리 X
	public List<ReplyVO> listReply(@Param("boardNum") int boardNum);
	
	// 댓글 페이지 처리 O
	public List<ReplyVO> listReplyPageing(@Param("boardNum") int boardNum, @Param("start") int start, @Param("end") int end);
	
	public int listReplyCount(@Param("boardNum") int boardNum);
	
	public void updateReply(ReplyVO reply);
	
	public void deleteReply(@Param("replyNo") int replyNo ,@Param("boardNum") int boardNum);
	
	public int hasReplyByBoardNumAndReplyNo(@Param("replyNo") int replyNo ,@Param("boardNum") int boardNum);
}
