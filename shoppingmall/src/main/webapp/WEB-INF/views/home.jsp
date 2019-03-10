<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
	if($("#msg").val() == "cart insert fail"){
		alert("이미 존재하는 상품 입니다.");
		location.href="${pageContext.request.contextPath}/product/detail/${productId}";
	}
});
</script>	
</head>
<body>
	<input type="hidden" id="msg" value="${msg}">
</body>
</html>
