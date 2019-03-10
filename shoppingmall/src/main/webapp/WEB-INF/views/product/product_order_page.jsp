<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

$(document).ready(function(){

	$("#address_1").prop("checked", true);
	$("#address_2").prop("checked", false);
	$("#form2").hide();
		
	var totalPrice = 0;
	for(var i=0; i<$("#productSize").val(); i++){
		var price = intChange($("#totalPrice_"+i+""));
		totalPrice += price;
	}
	
	var finalPriceDiv = "<table class='table-bordered col-sm-12 text-center mb-1'>"+
							"<thead>"+
								"<tr>"+
									"<th class='col-sm-4'>총 주문 금액</th>"+
									"<th class='col-sm-4'>총 할인 + 부가결제 금액</th>"+
									"<th class='col-sm-4'>총 결제 예정 금액</th>"+
								"</tr>"+
							"</thead>"+
							"<tbody>"+
								"<tr>"+
									"<td>"+addComma(totalPrice)+"원"+"</td>"+
									"<td>0원</td>"+
									"<td>"+addComma(totalPrice)+"원"+"</td>"+
								"</tr>"+
							"</tbody>"+
						"</table>"+
						"<input type='button' value='결제하기' id='paymentExecute'"+
						   "class='btn btn-dark mb-1' style='width:200px; height:50px; float:right;'>";
	
	$("#finalPrice").html(finalPriceDiv);	
	// 주소 방식 선택
	$("input[id^=address_]").change(function(e){
		
		var num = e.target.id.split("_")[1];
		
		// 직접 입력을 선택했을 경우
		if(num == 2){
			$("#address_1").prop("checked", false);
			$("#address_2").prop("checked", true);
			$("#form1").hide();
			$("#form2").show();
		} else {
			$("#address_1").prop("checked", true);
			$("#address_2").prop("checked", false);
			$("#form2").hide();
			$("#form1").show();
		}
	});
	
	
	$("#paymentExecute").on("click", function(){
		
		for(var i=0; i<$("#productSize").val(); i++){
			$("#purchasePrice_"+i+"").val(parseInt($("#purchasePrice_"+i+"").val()));
		}
		
		// 기본 배송지가 선택되었을 경우
		if($("input[id=address_1]:checked").length == 1){
			var form = $("#form1, #orderListForm").serialize();
			// var form = $("#form1");
// 			console.log(form[0]);
// 			console.log($("#orderListForm")[0]);
			
			$.ajax({
				
				url : '${pageContext.request.contextPath}/product/buyProduct.do',
				type : 'post',
				data : form,
				
				success : function(data) {
					
					if(data == "success") {
						alert("주문이 완료되었습니다!");
						location.href="${pageContext.request.contextPath}/home"
					}
				}, 
				error : function(xhr, status){
					alert("error");
				}
				
			}); // ajax
			
		}  else {
			var form = $("#form2");
			form.submit();
		}
	}); 
	
}); // end
</script>
</head>
<body>
<input type='hidden' id="productSize" value="${productList.size()}">
<div class="row mt-3">
	<div class="mx-auto">
		<p class="mb-5" style="border-bottom:1px solid gray;">ORDER FORM</p>
	</div>
