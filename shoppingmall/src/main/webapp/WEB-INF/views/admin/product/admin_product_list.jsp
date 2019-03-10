<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 전체 보기</title>
<script>
$(document).ready(function(){
	
	// 이전에 수정버튼을 눌렀는 지의 유무를 확인하는 변수
	var rowActive = -1;
	
	// $("input[id^=updateBtn_]").click(function(e){
	$(document).on('click', 'input[id^=updateBtn_]', function(e){	
	
		var num = e.target.id.split("_")[1];
		var discountHidden = $("#discountHidden_"+num+"").val();
		var stockHidden = $("#stockHidden_"+num+"").val();
		console.log("rowActive = "+rowActive);
		
		// 이전에 수정 버튼을 눌렀을 경우
		if(rowActive != -1){
			$("#execute").attr({value :  '수정', id : "updateBtn_"+rowActive+""});
			// $("#priceTd_"+rowActive+"").html($("#priceHidden_"+rowActive+"").val()+"원");
			$("#discountTd_"+rowActive+"").html($("#discountHidden_"+rowActive+"").val()+"%");
			$("#stockTd_"+rowActive+"").html($("#stockHidden_"+rowActive+"").val()+"개");
		}
		// alert("num = "+num);
		// $("#updateBtn_"+num+"").attr({'value' :  '수정하기', 'id' : 'execute'});
		$("#updateBtnTd_"+num+"").html("<input type='button' id='execute' value='수정하기'>");
		// $("#priceTd_"+num+"").html("<input type='text' id='priceInput_"+num+"' value='"+$("#priceHidden_"+num+"").val()+"'>");
		// $("#priceInput_"+num+"").css({"width" : 100, "text-align" : "center"});
		
		$("#discountTd_"+num+"").html("<input type='number' value='"+discountHidden+"' id='discountInput_"+num+"' min='0' step='5' max='100'>");
		$("#discountInput_"+num+"").css("width", 50);
		
		$("#stockTd_"+num+"").html("<input type='number' id='stockInput_"+num+"' value='"+stockHidden+"' min='0'>");
		$("#stockInput_"+num+"").css({"text-align" : "center", "width" : 80});
		
		rowActive = num; 
	}); // clcik
	
	$(document).on('click', "input[id=execute]", function(){
		// alert("test");
		// console.log("price = "+$("#priceInput_"+rowActive+"").val());
		// console.log("discount = "+$("#discountInput_"+rowActive+"").val());
		// console.log("stock = "+$("#stockInput_"+rowActive+"").val());
		
		// var price = $("#priceInput_"+rowActive+"").val();
		var discount = $("#discountInput_"+rowActive+"").val()-$("#discountHidden_"+rowActive+"").val();
		// var discount = $("#discountInput_"+rowActive+"").val();
		// alert(discount);
		var rowStock = $("#stockInput_"+rowActive+"").val();
		var stock = $("#stockInput_"+rowActive+"").val()-$("#stockHidden_"+rowActive+"").val();
		
		// if
		if(// price == $("#priceHidden_"+rowActive+"").val() && 
		   discount == $("#discountHidden_"+rowActive+"").val() &&
		   rowStock == $("#stockHidden_"+rowActive+"").val()){
			alert("가격 또는 할인률 또는 수량이 바뀌어야 가능합니다.");
			
		} else {
			$.ajax({
				
				type : 'get',
				url : '${pageContext.request.contextPath}/admin/productUpdate.do',
				data : {
					productId : $("#productId_"+rowActive+"").val(),				
					discountRate : discount,
					productStock : stock
				},
				success : function(data){
					alert("success");			
					$("#updateBtnTd_"+rowActive+"").html("<input type='button' value='수정' id='updateBtn_"+rowActive+"'>")
					$("#discountTd_"+rowActive+"").html(data[0]+"%");
					$("#discountHidden_"+rowActive+"").attr("value", data[0]);
					
					$("#stockTd_"+rowActive+"").html(data[1]+"개");
					$("#stockHidden_"+rowActive+"").attr("value", data[1]);
					
					var discountPrice = (100-parseInt(data[0]))*parseInt($("#priceTd_"+rowActive+"").text())*0.01;
					
					$("#discountPrice_"+rowActive+"").html(discountPrice+"원");
				}, 
				error : function(xhr, status){
					alert("error");
				}
			});
			
		}
		
		
	}); // click
}); // end
</script>
</head>
<body>
<h1>상품 리스트</h1>

<c:if test="${empty productList}">
	<div id="emptyProductList" class="mt-3">
		등록된 상품이 없습니다.
	</div>
</c:if>

<div class="row mx-auto">
<table style="text-align: center;" class="table table-hover"> 
	<thead>
		<tr>
			<th>상품 이미지</th>
			<th>상품 이름</th>
			<th>상품 등록 날짜</th>
			<th>상품 가격</th>
			<th>현재 할인률</th>
			<th>할인 후 가격</th>
			<th>총 주문 갯수</th>
			<th>남은 수량</th>
			<th>상품 수정하기</th>
		</tr>
	</thead>
	<c:forEach var="product" items="${productList}" varStatus="st">
	<%-- <input type="hidden" id="priceHidden_${st.index}" value="${product.productPrice}"> --%>
	<input type="hidden" id="discountHidden_${st.index}" value="${product.discountRate}">
	<input type="hidden" id="stockHidden_${st.index}" value="${product.productStock}">
	<input type="hidden" id="productId_${st.index}" value="${product.productId}">
	<tbody id="productTbody_${st.index}">
		<tr>
			<td>
				<img width="100" src="<c:url value='/product/${product.productId}/thumbnail/${product.productTitleImg}'/>">
			</td>
			<td>아이디 : ${product.productId}<br>이름 : ${product.productName}</td>
			<td>${product.productDate}</td>
			<td id="priceTd_${st.index}">${product.productPrice}원</td>
			<td id="discountTd_${st.index}">
				${product.discountRate}%
			</td>
			<td id="discountPrice_${st.index}"><fmt:formatNumber value="${product.productPrice*(100-product.discountRate)*0.01}" 
						  						  pattern="#,###"/>원</td>
			<td>${product.orderCount}개</td>
			<td id="stockTd_${st.index}">
				${product.productStock}개</td>
			<td id="updateBtnTd_${st.index}"><input type="button" id="updateBtn_${st.index}" value="수정"></td>
		</tr>
	</tbody>
	</c:forEach>	
	
	
</table>
	
</div>

</body>
</html>