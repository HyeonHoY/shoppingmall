<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title></title>
</head>
<body>
<!-- 서브 카테고리 -->
<div class="row mt-3">
	<div class="mx-auto">
		<p class="mb-3" style="border-bottom:1px solid gray;">
			<b>${subCategory}</b>
		</p>
	</div>
</div>

<!-- 서브 카테고리 종류 -->
<div class="row mb-3">
	<div class="mx-auto" >
	  <c:forEach var="subCate" items="${sub}" varStatus="st">
	  	<a style="display:inline; margin-right:30px;" 
	  	   href="${path}/sm/product/${sub.get(st.index)}">${sub.get(st.index)}&nbsp;</a>
	  </c:forEach>
	</div>
</div>

<!-- 서브 카테고리에 맞는 상품 리스트 -->
<div class="row mx-auto">
	<c:forEach var="product" items="${productList}" varStatus="st">
		<div class="col-lg-4 col-md-6 my-2">
			<div class="card h-100">
				<a href="${path}/sm/product/detail/${product.productId}">
					<img class="card-img-top" height="400"
						 src="<c:url value='/product/${product.productId}/${product.productTitleImg}'/>">
				</a>
				<div class="card-body">
					<h4 class="card-title">
						<a href="${path}/sm/product/detail/${product.productId}">
							${product.productName}</a>
					</h4>
					<h5>${product.productPrice}</h5>
					<p class="card-text">${product.productId}</p>
				</div>
				<div class="card-footer">
					<small class="text-muted">&#9733; &#9733; &#9733; &#9733;
						&#9734;</small>
				</div>
			</div>
		</div>
	</c:forEach>
</div>

<!-- 페이징 -->
<div class="row mt-3 mb-4">
	<div class="mx-auto">
		<c:if test="${not empty productList && pageVO.listCount > 0}">
			<%@ include file="../board/paging.jsp"%>
		</c:if>
	</div>
</div>
</body>
</html>