</div>
<form name="orderListForm" 
	  method="post" 
	  action="${pageContext.request.contextPath}/product/buyProduct.do" 
	  id="orderListForm"
	  style="border-bottom : 1px solid gray; margin-bottom:20px;">
	  
	<table class="table col-sm-12 text-center " >
		<thead>
			<tr>
				<th>상품/옵션 정보</th>	
				<th>수량</th>	
				<th>상품금액</th>
				<th>할인금액</th>
				<th>할인적용금액</th>
				<th>배송비</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${productList}" var="product" varStatus="st">
			<tr>
				<td class="col-sm-3">
					<img src='<c:url value="/product/${product.productId}/thumbnail/${product.productTitleImg}"/>'
						 width="100px" style="float:left;">
					<div id="productName" class="pt-4">${product.productName}</div>
					<input type="hidden" name="productId" value="${product.productId}">
				</td>
				<td>
					<div id="purchaseCount" class="pt-4">${orderList[st.index].purchaseCount}개</div>
					<input type="hidden" name="purchaseCount" value="${orderList[st.index].purchaseCount}">
				</td>
				<td>
					<div class="pt-4">
					<fmt:formatNumber value="${product.productPrice*orderList[st.index].purchaseCount}"
									  pattern="#,###"  />원
					</div>
				</td>
				<td>
					<div class="pt-4">
					<fmt:formatNumber value="${product.productPrice*product.discountRate*0.01*orderList[st.index].purchaseCount}"
									  pattern="#,###" />원
					</div>
				</td>
				<td id="totalPrice_${st.index}">
					<div class="pt-4">
					<fmt:formatNumber value="${product.productPrice*(100-product.discountRate)*0.01*orderList[st.index].purchaseCount}" 
					 				  pattern="#,###" />원
					</div>
					<input type="hidden" name="purchasePrice" id="purchasePrice_${st.index}"
						   value="${product.productPrice*(100-product.discountRate)*0.01*orderList[st.index].purchaseCount}">
				</td>
				<td><div class="pt-4">공란</div></td>
			</tr>
		</c:forEach>	
		</tbody>
	</table>
	</form>
		
	<div><pre><b>배송지 정보</b></pre></div>	
	<div class="form-inline border border-secondery border-bottom-0" style="height:50px; font-size:12px;">
		<div class="col-sm-1" style="text-align:center;"><b>배송지 선택</b></div>&nbsp;
		<input type="radio" id="address_1">기본 배송지&nbsp;&nbsp;&nbsp;
		<input type="radio" id="address_2">직접 입력
	</div>	
	
	
	<!-- 기본 배송시 -->
	<form id="form1" 
		  name="form1" 
		  method="post" 
		  action="${pageContext.request.contextPath}/product/buyProduct.do"
		  class="mb-3"
		  style="border-bottom : 1px solid gray; margin-bottom:20px; padding-bottom:30px;">
		  
		<table class="table-bordered col-sm-12" style="font-size:12px;">
			<tr>
				<th style="" class="col-sm-1">받으시는 분</th>
				<td>
					<input type="hidden" id="id" name="id" value="${member.id}">
					<input type="text" id="name" name="name" readonly="readonly" value="${member.name}" style="border:none">
				</td>
			</tr>
			<tr>
				<th style="text-align:center">핸드폰 번호</th>
				<td>
					<input type="text" id="phone" readonly="readonly" name="phone" value="${member.phone}" style="border:none">
				</td>
			</tr>
			<tr>
				<th style="text-align:center">주소</th>
				<td>
					<input type="text" id="address" name="address" value="${member.address}" 
							style="border:none; width:100%" readonly="readonly">
				</td>
			</tr>
			<tr>
				<th style="text-align:center">배송 시 요구사항</th>
				<td>
					<textarea rows="10" cols="99" id="call_massage" name="call_massage"></textarea>
				</td>
			</tr>
		</table>
	</form>
	
	
	<!-- 직접 입력시 -->
	<form id="form2" 
		  name="form2" 
		  method="post" 
		  action="${pageContext.request.contextPath}/product/buyProduct.do"
		  class="mb-3"
		  style="border-bottom : 1px solid gray; margin-bottom:20px;">
		  
		<table border="1" class="col-sm-12">
			<tr>
				<th style="text-align:center" class="col-sm-1">받으시는 분</th>
				<td>
					<input type="hidden" id="id" name="id" value="${member.id}">
					<input type="text" id="name" name="name">
				</td>
			</tr>
			<tr>
				<th style="text-align:center">핸드폰 번호</th>
				<td>
					<input type="text" id="phone" name="phone">
				</td>
			</tr>
			<tr>
				<th style="text-align:center">주소</th>
				<td>
					<input type="text" id="address" name="address">
				</td>
			</tr>
			<tr>
				<th style="text-align:center">배송 시 요구사항</th>
				<td>
					<textarea rows="10" cols="99" id="call_massage" name="call_massage"></textarea>
				</td>
			</tr>
		</table>
	</form>
	
	<div><pre><b>결제 예정 금액</b></pre></div>
	<div id="finalPrice"></div>
	
</body>
</html>