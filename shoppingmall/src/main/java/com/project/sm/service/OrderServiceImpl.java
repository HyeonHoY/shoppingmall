package com.project.sm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.sm.dao.OrderDAO;
import com.project.sm.vo.OrderVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class OrderServiceImpl implements OrderService {

	@Inject
	OrderDAO dao;
	
	@Override
	public boolean orderInsert(OrderVO order) {
		
		boolean flag = false;
		
		try {
			dao.orderInsert(order);
			flag = true;
		} catch(Exception e){
			log.error("OrderServiceImpl insertOrder error");
			e.printStackTrace();
			flag = false;
		}
		
		return flag;
	}

	@Override
	public List<OrderVO> orderList() {
		return dao.orderList();
	}

	@Override
	public boolean updateDelivery(int orderNum, String delivery) {
		boolean flag = false;
		
		try {
			dao.updateDelivery(orderNum, delivery);
			flag = true;
		} catch(Exception e) {
			log.error("OrderServiceImpl updateDelivery error!!!!!!!");
			e.printStackTrace();
		}
		return flag;
	}

	@Override
	public List<OrderVO> memberOrderList(String id) {
		return dao.memberOrderList(id);
	}

}
