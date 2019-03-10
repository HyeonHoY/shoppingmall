package com.project.sm.vo;

import lombok.Data;

@Data
public class OrderVO {

	private String productId;
	private int purchaseCount;
	private int purchasePrice;
	private String paymentDate;
	private String delivery;
	private String id;
	private int orderNum;
	private String deliveryMessage;
	
	
	
//	private List<String> listProductId;
//	private List<Integer> listPurchaseCount;
//	private List<Integer> listPurchasePrice;
//	private List<String> listId;
}
