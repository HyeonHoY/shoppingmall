<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<title>SM</title>
</head>
<style>
.carousel-inner img {
      width: 100%;
      height: 100%;
  }
</style>
<body>
	<!-- carousel -->
	<!-- <div id="carouselExampleIndicators" class="carousel slide m-3" data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		
		<div class="carousel-inner" role="listbox">
			<div class="carousel-item active">
				<img class="d-block img-fluid" src="http://placehold.it/900x350"
					alt="First slide">
			</div>
			<div class="carousel-item">
				<img class="d-block img-fluid" src="http://placehold.it/900x350"
					alt="Second slide">
			</div>
			<div class="carousel-item">
				<img class="d-block img-fluid" src="http://placehold.it/900x350"
					alt="Third slide">
			</div>
		</div>
		
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div> -->
	<!-- carousel -->

<div class="row mx-auto cont">
	<c:forEach var="product" items="${productList}" varStatus="st">
		<div class="col-lg-4 col-md-6 my-2">
			<div class="card h-100">
				<a href="${path}/sm/product/detail/${product.productId}">
					<img class="card-img-top" height="400"
						 src="<c:url value='/product/${product.productId}/${product.productTitleImg}'/>">
				</a>
				<div class="card-body">
					<h4 class="card-title">
						<a href="${path}/sm/product/detail/${product.productId}">
							${product.productName}</a>
					</h4>
					<h5>${product.productPrice}</h5>
					<p class="card-text">${product.productId}</p>
				</div>
				<div class="card-footer">
					<small class="text-muted">&#9733; &#9733; &#9733; &#9733;
						&#9734;</small>
				</div>
			</div>
		</div>
	</c:forEach>
</div>
	
</body>
</html>