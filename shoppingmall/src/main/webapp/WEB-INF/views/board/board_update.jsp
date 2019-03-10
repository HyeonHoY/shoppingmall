<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  /*  파일 필드 숨기기 */ 
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
   var pw_flag= false;
 
   function selectPw(pw) {
	   
	   //alert("pw : "+pw);
	   
	   if(pw==""){
		   //alert("존재하지 않음");
			$('#boardPw').val("");
			$('#checkPwd').html("");
			document.getElementById("boardPw").disabled=true;
			$('#secret_2').prop("checked",true);
			$('#secret_1').prop("checked",false);

		}else{
			//alert("존재");
			//$('#boardPw').val("");
			$('#secret_1').prop("checked",true);
			$('#secret_2').prop("checked",false);
			document.getElementById("boardPw").disabled=false;
		}
	}
   
	window.onload = function(e) {
		var pwck = "${board.boardPw}";
		//alert("pwck : "+pwck);
		selectPw(pwck);   // 이메일 설정	
	};
   
   $(document).ready(function(){
      
     $("#boardWriter").val("");
     $("#boardDate").val("");
     //$("#boardPw").attr("disabled",true);
     
      // multipartFile 추가 유무
      var img_append_check = 0;// 1이면 추가
      
      // multipartFile 삭제 유무
      var img_delete_check = 0;// 1이면 삭제
      var count = 0;
      var rowCnt = 0;
      console.log("rowCnt = "+rowCnt);
      var boardFile = $('#boardFile').val();//게시판 사진 정보
      var delete_img = "";
      var boardNum = $('#boardNum').val();//게시판 번호
      var x="";
      var insertFile="";
      
      // input type file 연변
      var file_num = 1;
      
      // 추가했던 사진을 지웠을 경우 그에 해당되는 input type file을 지워주기 위해 변수 사용
      var delete_check = new Array();
      
      
      // 이미지 삭제 버튼 클릭
      //가상적으로 작성된 하위 요서 이벤트 처리
      $(document).on("click","input[id^=delete_]",function(e){   
         
        // alert("test");
         // console.log("boardFile : "+boardFile);
         
         var first_num = e.target.id.split("_")[1];
         var last_num = e.target.id.split("_")[2];
         console.log("first_num = "+first_num);
         console.log("last_num = "+last_num);
         
         var fileName = $("#deleteDiv_"+first_num+"_"+last_num+"").text();
       console.log("fileName = "+fileName);   
         
       // 기존에 있던 데이터를 삭제했을 경우
       if(first_num == 0) {
          $("#boardDate").val($("#boardDate").val()+fileName+"?");
          // console.log(fileName);
       } else {
          var fileName = $("#picUpload_"+first_num+"")[0].files[last_num].name;
           $("#boardWriter").val($("#boardWriter").val()+fileName+"?");
       }
          
       $("#deleteDiv_"+first_num+"_"+last_num).remove();
         $("#imgTagDiv_"+first_num+"_"+last_num).remove();
         
         
         
         // console.log($("#picUpload_"+first_num+"")[0].files.length);
         
         /*
         delete_check[first_num] = delete_check[first_num]-1;
         
      // picUpload에 삭제하려는 정보를 제외한 나머지 정보가 존재하지 않을 경우 picUpload 파일 필드 제거
         if(delete_check[first_num] == 0){
            // alert("0개!!!!!!!!!");
            $("#picUpload_"+first_num+"").remove();
            // $("#boardWriter_"+first_num+"").remove();
            
         } else {
           // alert("test");
            var fileName = $("#picUpload_"+first_num+"")[0].files[last_num].name;
            $("#boardWriter").val($("#boardWriter").val()+fileName+"?");
            // console.log("삭제 후 "+$("#boardWriter_"+first_num+"").val());
         }
         */
         
         /* 
            
         //추가된 파일들 이름 확인
         delete_img += fileName+"?";
         
         if(insertFile.length == 0){
            img_append_check = 0;
         }
         
         img_delete_check = 1;
 */      });// delete_ click
      
      
      // 이미지 추가 부분
      $("div[class=upload]").on("change","input[name=picUpload]" , function(){
         
         $("label").attr("for", "picUpload_"+(file_num+1));
         delete_check[file_num] = this.files.length;
         console.log("파일 개수 : "+delete_check[file_num]);
         $("div[class=upload]:last").append('<input type="file" id="picUpload_'+(file_num+1)+'" name="picUpload" multiple>');
         // $("form").append("<input type='hidden' name='boardWriter' id='boardWriter_"+(file_num+1)+"'>");
         // console.log($("input[name=picUpload]"));
         img_append_check = 1;
         
         var file = this.files;
         // console.log("file 갯수 : "+file.length);
         
         var reader = new FileReader();
         
         // for
         for(var i=0; i<file.length; i++){
            x = file[i];
            insertFile += x.name+"?";
            
            $("#attachments").append(
               '<div id="deleteDiv_'+file_num+'_'+i+'">'+x.name+'<input type="button" id="delete_'+file_num+'_'+i+'" value="X"></div>'
            );
            
            // console.log($("#boardWriter_"+file_num+"").val());
            // $("#boardWriter_"+file_num+"").val($("#boardWriter_"+file_num+"").val()+x.name+"?");
            
           
            reader.readAsDataURL(x);
            reader.onload = function(e) { 
               var file_num_capy = file_num-1;
               
               // console.log("boardFile : "+rowCnt);
               
                // 추가된 사진 정보 boardFile에 저장
                boardFile+=x.name+"?";
                // console.log("boardFile : "+boardFile);   
                // console.log("i = "+i);

            $("#imgDiv").append(  
                   '<div id="imgTagDiv_'+file_num_capy+'_'+rowCnt+'">'+
                      "<img id='imgTag_"+file_num_capy+"_"+rowCnt+"' src=\"" + e.target.result + 
                         "\"\ style='width:300px; height:300px'/>"+
               '</div>'
                );
                rowCnt++;
                
             }; // reader.onload
            
            reader = new FileReader();
            
         }// for
         file_num++;
         rowCnt = 0;
      }); // 
      
      
      
      // 수정하기 버튼
      $("#updateBoard").click(function(){
         // 폼점검
         console.log("updateBoard click img_append_check = "+img_append_check);
         var theForm = $("#updateBoardForm");
         var msg = "false";
         
         if(confirm("정말로 수정하시겠습니까?")== true){
            
           // 사진을 추가하지 않았을 경우 multipartFile을 null로 보낸다
             if(img_append_check == 0){
                $("input[name=picUpload]").remove();
             }
           
           // 사진을 삭제했을 경우 boardWrtier에 삭제해야하는 이미지 이름을 임시로 저장한다
//             if(img_delete_check == 1) {
                 
//               theForm.append("<input type='hidden' id='boardWriter' name='boardWriter' value='"+delete_img+"'>");
//             }
           // 마지막 요소 지우기
           $("#picUpload_"+file_num+"").remove();
           // $("#boardWriter_"+file_num+"").remove();
            console.log($("input[name=picUpload]"));
            
            if($("#boardKinds").val() != 1){
            	$("#updateBoardForm").append("<input type='hidden' name='productId' value='${board.productId}'>");
            }
            
            theForm.submit();
            
         } else {
            msg = "false";
         }
         
      }); // click
      
      //비밀번호 활성화 비활성화
      $("input[id^=secret_]").on("click",function(e){
         
         var num = e.target.id.split("_")[1];
         
         console.log(e.target.id+" , num : "+num);
         
         if(num==2){
			pw_flag=true;
			$('#boardPw').val("");
			$('#checkPwd').html("");
			$('#secret_2').prop("checked",true);
			$('#secret_1').prop("checked",false);
			pw_flag=true;
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
      
   }); // end
</script>
</head>
<body>
   <input type="hidden" value="${productId}">
   <form method="post" id="updateBoardForm" name="updateBoardForm"
        action="${pageContext.request.contextPath}/board/update/execute.do"
        enctype="multipart/form-data">
        <input type='hidden' name='boardWriter' id="boardWriter"><!-- 새로 추가한 사진을 지운 정보 -->
        <input type='hidden' name='boardKinds' id="boardKinds" value="${board.boardKinds}">
        <input type='hidden' name='boardDate' id="boardDate"><!-- 기존에 존재했던 사진을 지운 정보 -->
      <input type="hidden" id="boardFile" name="boardFile" value="${board.boardFile}">
      <!-- 게시글 번호 인자 보내기 -->
      <input type="hidden" id="boardNum" name="boardNum" value="${board.boardNum}"/>
      
      <section id="updateForm1" class="border mt-3">
         <table id="updateTable" class="table table-hover">
            
            <!-- 제목 -->
            <tr>
               <th class="col-xs-1">제목</th>
               <td><input type="text" id="boardSubject" name="boardSubject" class="form-control"
                  value="${board.boardSubject}" ng-model="boardSubject"
                  placeholder="제목을 입력하세요." />
               </td>
            </tr>
            
            <!-- 비밀번호 -->
            <tr>
               <th>비밀번호</th>
               <td>
                  <div class="form-inline">
                     <input type="password" id="boardPw" name="boardPw" class="form-control col-xs-12"
                          maxlength="20" size="25" value="${board.boardPw}"/> &nbsp;
                     <input class="form-control" type="radio" id="secret_1" name="secret_1" value="radio" onClick="this.form.boardPw.disabled=false">&nbsp;활성&nbsp;
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
                     <label for="picUpload_1"> <i class='far fa-file-image'></i>&nbsp;사진
                     </label>
                     <input type="file" id="picUpload_1" name="picUpload" multiple/>&nbsp;
                  </div>
               </td>
            </tr>

            <!-- 내용 // textarea 필드에 공백이 들어가있음. 수정해야됨-->
            <!-- textarea 사이에 공백을 주면 안됨! -->
            <tr>
               <th>내용</th>
               <td><textarea id="boardContent" name="boardContent" ng-model="boardContent" class="form-control"
                          cols="46" rows="15" required="true"
                          placeholder="내용을 입력하세요." >${board.boardContent}</textarea>
               </td>
            </tr>

            <c:choose>
               <c:when test="${empty board.boardFile}">
                  <tr>
                     <th>첨부파일</th>
                     <td><div id="attachments"></div></td>
                  </tr>
                  <tr>
                     <th>사진</th>
                     <td><div id="imgDiv"></div></td>
                  </tr>
               </c:when>
               
               <c:otherwise>
                  <tr>
                     <th>첨부파일</th>
                     <td>
                        <div id="attachments">
                           <c:forEach items="${list}" var="list" varStatus="st">
                              <div id="deleteDiv_0_${st.index}">${list}<input type="button" id="delete_0_${st.index}" value="X"></div>                                 
                           </c:forEach>
                        </div>
                     </td>
                  </tr>
                  <tr>
                     <th>사진</th>
                     <td>
                        <!-- div 안에 있는 div 바꾸기 -->
                        <div id="imgDiv">
                           <c:forEach items="${list}" var="list" varStatus="st">
                              <div id="imgTagDiv_0_${st.index}">
                                 <img id="imgTag_0_${st.index}" src='<c:url value="/image/${board.boardNum}번 게시물/${list}" />' height="400"/>
                              </div>
                           </c:forEach>
                        </div>
                     </td>
                  </tr>
               </c:otherwise>
            </c:choose>
         </table>

      </section>
      <br>

      <!-- 등록 버튼 -->
      <input type="button" style="float: right; width: 100px; margin: 10px;"
         class="btn btn-outline-primary" id="updateBoard" value="수정">
      <br> <br>
   </form>
   <!-- updateform End -->
</body>
</html>