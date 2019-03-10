<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>		<!-- 논리적 -> jstl  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>	<!-- 스프링 폼과 에러 사용 -->
<!DOCTYPE html>
<html lang="ko-kr">
<style>
body#LoginForm {
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
   border-radius : 2px;
   margin : auto;
   display : flex;
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

.login-form  .btn-success {
   background : #007BFF none repeat scroll 0 0;
   border-color : #007BFF;
   color : #ffffff;
   font-size : 14px;
   width : 120px;
   height : 50px;
   line-height : 50px;
   padding : 0;
}

.login-form  .btn-primary {
   background : #007BFF none repeat scroll 0 0;
   border-color : #007BFF;
   color : #ffffff;
   font-size : 14px;
   width : 120px;
   height : 50px;
   line-height : 50px;
   padding : 0;
}

.login-form  .btn-danger {
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
   margin-top : 10px;
}

.back a {
   color : #444444;
   font-size : 13px;
   text-decoration : none;
}

/* id 부분  */
.div_align {
   background : yellow;
   text-align : left;
   margin-left : 0px;
}

.div_align2 {
   background : cyan;
   text-align : left;
}

.div_row {
   background : green;
}
</style>
<!-- 주소검색 : daum -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link rel="stylesheet" href="<c:url value='/css/memberForm.css'/>">
<script src="<c:url value='/js/custom/datepicker.ko.js' />"></script>
<script src="<c:url value='/js/custom/memberValid.js' />"></script>
<!-- ----------------------------------------------------------------------- -->
<script>

   //아이디 체크여부 확인 (아이디 중복일 경우 = 1 , 중복이 아닐경우 = 0 )
   var idck = 0;
   $(function() {
      //idck 버튼을 클릭했을 때 
      $("#idck").click(function() {
    	  
         alert("idck")
         
         $.ajax({
            async : false,
            type : 'POST',
            dataType : 'text',
            url : "${pageContext.request.contextPath}/member/idCheck.do",
            data : {
               id : $('#id_fld').val()
            }, // data 
            success : function(data) {
            	
               alert(data);
               console.log("아이디 중복 점검 수신 !");
               if (data == 1) {

                  alert("아이디가 존재합니다. 다른 아이디를 입력해주세요.");
                  
                  //아이디가 존재할 경우 빨강으로 , 아니면 파랑으로 처리하는 디자인
                  $(".result .msg").text("사용 불가한 아이디입니다.")
                  $(".result .msg").attr("style", "color : #f00")
                  $("#id_fld").focus();
                  idck = 0;

               } else {
            	   
                  alert("사용가능한 아이디입니다.");
                  
                  //아이디가 존재할 경우 빨강으로 , 아니면 파랑으로 처리하는 디자인
                  $(".result .msg").text("사용 가능한 아이디입니다.")
                  $(".result .msg").attr("style", "color : #00f")
                  $("#pw").focus();
                  //아이디가 중복하지 않으면  idck = 1 
                  idck = 1;

               }
            },
            error : function(error) {

               alert("error : " + error);
               
            }
         });
      });
      
   });
   
   
   /////////////////////////////////////////////////////////////////////////////
   var pwck = 0;
   //비밀번호 일치 확인
   function checkPwd() {
	   
      var f = document.forms[0];//여러개의 폼 중 하나
      var pw1 = f.pw.value;
      var pw2 = f.pw_check.value;
      
      if (pw1 == pw2) {
    	  
         document.getElementById("checkPwd").style.color = "blue";
         document.getElementById("checkPwd").innerHTML = "암호가 확인되었습니다.";
         pwck = 1;
         
      } else {
    	  
         document.getElementById("checkPwd").style.color = "red";
         document.getElementById("checkPwd").innerHTML = "동일한 비밀번호가 아닙니다.";
         pwck = 0;
         
      }
   }
   
   
   //아이디 패턴 점검
   function idCheck(){
	   
      //alert("test");
      var f = document.forms[0];//여러개의 폼 중 하나
      var regex = /^[a-z]{1}(?=.*[a-z]).{7,19}$/;

      if(regex.test(f.id.value)){
    	  
         document.getElementById("idCheck").innerHTML = "";      
         document.getElementById("id_fld").style.border="";
         
      } else {
    	  
         document.getElementById("idCheck").style.color="red";
         document.getElementById("idCheck").style.fontSize="11px";
         document.getElementById("idCheck").innerHTML = "아이디는 영문자소문자 8~20자로 입력합니다.";
         document.getElementById("id_fld").style.border="thick solid #FF0000";
         
      } 
   }
   
   
   //비밀번호 패턴 점검
   function pwCheck(){
	   
      //alert("test");
      var f = document.forms[0];//여러개의 폼 중 하나
      var regex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,20}$/;
      
      if(regex.test(f.pw.value)){
    	  
         document.getElementById("pwCheck").innerHTML = "";      
         document.getElementById("pw").style.border="";
         
      } else {
    	  
         document.getElementById("pwCheck").style.color="red";
         document.getElementById("pwCheck").style.fontSize="11px";
         document.getElementById("pwCheck").innerHTML = "패쓰워드는 특수문자, 숫자, 영문자대소문자를 혼합하여 8~20자로 입력합니다.";
         document.getElementById("pw").style.border="thick solid #FF0000";
         
      } 
   }
   
   
   /////////////////////////////////////////////////////////////////////////////
   // 회원가입 버튼
   $(function() {
	   
      $("#birthday").datepicker();
      $("#submit_btn").click(function() {
    	  
         combineEmail();
         combinePhone();
         
         if (confirm("회원가입 하시겠습니까?")) {
        	 
            if (idck == 0 && pwck == 0) {
            	
               alert("아이디 중복점검과 비밀번호를 확인해주세요");
               return false;
               
            } else {
            	
               document.getElementById("test").submit();
               
            }
         }
      });
   });

   
   // 리셋 버튼
   $(function() {
      $("#reset_btn").click(
            
            function() {
            	
               var ask = window.confirm("메인 화면으로 가시겠습니까?");
               
               if (ask) {
                  location.href = "${pageContext.request.contextPath}";
               }
               
         });
   });
