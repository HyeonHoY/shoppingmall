<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>

<!-- Admin Member Page Category Content -->
<div id="adminMainPageCategory" class="list-group m-2 text-center">
	
	<div class="my-2">
		<a class="btn btn-secondary w-100" href="${path}/sm/">쇼핑몰 이동</a>
	</div>
	
	<!-- Test1 -->
	<a id="memberPurchaseAllList" href="${path}/sm/admin/allMember.do" class="list-group-item">
		<button type="button" class="btn btn-link" data-toggle="collapse"
			data-target="#demo1">회원목록</button>
	</a>
	
	<!-- Test2 -->
	<a id="memberAllList" href="${path}/sm/admin/allMember.do" class="list-group-item">
		<button type="button" class="btn btn-link" data-toggle="collapse"
			data-target="#demo1">상품구매회원목록</button>
	</a>
</div>

</body>
</html>