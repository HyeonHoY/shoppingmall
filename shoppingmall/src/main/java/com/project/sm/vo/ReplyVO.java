package com.project.sm.vo;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ReplyVO {
	
	private int replyNo;
	private int boardNum;
	private String replyContent;
	private String replyWriter;
	
	// @JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-mm-dd hh24:mi:ss", timezone="EST")
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="EST")
	private String regdate;
	
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="EST")
	private String updatedate;
	
	private String replyReadCount;
	
	private String securityReply;
	private String userWriter;
	
	
	
	public ReplyVO(int boardNum, String replyContent, String replyWriter) {
		
		this.boardNum = boardNum;
		this.replyContent = replyContent;
		this.replyWriter = replyWriter;
	}

	public ReplyVO(int replyNo, int boardNum, String replyContent) {
		
		this.replyNo = replyNo;
		this.boardNum = boardNum;
		this.replyContent = replyContent;
	}

	public ReplyVO(int replyNo, int boardNum) {
		
		this.replyNo = replyNo;
		this.boardNum = boardNum;
	}

	public ReplyVO() {
	}
}
