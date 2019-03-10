<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(document).ready(function(){
		
		var tempTotal = 0;
		var tempCount = 0;
		var paymentReady = 0;
		var paymentReadyPrice = 0;
		// alert($("#purchaseCount").val());
		
		for(var i=0; i<$("#purchaseCount").val(); i++) {
			// alert($("#tempTotal_"+i+"").text());
			tempTotal += parseInt($("#tempTotal_"+i+"").text());
			tempCount += parseInt($("#tempCount_"+i+"").text());
			if($.trim($("td[id=deliveryTd_"+i+"]").text()) == 'n') {
				paymentReady++;
				paymentReadyPrice += parseInt($("#tempTotal_"+i+"").text());
			} // if
		}// for
		
		$("div[id=totalPrice]").html(
			"총 주문 개수 : "+$("#purchaseCount").val()+"개<br>"+
			"총 매출은 "+tempTotal+"원 이고 총 "+tempCount+"개 판매 되었습니다.<br>"+
			"현재 배송 준비중인 물품은 "+"<span id='paymentReadySpan'>"+paymentReady+"</span>"+"개 입니다.<br>"+
			"배송 준비중인 총가격 : "+"<span id='paymentReadyPrice'>"+paymentReadyPrice+"</span>원"
			// "배송 완료된 물품들의 총 가격은 "+tempTotal+"원 이고 총 "+tempCount+"개 판매 되었습니다.<br>"+
		);
		
		//alert("paymentReady = "+paymentReady);
		
		// deliveryTd_
		// $("input[id^=deliveryBtn_]").click(function(e){
		$("td[id^=deliveryTd_]").on('click', 'input[id^=deliveryBtn_]', function(e){
			var num = e.target.id.split("_")[1];
			alert("num = "+num);
			
			var delivery = $.trim($("td[id=deliveryTd_"+num+"]").text());
			delivery == 'y' ? (delivery = 'n') : (delivery='y'); 
			
			console.log("delivery = "+delivery);
			
			$.ajax({
				type : 'get',
				url : '${pageContext.request.contextPath}/admin/updateDelivery.do',
				data : {
					orderNum : parseInt($("#orderNum_"+num+"").text()),
					delivery : delivery
				},
				success : function(data){
					// 업데이트를 성공했을 경우
					if(data=='success') {
						if(delivery == 'y') {
							$("td[id=deliveryTd_"+num+"]").html(
								delivery+'<input type="button" id="deliveryBtn_'+num+'" value="배송취소">&nbsp;'
							);
							$("#paymentReadySpan").text(parseInt($("#paymentReadySpan").text()-1));
							$("#paymentReadyPrice").text(parseInt($("#paymentReadyPrice").text()-$("#tempTotal_"+num+"").text()));
							
						} else {
							$("td[id=deliveryTd_"+num+"]").html(
								delivery+'<input type="button" id="deliveryBtn_'+num+'" value="배송하기">&nbsp;'
							);
							$("#paymentReadySpan").text(parseInt($("#paymentReadySpan").text())+1);
							$("#paymentReadyPrice").text(parseInt($("#paymentReadyPrice").text())+parseInt($("#tempTotal_"+num+"").text()));
						} // if
					} // if
				}, // success
				error : function(xhr, status){
					alert("erorr");
				}
			});
		}); // click
		
	}); // end
</script>
</head>
<body>
	<%-- ${order} --%>
	<h1 align="center">현재 주문 현황</h1>
	<input type="hidden" id="purchaseCount" value="${count}">
	<table class="table table-hover">
		<thead>
			<tr class="col-sm-12">
				<th>구매자</th>
				<th>상품 아이디</th>
				<th>구매 개수</th>
				<th>상품 가격</th>
				<th>총 구매 가격</th>
				<th>구매 일자</th>
				<th>주문 번호</th>
				<th>휴대폰 번호</th>
				<th>배송지</th>
				<th>배송 유무</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${order}" var="order" varStatus="st">
			<tr>
				<td>${order.id}</td>
				<td>${order.productId}</td>
				<td><div class="form-inline"><div id="tempCount_${st.index}">${order.purchaseCount}</div>개</div></td>
				<td>${order.purchasePrice}원</td>
				<td>
					<div class="form-inline">
						<div id="tempTotal_${st.index}">${order.purchasePrice*order.purchaseCount}</div>원
					</div>
				</td>
				<td>${order.paymentDate}</td>
				<td id="orderNum_${st.index}">${order.orderNum}번</td>
				<td>${member[st.index].phone}</td>
				<td>${member[st.index].address}</td>
				<td id="deliveryTd_${st.index}">${order.delivery}
					<c:choose>
						<c:when test="${order.delivery == 'n'}">
							<input type="button" id="deliveryBtn_${st.index}" value="배송하기">
						</c:when>
						<c:otherwise>
							<input type="button" id="deliveryBtn_${st.index}" value="배송취소">
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>	
	<div id="totalPrice"></div>
</body>
</html>