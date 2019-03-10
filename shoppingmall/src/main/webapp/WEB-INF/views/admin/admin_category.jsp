<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
</head>
<body>

<!-- Admin Main Page -->
<c:if test="${num==1}">
	<%@ include file="../admin/main/admin_main_category.jsp"%>
</c:if>

<c:if test="${num==2}">
	<%@ include file="../admin/order/admin_order_category.jsp"%>
</c:if>

<c:if test="${num==3}">
	<%@ include file="../admin/member/admin_member_category.jsp"%>
</c:if>

<c:if test="${num==4}">
	<%@ include file="../admin/product/admin_product_category.jsp"%>
</c:if>

<c:if test="${num==5}">
	<%@ include file="../admin/test/test_category.jsp"%>
</c:if>
	
</body>
</html>