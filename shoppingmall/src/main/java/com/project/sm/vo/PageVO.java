/**
 * 
 */
package com.project.sm.vo;

import lombok.Data;

/**
 * 페이지 VO(객체)
 * @author a
 *
 */
@Data
public class PageVO {
	
	private int page; // 현재 페이지
	private int maxPage; // 총 페이지 수
	private int startPage; // 시작 페이지
	private int endPage; // 끝 페이지
	private int listCount; // (페이지당) 총 페이지 수
	
}
