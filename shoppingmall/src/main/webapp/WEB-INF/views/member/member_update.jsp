<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html lang="ko">
<style>
body#LoginForm{ 
	background-repeat : no-repeat; 
	background-position : center; 
	background-size : cover; 
	padding : 0;}

.form-heading { 
	color : #fff; 
	font-size : 23px;
}

.panel h2{ 
	color : #444444; 
	font-size : 18px; 
	margin : 0 0 8px 0;
}
	
.panel p { 
	color : #777777; 
	font-size : 14px; 
	margin-bottom : 30px; 
	line-height : 24px;
}

.login-form .form-control {
	background : #f7f7f7 none repeat scroll 0 0;
	border : 1px solid #d4d4d4;
	border-radius : 4px;
	font-size : 14px;
	height : 50px;
	line-height : 50px;
}

.main-div {
	background : #ffffff none repeat scroll 0 0;
	border-radius : 2px;
	margin : auto;
	width : 300px;
}

.login-form .form-group {
	margin-bottom : 10px;
}

.login-form{ 
	text-align : center;
}

.forgot a {
	color : #777777;
	font-size : 14px;
	text-decoration : underline;
}

.login-form .btn.btn-success {
	background : #007BFF none repeat scroll 0 0;
	border-color : #007BFF;
	color : #ffffff;
	font-size : 14px;
	width : 120px;
	height : 50px;
	line-height : 50px;
	padding : 0;
}

.btn.btn-danger {
	background : #007BFF none repeat scroll 0 0;
	border-color : #007BFF;
	color : #ffffff;
	font-size : 14px;
	width : 120px;
	height : 50px;
	line-height : 50px;
	padding : 0;
}

.forgot {
	text-align : left; 
	margin-bottom : 30px;
}

.botto-text {
	color : #ffffff;
	font-size : 14px;
	margin : auto;
}

.login-form .btn.btn-success.reset {
	background : #ff9900 none repeat scroll 0 0;
}

.back { 
	text-align : left; 
	margin-top :10px;
}

