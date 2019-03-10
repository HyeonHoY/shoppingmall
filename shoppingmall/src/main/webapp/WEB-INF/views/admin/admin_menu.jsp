<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

  <!-- 관리자 메뉴 -->
  <ul class="nav nav-tabs mt-1" role="tablist" style="font-size:24px">
    <li class="nav-item">
      <a id="orderAdministration" class="nav-link"
      	 href="${path}/sm/admin/orderList.do?num=2">주문관리</a>
    </li>
    <li class="nav-item">
      <a id="memberAdministration" class="nav-link"
      	 href="${path}/sm/admin/allMember.do?num=3">회원관리</a>
    </li>
    <li class="nav-item">
      <a id="productAdministration" class="nav-link"
      	 href="${path}/sm/admin/adminProductList.do?num=4">상품관리</a>
    </li>
    <li class="nav-item">
      <a id="productAdministration" class="nav-link"
      	 href="${path}/sm/admin/test.do?num=5">test</a>
    </li>
  </ul>
  
</body>
</html>