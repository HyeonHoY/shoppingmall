/**
 * 
 */
package com.project.sm.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.project.sm.mapper.CartMapper;
import com.project.sm.vo.CartVO;

/**
 * @author a
 *
 */
@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	SqlSession sqlSession;
	
	/**
	 * @see com.project.sm.dao.CartDAO#inserCart(com.project.sm.vo.CartVO)
	 */
	@Override
	public void inserCart(CartVO cart) {
		
		sqlSession.getMapper(CartMapper.class).insertCart(cart);
	}

	@Override
	public List<CartVO> listCart(String memberId) {
		
		return sqlSession.getMapper(CartMapper.class).listCart(memberId);
	}
	
	@Override
	public int countCart(String memberId) {
		return sqlSession.getMapper(CartMapper.class).countCart(memberId);
	}

	@Override
	public int updateCart(CartVO cart) {
		sqlSession.getMapper(CartMapper.class).updateCart(cart);
		return sqlSession.getMapper(CartMapper.class).selectCartCount(cart.getCartNum());
	}

	@Override
	public void deleteCart(CartVO cart) {
		sqlSession.getMapper(CartMapper.class).deleteCart(cart);
	}

}
