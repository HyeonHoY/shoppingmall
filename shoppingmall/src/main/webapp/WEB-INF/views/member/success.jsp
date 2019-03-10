<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<title>success!</title>
<script>
/* $(document).ready */
$(function(){
    
	alert("회원가입을 축하합니다!");
	location.href="${pageContext.request.contextPath}/login/login.do?num=1";
	
//     $('#myModal').modal();
    
//     $('#close_btn').click(function() {
//         location.href="${pageContext.request.contextPath}/login/login.do?num=1";
//     });
    
});
</script>
</head>
<body>

   <!-- The Modal -->
<!--    <div class="modal" id="myModal"> -->
<!--       <div class="modal-dialog"> -->
<!--          <div class="modal-content"> -->

<!--             Modal body -->
<%--             <div class="modal-body" style="text-align: center">${msg}</div> --%>

<!--             <div class="modal-footer"> -->
<!--                <button id="close_btn" type="button" class="btn btn-success" data-dismiss="modal">Close</button> -->
<!--             </div> -->

<!--          </div> -->
<!--       </div> -->
<!--    </div> -->
</body>
</html>