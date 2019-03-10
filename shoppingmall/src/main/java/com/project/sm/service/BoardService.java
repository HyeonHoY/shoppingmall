package com.project.sm.service;

import java.util.List;
import com.project.sm.vo.BoardVO;

public interface BoardService {
	
	public void insertBoard(BoardVO board);
	public int getLastSeq();
	
	public int getAllArticleCount(int boardKinds);
	public int getAllSearchArticleCount(String keyword, String searchOption,int boardKinds);
	
	public List<BoardVO> articleList();
	// public List<BoardVO> articlePageProcessingList(int page, int pageLimit, int boardKinds);
	public List<BoardVO> articlePageProcessingList(int page, int pageLimit, int boardKinds, String productId);
	public List<BoardVO> articleSearchList(String keyword, String searchOption);
	public List<BoardVO> articleCombineList(int page, int pageLimit,
											String keyword, String searchOption,int boardKinds);
	
	
	public BoardVO viewBoard(int boardNum);
	
	public void updateBoard(BoardVO board);
	
	public void deleteBoard(int boardNum);

	public boolean updateReadCount(int boardNum);
}
