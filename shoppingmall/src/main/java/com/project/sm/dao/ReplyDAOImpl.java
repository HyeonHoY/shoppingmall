/**
 * 
 */
package com.project.sm.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.sm.mapper.ReplyMapper;
import com.project.sm.vo.ReplyVO;

import lombok.extern.slf4j.Slf4j;

/**
 * @author a
 *
 */
@Repository
@Slf4j
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	SqlSession sqlSession;
	
	/**
	 * @see com.project.sm.dao.ReplyDAO#insertReply(com.project.sm.vo.ReplyVO)
	 */
	@Override
	public void insertReply(ReplyVO reply) {

		sqlSession.getMapper(ReplyMapper.class).insertReply(reply);
	}

	@Override
	public ReplyVO getReply(int replyNo) {
		
		return sqlSession.getMapper(ReplyMapper.class).getReply(replyNo);
	}
	
	// 페이지 처리 X
//	@Override
	public List<ReplyVO> listReply(int boardNum) {

		return sqlSession.getMapper(ReplyMapper.class).listReply(boardNum);
	}
	
	// 페이지 처리 O
	@Override
	public List<ReplyVO> listReplyPageing(int boardNum, int start, int end) {

		return sqlSession.getMapper(ReplyMapper.class).listReplyPageing(boardNum, start, end);
	}

	@Override
	public int listReplyCount(int boardNum) {
		
		return sqlSession.getMapper(ReplyMapper.class).listReplyCount(boardNum);
	}
	
	@Override
	public void updateReply(ReplyVO reply) {
	
		sqlSession.getMapper(ReplyMapper.class).updateReply(reply);
	}

	@Override
	public boolean deleteReply(int replyNo, int boardNum) {
		
		log.info("dao deleteReply");
		
		boolean flag = false;
		
		// 해당 레코드 존재 시 
		if(this.hasReplyByBoardNumAndReplyNo(replyNo, boardNum)){
			try {
				sqlSession.getMapper(ReplyMapper.class).deleteReply(replyNo, boardNum);
				flag = true;
				log.info("삭제 성공");
			} catch(Exception e) {
				log.error("dao deleteRely error");
				e.printStackTrace();
			}
		} else {
			flag = false;
			log.error("삭제 실패");
		}
		
		return flag;
	}

	@Override
	public boolean hasReplyByBoardNumAndReplyNo(int replyNo, int boardNum) {

		log.info("hasReplyByBoardNumAndReplyNo");
		
		return sqlSession.getMapper(ReplyMapper.class).hasReplyByBoardNumAndReplyNo(replyNo, boardNum) == 1 ? true : false;
	}

}
