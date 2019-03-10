<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<style>
input {
	width: 440px;
}

form#registrationForm {
	margin: 15px;
}
/* 
section#writeForm {
	border: 1px solid #ccc;
}
 */
textarea {
	resize: none;
}

/* 파일 필드 숨기기 */
 input[type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	 padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0); 
	border: 0;
}

.upload label {
	display: inline-block;
	padding: .5em .75em;
	color: #3399ff;
	font-size: 12px;
	line-height: normal;
	vertical-align: middle;
	background-color: #fdfdfd;
	cursor: pointer;
	border: 1px solid #ebebeb;
	border-bottom-color: #e2e2e2;
	border-radius: .25em;
}
</style>
<script src="<c:url value='/js/custom/fileUpload.js' />"></script>
<script>

	// AngularJS
	var app = angular.module('registrationFormApp', []);

	app.controller('registrationFormController', function($scope) {
		
		// 최종  폼점검
		$scope.formFinalCheck = function($event) {

// 			alert("최종 폼점검");
			
// 			alert("상품 가격 : " + $scope.registrationForm.productPrice.$valid);
// 			alert("품번 : " + $scope.registrationForm.productId.$valid);
// 			alert("상품 가격 : " + $scope.registrationForm.productPrice.$valid);
// 			alert("상품 재고 : " + $scope.registrationForm.productStock.$valid);
// 			alert("상품 이미지 : " + $scope.registrationForm.productImg.$valid);
			
// 			alert("상품명 : " + $scope.registrationForm.productName.$valid);
// 			alert("상품 설명 : " + $scope.registrationForm.productContent.$valid);
			
			if ($scope.registrationForm.productName.$valid == true &&
				$scope.registrationForm.productId.$valid == true &&
				$scope.registrationForm.productPrice.$valid == true &&
				$scope.registrationForm.productStock.$valid == true ) {
				// $scope.registrationForm.productImg.$valid == true) {
				// $scope.registrationForm.mainCategory.$valid == true &&
				// $scope.registrationForm.productContent.$valid == true
				
				// alert("폼점검 완료");

				document.registrationForm.action = "productRegistration.do";
				document.registrationForm.submit();

			} else {

				// alert("폼점검 미완료");
				document.registrationForm.productName.focus();

			} // else
		} // formFinalCheck
		
		
	}); // controller
	
	
	// 카테고리 설정
	var topSubCategory = new Array("맨투맨", "후드티", "티셔츠");
	var bottomSubCategory = new Array("슬랙스", "면바지", "청바지");
	
	function changeSelect(value) {
		
	    document.all.subCategory.length=1;
	    
		 if(value == '상의') {
			for(i=0; i<topSubCategory.length; i++) {
			    option = new Option(topSubCategory[i]);
			    document.all.subCategory.options[i+1] = option;
			    document.all.subCategory.options[i+1].value = topSubCategory[i];
			}
			alert("옵션 값 : " + value);
		 } else if(value == '하의') {
			 
			for(i=0; i<bottomSubCategory.length; i++) {
			    option = new Option(bottomSubCategory[i]);
			    document.all.subCategory.options[i+1] = option;
			    document.all.subCategory.options[i+1].value = bottomSubCategory[i];
			}
		 } // if 하의
	}
	
	
	/* 이미지 미리보기 및 파일명 출력 */
	$(document).ready(function(){
			
		// var fileName = $("#picUpload").val().split("\\");
		var num = 1;
		
		//  이미지 미리보기 함수(상품 설명)
        $('#productExplainImg').change(function() {
       		addPreview(this.files, "productExplain"); //preview form 추가하기
        }); // function
        
    	//  이미지 미리보기 함수(상품명)
        $('#productTitleImg').change(function() {
       		addPreview(this.files, "titleImgDiv", '50', '50'); //preview form 추가하기
        }); // function
		
	});	// jQuery
	
