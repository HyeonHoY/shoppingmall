/**
 * 
 */
package com.project.sm.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.sm.dao.ProductDAO;
import com.project.sm.vo.ProductVO;

import lombok.extern.slf4j.Slf4j;

/**
 * @author a
 *
 */
@Service
@Slf4j
public class ProductServiceImpl implements ProductService {

	@Autowired
	private ProductDAO dao;
	
	
	/**
	 * @see com.project.sm.service.ProductService#viewProduct(java.lang.String)
	 */
	@Override
	public ProductVO viewProduct(String productId) {
		
		ProductVO productVO = new ProductVO();
		
		try {
			
			productVO = dao.viewProduct(productId);
			
		} catch (Exception e) {
			log.debug("ProductService viewProduct E : "+e.getMessage());
		}
		
		return productVO;
		
	} // viewProduct

	
	/**
	 * @see com.project.sm.service.ProductService#insertProduct(com.project.sm.vo.ProductVO)
	 */
	@Override
	public void insertProduct(final ProductVO productVO) {
		
		try {
			
			dao.insertProduct(productVO);
			
		} catch (Exception e) {
			log.debug("ProductService insertProduct E : " + e.getMessage());
		}
		
	} // insertProduct

	
	/**
	 * @see com.project.sm.service.ProductService#updateProduct(com.project.sm.vo.ProductVO)
	 */
	@Override
	public boolean updateProduct(ProductVO product) {
		
		boolean flag = false;
		
		try{
			dao.updateProduct(product);
			flag = true;
		} catch(Exception e) {
			log.error("ProductServiceImpl updateProduct error");
			e.printStackTrace();
			flag = false;
		}
		return flag;
	}

	
	/**
	 * @see com.project.sm.service.ProductService#deleteProduct(com.project.sm.vo.ProductVO)
	 */
	@Override
	public void deleteProduct(ProductVO productVO) {
	}

	
	/**
	 * @see com.project.sm.service.ProductService#getAllProductList()
	 */
	@Override
	public List<ProductVO> getAllProductList() {
		
		List<ProductVO> list = new ArrayList<>();
		
		try {
			
			log.info("ProductService getAllProductList");
			list = dao.getAllProductList();
			
		} catch (Exception e) {
			
			log.debug("ProductService getAllProductList E : "+e.getMessage());
			
		}
		
		return list;
	}


	/**
	 * @see com.project.sm.service.ProductService#viewSubCategory(java.lang.String)
	 */
	@Override
	public List<String> viewSubCategory(String mainCategory) {
		
		log.info("ProductService viewSubCategory " + mainCategory);
		
		List<String> list = new ArrayList<>();
		
		try {
			
			list = dao.viewSubCategory(mainCategory);
			
		} catch (Exception e) {
			log.debug("ProductService viewSubCategory E : " + e.getMessage());
		}
		
		return list;
		
	}

	
	/**
	 * @see com.project.sm.service.ProductService#productPageProcessingList(int, int, java.lang.String)
	 */
	@Override
	public List<ProductVO> productPageProcessingList(int page, int pageLimit, String subCategory) {

		log.info("ProductService productPageProcessingList " + subCategory);
		
		List<ProductVO> list = new ArrayList<>();
		
		try {
			
			list = dao.productPageProcessingList(page, pageLimit, subCategory);
			
		} catch (Exception e) {
			log.debug("ProductService productPageProcessingList E : " + e.getMessage());
		}
		
		return list;
		
	}


	/**
	 * @see com.project.sm.service.ProductService#getAllProductCount()
	 */
	@Override
	public int getAllProductCount() {

		log.info("ProductService getAllProductCount");
		
		int count = 0;
		
		try {
			count = dao.getAllProductCount();
		} catch (Exception e) {
			log.debug("ProductService getAllProductCount E : " + e.getMessage());
		}
		
		return count;
		
	}
	
	
	
} //
