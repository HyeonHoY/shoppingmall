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
	width: 300px;
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
	
	//비밀번호 폼점검
	$("#pw").blur(function() {
		
			var pw = document
					.getElementById("pw").value;
			console.log("pw : " + pw);
			var regex = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W).{8,20}$/;
			if (regex.test(pw)) {
				document
						.getElementById("pwdCheck").innerHTML = "";
				document.getElementById("pw").style.border = "";
			} else {
				document
						.getElementById("pwdCheck").innerHTML = "패쓰워드는 특수문자, 숫자, 영문자대소문자를 혼합하여 8~20자로 입력합니다.";
				document
						.getElementById("pwdCheck").style.color = "red";
				document
						.getElementById("pwdCheck").style.fontSize = "11px"
				document.getElementById("pw").style.border = "thick solid #FF0000";
				document.getElementById("pw").value = '';
				document.getElementById("pw")
						.focus();
			}
	});
	//비밀번호 폼점검 끝
	
	$("#btn").click(function() {
		
		var userPw = $("#pw").val();
		if (userPw == "") {
			alert("바꾸실 비밀번호를 입력하세요. ");
			$("#pw").focus();
			return;
		}
		var ask = window
				.confirm("비밀번호를 변경하시겠습니까?");
		if (ask == true && pwck == 1) {
			alert("변경이 완료 되었습니다.");
			document.form1.action = "${path}/sm/login/updatePw.do?id=${userId}";
			document.form1.submit();
		} else {
			alert("변경하실 비밀번호를 다시 확인해 주세요.");
			return;
		}
	});
});

	var pwck = 0;
	function checkPwd() {
		var f = document.forms[0];//여러개의 폼 중 하나
		var pw1 = f.pw.value;
		var pw2 = f.pwCheck.value;
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
</script>
</head>
<body id="FindPwForm">
	<div class="container">
		<h1 class="form-heading">Find password</h1>
		<div class="find-pw-form">
			<div class="main-div">
				<div class="panel">
					<h2>비밀번호 변경</h2>
					<br> 변경하실 비밀번호를 입력해주세요.

				</div>
				<form id="FindPw" name="form1" method="post">
					<div class="form-group mb-2">
						<br> <input type="password" class="form-control" id="pw"
							name="pw" placeholder="새 비밀번호"> &nbsp;
						<div id="pwdCheck" class="mb-2"></div>
						<input type="password" class="form-control" id="pwCheck"
							name="pwCheck" placeholder="비밀번호 확인" onkeyup="checkPwd()">
						&nbsp;
						<div id="checkPwd"></div>
					</div>

					<button type="button" class="btn btn-primary" id="btn" name="btn"
						value="${userId}">비밀번호 변경</button>
				</form>
			</div>
			<p class="botto-text">Designed by Jooddol</p>
		</div>
	</div>
</body>
</html>