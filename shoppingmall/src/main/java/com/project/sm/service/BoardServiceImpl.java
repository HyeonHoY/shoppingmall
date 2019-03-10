package com.project.sm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.sm.dao.BoardDAO;
import com.project.sm.vo.BoardVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class BoardServiceImpl implements BoardService {

	@Inject
	BoardDAO dao;
	
	@Override
public void insertBoard(BoardVO board) {
		
		try {
			log.info("BoardController insertBoard");
			log.info("board : "+board);
			dao.insertBoard(board);
		} catch(Exception e) {
			
			log.info("exception");
			e.printStackTrace();
		}		
	}

	@Override
	public int getLastSeq() {
		
		return dao.getLastSeq();
	}
	
	@Override
	public int getAllArticleCount(int boardKinds) {
		
		log.info("BoardServiceImpl getAllArticleCount");
		
		int count = dao.getAllArticleCount(boardKinds);

		log.info("count : "+count);
		
		return count;
	}
	
	@Override
	public int getAllSearchArticleCount(String keyword, String searchOption, int boardKinds) {
		
		return dao.getAllSearchArticleCount(keyword, searchOption,boardKinds);
	}
	
	@Override
	public List<BoardVO> articleList() {
		
		return dao.articleList();
	}
	
	@Override
	public List<BoardVO> articleSearchList(String keyword, String searchOption) {
		
		return dao.articleSearchList(keyword, searchOption);
	}
	
	@Override
	public List<BoardVO> articlePageProcessingList(int page, int pageLimit, int boardKinds, String productId) {
		
		log.info("BoardServiceImpl articlePageProcessionList");
		log.info("page : "+page+" , pageLimit : "+pageLimit+" , boardKinds : "+boardKinds);
		return dao.articlePageProcessingList(page, pageLimit ,boardKinds, productId);
	}
	
	@Override
	public List<BoardVO> articleCombineList(int page, int pageLimit, String keyword, String searchOption, int boardKinds) {
		
		log.info("BoardServiceImpl articleCombineList");
		log.info("boardKinds : "+boardKinds);
		
		return dao.articleCombineList(page, pageLimit, keyword, searchOption, boardKinds);
	}


	@Override
	public BoardVO viewBoard(int boardNum) {
		
		return dao.viewBoard(boardNum);
	}

	@Override
	public void updateBoard(BoardVO board) {
		dao.updateBoard(board);
	}

	@Override
	public void deleteBoard(int boardNum) {
		
		dao.deleteBoard(boardNum);
	}
	
	@Override
	public boolean updateReadCount(int boardNum) {
		
		boolean result = false;
		
		try {
			dao.updateReadCount(boardNum);
			result = true;
			
		} catch(Exception e) {
			e.printStackTrace();
			result = false;
		}
		
		return result;
	}

}