</script>
<title>자유게시판 글쓰기</title>
</head>
<body ng-app="registrationFormApp"
	ng-controller="registrationFormController">

	<h5 class="my-4" style="text-align: center">게시글 작성</h5>
	<br>

	<!--
		 HTTP Status 400 – Bad Request
		 Required String parameter 'subject' is not present
		 
		 위의 에러가 뜰시 form태그에서 아래에 2줄을 주석처리하거나 삭제할 것!
		 
		 modelAttribute="uploadForm"
		 enctype="multipart/form-data" 
	-->

	<form method="post" 
			   id="registrationForm" 
			   name="registrationForm"
			   enctype="multipart/form-data"
			   ng-model="registrationForm" 
			   ng-submit="formFinalCheck()">

		<section id="writeForm" class="border">
			<table id="writeForm" class="table table-hover m-auto">

				<!-- 상품명 -->
				<tr>
					<th class="col-xs-1">상품명</th>
					<td>
						<div class="form-inline">
							<input type="text" id="productName" name="productName" class="form-control"
								   ng-model="productName" placeholder="제목을 입력하세요." />
							<!-- (게시판에 내용에 들어감) -->
							&nbsp;&nbsp;
							<label for="productTitleImg">
								<i class='far fa-file-image'></i>&nbsp; 상품 타이틀
							</label> 
						 	<input type="file" id="productTitleImg" name="productTitleImg" multiple />
						 	<div id="titleImgDiv"></div>
						</div> 
					</td>
				</tr>

				<!-- 카테고리 설정 -->
				<tr>
					<th class="col-xs-1" style="font-size:12px;">주 카테고리</th>
					<td colspan=3>
						<div class="form-group">
		                  <select id="mainCategory" name="mainCategory" class="form-control col-sm-4"
		                  		  onChange="changeSelect(value)" ng-model="mainCategory">
		                     <option selected>메인</option>
		                     <option value="상의">상의</option>
		                     <option value="하의">하의</option>
		                  </select> 
		                </div>
					</td>
					<th class="col-xs-1" style="font-size:12px;">부 카테고리</th>
					<td colspan=4>
						<div class="form-group">
		                  <select id="subCategory" name="subCategory" class="form-control col-sm-4"
		                  		  ng-model="subCategory">
		                     <option>서브</option>
		                  </select> 
		                </div>
					</td>
				</tr>
				
				<!-- 품번 / 가격 / 재고 등록 -->
				<tr>
					<!-- 품번 -->
					<th>품번</th>
					  <td colspan="2">
						<input type="text" id="productId" name="productId" class="form-control"
							   ng-model="productId">
					  </td>
						
					<!-- 가격 -->
					<th>가격</th>
					  <td colspan="1">
						<input type="text" id="productPrice" name="productPrice" class="form-control"
							   ng-model="productPrice">
					  </td>
					
					<!-- 재고 -->
					<th>재고</th>
					  <td colspan="1">
						<input type="text" id="productStock" name="productStock" class="form-control"
							   ng-model="productStock">
					  </td>
				</tr>
				
				<!-- 파일첨부 -->
				<tr>
					<th>파일첨부</th>
					<td colspan="5">
						<div class="upload">

							<!-- 사진업로드(게시판에 내용에 들어감) -->
							<label for="productExplainImg">
								<i class='far fa-file-image'></i>&nbsp;사진
							</label> 
							<!-- <input type="file" id="productImg_1" name="productImg" ng-model="productImg"
								   multiple onchange="getCmaFileView(this,'all')"/> -->
						 	<input type="file" id="productExplainImg" name="productExplainImg" multiple />
							&nbsp;&nbsp;
						</div>
					</td>
				</tr>

				<!-- 내용 // textarea 필드에 공백이 들어가있음. 수정해야됨-->
				<tr>
					<th>상품 설명</th>
					<td id="explain_td">
						<div id="productExplain" contentEditable="true" style="height:400px" class="form-control" data-placeholder="내용을 입력해주세요."></div>
						<input type="hidden" name="hiddenExplain" id="hiddenExplain">
					</td>
				</tr>
			</table>

		</section>
		<br>
		

		<!-- 등록 버튼 -->
		<input type="submit" style="float: right; width: 100px; margin: 10px;"
			class="btn btn-outline-primary" id="submitBoard" value="등록"
			ng-disabled="registrationForm.$invalid">
		<br>
		<br>
	</form>
</body>
</html>