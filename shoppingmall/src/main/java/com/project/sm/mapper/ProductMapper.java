/**
 * 
 */
package com.project.sm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.sm.vo.ProductVO;

/**
 * @author a
 *
 */
public interface ProductMapper {
	
	/**
	 * 상품 정보 상세보기
	 * @param productId		품번
	 * @return	ProductVO (상품 정보)
	 */
	public ProductVO viewProduct(@Param("productId") String productId);
	
	
	/**
	 * 상품 정보 등록하기
	 * @param productVO		등록할 상품 정보
	 */
	public void insertProduct(ProductVO productVO);
	
	
	/**
	 * 상품 정보 수정하기
	 * @param productVO		수정할 상품 정보
	 */
	public void updateProduct(ProductVO product);
	
	
	/**
	 * 상품 정보 삭제하기
	 * @param productVO		삭제할 상품 정보
	 */
	public void deleteProduct(ProductVO productVO);
	
	
	/**
	 * 전체 상품 정보 리스트 
	 * @return	전체 상품 정보 리스트
	 */
	public List<ProductVO> getAllProductList();
	
	
	/**
	 * 메인 카테고리에 맞는 서브 카테고리 출력
	 * @param mainCategory	메인 카테고리
	 * @return				서브 카테고리
	 */
	public List<String> viewSubCategory(@Param("mainCategory") String mainCategory);
	
	
	/**
	 * 서브 카테고리 클릭시 서브카테고리에 맞는 상품 리스트 출력 + 페이징 처리 추가
	 * 
	 * @param page			현재 페이지
	 * @param pageLimit		페이지당 나오는 상품 개수
	 * @param subCategory	서브 카테고리
	 * @return				서브 카테고리로 검색된 상품 리스트
	 */
	List<ProductVO> productPageProcessingList(@Param("page") int page,
			   								  @Param("pageLimit") int pageLimit,
			   								  @Param("subCategory") String subCategory);
	
	
	/**
	 * 상품 전체 개수
	 * @return	상품 전체 개수
	 */
	int getAllProductCount();
	
} //
