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
public class CartVO {

	private int cartNum;
	private String memberId;
	private String productId;
	private int cartCount;
	private String cartDate;
}
