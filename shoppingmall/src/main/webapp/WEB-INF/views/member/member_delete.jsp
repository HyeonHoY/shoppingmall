<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko-kr">
<style>
body#FindPwForm{ 
	background-repeat : no-repeat; 
	background-position : center; 
	background-size : cover; 
	padding : 0;
}

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

.find-pw-form .form-control {
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
	width : 250px;
}

.find-pw-form .form-group {
	margin-bottom : 10px;
}

.find-pw-form{ 
	text-align : center;
}

.forgot a {
	color : #777777;
	font-size : 14px;
	text-decoration : underline;
}

.find-pw-form  .btn.btn-success {
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
	margin-bottom :30px;
}

.botto-text {
	color : #ffffff;
	font-size : 14px;
	margin : auto;
}

.find-pw-form .btn.btn-primary.reset {
	background : #ff9900 none repeat scroll 0 0;
}

.back { 
	text-align : left; 
	margin-top :10px;
}

.back a {
	color : #444444;
	font-siz : 13px;
	text-decoration :none;
}

</style>
<head>
<title>회원 탈퇴</title>
<script>
$(document).ready(function(){
	
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
	
	}); //비밀번호 점검 여부 끝
	
	
	//삭제 시작
	$("#deleteBtn").click(function(){

		var ask = window.confirm("삭제하시겠습니까?");
		
		if(ask==true && pwck==1){	
			
			console.log("success");
			alert("이용해 주셔서 감사합니다.");
			document.getElementById("deleteForm").submit();
			
		} else {
			
			console.log("false");
			alert("입력된 정보가 올바르지 않습니다. 다시 입력해 주십시오.");
			return;
		}
		
	}); //삭제 끝
	
	
	//관리자 삭제 시작
	$("#deleteAdminBtn").click(function(){

		var ask = window.confirm("삭제하시겠습니까?");
		
		if(ask){
			
			console.log("success");
			alert("이용해 주셔서 감사합니다.");
			document.getElementById("deleteForm").submit();
			
		} else {
			
			console.log("false");
			alert("입력된 정보가 올바르지 않습니다. 다시 입력해 주십시오.");
			return;
			
		}
		
	});//관리자 삭제 끝
	
});


//삭제 취소시 개인 상세정보 페이지로 리턴	
$(function() {
    $("#viewBtn").click(
          
          function() {
             var ask = window.confirm("삭제를 취소하시겠습니까?");
             if (ask) {
                location.href = "${pageContext.request.contextPath}/login/view.do?pw=${member.pw}";
             }
	});
    
    
  //관리자 계정 버튼
    $("#viewAdminBtn").click(
	          
	          function() {
	             var ask = window.confirm("회원 탈퇴를 취소하시겠습니까?");
	             if (ask) {
	                location.href = "${pageContext.request.contextPath}/security/view.do?id=${member.id}";
	             }
		});
  
});
</script>
</head>
<body id="FindPwForm">
<div class="container">
	<h1 class="form-heading">Find id</h1>
	<div class="find-pw-form">
		<div class="main-div">
    		<div class="panel">
   				<h2>회원 탈퇴</h2><br>
   			</div>
			<c:choose>
				<c:when test="${sessionScope.role == 'role_admin'}">
					<div class="panel mb-2">회원 정보를 삭제하시겠습니까?<br></div>
						<form id="deleteForm" 
							  name="form1" 
							  method="post" 
							  action="${path}/sm/admin/deleteExecution.do?id=${member.id}">
							  
							<button type="button" class="btn btn-success" id="deleteAdminBtn" name="deleteAdminBtn">삭제</button>
					   		<button type="button" class="btn btn-danger" id="viewAdminBtn" name="viewAdminBtn" >취소</button>
					   		
					    </form>
				</c:when>
				<c:otherwise>
					<form id="deleteForm" 
						  name="form1" 
						  method="post" 
						  action="${path}/sm/member/deleteExecution.do">
						  
						<input type="hidden" id="memberPw" name="memberPw" value="${member.pw}">
				        <div class="form-group">
				            <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호 입력">
				        </div>
						<div id="pwCheck" class="mb-2"></div>
						<button type="button" class="btn btn-success" id="deleteBtn" name="deleteBtn">삭제</button>
						<button type="button" class="btn btn-danger" id="viewBtn" name="viewBtn" >취소</button>
						
					  </form>
				</c:otherwise>
			</c:choose>
    	</div>
	<p class="botto-text"> Designed by Jooddol</p>
	</div>
</div>
</body>
</html>