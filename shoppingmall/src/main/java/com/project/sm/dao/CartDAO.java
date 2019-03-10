/**
 * 
 */
package com.project.sm.dao;

import java.util.List;

import com.project.sm.vo.CartVO;

/**
 * @author a
 *
 */
public interface CartDAO {

	public void inserCart(CartVO cart);
	public List<CartVO> listCart(String memberId);
	public int countCart(String memberId);
	public int updateCart(CartVO cart);
	public void deleteCart(CartVO cart);
}
