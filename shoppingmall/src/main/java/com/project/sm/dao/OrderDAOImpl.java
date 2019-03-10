package com.project.sm.dao;


import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.sm.mapper.OrderMapper;
import com.project.sm.vo.OrderVO;

@Repository
public class OrderDAOImpl implements OrderDAO {

	@Inject
	SqlSession session;
	
	@Override
	public void orderInsert(OrderVO order) {
		session.getMapper(OrderMapper.class).orderInsert(order);
	}

	@Override
	public List<OrderVO> orderList() {
		return session.getMapper(OrderMapper.class).orderList();
	}

	@Override
	public void updateDelivery(int orderNum, String delivery) {
		session.getMapper(OrderMapper.class).updateDelivery(orderNum, delivery);
	}

	@Override
	public List<OrderVO> memberOrderList(String id) {
		return session.getMapper(OrderMapper.class).memberOrderList(id);
	}
}
