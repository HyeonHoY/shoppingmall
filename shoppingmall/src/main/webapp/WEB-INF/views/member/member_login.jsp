<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko-kr">
<style>
body#LoginForm {
   background-repeat : no-repeat;
   background-position : center;
   background-size : cover;
   padding : 0;
}

.form-heading {
   color : #fff;
   font-size : 23px;
}

.panel h2 {
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
   width : 250px;
}

.login-form .form-group {
   margin-bottom : 10px;
}

.login-form {
   text-align : center;
}

.forgot a {
   color : #777777;
   font-size : 14px;
   text-decoration : underline;
}

.login-form  .btn.btn-primary {
   background : #007BFF none repeat scroll 0 0;
   border-color : #007BFF;
   color : #ffffff;
   font-size : 14px;
   width : 100%;
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

.login-form .btn.btn-primary.reset {
   background : #ff9900 none repeat scroll 0 0;
}

.back {
   text-align : left;
   margin-top : 10px;
}

.back a {
   color : #444444;
   font-size : 13px;
   text-decoration : none;
}
</style>

<head>
<title>로그인 페이지</title>
<script>
$(document).ready(function() {
    
   $("#pw").on("focus", function() {
      
      $(this).attr("type", "password");
      
   }); // pw
   
   var result = $("#msg").val();
      
   var msg = result.length;
   
   if(msg>0){
      alert("회원 정보가 존재하지 않습니다. 다시 입력해 주십시오.");
      $("#id").focus();
   }
   
   $("#btnLogin").click(function() {
      
      var userId = $("#id").val();
      var userPw = $("#pw").val();
      
      if (userId == "") {
         alert("아이디를 입력하세요. ");
         $("#id").focus();
         return;
      }
      
      if (userPw == "") {
         alert("비밀번호를 입력하세요. ");
         $("#pw").focus();
         return;
      }
      
      document.form1.action = "${path}/sm/login/loginCheck.do?num=${num}"
      document.form1.submit();
      
   }); // btnLogin
   
}); // ready
</script>
</head>
<body id="LoginForm">
   <div class="container">
      <input type="hidden" id="msg" name="msg" value="${msg}">
      <h1 class="form-heading">login Form</h1>
      <div class="login-form">
         <div class="main-div">
            <div class="panel">
               <h2>회원 로그인</h2>
               <br>
            </div>
            <form id="Login" 
                 name="form1" 
                 method="post">
               <input type="hidden" id="boardKinds" name="boardKinds" value="${boardKinds}">    
               <div class="form-group">
                  <input type="text" class="form-control" id="id" name="id" placeholder="아이디">
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" id="pw" name="pw" placeholder="비밀번호">
               </div>
               <div class="forgot">
                  <a href="${path}/sm/login/inquiryId.do">아이디 찾기</a>&nbsp; 
                  <a href="${path}/sm/login/inquiryPw.do">비밀번호 찾기</a>&nbsp; 
                  <a style="float : right" href="${path}/sm/member/write.do">회원가입</a>
               </div>
               <button type="submit" class="btn btn-primary" id="btnLogin">로그인</button>
               
            </form>
         </div>
         <p class="botto-text">Designed by Jooddol</p>
      </div>
   </div>
</body>
</html>