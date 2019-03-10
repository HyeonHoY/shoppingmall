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

form#boardWriteForm {
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

<script>
	
	var pw_flag= true;
	
	$(document).ready(function() {
		
		$("#boardPw").attr("disabled",true);
		
		// firefox에서 input태그에 type이 password이면 아이디 자동생성을 방지하기 위한 코드
		$("#boardPw").on("focus", function() {
			
			$(this).attr("type", "password");
			
		});
		
		// 이미지 및 이미지 파일명 미리보기
		$('#picUpload').change(function() {
        	
            addPreview($(this)); //preview form 추가하기
            
    	});
		
		$("input[id^=secret_]").on("click",function(e){
			
			var num = e.target.id.split("_")[1];
			
			console.log(e.target.id+" , num : "+num);
			
			if(num==2){
				pw_flag=true;
				$('#boardPw').val("");
				$('#checkPwd').html("");
				$('#secret_2').prop("checked",true);
				$('#secret_1').prop("checked",false);
			}else{
				$('#secret_1').prop("checked",true);
				$('#secret_2').prop("checked",false);
			}
		});
		
		$("#boardPw").keyup(function(e){
			
			var pw = $("#boardPw").val();
			console.log("pw : "+pw);
			var regex = /^\d{0,10}$/;
			if(!regex.test(pw)){
				$('#checkPwd').html("비밀번호는 숫자로 0~10자로 작성합니다.");
				$('#checkPwd').css("color","red");
				$('#checkPwd').css("padding-top","10px");
				pw_flag=false;
				console.log("pw_flag : "+pw_flag);
			}else{
				$('#checkPwd').html("");
				pw_flag=true;
				console.log("pw_flag : "+pw_flag);
			}
		});
	}); // jQuery

	// AngularJS
	var app = angular.module('boardWriteFormApp', []);
	
	app.controller('boardWriteFormController', function($scope) {
		// 최종  폼점검
		$scope.formFinalCheck = function($event) {

			alert("최종 폼점검");
			console.log("angular form pw_flag  :"+pw_flag);
			if ($scope.boardWriteForm.boardSubject.$valid == true && 
				$scope.boardWriteForm.boardContent.$valid == true &&
				pw_flag == true) {
				
				alert("폼점검 완료");

				document.boardWriteForm.action = "${pageContext.request.contextPath}/board/insert.do";
				document.boardWriteForm.submit();

			} else {

				alert("폼점검 미완료");
				document.boardWriteForm.boardSubject.focus();

			} // else
		} // formFinalCheck
	}); // controller
	
 	var fileName = $("#picUpload").val().split("\\");
 	
    // image preview 기능 구현
    // input = file object[]
    function addPreview(input) {
        if (input[0].files) {
            //파일 선택이 여러개였을 시의 대응
            for (var fileIndex = 0 ; fileIndex < input[0].files.length ; fileIndex++) {
                var file = input[0].files[fileIndex];
                var reader = new FileReader();
 
                reader.onload = function (img) {
                    //div id="preview" 내에 동적코드추가.
                    //이 부분을 수정해서 이미지 링크 외 파일명, 사이즈 등의 부가설명을 할 수 있을 것이다.
                    $("#preview").append(
                        "<img src=\"" + img.target.result + 
                        "\"\ style='width:300px; height:300px'/>"                        
                    );
                };
                
                reader.readAsDataURL(file);
            }
        } else alert('invalid file input'); // 첨부클릭 후 취소시의 대응책은 세우지 않았다.
    }
 
    function getCmaFileInfo(obj,stype) {
   	 
    	// 변수 설정
        var fileObj, pathHeader , pathMiddle, pathEnd, allFilename, fileName, extName;
    	
    	
        if(obj == "[object HTMLInputElement]") {
            fileObj = obj.value
        } else {
            fileObj = document.getElementById(obj).value;
        }
        
        if (fileObj != "") {
                pathHeader = fileObj.lastIndexOf("\\");
                pathMiddle = fileObj.lastIndexOf(".");
                pathEnd = fileObj.length;
                
                // 파일명
                fileName = fileObj.substring(pathHeader+1, pathMiddle);
                extName = fileObj.substring(pathMiddle+1, pathEnd);
                allFilename = fileName+"."+extName;
     
                if(stype == "all") {
                        return allFilename; // 확장자 포함 파일명
                } else if(stype == "name") {
                        return fileName; // 순수 파일명만(확장자 제외)
                } else if(stype == "ext") {
                        return extName; // 확장자
                } else {
                        return fileName; // 순수 파일명만(확장자 제외)
                }
        } else {
                alert("파일을 선택해주세요");
                return false;
        }
        // getCmaFileView(this,'name');
        // getCmaFileView('upFile','all');
     }
     
    function getCmaFileView(obj,stype) {
        var s = getCmaFileInfo(obj,stype);
        $("#picText").text(s);
    }
	
