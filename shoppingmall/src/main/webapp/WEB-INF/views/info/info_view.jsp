<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Scrolling Nav - Start Bootstrap Template</title>
</head>
  <body id="page-top">

    <header class="bg-primary text-white mb-2">
      <div class="container text-center">
        <br><br>
        <h1>내 정보</h1>
        <br><br>
        <!-- <p class="lead"></p> -->
      </div>
    </header>

    <section id="about">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto">
          <h2>프로필         
			<c:choose>
				<c:when test="${sessionScope.role == 'role_admin'}">
					<a class="btn btn-danger" href="${path}/sm/admin/delete.do?id=${dto.id}" 
						role="button" style="text-align:center;">삭제</a>
				</c:when>
				<c:otherwise>
					<a class="btn btn-danger" href="${path}/sm/member/delete.do" 
						role="button" style="text-align:center;">삭제</a>
				</c:otherwise>
			</c:choose>
		  </h2>
            <p class="lead">
            	이름 : ${dto.name}<br>
            	아이디 : ${dto.id}<br>
			</p>
          </div>
        </div>
      </div>
    </section>

    <section id="services" class="bg-light">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto">
     
            <p class="lead">
            	<h2>연락처   			 
            	<div class="btn-group" role="group" aria-label="Basic example">
            		<c:choose>
						<c:when test="${sessionScope.role == 'role_admin'}">
							<a class="btn btn-primary" href="${path}/sm/admin/update.do?menu=2&id=${dto.id}" 
								role="button" style="text-align:center;">전화번호 수정</a>
  							<a class="btn btn-primary" href="${path}/sm/admin/update.do?menu=3&id=${dto.id}" 
  								role="button" style="text-align:center;">이메일 수정</a>
						</c:when>
						<c:otherwise>
							<a class="btn btn-primary" href="${path}/sm/member/update.do?menu=2" 
								role="button" style="text-align:center;">전화번호 수정</a>
  							<a class="btn btn-primary" href="${path}/sm/member/update.do?menu=3" 
  								role="button" style="text-align:center;">이메일 수정</a>
						</c:otherwise>
					</c:choose>
				</div>
            	</h2>
            	<p class="lead">
            	전화번호 : ${dto.phone}<br>
            	이메일 : ${dto.email}
            	</p>   	
            </p>
          </div>
        </div>
      </div>
    </section>

    <section id="contact">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto">
          <br>
            <h2>배송지 주소
            	<c:choose>
					<c:when test="${sessionScope.role == 'role_admin'}">
						<a class="btn btn-primary" role="button" style="text-align:center;"
							href="${path}/sm/admin/update.do?menu=4&id=${dto.id}" >수정</a>
					</c:when>
					<c:otherwise>
 						<a class="btn btn-primary" role="button" style="text-align:center;"
 							href="${path}/sm/member/update.do?menu=4" >수정</a>
					</c:otherwise>
				</c:choose>
            </h2>
            <p class="lead">
            	우편번호 : ${dto.zip}<br>
            	상세주소 : ${dto.address}<br>
            </p>
          </div>
        </div>
      </div>
    </section>
  </body>
</html>