package com.project.sm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.sm.vo.OrderVO;

public interface OrderMapper {

	public void orderInsert(OrderVO order);
	public List<OrderVO> orderList();
	public void updateDelivery(@Param("orderNum") int orderNum, @Param("delivery") String delivery);
	public List<OrderVO> memberOrderList(String id);
}
