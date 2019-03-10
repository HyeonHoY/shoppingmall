/**
 * 
 */
package com.project.sm.dao;

import java.util.List;

import com.project.sm.vo.OrderVO;

/**
 * 게시판 DAO
 * @author a
 *
 */
public interface OrderDAO {
	public void orderInsert(OrderVO order);
	public List<OrderVO> orderList();
	public void updateDelivery(int orderNum, String delivery);
	public List<OrderVO> memberOrderList(String id);
}
