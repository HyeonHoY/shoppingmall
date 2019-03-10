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
   
   if($("#list_count").val() == 0){
      $("table").remove();
      $("#noCartItem").append("<div style='display : flex; align-items:center; height:500px;"+
                        "justify-content : center;'>상품이 존재하지 않습니다!</div>");
   } else {
      // 상품 개수만큼 배열 크기 선언
      // var term_value = new Array(parseInt($('#list_count').val()));
      // alert(term_value.length);
      
      var totalPrice = 0;
      for(var i=0; i<$("#list_count").val(); i++) {
         totalPrice += intChange($("#afterPriceDiv_"+i+""));
      }
      
      // 처음
      $("input:checkbox").prop("checked", true);
      
      // 전체 선택 클릭
      $("#selectAll").on('click', function(){
         
         var all_condision = $("input[id=selectAll]").prop("checked");
         
         // selectAll checkbox가 true일 경우 모든 체크박스 true 
         if(all_condision == true){
            $("input[id^=select_]").prop('checked', true);
            
            for(var i=0; i<$("#list_count").val(); i++){
               
               var price = parseInt($("#afterPriceDiv_"+i+"").text().trim().replace("원", "").replace(",", ""));
               totalPrice += price; 
            }
            $("#totalPriceTd").html(addComma(totalPrice)+"원");
         } else {
            
            $("input[id^=select_]").prop('checked', false);
            totalPrice = 0;
            $("#totalPriceTd").html(addComma(totalPrice)+"원");
         }
      });
      
      // 선택 항목 클릭
      $("input[id^=select_]").click(function(e){
         
         var num = e.target.id.split("_")[1];
         var one_condision = $("input[id=select_"+num+"]").prop("checked");
         
         if(one_condision == true){
            totalPrice = totalPrice + intChange($("#afterPriceDiv_"+num+""));
            $("#totalPriceTd").html(addComma(totalPrice)+"원");
            //$("input[id=selectAll]").prop("checked", true);
         } else {
            totalPrice = totalPrice - intChange($("#afterPriceDiv_"+num+""));
            $("#totalPriceTd").html(addComma(totalPrice)+"원");
            //$("input[id=selectAll]").prop("checked", false);
         }
      });
      
      // 테이블 생성   
      $("#allProductBuy").html(
         "<table class='table-bordered col-lg-12 text-center my-2'>"+
            "<tr>"+
                  "<th class='table col-lg-4 py-2'>총 상품 가격</th>"+
                  "<th class='table col-lg-4 py-2'>배송비</th>"+
                  "<th class='table col-lg-4 py-2'>선택상품 주문</th>"+
            "</tr>"+
            "<tr>"+
               "<td id='totalPriceTd' class='py-4'>"+addComma(totalPrice)+"원"+"</td>"+
               "<td class='py-4'>0원</td>"+
               "<td class='py-4'><input type='button' value='선택상품주문' id='selectOrderBtn' "+
                        "style='width:150px; height:50px;' class='btn btn-dark'></td>"+
            "</tr>"+
         "</table>"
      );
      
      
      // 수량 수정버튼을 눌렀을 때
      $("input[id^=countChangeBtn_]").click(function(e){
         
         var num = e.target.id.split("_")[1];
//          alert($("#cartNum_"+num+"").val());
//          alert($("#cartCount_"+num+"").val());
         
         $.ajax({
            
            type : 'get',
            url : '${pageContext.request.contextPath}/cart/update.do',
            data : {
               cartNum : $("#cartNum_"+num+"").val(),
               cartCount : $("#cartCount_"+num+"").val()
            },
            success : function(data){
               
               var rowPrice = parseInt($("#productPrice_"+num+"").val()*(100-$("#discountRate_"+num+"").val())*0.01)*$("#rowCartCount_"+num+"").val();
               $("#rowCartCount_"+num+"").val(parseInt(data));
               var nowPrice = parseInt($("#productPrice_"+num+"").val()*(100-$("#discountRate_"+num+"").val())*0.01)*$("#rowCartCount_"+num+"").val();
               var beforePrice = addComma($("#productPrice_"+num+"").val()*parseInt(data))+"원";
               var afterPrice = addComma($("#productPrice_"+num+"").val()*(100-$("#discountRate_"+num+"").val())*parseInt(data)*0.01)+"원";
               
               totalPrice = totalPrice+nowPrice-rowPrice;
               
               $("#beforePriceDiv_"+num+"").html(beforePrice);
               $("#afterPriceDiv_"+num+"").html(afterPrice);   
               $("#totalPriceTd").html(addComma(totalPrice)+"원");
            },
            error : function(xhr, status){
               alert(xhr);
            }
         }); // ajax
      }); // click

      // 개별 상품 주문
      $("input[id^=orderBtn_]").click(function(e){
         
         var form = $("<form id='buyProductForm' name='buyProductForm'></form>");
         form.attr({ "action" : "${pageContext.request.contextPath}/product/productOrderPage.do", 'method' : 'post' });
         form.appendTo("body");
         
         var num = e.target.id.split("_")[1];
         var num1 = e.target.id;
         alert("타겟 아이디"+num1);
         
         submitData(form, num);
         form.submit();
         
      }); // click
      
      // 선택상품 주문 버튼
      $("#selectOrderBtn").on("click", function(){
         
         var form = $("<form id='buyProductForm' name='buyProductForm'></form>");
         form.attr({ "action" : "${pageContext.request.contextPath}/product/productOrderPage.do", 'method' : 'post' });
         form.appendTo("body");
         
         if($("input:checkbox[name=select_box]:checked").length != 0){
            var length = $("input:checkbox[name=select_box]:checked").length;
            // console.log("length = "+length);
            
            // 선택된 아이디 찾기
            $("input:checkbox[name=select_box]:checked").each(function(){
               
               // 선택된 값 확인
               if(this.checked == true) {
                  // console.log(this.id.split('_')[1]);
                  var num = this.id.split('_')[1];
                  submitData(form, num);
               }
            });
            // console.log(form);
            form.submit();
         } else {
            alert("주문은 상품이 1개 이상 선택되어 있어야 합니다.");
         }
      });
      
      // 삭제하기 버튼
      $("input[id^=deleteBtn_]").click(function(e){
         var num = e.target.id.split("_")[1];
         var cartNum = $("#cartNum_"+num+"").val();
         
         var form = $("<form action='${pageContext.request.contextPath}/cart/delete.do'>"+
                      "<input value='"+cartNum+"' name='cartNum'></form>");
         form.appendTo("body").submit();
      });
   } // else
   
}); // end
</script>
</head>
<body >
<c:if test="${not empty sessionScope.id}">

