<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style>
input#purchasePrice, #productId {
	border : 0;
}

#purchaseCount {
	width : 50px; 
	text-align : center; 
	font-size : 12px;
}

ul {
	list-style:none;
	padding-left:0;
}

h3 {
	border-bottom : 1px dotted gray;
	padding-bottom : 10px;
}
</style>
<script>
$(document).ready(function(){
	
	// review img 가공
	for(var i=0; i<$("#review_count").val(); i++){
		// console.log($("#boardFile_"+i+"").val().length);
		
		if($("#boardFile_"+i+"").val().length > 4){
			$("#boardFile_"+i+"").val($("#boardFile_"+i+"").val().split("?")[0]);
			$("#img_"+i+"").html(
				"<img src='${pageContext.request.contextPath}/image/"+$("#reviewNum_"+i+"").val()+'번 게시물/'+$("#boardFile_"+i+"").val()+"' width='50'>"
			);
		}
	}
	
	// inquiry img 가공
	for(var i=0; i<$("#inquiry_count").val(); i++){
		// console.log($("#inquiryFile_"+i+"").val().length);
		
		if($("#inquiryFile_"+i+"").val().length > 4){
			// alert("d");
			$("#inquiryFile_"+i+"").val($("#inquiryFile_"+i+"").val().split("?")[0]);
			$("td[id=inquiryImg_"+i+"]").html(
				"<img src='${pageContext.request.contextPath}/image/"+$("#inquiryNum_"+i+"").val()+'번 게시물/'+$("#inquiryFile_"+i+"").val()+"' width='50'>"
			);
		}
	}
	
	// 기존 html에서 0으로 해놓으면 새로고침 했을 때 값이 0으로 바뀌어 버리는 문제를 해결하기 위한 함수
	$("#totalB").html(parseInt($("#purchasePrice").text().trim().replace(",", ""))*$("#purchaseCount").val());
	
	var price = parseInt($("#purchasePrice").text().trim().replace(",", ""));
	
	$("#purchaseCount").change(function(){

		var count = $("#purchaseCount").val();
		
		$("#totalB").html(price*count);
	});
	
	
	$("a").on('click', function(e){
		
	      if (this.hash !== "") {
	    	  
	          event.preventDefault();

	          var hash = this.hash;

	          $('html, body').animate({
	            scrollTop: $(hash).offset().top
	          }, 1, function(){
	       
	            window.location.hash = hash;
	          });
	        } // End if
	});
	
	// 구매하기
	$("#buyButton").click(function(){

		if($("#purchaseCount").val() > 0){
			$("#buyProductForm").append("<input type='hidden' name='purchasePrice' value='"+price+"'>");
			$("#buyProductForm").submit();	
		} else {
			alert("구매 시 수량은 1개 이상이여야 구매하실 수 있습니다.");
		}
		
	});
	
	// 장바구니
	$("#cartButton").click(function(){
		
		alert("장바구니 페이지 이동!");
		
		 if($("#purchaseCount").val() == 0){
			alert("구매할 개수는 1개 이상이여야 합니다.");
		} else {
			var form = $("#buyProductForm")[0];
			form[0].name = "memberId";
			form[2].name = "cartCount";
			form[2].value = parseInt(form[2].value);
			form.action = '${pageContext.request.contextPath}/cart/insert.do';
			form.submit();
			console.log(form);
		} 
	});
	
	// 비밀글을 클릭하였을 때
	$("a[id^=reviewSecret_]").click(function(e){
		// alert("test");
		
		var num = e.target.id.split("_")[1];
		
		var checkPw = prompt("비밀번호를 입력하세요.");
		// alert("check = "+checkPw);
		
		$.ajax({
			
			type:'post',
			url:'${pageContext.request.contextPath}/board/checkBoardPage.do',
			
			data: {
				checkPw : String(checkPw),
				boardNum : parseInt($("#reviewNum_"+num+"").val())
			},
			
			success : function(data){
				// alert(data);
				
				if(data != "실패"){
					location.href="${pageContext.request.contextPath}/board/view.do?boardNum="+$("#reviewNum_"+num+"").val()+"&productId="+$("#productId").val();
				} else {
					alert("비밀번호가 일치하지 않습니다!");
				}
			},
			
			error : function(xhr, status){
				alert("error");
			}
			
		});// ajax
	}); // click
	
	// review 게시판
	$("#reviewWrite").click(function(){
		// alert("Test");
		
		// console.log($("#productId").val());
		
		location.href="${pageContext.request.contextPath}/board/write.do/boardKinds/2/product/"+$("#productId").val()+"";
	});
	
	// Q&A 게시판
	$("#QnA").click(function(){
		alert("test");
		location.href="${pageContext.request.contextPath}/board/write.do/boardKinds/3/product/"+$("#productId").val()+"";
	});
	
});// end
</script>
</head>
<body>
<div id="productDetailWrapper" class="m-3">
	<form id="buyProductForm" 
		  method="post"
		  class="form-inline mx-auto mb-2"
		  action="${pageContext.request.contextPath}/product/productOrderPage.do">
	     
		<input type="hidden" name="id" value="${sessionScope.id}">
	
		<div id="productTitleImg" class="col-lg-5 border border-secondery p-4 mx-5">
			<img src='<c:url value="/product/${product.productId}/${product.productTitleImg}" />'
				 height="450" class="w-100">
		</div>
		
		<div id="productInfomation" class="col-lg-5 mx-5" style="height:500px;">
			
			<!-- 상품명 -->
			<div id="productName" 
				 class="border border-secondery border-right-0 border-left-0 text-center py-1 mb-3
				 		bg-light">
				${product.productName}
			</div>
			
			<!-- 판매가 -->
			<table id="" class="mx-2 mb-3" style="font-size:12px;">
			  <tr>
			  	<th style="width:120px;">판매가</th>
				<td>
				  <div class="form-inline">
				  	<c:choose>
				  		<c:when test="${product.discountRate == null}">
						  	<div style="text-decoration:line-through red;">${product.productPrice}</div>&nbsp;
						  	<div id="purchasePrice">
						  		<fmt:formatNumber value="${product.productPrice*(100-product.discountRate)*0.01}" 
						  						  pattern="#,###"/>
						  	</div>원
					  	</c:when>
					  	<c:otherwise>
						  	<div id="purchasePrice">
						  		<fmt:formatNumber value="${product.productPrice}" pattern="#,###"/>
						  	</div>원
					  	</c:otherwise>
				  	</c:choose>
				  </div>
				</td>
			  </tr>
			  <tr>
			  	<th>적립금</th>
			  	<td>
			  		추후 업데이트 예정
			  	</td>
			  </tr>
			</table>
			
			<div id="purchaseCountWrapper" 
				 class="border border-secondery border-right-0 border-left-0 mx-auto 
				 		form-inline col-lg-12 py-3">
				 
				<div class="col-lg-5 ml-5">
					${product.productName}
					<input type="text" id="productId" readonly="readonly"
				   		   name="productId" value="${product.productId}">
				</div>
			
				<div class="col-lg-5">
					<b style="font-size:12px;">구매할 개수 :</b>
					<input type="number" min="0" max="${product.productStock}" value="0"
						   id="purchaseCount" name="purchaseCount">
				</div>
			</div>
			
			<div class="row ml-2 my-2">
				<b style="padding-top:14px; margin-right:10px;">총 상품 금액(수량)&nbsp;:</b>
				<div style="font-size:28px; "><b id="totalB"></b>원</div>
			</div>
			
			<input type="button" id="buyButton" class="btn btn-dark mr-1" 
				   value="구매하기" style="width:159px;">
			<input type="button" id="cartButton" class="btn btn-outline-dark mr-1"
				   value="장바구니" style="width:159px;">
			<input type="button" id="wishButton" class="btn btn-outline-dark" 
				   value="찜하기" style="width:159px;"> 
		</div>
	</form>
	
	
	<!-- 상품 상세정보 -->
	<div id="productDetailBar" class="row border border-secondery border-right-0 border-left-0 m-5">
		<div class="mx-auto cont" >
			<a href="#productDetailBar" class="btn text-dark">상품 상세정보</a>/
			<a href="#productPurchaseExplainBar" class="btn text-dark">상품 구매안내</a>/
			<a href="#productReview" class="btn text-dark">상품 사용후기</a>/
			<a href="#productQnA" class="btn text-dark">상품 Q&amp;A</a>
		</div>
	</div>
	
	<div id="explainImg" class="m-5">
		<img src='<c:url value="/product/${product.productId}/${product.productExplainImg}" />'
			 class="w-100">
	</div>
	
	
	<!-- 상품 구매안내 -->
	<div id="productPurchaseExplainBar" 
		 class="row border border-secondery border-right-0 border-left-0 m-5">
		<div class="mx-auto cont" >
			<a href="#productDetailBar" class="btn text-dark">상품 상세정보</a>/
			<a href="#productPurchaseExplainBar" class="btn text-dark">상품 구매안내</a>/
			<a href="#productReview" class="btn text-dark">상품 사용후기</a>/
			<a href="#productQnA" class="btn text-dark">상품 Q&amp;A</a>
		</div>
	</div>
	
	<div id="productPurchaseExplain" class="m-5">
		<div id="explainWrapper" class="m-auto w-100 py-4" style="border:3px double #eaeaea;" >
            <div style="width:95%; margin:0 auto;">
            
            	<!-- 상품결제정보 -->
                <div class="cont mb-5">
                    <h3>상품결제정보</h3>
                    - 무통장 입금
					<div>- 실시간 계좌이체</div>
					<div>- 카드 결제</div>
					<div>- 핸드폰 결제</div>
					<div>- 네이버 페이</div>
					<div><br></div>
					<div>- <b>적립금</b></div>
					<div>
						주문으로 발생한 적립금은 배송완료 체크시점으로 부터<font color="#ff0000"> 20일</font>
						이 지나야 실제 사용 가능 적립금으로 변환됩니다.<br><br>
					</div>                
				</div>
				
				
				<!-- 배송정보 -->
                <div class="cont mb-5">
                    <h3>배송정보</h3>
                    <ul class="delivery">
						<li class="mb-2">배송 방법 : 택배</li>
                        <li class="mb-2">배송 지역 : 전국지역</li>
                        <li class="mb-2">배송 비용 : 2,500원</li>
                        <li class="mb-2">배송 기간 : 2일 ~ 7일</li>
                        <li>
	                        <div><br></div>
	                        <div><b>배송안내</b></div>
	                        <div><b><br></b></div> 
	                        <div>
	                        	-<font color="#ff0000">5만원 이상</font> 
								결제시 배송비(2500원)는 무료이며, <font color="#ff0000">5만원 미만</font>
								의 경우 배송비(2500원)가 추가됩니다.
	                        </div>
	                        
	                        <div>-CJ택배로 발송되며, 결제일을 기준으로 평균 2~4일 이내에 상품이 준비되어 발송됩니다.</div>
	                        <div><br></div>
	                        <div><b>택배 발송</b></div>
	                        <div><b><br></b></div>
	                        <div>- 19:00까지 결제 완료된 주문건에 한하여 거래처에 입고 요청이 되고&nbsp;
	                        	<span style="font-size: 9pt;">다음날 오전에 입고되어 발송됩니다.</span>
	                        </div>
	                        
	                        <div>- 택배배송 업무시간은 18:00에 마감되오니 참고하여 주시기 바랍니다.</div>
	                        <div>
	                        	- 주문후 평균적으로 2~3일 소요되며&nbsp;<span style="font-size: 9pt;">
	                        	거래처 사정으로 입고가 지연될 경우 3~14일 정도 소요될 수 있습니다.</span>
	                        </div>
                        </li>
                  	</ul>
				</div>
				
				
				<!-- 교환 및 반품정보 -->
                <div class="cont my-5">
                    <h3>교환 및 반품정보</h3>
                    <div><b>교환 및 반품안내</b></div>
                    <div><b><br></b></div>
                    <div>
                    	- 상품 수령 후 7일 이내 SM&nbsp; Q&amp;A 게시판 또는 고객센터 070-7424-1881 로 접수
                    </div>
                    <div>
                    	- CJ택배 홈페이지를 통해 반품예약 또는 CJ택배 1588 - 1255 으로 접수
                    </div>
                    <div><br></div>
                    <div>
                    	- <b>교환시&nbsp;</b>
                    </div>
                    <div>
                    	&nbsp; 상품 포장안에 왕복 배송비 5000원을 교환/반품신청서에 동봉하여 CJ택배로 착불 발송 (
                    	<span style="font-size: 9pt;">타택사로 발송시 2500원 동봉후 선불로 발송)</span>
                    </div>
                    <div>
                    	&nbsp; &lt;SM과 계약된 CJ택배가 아닌 타택배로 발송된 상품은
                    	<span style="font-size: 9pt;">&nbsp;분실될 경우 SM이 책임지지 않습니다.&gt;</span>
                    </div>
                    <div><br></div>
                    <div>
                    	- <b>환불시</b>
                    </div>
                    <div>
                    	&nbsp; 단일상품 구매 후 환불시 5000원 동봉
                    	<span style="font-size: 9pt;">&nbsp;(환불시 처음 결제해주셨던 택배비 포함하여 환불처리됩니다.)
                    	</span>
                    </div>
                    <div>
                    	&nbsp; 복수상품 구매 후 환불시 반품 상품 제외한 나머지&nbsp;
                    	<span style="font-size: 9pt;">상품의 구매 금액이 </span>
                    	<font color="#ff0000" style="font-size: 9pt;">5만원 미만</font>
                    	<span style="font-size: 9pt;">시 5000원 동봉</span>
                    </div>
                    <div>
                    	&nbsp; 복수상품 구매 후 환불시 반품 상품 제외한 나머지 상품의 구매&nbsp;
                    	<span style="font-size: 9pt;">금액이 </span>
                    	<font color="#ff0000" style="font-size: 9pt;">5만원 이상</font>
                    	<span style="font-size: 9pt;">시 2500원 동봉</span>
                    </div>
                    <div><b><br></b></div>
                    <div><b><br></b></div>
                    <div><b>교환 및 반품이 불가능한 경우</b></div>
                    <div><br></div>
                    <div>
                    	- 반품 기간이 지난 상품(상품 수령 후 7일이 경과한 상품)
                    </div>
                    <div>
                    	- 고객의 부주의로 인해 제품의 변형이나 훼손,오염,파손 등으로 인해
                    	<span style="font-size: 9pt;">&nbsp;재화의 가치가 떨어진 경우</span>
                    </div>
                    <div>
                    	- 제품착용의 흔적이 있을 경우 ( 향수, 스킨, 바디로션, 탈취제, 세탁등의 흔적)
                    </div>
                    <div>
                    	- 인위적인 수선이나 세탁으로 인해 업체 반송이 거부될 경우
                    </div>
                    <div>
                    	- 받았던 상태가 아닌 포장 비닐 없이 발송되어 상품이 훼손된 경우
                    </div>
                </div>
                
                
                <!-- 서비스문의 -->
                <div class="cont my-5">
                    <h3>서비스문의</h3>
                </div>
                
            </div>
        </div>
	</div>
	<input type="hidden" id="review_count" value="${reviews.size()}">
	<!-- 상품 사용후기 -->
	<div id="productReview" class="row border border-secondery border-right-0 border-left-0 m-5">
		<div class="mx-auto cont" >
			<a class="btn text-dark" href="#productDetailBar">상품 상세정보</a>/
			<a class="btn text-dark" href="#productPurchaseExplainBar">상품 구매안내</a>/
			<a class="btn text-dark" href="#productReview">상품 사용후기</a>/
			<a class="btn text-dark" href="#productQnA">상품 Q&amp;A</a>
		</div>
	</div>
	
	<div class="row mt-3">
		<div class="mx-auto">
			<p class="mb-2" style="border-bottom:1px solid gray; font-family:Acme;">Reviews</p>
		</div>
	</div>
	
	<c:choose>
		<c:when test="${not empty reviews}">
			<table class="table-bordered col-sm-11 text-center m-5">
				<thead>
					<tr>
						<th>이미지</th>
						<th>제목</th>
						<th>만족도</th>
						<th>작성자</th>
						<th>작성 일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${reviews}" var="review" varStatus="st">
					<input type="hidden" value="${review.boardFile}" id="boardFile_${st.index}">
					<input type="hidden" value="${review.boardNum}" id="reviewNum_${st.index}">
					<tr>
						<td id="img_${st.index}">${review.boardFile}</td>
						<td>
							<c:choose>
								<c:when test="${empty review.boardPw || sessionScope.role == 'role_admin' || sessionScope.id == review.boardWriter}">
									<a href="${pageContext.request.contextPath}/board/view.do?boardNum=${review.boardNum}&productId=${product.productId}">
											 ${review.boardSubject}</a>
								</c:when>
								<c:otherwise>
									<a id="reviewSecret_${st.index}" href="#">비밀글 입니다.</a>
								</c:otherwise>
							</c:choose>
							
						</td>
						<td></td>
						<td>${review.boardWriter}</td>
						<td id="orderNum_${st.index}">${review.boardDate}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
		</c:when>
		
		<c:otherwise>
			<div id="noReviews" class="border border-secondery m-5">
				<p id="noReviewsContent" 
				   style="font-family:Jua; text-align:center;">- 구매 후기가 없습니다. -</p>
			</div>
					
		</c:otherwise>
	</c:choose>
	
	<div id="reviewBtnWrapper" class="mx-5 mb-5">
		<input type="button" value="후기 작성하기" id="reviewWrite"
			   class="btn btn-outline-dark my-3 float-right">
	</div>
	<br>
	
	
	<!-- 상품 Q&A -->
	<div id="productQnA" class="row border border-secondery border-right-0 border-left-0 m-5">
		<div class="mx-auto cont" >
			<a class="btn text-dark" href="#productDetailBar">상품 상세정보</a>/
			<a class="btn text-dark" href="#productPurchaseExplainBar">상품 구매안내</a>/
			<a class="btn text-dark" href="#productReview">상품 사용후기</a>/
			<a class="btn text-dark" href="#productQnA">상품 Q&amp;A</a>
		</div>
	</div>
	
	<div class="row mt-3">
		<div class="mx-auto">
			<p class="mb-2" style="border-bottom:1px solid gray; font-family:Acme;">Q&amp;A</p>
		</div>
	</div>
	
	
	
	<c:choose>
		<c:when test="${not empty inquirys}">
		<div>
			<input type="hidden" value="${inquirys.size()}" id="inquiry_count">
			<table class="table-bordered col-sm-11 text-center m-5">
			  <thead>
				<tr>
					<th>이미지</th>
					<th>제목</th>
					<th>만족도</th>
					<th>작성자</th>
					<th>작성 일자</th>
				</tr>
			  </thead>
			  <tbody>
				<c:forEach items="${inquirys}" var="inquiry" varStatus="st">
				<input type="hidden" value="${inquiry.boardFile}" id="inquiryFile_${st.index}">
				<input type="hidden" value="${inquiry.boardNum}" id="inquiryNum_${st.index}">
				<tr>
					<td id="inquiryImg_${st.index}"></td>
					<td>
						<a href="${pageContext.request.contextPath}/board/view.do
									?boardNum=${inquiry.boardNum}&productId=${product.productId}">
								 ${inquiry.boardSubject}</a>
					</td>
					<td></td>
					<td>${inquiry.boardWriter}</td>
					<td>${inquiry.boardDate}</td>
				  </tr>
				  </c:forEach>
			  </tbody>
			</table>
		</div>
	
	</c:when>
		
		<c:otherwise>
			<div id="noReviews" class="border border-secondery m-5">
				<p id="noReviewsContent" 
				   style="font-family:Jua; text-align:center;">- Q&amp;A가 없습니다. -</p>
			</div>
					
		</c:otherwise>
	</c:choose>
	
	<div>
		<input type="button" value="상품 문의" id="QnA"
			   class="btn btn-outline-dark float-right mb-2 mx-5">
	</div>
</div>
</body>
</html>