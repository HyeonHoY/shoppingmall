/**
 * 
 */
package com.project.sm.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.project.sm.mapper.ProductMapper;
import com.project.sm.vo.ProductVO;

import lombok.extern.slf4j.Slf4j;

/**
 * @author a
 *
 */
@Repository
@Slf4j
public class ProductDAOImpl implements ProductDAO {

	@Autowired
	private SqlSession sqlSession;

	
	/**
	 * @see com.project.sm.dao.ProductDAO#viewProduct(java.lang.String)
	 */
	@Override
	public ProductVO viewProduct(String productId) {
		
		ProductVO productVO = new ProductVO();
		
		try {
			log.info("ProductDAO viewProduct");
			productVO = sqlSession.getMapper(ProductMapper.class).viewProduct(productId);
			
		} catch (Exception e) {
			log.debug("ProductDAO viewProduct E : "+e.getMessage());
		}
		
		return productVO;
	}

	
	/**
	 * @see com.project.sm.dao.ProductDAO#insertProduct(com.project.sm.vo.ProductVO)
	 */
	@Override
	public void insertProduct(ProductVO productVO) {
		
		try {
			log.info("ProductDAO insertProduct");
			log.info("productVO = "+productVO);
			sqlSession.getMapper(ProductMapper.class).insertProduct(productVO);
			
		} catch (Exception e) {
			log.debug("ProductDAO insertProduct E : "+e.getMessage());
		}
		
	}

	
	/**
	 * @see com.project.sm.dao.ProductDAO#updateProduct(com.project.sm.vo.ProductVO)
	 */
	@Override
	public void updateProduct(ProductVO product) {

		sqlSession.getMapper(ProductMapper.class).updateProduct(product);
	}

	
	/**
	 * @see com.project.sm.dao.ProductDAO#deleteProduct(com.project.sm.vo.ProductVO)
	 */
	@Override
	public void deleteProduct(ProductVO productVO) {

		
	}

	
	/**
	 * @see com.project.sm.dao.ProductDAO#getAllProductList()
	 */
	@Override
	public List<ProductVO> getAllProductList() {
		
		List<ProductVO> list = new ArrayList<>();
		
		try {
			
			log.info("ProductDAO getAllProductList");
			list = sqlSession.getMapper(ProductMapper.class).getAllProductList();
			
		} catch (Exception e) {
			
			log.debug("ProductDAO getAllProductList E : "+e.getMessage());
			
		}
		
		return list;
	}


	/**
	 * @see com.project.sm.dao.ProductDAO#viewSubcategory(java.lang.String)
	 */
	@Override
	public List<String> viewSubCategory(String mainCategory) {

		List<String> list = new ArrayList<>();
		
		log.info("메인 카테고리 값 : " + mainCategory);
		
		try {
			log.info("##################### ProductDAO viewSubCategory #####################");
			
			list = sqlSession.getMapper(ProductMapper.class)
					  		 .viewSubCategory(mainCategory);
			
			log.info("##################### productVO 출력 ##################### : " + list);
			
		} catch (Exception e) {
			log.debug("ProductDAO viewSubCategory E : "+e.getMessage());
		}
		
		return list;
	}
	
	
	/**
	 * @see com.project.sm.dao.ProductDAO#productPageProcessingList(int, int, java.lang.String)
	 */
	@Override
	public List<ProductVO> productPageProcessingList(int page, int pageLimit, String subCategory) {
		
		List<ProductVO> list = new ArrayList<>();
		
		log.info("서브 카테고리 값 : " + subCategory);
		
		try {
			log.info("##################### ProductDAO productPageProcessingList #####################");
			
			list = sqlSession.getMapper(ProductMapper.class)
					  		 .productPageProcessingList(page, pageLimit, subCategory);
			
		} catch (Exception e) {
			log.debug("ProductDAO productPageProcessingList E : "+e.getMessage());
		}
		
		return list;
		
	}


	/**
	 * @see com.project.sm.dao.ProductDAO#getAllProductCount()
	 */
	@Override
	public int getAllProductCount() {
		
		int count = 0;
		
		try {
			log.info("ProductDAO getAllProductCount");
			count = sqlSession.getMapper(ProductMapper.class).getAllProductCount();
		} catch(Exception e) {
			log.debug("ProductDAO getAllProductCount E : " + e.getMessage());
		}
		
		return count;
		
	}
	
	
} //
