<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 전체 보기</title>
<script>
$(document).ready(function(){
	for(var i=0; i<$("#list_size").val(); i++){
		$("#combinePrice_"+i+"").html(parseInt($("#combinePrice_"+i+"").text())+"원");
	}
});
</script>
</head>
<body>
${productList}


<!-- 인자 확인 div -->
<input type="hidden" id="list_size" value="${productList.size()}">
<div class="row mx-auto">
<c:forEach var="product" items="${productList}" varStatus="st">
	<div class="col-lg-4 col-md-6 my-2">
		<div class="card h-100">
			<!-- <a href="/sm/content.do"> -->
			<a href="${pageContext.request.contextPath}/product/view.do?id=${product.productId}">
			<img class="card-img-top"
				 src="<c:url value='/product/${product.productId}/${product.productTitleImg}'/>" height="400"></a>
			<div class="card-body">
				<h4 class="card-title">
					<a href="${pageContext.request.contextPath}/product/view.do?id=${product.productId}">
					${product.productName}</a>
				</h4>
				<h5 style="text-decoration:line-through red">${product.productPrice}원</h5>
				<h5 id="combinePrice_${st.index}">${product.productPrice*(100-product.discountRate)*0.01}</h5>
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

</body>
</html>