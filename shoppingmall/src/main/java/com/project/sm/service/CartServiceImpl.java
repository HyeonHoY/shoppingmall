/**
 * 
 */
package com.project.sm.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.sm.dao.CartDAO;
import com.project.sm.vo.CartVO;

import lombok.extern.slf4j.Slf4j;

/**
 * @author a
 *
 */
@Service
@Slf4j
public class CartServiceImpl implements CartService {

	@Inject
	CartDAO dao;
	
	/**
	 * @see com.project.sm.service.CartService#insertCart(com.project.sm.vo.CartVO)
	 */
	@Override
	public boolean insertCart(CartVO cart) {
		
		boolean flag = false;
		try {
			dao.inserCart(cart);
			flag = true;
		} catch(Exception e) {
			log.error("CartServiceImpl insertCart error");
			e.printStackTrace();
			flag = false;
		}
		
		return flag;
	}

	@Override
	public List<CartVO> listCart(String memberId) {
		
		return dao.listCart(memberId);
	}

	@Override
	public int countCart(String memberId) {
		return dao.countCart(memberId);
	}
	
	@Override
	public int updateCart(CartVO cart) {
		return dao.updateCart(cart);
	}

	@Override
	public void deleteCart(CartVO cart) {
		dao.deleteCart(cart);
	}

}