.back a {
	color : #444444; 
	font-size : 13px;
	text-decoration : none;
}
</style>
<head>
<!-- 주소검색 : daum -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="<c:url value='/js/custom/memberUpdateValid.js' />"></script>
<title>회원정보 수정</title>

	<!-- 자바스크립트 부분 -->	
	<script>
	//테스트
	function test(){
		alert("test");
	}
	
	//연락처설정
	function selectPhone(phone) {
   
	   // 작성 시작
	   var phone1 = document.getElementById("phone1").value;
	   var optionLen = phone1.options.length;
	   
	    for (var i=0; i<optionLen; i++) {
	   
	       if (phone == phone1.options[i].value)
	           phone1.selectedIndex = i;
	       
	   } // for
	   // 작성 끝
	}
	
	
	// 이메일 설정
	function selectEmail(emailDomain) {
		
	   var emailPortal = document.getElementById("email2");
	   var emailUserDomain = document.getElementById("email3");
	   var optionLen = emailPortal.options.length;
	   //alert("option email2 lenght : "+optionLen);
	   
	   // 도메인 점검 : 이메일 포털 도메인일 경우
	   for (var i=0; i<optionLen-1; i++) { // "사용자 직접 입력 항목"은 제외 6-1 = 총 5항목
	       
	       if (emailDomain.trim() == emailPortal.options[i].value) {
	    	   
	           //alert("select2");
	           emailPortal.selectedIndex = i;
	           emailUserDomain.value = "";
	           break;
	       }
	       
	   } // for        
	   
	   // 사용자 도메인일 경우
	   if (emailDomain.trim() != emailPortal.options[i].value) {
		   
		   //alert("select3");
	       emailPortal.selectedIndex = optionLen-1; // 사용자 직접 입력 항목 설정
	       emailUserDomain.value = emailDomain; // 사용자 메일 도메인으로 설정
	       
	   }    
	}
	
	//처음 시작시 select 기본 설정
	window.onload = function(e) {
		
		var menu = ${menu};
		//alert("menu : "+menu);
		
		if(menu==2){
			selectPhone("${phone[0]}");   // 연락처 앞번호 설정
		}
		selectEmail("${email[1]}");   // 이메일 설정	
	};
	</script>
	
	<!-- jQuery부분 -->
	<script>
	
 	$(document).ready(function(){
 		
 		//비밀번호 점검
 		//.blur나 focusout을  사용하면 계속 ready상태로 존재하고 있어 무한 루프로 돌게 된다. 
 		//점검하는 정보를 console.log를 사용하면 문제를 완화시킬 수 있다.
 		var pwck=0;
 		
 		$("#pw").focusout(function(){
 			
 			var pw1 = document.getElementById("memberPw").value;
			var pw2 = document.getElementById("pw").value;
			console.log("pw1 : "+pw1+", pw2 : "+pw2);
			
			if(pw1==pw2){
				
				console.log("success!");
				document.getElementById("pwCheck").innerHTML = "";
				document.getElementById("pw").style.border="";
				pwck=1;
				
			} else {
				
				console.log("false!");
				document.getElementById("pwCheck").innerHTML = "비밀번호가 일치하지 않습니다.";
				document.getElementById("pwCheck").style.color="red";
			    document.getElementById("pwCheck").style.fontSize="11px"
			    document.getElementById("pw").style.border="thick solid #FF0000";
			    document.getElementById("pw").value='';
			
				pwck=0;
			}
		});
		//비밀번호 점검 여부 끝
 		
		
 		//연락처 유효성 검사
		$("#phoneUpdateBtn").click(function(){
			
			var phoneCheck = 0;
			combinePhone();
			
			var phone = document.getElementById("phone").value;
			console.log("phone : "+phone);
			var regex = /^(\d{3}).*(\d{3,4}).*(\d{4})$/;
			
			if(regex.test(phone)){
				
				document.getElementById("phoneCheck").innerHTML = "";  
				phoneCheck=1;
				
			} else {
				
				document.getElementById("phoneCheck").innerHTML = "올바른 연락처가 아닙니다. 다시 입력해 주세요.";
				document.getElementById("phoneCheck").style.color="red";
			    document.getElementById("phoneCheck").style.fontSize="11px"
			    document.getElementById("phone2").value='';
			    document.getElementById("phone3").value='';
				document.getElementById("phone2").focus();
				phoneCheck=0;
				
			}
			
			var ask = window.confirm("수정하시겠습니까?");
			
			if(ask==true &&phoneCheck==1&&pwck==1){	
				
				alert("성공적으로 수정되었습니다.");
				document.getElementById("Login").submit();
				/* location.href="${pageContext.request.contextPath}/login/view.do?pw=${member.pw}"; */
				
			} else {
				
				alert("입력된 정보가 올바르지 않습니다. 다시 입력해 주십시오.");
				return;
				
			}
		});//핸드폰 유효성 검사 끝	
 		
		
		//이메일 유효성 검사
		$("#emailUpdateBtn").click(function(){
			
			var emailCheck = 0;
			
			//alert("e1");
			combineEmail();
			//alert("e2");
			var email = document.getElementById("email").value;
			console.log("email : "+email);
			var regex =  /^[a-z]{2}([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			
			if(regex.test(email)){
				
				//alert("e3");
				document.getElementById("emailCheck").innerHTML = "";  
				emailCheck=1;
				
			} else {
				
				//alert("e4");
				document.getElementById("emailCheck").innerHTML = "올바른 이메일이 아닙니다. 다시 입력해 주세요.";
				document.getElementById("emailCheck").style.color="red";
			    document.getElementById("emailCheck").style.fontSize="11px"
			    document.getElementById("email1").value='';
			    document.getElementById("email3").value='';
				document.getElementById("email1").focus();
				emailCheck=0;
				
			}
			
			var ask = window.confirm("수정하시겠습니까?");
			
			if(ask==true &&emailCheck==1&&pwck==1){	
				
				console.log("success");
				alert("성공적으로 수정되었습니다.");
				document.getElementById("Login").submit();
				
			} else {
				
				console.log("false");
				alert("입력된 정보가 올바르지 않습니다. 다시 입력해 주십시오.");
				return;
				
			}
		});//이메일 유효성 검사 끝
		
		
		//주소 기본주소 + 상세주소 합치기
		$("#addressUpdateBtn").click(function(){
			
			alert("클릭");
			
			var addressCheck = 0;
			var address1 = document.getElementById("roadAddr1").value;
			var address2 = document.getElementById("roadAddr2").value;
			//alert("addr1 : "+address1+" , addr2 : "+address2);
			
			combineAddress();
			
			if(address2.length<=2){
				
				document.getElementById("addressCheck").innerHTML = "최소 2자 이상 입력해야합니다. 다시 입력해 주세요.";
				document.getElementById("addressCheck").style.color="red";
			    document.getElementById("addressCheck").style.fontSize="11px"
			    document.getElementById("roadAddr2").value="";
				document.getElementById("roadAddr2").focus();
				addressCheck = 0;
				
			} else {
				
				document.getElementById("addressCheck").innerHTML = "";
				addressCheck=1;
				
			}
			
			var ask = window.confirm("수정하시겠습니까?");
			
			if(ask==true &&addressCheck==1&&pwck==1){	
				
				console.log("success");
				alert("성공적으로 수정되었습니다.");
				document.getElementById("Login").submit();
				
			} else {
				
				console.log("false");
				alert("입력된 정보가 올바르지 않습니다. 다시 입력해 주십시오.");
				return;
				
			}
		});//기본 주소 상세주소 합치기 끝
		
		
		/*  		관리자 계정 유효성 검사 버튼			 */
		
		//연락처 유효성 검사 끝
		$("#phoneAdminUpdateBtn").click(function(){
			
			alert($("#memberID").val());
			
			var phoneCheck = 0;
			combinePhone();
			
			var phone = document.getElementById("phone").value;
			console.log("phone : "+phone);
			var regex = /^(\d{3}).*(\d{3,4}).*(\d{4})$/;
			
			if(regex.test(phone)){
				
				document.getElementById("phoneCheck").innerHTML = "";  
				phoneCheck=1;
				
			} else {
				
				document.getElementById("phoneCheck").innerHTML = "올바른 연락처가 아닙니다. 다시 입력해 주세요.";
				document.getElementById("phoneCheck").style.color="red";
			    document.getElementById("phoneCheck").style.fontSize="11px"
			    document.getElementById("phone2").value='';
			    document.getElementById("phone3").value='';
				document.getElementById("phone2").focus();
				phoneCheck=0;
				
			}
			
			var ask = window.confirm("수정하시겠습니까?");
			
			if(ask==true &&phoneCheck==1){	
				
				alert("성공적으로 수정되었습니다.");
				document.getElementById("Login").submit();
				/* location.href="${pageContext.request.contextPath}/login/view.do?pw=${member.pw}"; */
				
			} else {
				
				alert("입력된 정보가 올바르지 않습니다. 다시 입력해 주십시오.");
				return;
				
			}
		});//핸드폰 유효성 검사 끝	
 		
		
		//이메일 유효성 검사
		$("#emailAdminUpdateBtn").click(function(){
			
			var emailCheck = 0;
			
			//alert("e1");
			combineEmail();
			//alert("e2");
			var email = document.getElementById("email").value;
			console.log("email : "+email);
			var regex =  /^[a-z]{2}([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			
			if(regex.test(email)){
				
				//alert("e3");
				document.getElementById("emailCheck").innerHTML = "";  
				emailCheck=1;
				
			} else {
				
				//alert("e4");
				document.getElementById("emailCheck").innerHTML = "올바른 이메일이 아닙니다. 다시 입력해 주세요.";
				document.getElementById("emailCheck").style.color="red";
			    document.getElementById("emailCheck").style.fontSize="11px"
			    document.getElementById("email1").value='';
			    document.getElementById("email3").value='';
				document.getElementById("email1").focus();
				emailCheck=0;
				
			}
			
			var ask = window.confirm("수정하시겠습니까?");
			
			if(ask==true &&emailCheck==1){	
				
				console.log("success");
				alert("성공적으로 수정되었습니다.");
				document.getElementById("Login").submit();
				
			} else {
				
				console.log("false");
				alert("입력된 정보가 올바르지 않습니다. 다시 입력해 주십시오.");
				return;
				
			}
		});//이메일 유효성 검사 끝
		
		
		//주소 기본주소 + 상세주소 합치기
		$("#addressAdminUpdateBtn").click(function(){

			var addressCheck = 0;
			var address1 = document.getElementById("roadAddr1").value;
			var address2 = document.getElementById("roadAddr2").value;
			
			combineAddress();
			
			if(address2.length<=2){
				
				document.getElementById("addressCheck").innerHTML = "최소 2자 이상 입력해야합니다. 다시 입력해 주세요.";
				document.getElementById("addressCheck").style.color="red";
			    document.getElementById("addressCheck").style.fontSize="11px"
			    document.getElementById("roadAddr2").value="";
				document.getElementById("roadAddr2").focus();
				addressCheck = 0;
				
			} else {
				
				document.getElementById("addressCheck").innerHTML = "";
				addressCheck=1;
				
			}
			
			var ask = window.confirm("수정하시겠습니까?");
			
			if(ask==true &&addressCheck==1){	
				
				console.log("success");
				alert("성공적으로 수정되었습니다.");
				document.getElementById("Login").submit();
				
			} else {
				
				console.log("false");
				alert("입력된 정보가 올바르지 않습니다. 다시 입력해 주십시오.");
				return;
				
			}
			
		}); //기본 주소 상세주소 합치기 끝
		/*  		관리자 계정 유효성 검사 버튼  끝 		 */
		
	});//document.ready 


	//수정 취소시 개인 상세정보 페이지로 리턴	
	$(function() {
		
	    $("#viewBtn").click(
	          
	          function() {
	             var ask = window.confirm("수정을 취소하시겠습니까?");
	             if (ask) {
	                location.href = "${pageContext.request.contextPath}/login/view.do?pw=${member.pw}";
	             }
	       });
	    
	    //관리자 계정 버튼
	    $("#viewAdminBtn").click(
		          
		          function() {
		             var ask = window.confirm("수정을 취소하시겠습니까?");
		             if (ask) {
		                location.href = "${pageContext.request.contextPath}/admin/view.do?id=${member.id}";
		             }
			});
	 });
	
</script>
</head>
<body id="LoginForm">
<div class="container">
<h1 class="form-heading">login Form</h1>
	<div class="login-form">
		<div class="main-div">
    		<div class="panel">
    		
	   			<!-- 관리자 계정 -->
	   			<c:choose>
				<c:when test="${sessionScope.role == 'role_admin'}">
					<c:if test="${menu == 2}">
					   <h2>전화번호 수정</h2>
					   <br>
					    <form id="Login" 
					    	  name="form1" 
					    	  method="post" 
					    	  action="${path}/sm/admin/phoneChange.do?id=${member.id}">
					    	  
					        <input type="hidden" id="memberPw" id="memberPw" value="${member.pw}">
					        <input type="hidden" id="memberID" id="memberID" value="${member.id}">
					        <div class="form-group form-inline">
								<select id="phone1" name="phone1" class="form-control col-sm-1.5">
								   <option value="010" selected>010</option>
								   <option value="011">011</option>
								   <option value="016">016</option>
								   <option value="017">017</option>
								   <option value="018">018</option>
								   <option value="019">019</option>
								</select> 
								-
								<input name="phone2" id="phone2" maxlength="4" size="5"
								               class="form-control col-sm-4 text-center" value="${phone[1]}"> 
								- 
								<input name="phone3" id="phone3" maxlength="4" size="5" 
								         class="form-control col-sm-4 text-center" value="${phone[2]}"> 
								<input type="hidden" name="phone" id="phone">&nbsp;
					        </div>
					        <div id="phoneCheck" class="mb-2"></div>
					   
							<button type="button" id="phoneAdminUpdateBtn" name="phoneAdminUpdateBtn" class="btn btn-success">수정</button>
					    	<button type="button" id="viewAdminBtn" name="viewAdminBtn" class="btn btn-danger">취소</button>
					    	<br><br>
					    	
					    </form>
					    
					   </c:if>
					   
					   <c:if test="${menu == 3}">
					   <h2>이메일 수정</h2>
					   <br>
					    <form id="Login" 
					    	  style="width:500px;" 
					    	  name="form1" 
					    	  method="post" 
					    	  action="${path}/sm/admin/emailChange.do?id=${member.id}">
					    	  
					    	 <input type="hidden" id="memberPw" id="memberPw" value="${member.pw}">
					         <div class="form-group form-inline mb-2 mr-sm-2">
						   		<input name="email1" id="email1" maxlength="20" size="25" class="form-control col-sm-3 text-center" value="${email[0]}">
								@
								 <select id="email2" name="email2" class="form-control">
						                  <option>naver.com</option>
						                  <option>daum.net</option>
						                  <option>empal.com</option>
						                  <option>nate.com</option>
						                  <option>paran.com</option>
						                  <option>직접 입력</option>
						         </select>&nbsp;  
						         <input name="email3" id="email3" maxlength="20" size="25" class="form-control col-sm-3">
						         <input type="hidden" name="email" id="email" readonly>
						         <br>
						         <br>
						         <div id="emailCheck" class="mb-2" style="text-align:center;"></div> 
						    </div>
							   
					        <div class="ml-3">
								<button type="button" class="btn btn-success" id="emailAdminUpdateBtn" name="emailAdminUpdateBtn">수정</button>
						    	<button type="button" id="viewAdminBtn" name="viewAdminBtn" class="btn btn-danger">취소</button>
						    	<br>
					    	</div>
					    	
					    </form>
					   </c:if>
					   
					   <c:if test="${menu == 4}">
					   <h2>주소지 수정</h2>
					   <br>
					    <form id="Login" 
					    	  name="form1" 
					    	  style="width:400px;" 
					    	  method="post" 
					    	  action="${path}/sm/admin/addressChange.do?id=${member.id}">
					    	  
					        <input type="hidden" id="memberPw" id="memberPw" value="${member.pw}">
					        <div class="form-group form-inline mr-sm-2">
					            <input type="text" class="form-control col-lg-4" id="zip" name="zip" value="${member.zip}" readonly>&nbsp;&nbsp;
					            <input type="button" id="zip1btn" value="도로명 주소검색"
					                     class="btn_style btn btn-secondary" onClick="road_Postcode()">
					        </div>
					        <div class="form-group">
					            <input type="text" class="form-control" id="roadAddr1" name="roadAddr1" value="${address[0]}" readonly>
					        </div>
					        <div class="form-group">
					            <input type="text" class="form-control" id="roadAddr2" name="roadAddr2" value="${address[1]}" placeholder="상세주소 입력">
					        </div>
					        <div id="addressCheck" class="mb-2"></div>
					        <input type="hidden" id="address" name="address">
		
							<button type="button" class="btn btn-success" id="addressAdminUpdateBtn" name="addressAdminUpdateBtn">수정</button>
						    <button type="button" id="viewAdminBtn" name="viewAdminBtn" class="btn btn-danger">취소</button>
					    	<br><br>
					    	
					    </form>
					 </c:if>
				</c:when>
				
				
				
				<c:otherwise>
												<!-- 유저일 경우 -->
				   <c:if test="${menu == 2}">
					   <h2>전화번호 수정</h2>
					   <br>
					    <form id="Login" 
					    	  name="form1" 
					    	  method="post" 
					    	  action="${path}/sm/member/phoneChange.do"
					    	  class="mb-5">
					    	  
					        <input type="hidden" id="memberPw" id="memberPw" value="${member.pw}">
					        <div class="form-group form-inline">
								<select id="phone1" name="phone1" class="form-control col-sm-1.5">
								   <option value="010" selected>010</option>
								   <option value="011">011</option>
								   <option value="016">016</option>
								   <option value="017">017</option>
								   <option value="018">018</option>
								   <option value="019">019</option>
								</select> 
								-
								<input name="phone2" id="phone2" maxlength="4" size="5"
								               class="form-control col-sm-4 text-center" value="${phone[1]}"> 
								- 
								<input name="phone3" id="phone3" maxlength="4" size="5" 
								         class="form-control col-sm-4 text-center" value="${phone[2]}"> 
								<input type="hidden" name="phone" id="phone">&nbsp;
					        </div>
					        <div id="phoneCheck" class="mb-2"></div>
					        <div class="form-group">
					            <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호 입력">
					        </div>
					        <div id="pwCheck" class="mb-2"></div>
							<button type="button" id="phoneUpdateBtn" name="phoneUpdateBtn" class="btn btn-success">수정</button>
					    	<button type="button" id="viewBtn" name="viewBtn" class="btn btn-danger">취소</button>
					    	<br><br>
					    	
					    </form>
					    <div style="height:200px;"></div>
					   </c:if>
					   
					   <c:if test="${menu == 3}">
					   <h2>이메일 수정</h2>
					   <br>
					    <form id="Login" 
					    	  style="width:500px;" 
					    	  name="form1" 
					    	  method="post" 
					    	  action="${path}/sm/member/emailChange.do">
					    	  
					    	 <input type="hidden" id="memberPw" id="memberPw" value="${member.pw}">
					         <div class="form-group form-inline mb-2 mr-sm-2">
						   		<input name="email1" id="email1" maxlength="20" size="25" class="form-control col-sm-3 text-center" value="${email[0]}">
								@
								 <select id="email2" name="email2" class="form-control">
						                  <option>naver.com</option>
						                  <option>daum.net</option>
						                  <option>empal.com</option>
						                  <option>nate.com</option>
						                  <option>paran.com</option>
						                  <option>직접 입력</option>
						         </select>&nbsp;  
						         <input name="email3" id="email3" maxlength="20" size="25" class="form-control col-sm-3">
						         <input type="hidden" name="email" id="email" readonly>
						    </div>
							<div id="emailCheck" class="mb-2 float-left"></div>    
					        <div class="form-group">
					            <input type="password" class="form-control col-sm-9" id="pw" name="pw" placeholder="비밀번호 입력">
					        </div>
					        <div id="pwCheck" class="mb-2 col-sm-8"></div>
							<button type="button" class="btn btn-success" id="emailUpdateBtn" name="emailUpdateBtn">수정</button>
					    	<button type="button" id="viewBtn" name="viewBtn" class="btn btn-danger">취소</button>
					    	<br>
					    	
					    </form>
					    <div style="height:200px;"></div>
					   </c:if>
					   
					   <c:if test="${menu == 4}">
					   <h2>주소지 수정</h2>
					   <br>
					    <form id="Login"
					    	  name="form1" 
					    	  style="width:400px;" 
					    	  method="post" 
					    	  action="${path}/sm/member/addressChange.do">
					    	  
					        <input type="hidden" id="memberPw" id="memberPw" value="${member.pw}">
					        <div class="form-group form-inline mr-sm-2">
					            <input type="text" class="form-control col-lg-4" id="zip" name="zip" value="${member.zip}" readonly>&nbsp;&nbsp;
					            <input type="button" id="zip1btn" value="도로명 주소검색"
					                     class="btn_style btn btn-secondary" onClick="road_Postcode()">
					        </div>
					        <div class="form-group">
					            <input type="text" class="form-control" id="roadAddr1" name="roadAddr1" value="${address[0]}" readonly>
					        </div>
					        <div class="form-group">
					            <input type="text" class="form-control" id="roadAddr2" name="roadAddr2" value="${address[1]}" placeholder="상세주소 입력">
					        </div>
					        <div id="addressCheck" class="mb-2"></div>
					        <input type="hidden" id="address" name="address">
					        <div class="form-group">
					            <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호 입력">
					        </div>
					        <div id="pwCheck" class="mb-2 col-sm-8"></div>
							<button type="button" class="btn btn-success" id="addressUpdateBtn" name="addressUpdateBtn">수정</button>
						    <button type="button" id="viewBtn" name="viewBtn" class="btn btn-danger">취소</button>
					    	<br><br>
					    	
					    </form>
					 </c:if>
				</c:otherwise>
			</c:choose> 
		   <br>
		   </div>
	    </div>
	<p class="botto-text"></p>
	</div>
</div>
</body>
</html>