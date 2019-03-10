<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<!-- Admin Main Page Category Content -->
<div id="adminMainPageCategory" class="list-group m-2 text-center">
	
	<div class="my-2">
		<a class="btn btn-secondary w-100" href="${path}/sm/">쇼핑몰 이동</a>
	</div>
	
	<!-- 상품목록 -->
	<a id="memberPurchaseAllList" href="${path}/sm/admin/adminProductList.do?num=4" 
	   class="list-group-item">
		<button type="button" class="btn btn-link" data-toggle="collapse"
				data-target="#demo1">상품목록</button>
	</a>
	
	<!-- 상품등록 -->
	<a id="memberAllList" href="${path}/sm/admin/registrationPage.do" class="list-group-item">
		<button type="button" class="btn btn-link" data-toggle="collapse"
				data-target="#demo1">상품등록</button>
	</a>
	
	<!-- Test3 -->
	<div id="productAllList" class="list-group-item">
	
		<!-- Test3 -->
		<button type="button" class="btn btn-link" data-toggle="collapse"
				data-target="#demo2">상품카테고리</button>
			
	</div>
	
	<!-- Test4 -->
	<a id="productRegisteration" href="${path}/sm/admin/registrationPage.do" class="list-group-item">
		<button type="button" class="btn btn-link" data-toggle="collapse"
			data-target="#demo3">상품카테고리</button>
	</a>
	
</div>	
</body>
</html>