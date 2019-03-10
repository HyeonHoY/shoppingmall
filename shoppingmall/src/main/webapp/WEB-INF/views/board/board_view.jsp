<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<style>
#viewWrapper {
	border: 1px solid #ccc;
}
#replyWrapper {
	background-color : gray;
}
#listBtn {
	float: right;
	margin: 0 0 5px 0;
}
</style>
<script>
$(document).ready(function(){ //start
	
	// 수정중인 버튼 활성화된 필드 id
	var active_fld_id = 0;
	var sessionId = $("#sessionId").val();
	var nowData = "";
	var all_count = $("#all_count").val();
	var page_count =15;
	var rowCnt = "";
	
	// console.log("count="+count);
	
	var replyHead = 
		'<thead id="head">'+
			'<tr align="center">'+
				'<th>번호</th>'+
				'<th>댓글 작성자</th>'+
				'<th>내용</th>'+
				'<th>작성 일자</th>'+
				'<th>수정 Y?N</th>'+
			'</tr>'+
		'</thead>';
			
		// 기존 댓글 정보 읽기
		$.ajax({
			type : "get",
			url : "${pageContext.request.contextPath}/board/viewJsonReply.do",
			
			data : {
				boardNum : $("#boardNum").val(),
				page_count : page_count
			},
			
			success : function(data){
				
				console.log(data);
				
				// 댓글이 없는 게시글일 경우 첫 thead 안보이게하기 
				if(data.length != 0) {
					$("table[id=replysTable]:first").html(replyHead);	
				}
				
				var firstData = "";
				var update_btn = "";
				
				// 페이지 처리 후 처음 데이터
				for(var i=0; i<data.length; i++) {
					if(data[i].replyWriter == sessionId) {
						var update_btn = 
							"<td id='updateBtn_"+(i+1)+"'>"+
								"<input type='button' id='updateActive_"+(i+1)+"' value='수정'>"+
							"</td>";
						
					} else {
						var update_btn = 
							"<td>&nbsp;</td>";
					}
					
					
					firstData += 
						"<tr id='replysTr_"+(i+1)+"'>"+
							"<input type='hidden' id='replyNo_"+(i+1)+"' value='"+data[i].replyNo+"'>"+
							"<td id='virtualNum_"+(i+1)+"'>"+(i+1)+"</td>"+
							"<td id='replyWriter_"+(i+1)+"'>"+data[i].replyWriter+"</td>"+
							"<td id='replyContent_"+(i+1)+"'>"+data[i].replyContent+"</td>"+
							"<td id='regdate_"+(i+1)+"'>"+data[i].regdate+"</td>"+
							update_btn + 
						"</tr>";// "<tr><td colspan='5'><div id='addContent_"+(i+1)+"'></div></td></tr>";
				} // for
				// console.log(firstData);
				
				$("table[id=replysTable]:last").append("<tbody id='replysBody'>"+firstData+"</tbody>");
				
				if(data.length == 15) {
					$("div[id=page_count_div]").append("<input type='button' id='nextVal' value='더보기'>");
				}
				
			}, // success
				
		error : function(xhr, status){
			alert("error");
		}
	});// ajax
	
	
	// 더보기 버튼 클릭 start
	$("div[id=page_count_div]").on('click', 'input[id=nextVal]', function(){

		page_count += 15;
		alert("page_count = "+page_count);
		
		$.ajax({
			
			type : 'get',
			url : '${pageContext.request.contextPath}/board/viewJsonReply.do',
			
			data : {
				boardNum : $("#boardNum").val(),
				page_count : page_count
			},
			
			success : function(data){
				console.log("data = "+data);
				var addData = "";
				console.log("page_count="+page_count);
				// page_count로 구한 데이터 길이만큼 반복
				for(var i=0; i<data.length; i++) {
					
					if(data[i].replyWriter == sessionId) {
						
						var update_btn = 
							"<td id='updateBtn_"+(page_count-14+i)+"'>"+
								"<input type='button' id='updateActive_"+(page_count-14+i)+"' value='수정'>"+
							"</td>";
					} else {
						var update_btn = 
							"<td>&nbsp;</td>";
					}
					
					addData +=
						"<tr id='replysTr_"+(page_count-14+i)+"'>"+
							"<input type='hidden' id='replyNo_"+(page_count-14+i)+"' value='"+data[i].replyNo+"'>"+
							"<td id='virtualNum_"+(page_count-14+i)+"'>"+(page_count-14+i)+"</td>"+
							"<td id='replyWriter_"+(page_count-14+i)+"'>"+data[i].replyWriter+"</td>"+
							"<td id='replyContent_"+(page_count-14+i)+"'>"+data[i].replyContent+"</td>"+
							"<td id='regdate_"+(page_count-14+i)+"'>"+data[i].regdate+"</td>"+
							update_btn+
						"</tr>";
						// "<tr><td colspan='5'><div id='addContent_"+(page_count-14+i)+"'></div></td></tr>";
				} // for

				// 현재 테이블 마지막 tr에 끼워넣기
				$("table[id=replysTable]:last").append("<tbody id='replysBody'>"+addData+"</tbody>");
				
				rowCnt = document.querySelectorAll("tbody[id=replysBody] tr[id^=replysTr_]").length;
				console.log("rowCnt="+rowCnt);
				
				if(data.length != 15) {
					$("div[id=page_count_div]").html("");
				}
				
				
			}, // success
			
			error : function(xhr, status){
				alert("error");
			}
		}); // ajax

				
	}); // 다음 페이지 버튼 끝
	
	// 댓글 작성 start
	$("#btnReplyWrite").click(function(e){
		
		console.log("page_count = "+page_count);
		
		// ajax
		$.ajax({
			
			type : 'get',
			url : '${pageContext.request.contextPath}/reply/insert.do',
			
			data : {
				boardNum : $("#boardNum").val(),
				replyContent : $("#replyContent").val(),
				replyWriter : $("#sessionId").val(),
				page_count : page_count
			}, 
			
			success : function(data){
				
				alert("success");
				console.log("data.length="+data.length);
				
				// 게시글에 처음 댓글이 달아질 경우 
				$("table[id=replysTable]:first").html(replyHead);	
				 
				var replys = "";
				for(var i=0; i<data.length; i++) {
					
					if(data[i].replyWriter == sessionId) {
						var update_btn = 
							"<td id='updateBtn_"+(i+1)+"'>"+
								"<input type='button' id='updateActive_"+(i+1)+"' value='수정'>"+
							"</td>";
						
					} else {
						var update_btn = 
							"<td>&nbsp;</td>";
					}
					
					// 댓글
					replys += 
						"<tr id='replysTr_"+(i+1)+"'>"+
							"<input type='hidden' id='replyNo_"+(i+1)+"' value='"+data[i].replyNo+"'>"+
							"<td id='virtualNum_"+(i+1)+"'>"+(i+1)+"</td>"+
							"<td id='replyWriter_"+(i+1)+"'>"+data[i].replyWriter+"</td>"+
							"<td id='replyContnent_"+(i+1)+"'>"+data[i].replyContent+"</td>"+
							"<td id='regdate_"+(i+1)+"'>"+data[i].regdate+"</td>"+
							update_btn+
						"</tr>";
				}
				
				$("table[id=replysTable]").append("<tbody id='replysBody'>"+replys+"</tbody>");
			}, // success
			
			error : function(xhr, status) {
				
			} // error
		}); 
		
		
	});// 댓글 작성 끝
	
	// 수정 버튼 클릭 start
	$("table[id=replysTable]").on('click', 'input[id^=updateActive_]', function(e){
		
		var no = e.target.id.split("_")[1];
		console.log("no="+no);
		
		// 최근에 클릭한 수정항목만 나타나게 하기
		// alert("수정버튼 클릭"+active_fld_id);
		
		// 다른 수정버튼 클릭 시 이전에 수행중이었던 수정활성화 닫기
		$("table[id=replysTable] tr[id=areaTr_"+active_fld_id+"]").remove();
		
		var no = e.target.id.split("_")[1];
		console.log(no);
		
		var area = 
			"<tr id='areaTr_"+no+"'>"+
				"<td colspan='5'>"+
					"<div id='addContent_"+no+"'>"+
						"<textarea class='form-control' rows='1' id='updateContent' cols='20' placeholder='수정하실 댓글을 입력하세요'></textarea>"+	
						"<input type='button' value='수정하기' id='updateRun_"+no+"'>"+
						"<input type='button' value='삭제하기' id='deleteRun_"+no+"'><br>"+
						"<input type='button' value='닫기' id='closeBtn_"+no+"'>"+
					"</div>"+
				"</td>"
			"</tr>";
		
		//  $(newContent).insertBefore("tr:eq(1)"); 
		$(area).insertAfter("tr:eq("+(no)+")");
		
		
		// 현재 수정중인 필드 id
		active_fld_id = no;
		console.log("active_fld_id = "+active_fld_id);
		
		
		}); // 수정 버튼 클릭 end
		
		
		// 수정 버튼의 닫기 버튼을 눌렀을 때 이벤트
		$("table[id=replysTable]").on('click', 'input[id^=closeBtn_]', function(e){
		
			var no = e.target.id.split("_")[1];
			// alert("닫기_"+no);
			
			$("table[id=replysTable] tr[id=areaTr_"+no+"]").remove();
		}); // 닫기 버튼 end
		
			
		// 수정하기 버튼 눌렀을 때
		$("table[id=replysTable]").on('click', 'input[id^=updateRun_]', function(e){
			
			var no = e.target.id.split("_")[1];
			console.log("no="+no);
			
			// 댓글 수정하기 ajax
			$.ajax({
				
				type : 'get',
				url : '${pageContext.request.contextPath}/reply/update.do',
				
				data : {
					replyNo : $("#replyNo_"+no+"").val(),
					boardNum : $("#boardNum").val(),
					replyContent : $("#updateContent").val()
				},
				
				// 첫번째 수정 후 아이디가 없어서 2번째엔 수정을 하지 못함
				success : function(data){
					
					// alert("success");
					
					var updateData = "";
					
					for(var i=0; i<data.length; i++) {
						
						if(data[i].replyWriter == sessionId) {
						var update_btn = 
							"<td id='updateBtn_"+(i+1)+"'>"+
								"<input type='button' id='updateActive_"+(i+1)+"' value='수정'>"+
							"</td>";
						
					} else {
						var update_btn = 
							"<td>&nbsp;</td>";
					}
						updateData +=
							"<tr id='replysTr_"+(i+1)+"'>"+
								"<input type='hidden' id='replyNo_"+(i+1)+"' value='"+data[i].replyNo+"'>"+
								"<td id='virtualNum_"+(i+1)+"'>"+(i+1)+"</td>"+
								"<td id='replyWriter_"+(i+1)+"'>"+data[i].replyWriter+"</td>"+
								"<td id='replyContent_"+(i+1)+"'>"+data[i].replyContent+"</td>"+
								"<td id='regdate_"+(i+1)+"'>"+data[i].regdate+"</td>"+
								update_btn+
							"</tr>";
					} // for
					
					alert("댓글이 수정되었습니다.");
					$("table[id=replysTable]").html(replyHead+"<tbody id='replysBody'>"+updateData+"</tbody>");
					
				}, // success
				
				error : function(xhr, status){
				alert("error");
			}
				
			}); // ajax
			
		}); // 수정하기  end
	 
		// 댓글 삭제하기 start
	$("table[id=replysTable]").on('click', 'input[id^=deleteRun_]', function(e){
		
		if(confirm("정말로 삭제하시겠습니까?")== true){
			var msg = "삭제하였습니다.";
		} else {
			var msg = "";
		}
          
		// 이벤트 번호
		var no = e.target.id.split("_")[1];
		// alert(no);
		
		// reply delete ajax start
		$.ajax({
			
			type : 'get',
			url : '${pageContext.request.contextPath}/reply/delete.do',
			
			data : {
				replyNo : $("[id=replyNo_"+no+"]").val(),
				boardNum : $("#boardNum").val(),
				msg : msg
			},
			
			success : function(data){
				
				console.log(data.length);

				if(data.length==0){
	               $("table[id=replysTable]").html("");
	            }
				
				var rowCnt = document.querySelectorAll("tbody[id=replysBody] tr[id^=replysTr_]").length;
				console.log(rowCnt);
				
				if(data.length != 0) {
					var deleteData = "";
 					
 					for(var i=0; i<data.length; i++) {
 						
 						if(data[i].replyWriter == sessionId) {
							var update_btn = 
								"<td id='updateBtn_"+(i+1)+"'>"+
									"<input type='button' id='updateActive_"+(i+1)+"' value='수정'>"+
								"</td>";
							
						} else {
							var update_btn = 
								"<td>&nbsp;</td>";
						}
 						
 						deleteData +=
 							"<tr id='replysTr_"+(i+1)+"'>"+
 								"<input type='hidden' id='replyNo_"+(i+1)+"' value='"+data[i].replyNo+"'>"+
 								"<td id='virtualNum_"+(i+1)+"'>"+(i+1)+"</td>"+
 								"<td id='replyWriter_"+(i+1)+"'>"+data[i].replyWriter+"</td>"+
 								"<td id='replyContent_"+(i+1)+"'>"+data[i].replyContent+"</td>"+
 								"<td id='regdate_"+(i+1)+"'>"+data[i].regdate+"</td>"+
 								update_btn+
 							"</tr>";
 							
 					} // for
 					
 					alert("댓글이 삭제되었습니다.");
 					$("table[id=replysTable]").html(replyHead+"<tbody id='replysBody'>"+deleteData+"</tbody>");
				} else {
					alert("댓글 삭제를 취소하였습니다.");					
				}
				
			}, // success
			
			error : function(xhr, status){
				alert("error");
			} // error
			
		}); // ajax end
		
	}); // 댓글삭제 end
	
	$("#deleteBtn").click(function(){
		
		var msg = "";
		var boardNum = $("#boardNum").val();
		
		if(confirm("정말로 게시글을 삭제하시겠습니까?")== true){
			msg = "yes";
		} else {
			msg = "no";
		}
		
		if(msg=="yes") {
			alert("게시물이 삭제되었습니다.");
			location.href="${pageContext.request.contextPath}/board/delete.do?num="+boardNum+"&boardKinds="+${board.boardKinds};
		}
	});
		
}); // end
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<input type="hidden" value="${board.productId}" id="productId" name="productId">
	<div>
		조회 수 : ${board.boardReadCount}<br>
		게시글 제목 : ${board.boardSubject}<br>
		게시글 가상 번호 : ${num}<br> 
		게시글 시퀀스 번호 : ${board.boardNum}<br>
		게시판 내용 : ${board.boardContent}<br>
		총 댓글 수 : ${all_count}<br>
		방문자 : ${sessionScope.id}
		<input type="hidden" id="all_count" value="${all_count}"> 
		<input type="hidden" id="sessionId" value="${sessionScope.id}"> 

	</div>

	<div id="viewWrapper" class="my-3">
		<div id="viewBoard" class="m-3">
			<div id="boardTitle"
				class="border border-top-0 border-right-0 border-left-0 row mx-auto">

				<!-- 제목 -->
				<div id="boardSub" class="mb-1 w-75">${board.boardSubject}</div>

				<!-- border border-top-0 border-right-0 border-left-0 -->

				<!-- 날짜 -->
				<div id="boardDate" class="mb-1 w-25">
					<fmt:parseDate var="tmp" value="${board.boardDate}"
						pattern="yyyy-MM-dd HH:mm" />
					<fmt:formatDate value="${tmp}" pattern="yyyy.MM.dd HH:mm" />
				</div>
			</div>

			<!-- 작성자 -->
			<div id="boardWriter" class="mx-auto mb-1">
				${board.boardWriter}</div>

			<!-- 내용 -->
			<div class="container">
				<div id="boardContent" class="m-5 mx-auto">
					
					<p>${board.boardContent}</p>
					<!-- 만약에 이미지가 뜨지 않을 경우 root-context에서 
						 File repository : 파일 저장소 검색 후 경로 설정 해줄 것! -->
					<c:if test="${not empty board.boardFile}">
						<c:forEach items="${list}" var="list">
							<img src="<c:url value='/image/${board.boardNum}번 게시물/${list}' />" height="400" />
							<div>${list}</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<br><br>
			
			<!-- 댓글 -->
			<!-- class="row" -->
			<div id="countImpormation" >
			
				<!-- 댓글수, 조회수 -->
				<p id="readcount_${board.boardNum}">
					댓글수&nbsp;&nbsp;${replysCount}&nbsp;&nbsp;조회수&nbsp;&nbsp;${board.boardReadCount}
				</p>
				
				<!-- 댓글 작성란 -->
				<form id="insertReply" method="post">
				 	<input type="hidden" id="boardNum" value="${board.boardNum}">
					<input type="hidden" id="userWriter" value="${board.boardWriter}">
					<textarea rows="5" cols="80" id="replyContent" placeholder="댓글을 작성해주세요" 
							  class="form-control col-lg-9"></textarea>
					<input type="button" id="btnReplyWrite" class="col-lg-1" value="댓글 작성">
				</form>
				
			</div>
			<!-- countImpormation -->
		</div>
		<!-- viewBoard -->
	</div>
	<!-- viewWrapper -->
	<div id="listBtn">
		<c:if test="${not empty sessionScope.id}">
			<c:if test="${sessionScope.id == board.boardWriter}">
				<a href="${path}/sm/board/update.do?num=${board.boardNum}&product=${board.productId}"
					class="btn btn-outline-primary"> 수정 </a>
				<a class="btn btn-outline-primary" id="deleteBtn"> 삭제 </a>
			</c:if>
		</c:if>
		<a href="${pageContext.request.contextPath}/board/list.do/boardKinds/${board.boardKinds}"
			class="btn btn-outline-primary"> 목록 </a>
	</div>
	<table border="1" id="replysTable" class="table table-dark table-striped"></table>
	<div id="page_count_div"></div>

</body>
</html>