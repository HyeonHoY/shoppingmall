/**
 * 
 */
package com.project.sm.dao;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


import com.project.sm.vo.BoardVO;

import lombok.extern.slf4j.Slf4j;

import com.project.sm.mapper.BoardMapper;

/**
 * 게시판 DAO 구현
 * @author a
 *
 */
@Repository
@Slf4j
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;
	
	
	@Transactional(propagation = Propagation.REQUIRED, 
			   rollbackFor = Exception.class)
	@Override
	public void insertBoard(final BoardVO board) {
		
		try {
			log.info("########################################");
			log.info("BoardDAO isertBoard");
			log.info("########################################");
			
			sqlSession.getMapper(BoardMapper.class).insertBoard(board);
			
			log.info("************** insert 성공 ! **************");
			
		}catch(Exception e) {
			log.error("10000");
			log.error("BoardDAO isertBoard E : "+e.getMessage());
		}
	}
		
	@Override
	public int getLastSeq() {
		
		return sqlSession.getMapper(BoardMapper.class).getLastSeq();
	}
	
	@Transactional(readOnly=true, rollbackFor = Exception.class)
	@Override
	public int getAllArticleCount(int boardKinds) {
		
		int count = 0;
		
		try {
			log.info("BoardDAO getAllArticleCount");
			count = sqlSession.getMapper(BoardMapper.class).getAllArticleCount(boardKinds);
			log.info("count : "+count);
			
		} catch(Exception e) {
			log.debug("BoardDAO getAllArticleCount E : " + e.getMessage());
		}
		
		return count;
	}
	
	
	@Transactional(readOnly=true, rollbackFor = Exception.class)
	@Override
	public int getAllSearchArticleCount(final String keyword, final String searchOption, final int boardKinds) {
		
		int count = 0;
		
		try {
			count = sqlSession.getMapper(BoardMapper.class).
					getAllSearchArticleCount(keyword, searchOption,boardKinds);
		} catch(Exception e) {
			log.debug("BoardDAO getAllArticleCount E : " + e.getMessage());
		}
		
		return count;
	}


	
	@Transactional(readOnly=true, rollbackFor = Exception.class)
	@Override
	public List<BoardVO> articleList() {
		
		List<BoardVO> list = new ArrayList<>();
		
		try {
			log.info("BoardDAO articleList");
			list = sqlSession.getMapper(BoardMapper.class).articleList();
		} catch(Exception e) {
			log.debug("BoardDAO articleList E : " + e.getMessage());
		}
		
		return list;
		
	}
	
	/*
	@Transactional(readOnly=true, rollbackFor = Exception.class)
	@Override
	public List<BoardVO> articlePageProcessingList(final int page, final int pageLimit, final int boardKinds) {
		
		List<BoardVO> list = new ArrayList<>();
		
		try {
			log.info("BoardDAO articlePageProceesingList");
			log.info("page : "+page+" , pageLimit : "+pageLimit+" , boardKinds : "+boardKinds);
			list = sqlSession.getMapper(BoardMapper.class).
				   articlePageProcessingList(page, pageLimit,boardKinds);
		} catch(Exception e) {
			log.debug("BoardDAO articlePageProceesingList E : " + e.getMessage());
		}
		
		return list;
	}
	*/

	@Transactional(readOnly=true, rollbackFor = Exception.class)
	@Override
	public List<BoardVO> articlePageProcessingList(final int page, final int pageLimit, final int boardKinds, final String productId) {
		
		List<BoardVO> list = new ArrayList<>();
		
		try {
			log.info("BoardDAO articlePageProceesingList");
			log.info("page : "+page+" , pageLimit : "+pageLimit+" , boardKinds : "+boardKinds);
			list = sqlSession.getMapper(BoardMapper.class).
				   articlePageProcessingList(page, pageLimit,boardKinds, productId);
		} catch(Exception e) {
			log.debug("BoardDAO articlePageProceesingList E : " + e.getMessage());
		}
		
		return list;
	}
	
	
	@Transactional(readOnly=true, rollbackFor = Exception.class)
	@Override
	public List<BoardVO> articleSearchList(final String keyword, final String searchOption) {
		
		List<BoardVO> list = new ArrayList<>();
		
		try {
			list = sqlSession.getMapper(BoardMapper.class).
				   articleSearchList(keyword, searchOption);
		} catch(Exception e) {
			log.debug("BoardDAO articlePageProceesingList E : " + e.getMessage());
		}
		
		return list;
		
	}
	
	
	@Transactional(readOnly=true, rollbackFor = Exception.class)
	@Override
	public List<BoardVO> articleCombineList(final int page, final int pageLimit, 
			final String keyword, final String searchOption, final int boardKinds) {

		List<BoardVO> list = new ArrayList<>();
		
		log.info("BoardDAOImpl articleCombineList");
		log.info("boardKinds : "+boardKinds);
	
		try {
		list = sqlSession.getMapper(BoardMapper.class).
		articleCombineList(page, pageLimit, keyword, searchOption,boardKinds);
		} catch(Exception e) {
		log.debug("BoardDAO articlePageProceesingList E : " + e.getMessage());
		}
		
		return list;
	
	}
	
	
	@Transactional(readOnly=true, rollbackFor = Exception.class)
	@Override
	public BoardVO viewBoard(final int boardNum) {
		
		BoardVO board = new BoardVO();
		
		try {
			
			log.info("BoardDAO viewBoard");
			board = sqlSession.getMapper(BoardMapper.class).viewBoard(boardNum);
			
			if(board == null) log.info("not data");
		} catch(Exception e) {
			log.debug("BoardDAO viewBoard E : " + e.getMessage());
		}
		
		return board;
		
	}

	
	@Transactional(propagation = Propagation.REQUIRED, 
			   rollbackFor = Exception.class)
	@Override
	public void updateBoard(BoardVO board) {
		
		try {
			log.info("@@@@@@@@@@@DAO service");
			log.info("board = "+board);
			sqlSession.getMapper(BoardMapper.class).updateBoard(board);
		}catch(Exception e) {
			log.error("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@1");
			log.error("BoardDAO updateBoard E : "+e.getMessage());
		}
	}
		

	@Transactional(propagation = Propagation.REQUIRED, 
			   rollbackFor = Exception.class)
	@Override
	public void deleteBoard(final int boardNum) {
				
		try {
			BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
			boardMapper.deleteBoard(boardNum);
		}catch(Exception e) {
			log.debug("BoardDAO deleteBoard E : "+e.getMessage());
		}
		
	}

	
	/**
	 * @see com.project.sm.dao.BoardDAO#updateReadCount(int)
	 */
	@Transactional(propagation = Propagation.REQUIRED, 
			   rollbackFor = Exception.class)
	@Override
	public void updateReadCount(final int boardNum) {

		try {
			BoardMapper boardMapper = sqlSession.getMapper(BoardMapper.class);
			boardMapper.updateReadCount(boardNum);
		}catch(Exception e) {
			log.debug("BoardDAO updateReadCount E : "+e.getMessage());
		}
		
	 }
}