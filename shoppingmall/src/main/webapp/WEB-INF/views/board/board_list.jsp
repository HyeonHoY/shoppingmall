<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<title>자유게시판</title>
<style>
.search{
	display : flex;
	align-items:center;
	justify-content : center;
}
</style>
<script>

	$(document).ready(function(){
		
		// 초기화면 ajax
		$.ajax({
			type : 'post',
			url : '${pathContext.request.contextpath}/board/list.do'
			
		}); 
		
		$("a[id^=secretSubject_]").click(function(e){
			
			var no = e.target.id.split("_")[1];//게시판 가상 번호
			var boardNum = $("#boardNum_"+no+"").val();
			
			var checkPw = prompt("게시판 비밀번호를 입력하세요.","");
			
			console.log("checkPw : "+checkPw);
			
			 $.ajax({
				
				type:'post',
				url:'${pageContext.request.contextPath}/board/checkBoardPage.do',
				data:{
					checkPw : checkPw,
					boardNum : boardNum
				},
				
				success:function(data){
					
					alert("check success!");
					console.log("data.length : "+data.length);
					if (data.length != 9) {
						alert("비밀번호가 일치하지 않습니다!");
					}else{
						$.ajax({
							type : 'get',
							url : '${pageContext.request.contextPath}/board/addReadCount.do',
							data : {
								boardNum : boardNum
							}, 
							success : function(data){
								console.log("data.length ="+data.length);
								// 조회수 업데이트 성공 시
								if(data.length == 8) {
									location.href = "${pageContext.request.contextPath}/board/view.do?num="+no
													+"&boardNum="+boardNum+""	
								}
							}, // success
							error : function(xhr, status) {
								alert("error");
							} // error
						}); // ajax
					}//if~else
				},
			}); // ajax 
			
		}); // secretSubject click end
		
		// 제목을 눌렀을 때
		$("a[id^=boardSubject_]").click(function(e){
			
			var no = e.target.id.split("_")[1];
			console.log("########### no : "+no);
			var boardNum = $("#boardNum_"+no+"").val();
			
			$.ajax({
				
				type : 'get',
				url : '${pageContext.request.contextPath}/board/addReadCount.do',
				
				data : {
					boardNum : boardNum
				}, 
				
				success : function(data){
					// alert("success");
					
					console.log("data.length ="+data.length);
					
					// 조회수 업데이트 성공 시
					if(data.length == 8) {
						location.href = "${pageContext.request.contextPath}/board/view.do?num="+no
										+"&boardNum="+boardNum+""	
					}
					
				}, // success
				
				error : function(xhr, status) {
					alert("error");
				} // error
				
			}); // ajax
			
		}); // boardSubject click end
		
	}); // ready end

</script>