<input type="hidden" id="list_count" value="${products.size()}">
<div class="row mt-3">
   <div class="mx-auto">
      <p class="mb-5" style="border-bottom:1px solid gray;">SHOPPING CART</p>
   </div>
</div>

<div id="noCartItem"></div>

<table class="table col-sm-12" id="cart_table">
   <thead id="cart_thead">
      <tr>
         <th><input type="checkbox" id="selectAll" checked="checked"></th>
         <th>상품 이미지</th>
         <th>상품 이름</th>
         <th>수량</th>
         <th>판매 가격</th>
         <th>배송비</th>
         <th>주문</th>
      </tr>
   </thead>
   <tbody>
   <c:forEach items="${products}" var="product" varStatus="st">
      <input type="hidden" id="cartNum_${st.index}" value="${carts[st.index].cartNum}">
      <input type="hidden" id="productPrice_${st.index}" value="${product.productPrice}">
      <input type="hidden" id="discountRate_${st.index}" value="${product.discountRate}">
      <tr>
         <td><input type="checkbox" id="select_${st.index}" name="select_box" checked="checked"></td>
         <td>
            <a href="${pageContext.request.contextPath}/product/view.do?id=${product.productId}">
               <img width="100" src="<c:url value='/product/${product.productId}/thumbnail/${product.productTitleImg}'/>">
            </a>
         </td>
         <td>
            <div class="form-inline"> 상품 아이디 : <div id="productId_${st.index}">${product.productId}</div></div>
            상품 이름 : ${product.productName}
         </td>
         <td>
            <input type="hidden" id="rowCartCount_${st.index}" value="${carts[st.index].cartCount}">
            <input type="number" id="cartCount_${st.index}" value="${carts[st.index].cartCount}"
                  class="form-control mb-1" style="width:55px;" max="99" min="0" autocomplete="off">
            <input type="button" class="btn btn-outline-dark" value="수정" 
                  id="countChangeBtn_${st.index}" style="width:55px;">
         </td>
         <td>
              <div id="afterPriceDiv_${st.index}">
               <fmt:formatNumber value="${carts[st.index].cartCount*product.productPrice*(100-product.discountRate)*0.01}" pattern="#,###" />원
            </div>
         </td>
         <td>공란</td>
         <td>
            <input type="button" class="btn btn-dark mb-2" value="주문하기" id="orderBtn_${st.index}"><br>
            <input type="button" class="btn btn-outline-dark" id="deleteBtn_${st.index}" value="삭제하기">
         </td>
      </tr>
   </c:forEach>
   </tbody>
</table>

<div id="allProductBuy" class="mb-5"></div>

</c:if>

</body>
</html>