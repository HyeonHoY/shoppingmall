/**
 * 
 */
package com.project.sm.mapper;

import java.util.List;
import com.project.sm.vo.CartVO;

/**
 * @author a
 *
 */
public interface CartMapper {
	// public void insertCart(CartVO cart);
	public void insertCart(CartVO cart);
	// public int insertCart(Map map);
	
	public List<CartVO> listCart(String memberId);
	public int countCart(String memberId);
	public void updateCart(CartVO cart);
	public int selectCartCount(int cartNum);
	public void deleteCart(CartVO cart);
}
