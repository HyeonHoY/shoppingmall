<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	width: 600px;
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
</head>
<body id="FindPwForm">
	<div class="container">
		<h1 class="form-heading">Find id</h1>
		<div class="find-pw-form">
			<div class="main-div">
				<div class="panel">
					<h2>아이디 찾기</h2>
					<br>
				</div>
				${userId}<br> <br>
				<div>
					<c:choose>
						<c:when test="${userId == '아이디를 찾을 수 없습니다.'}">
							<a href="${path}/sm/login/inquiryId.do" class="btn btn-primary"
								id="id_find_click">아이디 찾기</a>
						</c:when>

						<c:otherwise>
							<a href="${path}/sm/login/inquiryPw.do" class="btn btn-primary"
								id="pw_find_click">비밀번호 찾기</a>
						</c:otherwise>
					</c:choose>
					<a href="${path}/sm/" class="btn btn-primary">메인으로 가기</a>
				</div>

			</div>
			<p class="botto-text">Designed by Jooddol</p>
		</div>
	</div>
</body>
</html>