</script>
<title>글쓰기</title>
</head>
<body ng-app="boardWriteFormApp"
	ng-controller="boardWriteFormController">
	
	<h5 class="my-4" style="text-align: center">게시글 작성</h5>
	<br>
	<!--
		 HTTP Status 400 – Bad Request
		 Required String parameter 'subject' is not present
		 
		 위의 에러가 뜰시 form태그에서 아래에 2줄을 주석처리하거나 삭제할 것!
		 
		 modelAttribute="uploadForm"
		 enctype="multipart/form-data" 
	-->

	${productId}
	<form method="post" 
			   id="boardWriteForm" 
			   name="boardWriteForm"
			   enctype="multipart/form-data"
			   ng-model="boardWriteForm" 
			   ng-submit="formFinalCheck()">
		<input type="hidden" id="boardKinds" name="boardKinds" value="${boardKinds}">
		<input type="hidden" id="productId" name="productId" value="${productId}">
		<section id="writeForm" class="border">
			<table id="writeForm" class="table table-hover m-auto">
				
				<!-- 제목 -->
				<tr>
					<th class="col-xs-1">제목</th>
					<td>
						<input type="text" id="boardSubject" name="boardSubject" class="form-control"
							   ng-model="boardSubject" placeholder="제목을 입력하세요." 
							   ng-minlength="2" ng-maxlenght="100" required
							   />
					</td>
				</tr>
				
				<!-- 제목 폼점검 에러 -->
                <tr id="boardSubject_ERR" class="err_msg"
                    ng-show="boardWriteForm.boardSubject.$error.maxlegnth ||
                             boardWriteForm.boardSubject.$error.minlength">
                    <td colspan="2" class="col-xs-12" style="color:red;">게시글 제목을 2~50자 이내로 입력하십시오</td>
                </tr>
                
				<!-- 비밀번호 -->
				<tr>
					<th>비밀번호</th>
					<td>
						<div class="form-inline">
							<input type="password" id="boardPw" name="boardPw" class="form-control col-xs-12"
							 	 maxlength="20" size="25"/> &nbsp;
							<input class="form-control" type="radio" id="secret_1" name="secret_1" value="radio" onClick="this.form.boardPw.disabled=false" >&nbsp;활성&nbsp;
							<input class="form-control" type="radio" id="secret_2" name="secret_2" value="radio" onClick="this.form.boardPw.disabled=true" checked>&nbsp;비활성&nbsp;
						</div>
						<!-- 비밀번호 확인 -->
						<div id="checkPwd"></div>
					</td>
				</tr>

				<!-- 파일첨부 -->
				<tr>
					<th>파일첨부</th>
					<td>
						<div class="upload">
							<!-- 사진업로드(게시판에 내용에 들어감) -->
							<label for="picUpload">
								<i class='far fa-file-image'></i>&nbsp;사진
							</label> 
							<input type="file" id="picUpload" name="picUpload"
								   multiple onchange="getCmaFileView(this,'all')" />
							&nbsp;&nbsp;
							
							<!-- 파일업로드 -->
							<label for="fileUpload"> 
								<i class='far fa-folder-open'></i>&nbsp;파일
							</label> 
							<input type="file" id="fileUpload" />
						</div>
					</td>
				</tr>

				<!-- 내용 // textarea 필드에 공백이 들어가있음. 수정해야됨-->
				<tr>
					<th>내용</th>
					<td><textarea id="boardContent" name="boardContent" class="form-control"
								  ng-model="boardContent" rows="20" required="true"
								  ng-minlength="2"
								  ng-maxlength="2000"></textarea>
					</td>
				</tr>
				
				<!-- 내용 폼점검 에러 -->
                <tr id="boardContent_ERR" class="err_msg"
                    ng-show="boardWriteForm.boardContent.$error.maxlegnth ||
                             boardWriteForm.boardContent.$error.minlength">
                    <td colspan="2" class="col-xs-12" style="color:red;">내용은  2~1000자 이내로 입력하십시오</td>
                </tr>
				
				
				<tr>
					<th>첨부파일</th>
					<td>
						<div id="preview" ></div>
						<div id="picText"></div>
					</td>
				</tr>
			</table>

		</section>
		<br>
		
		

		<!-- 등록 버튼 -->
		<input type="submit" style="float: right; width: 100px; margin: 10px;"
			class="btn btn-outline-primary" id="submitBoard" value="등록"
			ng-disabled="boardWriteForm.$invalid">
		<br>
		<br>
	</form>
</body>
</html>