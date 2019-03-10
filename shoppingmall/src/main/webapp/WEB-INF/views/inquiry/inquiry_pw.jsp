<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<style>
body#FindPwForm {
   background-repeat: no-repeat;
   background-position: center;
   background-size: cover;
   padding: 0;
}

.form-heading {
   color: #fff;
   font-size: 23px;
}

.panel h2 {
   color: #444444;
   font-size: 18px;
   margin: 0 0 8px 0;
}

.panel p {
   color: #777777;
   font-size: 14px;
   margin-bottom: 30px;
   line-height: 24px;
}

.find-pw-form .form-control {
   background: #f7f7f7 none repeat scroll 0 0;
   border: 1px solid #d4d4d4;
   border-radius: 4px;
   font-size: 14px;
   height: 50px;
   line-height: 50px;
}

.main-div {
   background: #ffffff none repeat scroll 0 0;
   border-radius: 2px;
   margin: auto;
   width: 250px;
}

.find-pw-form .form-group {
   margin-bottom: 10px;
}

.find-pw-form {
   text-align: center;
}

.forgot a {
   color: #777777;
   font-size: 14px;
   text-decoration: underline;
}

.find-pw-form  .btn.btn-success {
   background: #007BFF none repeat scroll 0 0;
   border-color: #007BFF;
   color: #ffffff;
   font-size: 14px;
   width: 120px;
   height: 50px;
   line-height: 50px;
   padding: 0;
}

.forgot {
   text-align: left;
   margin-bottom: 30px;
}

.botto-text {
   color: #ffffff;
   font-size: 14px;
   margin: auto;
}

.find-pw-form .btn.btn-primary.reset {
   background: #ff9900 none repeat scroll 0 0;
}

.back {
   text-align: left;
   margin-top: 10px;
}

.back a {
   color: #444444;
   font-size: 13px;
   text-decoration: none;
}
</style>

<head>

<title>Shop Homepage - Start Bootstrap Template</title>

<script>
   $(document).ready(function() {
      
      var result = $("#msg").val();
      
      var msg = result.length;
      
      if(msg>0){
         alert("회원 정보가 존재하지 않습니다. 다시 입력해 주십시오.");
         $("#id").focus();
      }
      
      $("#btn").click(function() {
         var userId = $("#id").val();
         var userName = $("#name").val();
         if (userId == "") {
            alert("아이디를 입력하세요. ");
            $("#id").focus();
            return;
         }
         if (userName == "") {
            alert("이름 입력하세요. ");
            $("#name").focus();
            return;
         }
         document.form1.action = "${path}/sm/login/pwFindCheck.do"
         document.form1.submit();
      });
   });
</script>
</head>
<body id="FindPwForm">
   <div class="container">
      <input type="hidden" id="msg" name="msg" value="${msg}">
      <h1 class="form-heading">Find password</h1>
      <div class="find-pw-form">
         <div class="main-div">
            <div class="panel">
               <h2>비밀번호 찾기</h2>
               <br>
            </div>
            <form id="FindPw" name="form1" method="post">
               <div class="form-group">
                  <input type="text" class="form-control" id="id" name="id"
                     placeholder="아이디">
               </div>
               <div class="form-group">
                  <input type="text" class="form-control" id="name" name="name"
                     placeholder="이름">
               </div>
               <div class="forgot"></div>
               <button type="submit" class="btn btn-primary" id="btn">비밀번호
                  찾기</button>
               <button type="reset" class="btn btn-primary">다시 입력</button>
            </form>
         </div>
         <p class="botto-text">Designed by Jooddol</p>
      </div>
   </div>
</body>
</html>