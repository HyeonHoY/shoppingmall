<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- jstl 코어 태그 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- context경로 -->
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
      <div class="container">
        <a class="navbar-brand" href="${path}/sm/admin/admin.do?num=1">관리자 페이지</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
          	
            <li class="nav-item active">
	            <c:choose>
		            <c:when test="${sessionScope.id == null}">
		            <a class="nav-link" href="${path}/sm/login/login.do?num=1">로그인</a>
		            </c:when>
		            <c:otherwise>
		            <a class="nav-link" href="${path}/sm/login/info_pwCheck.do">${sessionScope.id}</a>
		            </c:otherwise>
	            </c:choose>
            </li>
            <li class="nav-item active">
	            <c:choose>
		            <c:when test="${sessionScope.id != null}">
		            <a class="nav-link" href="${path}/sm/login/logout.do">로그아웃</a>
		            </c:when>
	            </c:choose>
            </li>
            
            <!-- admin 로그인 시 fa fa-cog-->
            <c:if test="${sessionScope.role == 'role_admin'}">
	            <li class="nav-item active">
	              <a class="nav-link" href="${path}/sm/admin/admin.do?num=1">
	              <i class="fa fa-cog"></i>&nbsp;관리</a>
	            </li>	
            </c:if>
            <!-- admin 로그인 시 -->
            	
            <!-- 회원 로그인 성공시 -->
            <c:if test="${sessionScope.role != 'role_admin'}">
	            <li class="nav-item">
	              <a class="nav-link" href="#">서비스</a>
	            </li>	
            </c:if>
            
            <c:if test="${sessionScope.role != 'role_admin'}">
	            <li class="nav-item">
	              <a class="nav-link" href="#">연락처</a>
	            </li>	
            </c:if>
            
            <c:if test="${sessionScope.role != 'role_admin'}">
	            <li class="nav-item">
	              <a class="nav-link" href="${path}/sm/cart/cart.do">
	              	<i class="fas fa-shopping-cart"><span class="badge badge-danger" 
	              	   style="position:relative; right:8px; bottom:11px;">7</span>
	              	</i>장바구니</a>
	            </li>	
            </c:if>
            <!-- 회원 로그인 성공시 -->
          </ul>
        </div>
      </div>
    </nav>
</body>
