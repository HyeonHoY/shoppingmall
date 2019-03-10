<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-template.jspf" %>
</head>
<body>

	<!-- adminLayout -->
	<!-- adminPageTitle -->
	<div id="adminHeader">
		<tiles:insertAttribute name="adminHeader" />
	</div>
	
	<!-- menu -->
	<div id="menu">
		<tiles:insertAttribute name="menu" />
	</div>
	
	<!-- main body  -->
	<div id="mainBodyWrapper" class="row mx-auto">
	
		<!-- category -->
		<div class="col-lg-2">
		<tiles:insertAttribute name="category" />
		</div>
		
		<!-- body content -->
		<div class="col-lg-10">
			<tiles:insertAttribute name="admin" />
		</div>
	</div><!-- mainWrapper -->
	
</body>
</html>