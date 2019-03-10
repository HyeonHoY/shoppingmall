/**
 * 
 */
package com.project.sm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.sm.vo.BoardVO;

/**
 * 게시판 Mapper
 * @author a
 *
 */
public interface BoardMapper {
	
	
	public void insertBoard(BoardVO board);
	
	
	// 이미지 파일이 존재하는 게시판을 작성 시 작성된 시퀀스 번호를 가져오기 위한 매서드(폴더를 시퀀스 번호로 구분)
	public int getLastSeq();
	
	
	public int getAllArticleCount(@Param("boardKinds") int boardKinds);
	
	
	public int getAllSearchArticleCount(@Param("keyword") String keyword,
										@Param("searchOption") String searchOption,
										@Param("boardKinds") int boardKinds);
	
	
	public List<BoardVO> articleList();
	
	
	public List<BoardVO> articlePageProcessingList(@Param("page") int page,
												   @Param("pageLimit") int pageLimit,
												   @Param("boardKinds") int boardKinds,
												   @Param("productId") String productId);
	
	
/*	List<BoardVO> articlePageProcessingListOfBoardKinds(@Param("page") int page,
													    @Param("pageLimit") int pageLimit,
													    @Param("boardKinds") int boardKinds);*/
	
	
	public List<BoardVO> articleSearchList(@Param("keyword") String keyword,
									@Param("searchOption") String searchOption);
	
	
	public List<BoardVO> articleCombineList(@Param("page") int page,
									@Param("pageLimit") int pageLimit,
									@Param("keyword") String keyword,
									@Param("searchOption") String searchOption,
									@Param("boardKinds") int boardKinds);
	
	
	public BoardVO viewBoard(@Param("boardNum") int boardNum);
	
	
	public void updateBoard(BoardVO board);
	
	
	public void deleteBoard(@Param("boardNum")int boardNum);
	
	
	public void updateBoardNum(@Param("boardNum")int boardNum);	
	
	
	public void updateReadCount(@Param("boardNum") int boardNum);
	
}
