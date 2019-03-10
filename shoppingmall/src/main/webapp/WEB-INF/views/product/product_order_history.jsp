<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 내역</title>
<style>
td {
	width:150px;
	
}
</style>
</head>
<body>
<div class="row mt-3">
	<div class="mx-auto">
		<p class="mb-5" style="border-bottom:1px solid gray;">ORDER LIST</p>
	</div>
</div>

	<input type="hidden" id="purchaseCount" value="${count}">
	<table class="table-bordered col-sm-12 text-center mb-5">
		<thead>
			<tr>
				<th>구매 일자</th>
				<th>상품 이미지</th>
				<th>상품명</th>
				<th>구매 개수</th>
				<th>상품 가격</th>
				<th>주문 번호</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${orders}" var="order" varStatus="st">
			<tr>
				<td id="paymentDate" >${order.paymentDate}</td>
				<td id="productImg">
					<a href="${pageContext.request.contextPath}/product/view.do?id=${order.productId}">
						<img src="<c:url value='/product/${products[st.index].productId}/thumbnail/${products[st.index].productTitleImg}'/>" width="100">
					</a>
				</td>
				<td id="productName">
					${products[st.index].productName}
				</td>
				<td id="purchaseCount">
					<div id="tempCount_${st.index}">${order.purchaseCount}개</div>
				</td>
				<td><fmt:formatNumber value="${order.purchasePrice}" pattern="#,###"/>원</td>
				
				
				<td id="orderNum_${st.index}">${order.orderNum}번</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<div class="row">
		<div id="totalPrice" class="my-5"> </div>
	</div>
</body>
</html>