</head>
<body>
	<%-- <div>
		<c:if test="${empty map.keyword}">
			총 게시글 수 : ${pageVO.listCount}<br>
		</c:if>
		현재 페이지 : ${pageVO.page}<br> 총 페이지 : ${pageVO.maxPage}<br> 시작
		페이지 : ${pageVO.startPage}<br> 끝 페이지 : ${pageVO.endPage}<br>
		boardKinds : ${boardKinds}
		<c:if test="${not empty map.keyword}">
			검색된 갯수는 : ${map.count}개 입니다.<br>
			키워드 : ${map.keyword}
		</c:if>
		${articleList}
	</div> --%>
	
	<!-- col-lg-9 -->
		<div class="col-lg-12">
			<c:choose>
				<c:when test="${boardKinds==1}">
					<h4 class="my-4" style="text-align: center">자유게시판</h4>
				</c:when>
				<c:when test="${boardKinds==2}">
					<h4 class="my-4" style="text-align: center">상품 후기</h4>
				</c:when>
				<c:when test="${boardKinds==3}">
					<h4 class="my-4" style="text-align: center">Q & A</h4>
				</c:when>
			</c:choose>
			<div class="container">
				<!-- 검색 -->
				<div class=" mb-2 form-inline float-right">
					<form method="get"
						action="${path}/sm/board/search/all/list.do?
						page=${pageVO.page}&searchOption=${map.searchOption}&keyword=${map.keyword}&boardKinds=${boardKinds}">
						<input type="hidden" id="boardKinds" name="boardKinds" value="${boardKinds}">
						<select name="searchOption" class="form-control">
							<option value="all"
								<c:out value="${map.searchOption=='all' ? 'selected':''}" />>
								전체</option>
							<option value="board_writer"
								<c:out value="${map.searchOption=='board_writer'?'selected':''}"/>>
								이름</option>
							<option value="board_content"
								<c:out value="${map.searchOption=='board_content'?'selected':''}"/>>
								내용</option>
							<option value="board_subject"
								<c:out value="${map.searchOption=='board_subject'?'selected':''}"/>>제목</option>
						</select>
						<input type="text" name="keyword" id="keyword" class="form-control" value="${map.keyword}">
						<input type="submit" value="검색" class="btn btn-outline-secondary">
					</form>
				</div>
				
				<c:choose>
					<c:when test="${pageVO.listCount>0}">
						<table class="table table-hover">
							<!-- 헤드라인 -->
							<thead>
								<tr align="center">
									<th>번호</th>
									<c:if test="${boardKinds > 1 }">
										<th>상품</th>
									</c:if>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<!-- 헤드라인 -->
			
							<!-- 게시글 검색하지 않았을 경우  -->
							<c:if test="${empty map.keyword && not empty articleList && pageVO.listCount > 0}">
							
								<!-- 게시글  -->
								<c:forEach var="article" items="${articleList}" varStatus="art">
									<tbody>
										<tr align="center">
											<td><input type="hidden" id="boardNum_${pageVO.listCount-(art.count+(pageVO.page-1)*10)+1}" 
														value="${article.boardNum}"> 
															${pageVO.listCount-(art.count+(pageVO.page-1)*10)+1}
											</td>
											<c:if test="${boardKinds > 1 }">
												<td>
													<img width="50px" height="50px"
														src="<c:url value="/product/${productList[art.index].productId}/${productList[art.index].productTitleImg}" />">
												</td>
											</c:if>
											<c:if test="${not empty sessionScope.id}">	
												<td>
													<c:choose>
														<c:when test="${empty article.boardPw}">
															<a id='boardSubject_${pageVO.listCount-(art.count+(pageVO.page-1)*10)+1}' 
																href="#">${article.boardSubject}</a>
														</c:when>
														<c:otherwise>
															<c:choose>
																<c:when test="${article.boardWriter==sessionScope.id || sessionScope.role=='role_admin'}">
																	<a id='boardSubject_${pageVO.listCount-(art.count+(pageVO.page-1)*10)+1}' 
																	href="#">${article.boardSubject}</a>
																</c:when>
																<c:otherwise>
																	<a id='secretSubject_${pageVO.listCount-(art.count+(pageVO.page-1)*10)+1}' 
																	href="#">비밀글입니다.</a>
																</c:otherwise>
															</c:choose>
														</c:otherwise>
													</c:choose>		 
												</td>
											</c:if>
											
											<c:if test="${empty sessionScope.id}">	
												<td>
													<a href="${path}/sm/login/login.do?num=3&boardKinds=${boardKinds}">
															${article.boardSubject}</a>
												</td>
											</c:if>
											<td>${article.boardWriter}</td>
											<td>${article.boardDate}</td>
											<td>${article.boardReadCount}</td>
										</tr>
									</tbody>
								</c:forEach>
							</c:if>
			
							<!-- 검색으로 게시판을 찾을 경우 -->
							<c:if test="${(not empty map.searchOption || not empty map.keyword) && 
											not empty map.list && pageVO.listCount > 0}">
								<c:forEach var="article" items="${map.list}" varStatus="art">
									<tbody>
										<tr align="center">
											<td><input type="hidden" id="boardNum_${pageVO.listCount-(art.count+(pageVO.page-1)*10)+1}" 
											value="${article.boardNum}"> 
												<%-- ${art.count+(pageVO.page-1)*10}d ==> 내림차순 version--%>
												<%-- <input type="hidden" id="num_${pageVO.listCount-(art.count+(pageVO.page-1)*10)+1}" value=""> --%>
												${pageVO.listCount-(art.count+(pageVO.page-1)*10)+1} <%-- ${article.boardNum} --%>
											</td>
											<c:if test="${not empty sessionScope.id}">	
												<td>
													<c:choose>
														<c:when test="${empty article.boardPw}">
															<a id='boardSubject_${pageVO.listCount-(art.count+(pageVO.page-1)*10)+1}' 
																href="#">${article.boardSubject}</a>
														</c:when>
														<c:when test="${not empty article.boardPw}">
															<c:choose>
																<c:when test="${article.boardWriter==sessionScope.id || sessionScope.role=='role_admin'}">
																	<a id='boardSubject_${pageVO.listCount-(art.count+(pageVO.page-1)*10)+1}' 
																	href="#">${article.boardSubject}</a>
																</c:when>
																<c:otherwise>
																	<a id='secretSubject_${pageVO.listCount-(art.count+(pageVO.page-1)*10)+1}' 
																	href="#">비밀글입니다.</a>
																</c:otherwise>
															</c:choose>
														</c:when>
													</c:choose>		 
												</td>
											</c:if>
											<c:if test="${empty sessionScope.id}">	
												<td>
												<a href="${path}/sm/login/login.do?num=3&boardKinds=${boardKinds}">
														${article.boardSubject} </a></td>
											</c:if>
											<td>${article.boardWriter}</td>
											<td>${article.boardDate}</td>
											<td>${article.boardReadCount}</td>
										</tr>
									</tbody>
								</c:forEach>
							</c:if>
						</table>
					</c:when>
					<c:otherwise>
					<br>
						<table class="table table-hover">
							<!-- 헤드라인 -->
							<thead>
								<tr align="center">
									<th>번호</th>
									<c:if test="${boardKinds > 1 }">
										<th>상품</th>
									</c:if>
									<th>제목</th>
									<th>작성자</th>
									<th>작성일</th>
									<th>조회수</th>
								</tr>
							</thead>
							<tbody>
							  <tr>
							  	<c:if test="${boardKinds == 1 }">
								  <td colspan="5">
									<div class="col-lg-12" style="padding:70px 0px 20px 0px; text-align:center;">
										<h5>등록된 게시물이 존재하지 않습니다!!</h5>
									</div>
								  </td>
								</c:if>
								<c:if test="${boardKinds > 1 }">
								  <td colspan="6">
									<div class="col-lg-12" style="padding:70px 0px 20px 0px; text-align:center;">
										<h5>등록된 게시물이 존재하지 않습니다!!</h5>
									</div>
								  </td>
								</c:if>
							  </tr>
							 
							</tbody>
						</table>
					<br>
					</c:otherwise>
				</c:choose>
				
			<!-- 세션 아이디 존재 -->
			<c:if test="${not empty sessionScope.id && boardKinds == 1 }">
				<form action="${path}/sm/board/write.do/boardKinds/${boardKinds}">
					<input type="submit" class="btn btn-outline-secondary col-lg-1 float-right p-1" value="글쓰기"><br>
				</form> 
			</c:if>
			
			<!-- 세션 아이디 없음 -->
			<c:if test="${empty sessionScope.id}">
				<form action="${path}/sm/login/login.do?num=2&boardKinds=${boardKinds}">
					<input type="hidden" id="boardKinds" name="boardKinds" value="${boardKinds}">
					<input type="hidden" id="num" name="num" value="2">
					<input type="submit" class="btn btn-outline-secondary col-lg-1 float-right p-1" value="글쓰기"><br>
				</form> 
			</c:if>
			
			<c:if test="${not empty articleList && pageVO.listCount > 0}">
				<%@ include file="../board/paging.jsp"%>
			</c:if>
			
			<c:if test="${not empty map.list && pageVO.listCount > 0}">
				<%@ include file="../board/paging.jsp"%>
			</c:if>
			<br>
			<div class="search mb-5 form-inline col-lg-12">
				<form method="get"
					action="${path}/sm/board/search/all/list.do?
					page=${pageVO.page}&searchOption=${map.searchOption}&keyword=${map.keyword}&boardKinds=${boardKinds}">
					<input type="hidden" id="boardKinds" name="boardKinds" value="${boardKinds}">
					<select name="searchOption" class="form-control">
						<option value="all"
							<c:out value="${map.searchOption=='all' ? 'selected':''}" />>
							전체</option>
						<option value="board_writer"
							<c:out value="${map.searchOption=='board_writer'?'selected':''}"/>>
							이름</option>
						<option value="board_content"
							<c:out value="${map.searchOption=='board_content'?'selected':''}"/>>
							내용</option>
						<option value="board_subject"
							<c:out value="${map.searchOption=='board_subject'?'selected':''}"/>>제목</option>
					</select>
					<input type="text" name="keyword" id="keyword" class="form-control" value="${map.keyword}">
					<input type="submit" value="검색" class="btn btn-outline-secondary">
				</form>
			</div>
			<!-- container -->
		</div>

		<!-- col-lg-9 -->
	</div>
	<!-- Footer -->

</body>
</html>