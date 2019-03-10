<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
</head>
<body>
	
<!-- Admin Main Page Category Content -->
<div id="adminMainPageCategory" class="list-group m-2 text-center">
	
	<div class="my-2">
		<a class="btn btn-secondary w-100" href="${path}/sm/">쇼핑몰 이동</a>
	</div>
	
	<!-- Test1 -->
	<a id="memberPurchaseAllList" href="${path}/sm/admin/purchase.do" class="list-group-item">
		<button type="button" class="btn btn-link" data-toggle="collapse"
			data-target="#demo1">Test1</button>
	</a>
	
	<!-- Test2 -->
	<a id="memberAllList" href="${path}/sm/admin/allMember.do" class="list-group-item">
		<button type="button" class="btn btn-link" data-toggle="collapse"
			data-target="#demo1">Test2</button>
	</a>
	
	<!-- Test3 -->
	<div id="productAllList" class="list-group-item">
	
		<!-- Test3 -->
		<button type="button" class="btn btn-link" data-toggle="collapse"
			data-target="#demo2">Test3</button>
			
	</div>
	
	<!-- Test4 -->
	<a id="productRegisteration" href="${path}/sm/admin/registrationPage.do" class="list-group-item">
		<button type="button" class="btn btn-link" data-toggle="collapse"
			data-target="#demo3">Test4</button>
	</a>
	
</div>	

</body>
</html>