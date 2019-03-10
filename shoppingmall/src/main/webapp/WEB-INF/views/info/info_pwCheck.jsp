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

<title>My page</title>

<script>
$(document).ready(function() {
	$("#btn").click(function() {
		
		var userPw = $("#pw").val();
		alert("userPw : " + userPw);
		var memberPw = $("#memberPw").val();
		if (userPw == "") {
			alert("비밀번호를 입력하세요. ");
			$("#pw").focus();
			return;
		}
		if (userPw == memberPw) {
			document.form1.action = "${path}/sm/login/view.do"
			document.form1.submit();
			document
					.getElementById("pwCheck").innerHTML = "";
			document.getElementById("pw").style.border = "";
		} else {
			document
					.getElementById("pwCheck").innerHTML = "비밀번호가 일치하지 않습니다.";
			document
					.getElementById("pwCheck").style.color = "red";
			document
					.getElementById("pwCheck").style.fontSize = "11px"
			document.getElementById("pw").style.border = "thick solid #FF0000";
			document.getElementById("pw").value = '';
			document.getElementById("pw")
					.focus();
			return;
		}

	});
});
</script>
</head>
<body id="FindPwForm">
	<header class="bg-primary text-white mb-2">
      <div class="container text-center">
        <br><br>
        <h1>내 정보</h1>
        <br><br>
        <!-- <p class="lead"></p> -->
      </div>
    </header>

	<div class="container">
		<h1 class="form-heading">Find id</h1>
		<div class="find-pw-form">
			<div class="main-div">
				<div class="panel">
					<h2>비밀번호 입력</h2>
					<br>
				</div>
				<form id="FindPw" name="form1" method="post">
					<div class="form-group">
						<input type="hidden" id="memberPw" name="memberPw"
							value="${member.pw}"> <input type="password"
							class="form-control" id="pw" name="pw" placeholder="비밀번호">
					</div>
					<div id="pwCheck" class="mb-2"></div>
					<button type="button" class="btn btn-primary" id="btn" name="btn">확인</button>
				</form>
			</div>
			<p class="botto-text">Designed by Jooddol</p>
		</div>
	</div>
</body>
</html>