/**
 * 
 */
package com.project.sm.vo;

import lombok.Data;

/**
 * @author a
 *
 */
@Data
public class ProductVO {
	private String productId;
	private String mainCategory;
	private String subCategory;
	private String productName;
	private int productPrice;
	private int productStock;
	// 상품 제목 부분에 들어갈 사진
	private String productTitleImg;
	// 상품 설명 부분에 들어갈 사진
	private String productExplainImg;
	private String productContent;
	// 상품 등록 날짜
	private String productDate;
	// 할인률
	private int discountRate;
	// 주문 개수
	private int orderCount;
	
	public ProductVO(String productId, String mainCategory, String subCategory, String productName, int productPrice,
			int productStock) {
		
		this.productId = productId;
		this.mainCategory = mainCategory;
		this.subCategory = subCategory;
		this.productName = productName;
		this.productPrice = productPrice;
		this.productStock = productStock;
	}

	public ProductVO() {}
	
	
	
}