</script>
<!-- ----------------------------------------------------------------------- -->
<title>회원가입</title>
</head>
<body id="LoginForm">
   <h1 class="form-heading">login Form</h1>
   <div class="login-form">
      <div class="main-div">
         <div id="memberJoinBody" class="container mb-2">
         <div class="panel">
            <h2>회원 가입</h2>
            <br>
         </div>
            
            <!-- form -->
            <form:form id="test" 
                       commandName="memberValid" 
                       method="POST"
                       style="left:300px; position:relative;"      
                       action="joinValid.do">

               <!-- 아이디 시작 -->
               <div class=" form-group form-inline">
                  
                  <!-- 아이디 입력 폼 -->
                  <form:input class="form-control col-lg-4 mr-2"
                           name="id_fld" id="id_fld" path="id" maxlength="20" size="25"
                           placeholder="아이디" onkeyup="idCheck()"/>
                           
                  <!-- 아이디 중복 검사 -->
                  <input type="button" id="idck" name="idck" value="아이디  중복 검사"
                        class="btn_style btn btn-secondary col-lg-2.4 mr-2">&nbsp;
                        
                  <!-- 메시지 -->
                  <p class="result col-lg-3.2" style="font-size:16px">
                     <span class="msg"></span>
                  </p>
                  
               </div>
               
               <!-- 아이디 에러문구 -->
               <div>
                  <div id="idCheck" class="col-lg-5" style="text-align:left"></div>
                  <form:errors path="id" cssClass="err" />
               </div>
               <!-- 아이디 끝 -->

               <!-- 비밀번호  시작-->
               <div class=" form-group form-inline">
                  <form:password class="form-control col-lg-4 " name="pw" id="pw"
                              path="pw" maxlength="20" size="25" placeholder="비밀번호" onkeyup="pwCheck()"/>
               </div>
               
               <!-- 비밀번호 에러문구 -->
               <div>
                  <div id="pwCheck" class="col-lg-5" style="text-align:left">
                     <form:errors path="pw" cssClass="err" />
                  </div>
               </div>
               
               <!-- 비밀번호 확인 -->
               <div class="form-group form-inline">
                  <input type="password" class="form-control col-lg-4 mr-2"
                     name="pw_check" id="pw_check" maxlength="20" size="25"
                     placeholder="비밀번호 확인" onkeyup="checkPwd()" /> &nbsp;
                  <div id="checkPwd"></div>
               </div>
               <!-- 비밀번호 끝 -->
               
               <!-- 이름 -->
               <div class="form-group form-inline">
                  <form:input class="form-control col-sm-4" name="name" path="name"
                     maxlength="50" size="25" placeholder="Enter name" />
               </div>
               
               <!-- 이름 에러 -->
               <div class="col-lg-5" style="text-align:left;">
                  <form:errors path="name" cssClass="err" />
               </div>
               <!-- 이름 끝 -->
               
               <!-- 성별 -->
               <div class="form-group form-inline row">
                  <div class="col-lg-4 ml-3">
					성별 : Male&nbsp;<form:radiobutton path="gender" value="남자" />&nbsp;&nbsp; 
                     Female&nbsp;<form:radiobutton path="gender" value="여자" />&nbsp;
                  </div>
               </div>
               
               <!-- 성별 에러 -->
               <div class="col-lg-5" style="text-align:left;">
                  <form:errors path="gender" cssClass="err" />
               </div>
               <!-- 성별 끝 -->
               
               <!-- 핸드폰 -->
               <div class="clearfix">
                  <label for="phone" class="float-left">연락처</label>
               </div>
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
                                 class="form-control col-sm-1 text-center"> 
                  - 
                  <input name="phone3" id="phone3" maxlength="4" size="5" 
                           class="form-control col-sm-1 text-center"> 
                  <input type="hidden" name="phone" id="phone">&nbsp;
                  
               </div>
               
               <!-- 연락처 에러 -->
               <div class="col-lg-5" style="text-align:left;">
                  <form:errors path="phone" cssClass="err" />
               </div>
               <!-- 연락처 끝 -->
               
               <!-- 이메일 -->
               <div class="clearfix">
                  <label for="email" class="float-left">이메일</label>
               </div>
               <div class="form-group form-inline">    
                  <input name="email1" id="email1" maxlength="50" size="25"
                     class="form-control col-sm-2"> @ <select id="email2"
                     name="email2" class="form-control col-sm-2">
                     <option>naver.com</option>
                     <option>daum.net</option>
                     <option>empal.com</option>
                     <option>nate.com</option>
                     <option>paran.com</option>
                     <option>직접 입력</option>
                  </select>&nbsp; <input name="email3" id="email3" maxlength="50" size="25"
                     class="form-control col-sm-2">&nbsp; <input
                     type="hidden" name="email" id="email" >
               </div>
               
               <!-- 이메일 에러 -->
               <div class="col-lg-5" style="text-align:left;">
                  <form:errors path="email" cssClass="err" />
               </div>
               <!-- 이메일 끝 -->
               
               <!-- 우편번호 및 도로명 주소 -->
               <div class="clearfix">
                  <label for="zip" class="float-left">주소</label>
               </div>
               
               <!-- 우편번호 -->
               <div class="form-group form-inline">
                  <form:input id="zip" name="zip" path="zip" maxlength="5" size="6"
                     class="form-control col-sm-2" placeholder="우편번호" readonly="true" />
                  &nbsp;&nbsp; <input type="button" id="zip1btn" value="도로명 주소검색"
                     class="btn_style btn btn-secondary" onClick="road_Postcode()">
               </div>
               <form:errors path="zip" cssClass="err" />
               
               <!-- 도로명 주소 -->
               <div class="form-group form-inline">
                  <input type="text" class="form-control col-sm-7 mb-2" id="roadAddr1"
                     placeholder="도로명 주소" name="roadAddr1" maxlength="200" size="75"
                     readonly>&nbsp;
                  <form:errors path="roadAddr1" cssClass="err" />
                  <br> 
                  <input type="text" class="form-control col-sm-7"
                     id="roadAddr2" placeholder="상세주소" name="roadAddr2"
                     maxlength="200" size="75">&nbsp;
                  <form:errors path="roadAddr2" cssClass="err" />
               </div>
               
               <!-- 생년월일 -->
               <div class="form-group form-inline mb-2">
                  <div class="col-sm-1.5">
                     <div class="clearfix">
                        <label for="birthday" class="float-left">생년월일</label>
                     </div>
                  </div>&nbsp;&nbsp;
                  <form:input name="birthday" path="birthday" size="30" class="form-control col-sm-2"
                     type="date" />
                  <!--  반드시 type="date" 삽입  -->
                  <div class="col-sm-3" style="text-align:left;">
                     <spring:hasBindErrors name="memberValid">
                        <c:if test="${errors.hasFieldErrors('birthday')}">
                           <span class="err">${birthday_error}</span>
                        </c:if>
                     </spring:hasBindErrors>
                  </div>
               </div>
               
               <!-- 가입일 -->
               <input type="hidden" id="joindate" name="joindate" maxlength="10" size="12">
               
               <!-- 버튼  -->
               <div class="form-group form-inline mb-2 col-sm-11 float-right">
                  <input class="btn btn-primary" type="button" id="submit_btn"
                        name="submit_btn" value="회원가입" /> &nbsp;&nbsp; 
                  <input type="button" id="reset_btn" name="reset_btn"
                        class="btn btn-danger" value="취소" />&nbsp;&nbsp; 
               </div>
            </form:form>
         </div>
         <!-- memberJoinBody -->
      </div>
      <!-- main-div -->
   </div>
   
</body>
</html>