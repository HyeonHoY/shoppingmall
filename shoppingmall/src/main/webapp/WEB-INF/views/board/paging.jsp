<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<style>
#pageList{

	display : flex;
	align-items:center;
	justify-content : center;
	
}
</style>
</head>
<body>
	<section id="pageList">
		<ul class="pagination">

			<!-- 이전 페이지 -->
			<c:if test="${pageVO.page >= 11}">
				<li class="page-item">
					<c:if test="${empty map.searchOption}">
						<a class="page-link fas fa-angle-left" style="font-size:15px"
						   href="${pageContext.request.contextPath}/board/list.do?page=${pageVO.startPage-1}&boardKinds=${boardKinds}"></a>
					</c:if>
					<c:if test="${not empty map.searchOption}">
						<a class="page-link fas fa-angle-left" style="font-size:15px"
						   href="${pageContext.request.contextPath}/board/search/list.do?page=${pageVO.startPage-1}&
								searchOption=${map.searchOption}&
								keyword=${map.keyword}&
								boardKinds=${boardKinds}"></a>
					</c:if>
				</li>
			</c:if>

			<!-- 페이지 나열 ex) 5,6,7,8,9 -->
			<c:forEach var="tmpPage" 
						   begin="${pageVO.startPage}"
						   end="${pageVO.endPage}">
					
					<c:if test="${tmpPage == pageVO.page}">
						<li class="page-item active">
						
							<c:if test ="${empty map.searchOption}">
<%-- 								<a class="page-link" 
									href="http://localhost:8383/sm/">${tmpPage}</a> --%>
								<a class="page-link" 
									href="${pageContext.request.contextPath}/board/list.do?page=${tmpPage}&boardKinds=${boardKinds}">${tmpPage}</a>
							</c:if>
							<c:if test ="${not empty map.searchOption}">
								<a class="page-link" 
									href="${pageContext.request.contextPath}/board/search/list.do?page=${tmpPage}&
										searchOption=${map.searchOption}&
										keyword=${map.keyword}&
										boardKinds=${boardKinds}">${tmpPage}</a>
							</c:if>
						</li>
					</c:if>	
					<c:if test="${tmpPage != pageVO.page}">
						<li class="active">
							<!-- 페이징 숫자 출력되는 부분 -->
							<c:if test ="${empty map.searchOption}">
								<a class="page-link" href="${pageContext.request.contextPath}/board/list.do?page=${tmpPage}&boardKinds=${boardKinds}">${tmpPage}</a>
							</c:if>
							<c:if test ="${not empty map.searchOption}">
								<a class="page-link" 
									href="${pageContext.request.contextPath}/board/search/list.do?page=${tmpPage}&
										searchOption=${map.searchOption}&
										keyword=${map.keyword}&
										boardKinds=${boardKinds}">${tmpPage}</a>
							</c:if>
						</li>
					</c:if>
				</c:forEach>


			<!--  || pageVO.page >= pageVO.maxPage-10 -->
			<!-- 다음 페이지 버튼 -->
			<c:choose>
					<c:when test="${pageVO.page > pageVO.maxPage}">
						<li class="page-item">
						
							<c:if test ="${empty map.searchOption}">
								<a class='page-link fas fa-angle-right'
									href="${pageContext.request.contextPath}/board/list.do?page=${pageVO.maxPage}&boardKinds=${boardKinds}"></a>
				   			</c:if>
				   			
				   			<c:if test ="${not empty map.searchOption}">
								<a class='page-link fas fa-angle-right'
									href="${pageContext.request.contextPath}/board/search/list.do?page=${pageVO.maxPage}&
											searchOption=${map.searchOption}&
											keyword=${map.keyword}&
											boardKinds=${boardKinds}"></a>
				   			</c:if>
					</c:when>
					
					<c:when test="${pageVO.maxPage == pageVO.endPage + 1}">
						<li class="page-item">
							<c:if test ="${empty map.searchOption}">
								<a class='page-link fas fa-angle-right' style="font-size:15px"
									href="${pageContext.request.contextPath}/board/list.do?page=${pageVO.endPage + 1}&boardKinds=${boardKinds}"></a>
							</c:if>
							
							<c:if test ="${not empty map.searchOption}">
								<a class='page-link fas fa-angle-right' style="font-size:15px"
									href="${pageContext.request.contextPath}/board/search/list.do?page=${pageVO.endPage + 1}&
										searchOption=${map.searchOption}&
										keyword=${map.keyword}&
										boardKinds=${boardKinds}"></a>
							</c:if>
						</li>
					 </c:when>
					 
					 <c:when test="${pageVO.page >= pageVO.startPage &&
									pageVO.page <= pageVO.endPage && 
									pageVO.maxPage > pageVO.endPage}">
							<li class="page-item">
								<c:if test ="${empty map.searchOption}">
									<a class='page-link fas fa-angle-right' style="font-size:15px"
									   	   href="${pageContext.request.contextPath}/board/list.do?page=${pageVO.endPage + 1}&boardKinds=${boardKinds}"></a>
								</c:if>
								
								<c:if test ="${not empty map.searchOption}">
									<a class='page-link fas fa-angle-right' style="font-size:15px"
									   	   href="${pageContext.request.contextPath}/board/search/list.do?page=${pageVO.endPage + 1}&
												searchOption=${map.searchOption}&
												keyword=${map.keyword}&
												boardKinds=${boardKinds}"></a>
								</c:if>		
						</li>
					</c:when>
				</c:choose>
			<!-- 다음 페이지 끝 -->
		</ul>
	</section>
</body>
</html>