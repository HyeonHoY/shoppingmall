package com.project.sm.service;

import java.util.List;

import com.project.sm.vo.OrderVO;

public interface OrderService {

	public boolean orderInsert(OrderVO order);
	public List<OrderVO> orderList();
	public boolean updateDelivery(int orderNum, String delivery);
	public List<OrderVO> memberOrderList(String id);
}
