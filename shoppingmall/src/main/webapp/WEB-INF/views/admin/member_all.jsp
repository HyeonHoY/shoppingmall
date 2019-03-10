<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<style>
body#LoginForm {
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
	padding: 0;
	font-size : 11px;
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

.login-form .form-control {
	background: #f7f7f7 none repeat scroll 0 0;
	border: 1px solid #d4d4d4;
	border-radius: 4px;
	font-size: 14px;
	height: 50px;
	line-height: 50px;
}


.login-form .form-group {
	margin-bottom: 10px;
}

.login-form {
	text-align: center;
}

.forgot a {
	color: #777777;
	font-size: 14px;
	text-decoration: underline;
}

.login-form  .btn.btn-success {
	background: #007BFF none repeat scroll 0 0;
	border-color: #007BFF;
	color: #ffffff;
	font-size: 14px;
	width: 120px;
	height: 50px;
	line-height: 50px;
	padding: 0;
}

.btn.btn-danger {
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

.login-form .btn.btn-success.reset {
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

div.container{
	width:1200px;
}
</style>

<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Shop Homepage - Start Bootstrap Template</title>

<script>
	$(document).ready(function(){
		
		$('[data-toggle="tooltip"]').tooltip();
	    $('[data-toggle="popover"]').popover(); 
		
		$("[id^=updateRole_]").click(function(e){
			
			var st = e.target.id.split("_")[1];
			var role = $("#role_change").val();
			
			console.log("role="+role);
			
			if(confirm("정말로 권한을 바꾸시겠습니까?")) {
				 $.ajax({
		               
		               type : 'get',
		               url : '${pageContext.request.contextPath}/admin/roleUpdate.do',
		               data : {
		                  id : $("#id_"+st+"").val(),
		                  role : role
		               }, 
		               
		               success : function(data){

		                  console.log("data="+data);
		                  
		                  $("div[id=roleDiv_"+st+"]").html("<div id='roleDiv_"+st+"'>"+data+"</div>");
		               },
		               
		               error : function(xhr, status) {
		                  alert("error");
		               }
		            }); // ajax
		            
		         } 
		      });
		   });
		</script>


</head>
<body>
	<!-- 서버에 페이지처리를 위한 start, end 변수의 값과 검색을 하기 위한 keyword, searchOption을 submit하기 위한 폼 -->
	<form method="get"
		action="${path}/sm/admin/search/list.do?
								start=1&end=10&
								searchOption=${map.searchOption}&
								keyword=${map.keyword}">
		
		<!-- searchOption을 선택하기위한 select 태그 -->
		<select name="searchOption">
			<option value="all"
				<c:out value="${map.searchOption=='all' ? 'selected':''}" />>전체</option>

			<option value="m.id"
				<c:out value="${map.searchOption=='id'?'selected':''}"/>>아이디</option>
			<option value="m.name"
				<c:out value="${map.searchOption=='name'?'selected':''}"/>>이름</option>
			<option value="m.email"
				<c:out value="${map.searchOption=='email'?'selected':''}"/>>이메일</option>
			<option value="m.phone"
				<c:out value="${map.searchOption=='phone'?'selected':''}"/>>핸드폰번호</option>
			<option value="r.role"
				<c:out value="${map.searchOption=='role'?'selected':''}"/>>등급</option>
		</select> 
		<input type="text" name="keyword" id="keyword" value="${map.keyword}">
		<input type="submit" value="검색">
	</form>

	<!-- 검색 옵션이 없을 경우 모든 멤버의 개수만 나타나고, 검색 옵션이 존재할 경우 키워드와 검색시 나타나는 멤버 카운트 -->
	<div>
		모든 멤버 개수 : ${count} ${map.allCount}<br>
		<c:if test="${not empty map.searchOption}">
			키워드 : ${map.keyword}<br>
			검색된 멤버 개수 : ${map.count}<br>
		</c:if>
	</div>
<body id="LoginForm">

	<div class="container">
		<!-- 세션에 저장된 등급이 관리자 계정일 경우 실행하는 조건문 -->
		<c:choose>
			<c:when test="${sessionScope.role == 'role_admin'}">
				<table class="table table-sm table-striped table-hover">
					<thead class="thead-dark">
						<tr class="info" align="center">
							<th>아이디</th>
							<th>비밀번호</th>
							<th>이름</th>
							<th>성별</th>
							<th>이메일</th>
							<th>전화번호</th>
							<th>우편번호</th>
							<th>주소</th>
							<th>생년월일</th>
							<th>가입날짜</th>
							<th>수정날짜</th>
							<th>등급</th>
						</tr>
					</thead>
					<tbody>
						<!-- 관리자 등급이면서 검색옵션이 없을 경우 반복문 실행 -->
						<c:if test="${empty map.searchOption}">
							<c:forEach var="row" items="${list}" varStatus="st">
								<tr align="center">
									
									<td><input type="hidden" id="id_${st.count}" value="${row.id}">
										<a href="${path}/sm/admin/view.do?id=${row.id}">
										${row.id} </a></td>
									<td>${row.pw}</td>
									<td>${row.name}</td>
									<td>${row.gender}</td>
									<td>${row.email}</td>
									<td>${row.phone}</td>
									<td>${row.zip}</td>
									<%-- <td>${fn:replace(row.address, "*", " ")}</td> --%>
									<td>
										 <!-- 긴 주소 일부만 보이도록 조치 : 클릭 (click)하면 팝업으로 보이도록 조치 -->
										 <c:set var ="address1Crop" value="${fn:replace(row.address, \"*\",\" \")}" />
										 <a href="#" data-toggle="popover" 
										 			 data-content="${address1Crop}">
										 	${fn:substring(address1Crop,0,6)}..
										 </a>
									</td>						
								
								<%-- 	<td>
										 <!-- 긴 주소 일부만 보이도록 조치 : 롤 오버 (rollover)하면 팝업으로 보이도록 조치 -->
										 <div class="address_reduce_styl">
										 	    <a href="#" data-toggle="tooltip" 
					                                 data-placement="right" 
					                                 title="${fn:replace(row.address, '*', ' ')}">
					                            ${fn:replace(row.address, "*", " ")}
					                            </a>
										 </div>
									</td> --%>
									<td><fmt:formatDate value="${row.birthday}"
															pattern="yyyy년 M월 d일" /></td>
									<td>${row.joindate}</td>
									<td>${row.updatedate}</td>

									<td>
										<div class="form-inline mb-2 mr-sm-2">
										<div id="roleDiv_${st.count}">${row.role}</div>&nbsp;
											<c:if test="${row.role != 'role_admin'}">
												<select id="role_change">
													<option value="role_manager"
														<c:out value="${map.searchOption=='role_manager'?'selected':''}"/>>매니저</option>
													<option value="role_user"
														<c:out value="${map.searchOption=='role_user'?'selected':''}"/>>사용자</option>
												</select> &nbsp;
												<input type="button" value="권한주기" id="updateRole_${st.count}">
											</c:if>
										</div>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<!-- 관리자 계정이면서 검색옵션이 있을경우 반복문 실행 -->
						<c:if test="${not empty map.searchOption}">
							<c:forEach var="row" items="${map.list}">
								<tr align="center">
									<td><a href="${path}/sm/board/view.do?num=${article.boardNum}">
										${row.id} </a></td>
									<td>${row.pw}</td>
									<td>${row.name}</td>
									<td>${row.gender}</td>
									<td>${row.email}</td>
									<td>${row.phone}</td>
									<td>${row.zip}</td>
									<td>${fn:replace(row.address, "*", " ")}</td>
									<td><fmt:formatDate value="${row.birthday}"
															pattern="yyyy년 M월 d일" /></td>
									<td>${row.joindate}</td>
									<td>${row.updatedate}</td>
									<td>${row.role}</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
				<!-- 검색옵션이 없고, 회원정보 리스트가 5개 이상일 경우 실행 -->
				<c:if test="${empty map.searchOption && count > 5}">
					<nav aria-label="Page navigation example">
						<ul class="pagination justify-content-center">
							<!-- search/list.do 매핑에 start, end 전달 -->
							<li class="page-item">
							<a class="page-link"
								href="${path}/sm/admin/allMember.do?start=${rownum-10}&end=${rownum-1}">Previous</a></li>
							<li class="page-item">
							<a class="page-link"
								href="${path}/sm/admin/allMember.do?start=${rownum+10}&end=${rownum+19}">Next</a></li>
						</ul>
					</nav>
				</c:if>

				<!-- 검색옵션이 존재하고, 회원정보 리스트가 5개 이상일 경우 실행 -->
				<c:if test="${not empty map.searchOption && map.count > 5}">
					<nav aria-label="Page navigation example">
						<ul class="pagination justify-content-center">
							<!-- search/list.do 매핑에 start, end, searchOption, keyword 전달 -->
							<li class="page-item">
							<a class="page-link" href="${path}/sm/admin/search/list.do?start=${map.start-10}&end=${map.start-1}&searchOption=${map.searchOption}&keyword=${map.keyword}">Previous</a></li>
							<li class="page-item">
							<a class="page-link" href="${path}/sm/admin/search/list.do?start=${map.start+10}&end=${map.start+19}&searchOption=${map.searchOption}&keyword=${map.keyword}">Next</a></li>
						</ul>
					</nav>
				</c:if>
			</c:when>
			<c:otherwise>
			관리자 계정이 아닙니다!!
		</c:otherwise>
		</c:choose>
		<p class="botto-text"></p>
	</div>
</body>
</html>