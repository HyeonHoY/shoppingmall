<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
</head>
<style>
#hiddenUL {
	position:absolute;
	left:85px;
	top:70px;
	width:125px;
	height:125px;
	border : 1px gray solid;
	padding-bottom : 5px;
}

li {
	margin : 0 0 -20px 0;
	border : 0 0 -20px 0;
}
</style>
<script>
$(document).ready(function(){
	
	// mainCategory에 마우스가 올려져 있을 경우 subCategory들이 나타남
	$(function(){
		
		$('#hiddenUL').hide();
		
		$('#topCategory').hover(function() {
	        $(this).children('ul').fadeIn();
	    }, function() {
	        $(this).children('ul').fadeOut(); 
	    });
		
	}); // function hiddenUL
	
});
</script>
<body>

	<!-- Category Content -->
	<div class="m-2" style="font-family : 'Acme';">
	
		<!-- Product -->
		<h6 class="my-2"><b>Category</b></h6>
		
		<pre id="outer">Outer</pre>
		
		<div id="topBtn">
		  <div id="topCategory"><pre>Top</pre>
		  	<ul id="hiddenUL" class="nav">
			  <c:forEach var="subCate" items="${sub}" varStatus="st">
				<li id="${sub.get(st.index)}" class="nav-item col-lg-12">
				  <a id="subCategory_${sub.get(st.index)}" class="nav-link" 
				  	 href="${pageContext.request.contextPath}/product/${sub.get(st.index)}">
					  <span style="color:gray; font-size:12px;">
					  ${sub.get(st.index)}</span>
				  </a>
				</li>
			  </c:forEach>
			</ul>
		  </div>
		</div>
		
		<pre>Bottom</pre>
		<br><br><br><br>
		
		<!-- Community -->
		<h6><b>Community</b></h6>
		<a href="${pageContext.request.contextPath}/board/list.do/boardKinds/1" 
				style="color:black"><pre>Bulletin Board</pre></a>
		<a href="${pageContext.request.contextPath}/board/list.do/boardKinds/2" 
				style="color:black"><pre>Reviews</pre></a>
		<a href="${pageContext.request.contextPath}/board/list.do/boardKinds/3" 
				style="color:black"><pre>Q&amp;A</pre></a>
	</div>
	
</body>
</html>