/**
 * 
 */
package com.project.sm.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

/**
 * 게시판 VO
 * @author a
 *
 */
@Data
public class BoardVO {
	
	private int boardNum;
	private int boardKinds;//게시판 종류 => 1: 자유게시판, 2:상품 후기 , 3:Q & A
	private String boardWriter;
	private String boardPw;
	private String boardSubject;
	private String boardContent;
	private String boardFile;
	
	private List<MultipartFile> picUpload;
	
	/**
	 * 게시글 참조 번호
	 */
	private int boardReRef;
	
	/**
	 * 게시글 답글 레벨
	 */
	private int boardReLev;
	
	/**
	 * 게시글 답변 번호
	 */
	private int boardReSeq;
	
	private int boardReadCount;
	private String boardDate;
	private String productId;
	
	
	public BoardVO(String boardWriter, String boardSubject, String boardContent) {
		super();
		this.boardWriter = boardWriter;
		this.boardSubject = boardSubject;
		this.boardContent = boardContent;
	}

	public BoardVO() {
		super();
	}
	
}
