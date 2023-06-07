<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style type="text/css">

h1 {
	text-align: center;
}


.wrap {
	margin: 0 auto;
}

.table {
	display: block;
	justify-content: center;
}

table tr:last-child {
	text-align: right;
}

#paging {
	color: black;
	text-decoration: none;
}
#currentPaging {
	color: red;
	text-decoration: underline;
}

body {
	z-index: 
}
</style>

</head>
<body>
<%-- <c:import url="../../default/header.jsp"/> --%>
	<h1>공지사항</h1>
	<div class="wrap board_table">
		<table class="table table-striped">
			<tr>
				<th width="70px"> 번 호 </th>
				<th width="200px"> 제 목 </th>
				<th width="150px"> 작성자 </th>
				<th width="200px"> 날 짜 </th>
				<th width="70px"> 조회수 </th>
				<c:if test ="${info.grade == admin}"> <!-- info.grade(gold) == admin(관리자) 일 때 -->
					<th>관리자 권한</th>
				</c:if>
			</tr>
			
			
			<c:choose>
				<c:when test="${empty noticeBoardList}"> <!-- ${boardList.size() == 0} -->
					<tr>
						<td colspan="6">등록된 글이 없습니다.</td>
					</tr>	
				</c:when>
				<c:otherwise>
					<c:forEach var="noticeBoardDTO" items="${noticeBoardList }">
						<tr>
							<td>${noticeBoardDTO.write_no}</td>
							<td><a href="${contextPath }/board/notice/noticeBoardContentView?write_no=${noticeBoardDTO.write_no}&num=${num}">${noticeBoardDTO.title }</a></td>
							<td>${noticeBoardDTO.id }</td>
							<td>${noticeBoardDTO.savedate }</td>
							<td>${noticeBoardDTO.hit }</td>
							<c:if test ="${info.grade == admin}">
								<td><button onclick="location.href='${contextPath}/board/notice/noticeBoardDelete?write_no=${noticeBoardDTO.write_no}&file_name=${noticeBoardDTO.file_name }'">삭제</button></td>
							</c:if>
						<tr>	
					</c:forEach>
				</c:otherwise>
			</c:choose>
			
			<tr>
				<c:choose>
					<c:when test="${info.grade == admin}"> <!-- 관리자이면 -->
						<td colspan="6" align="center">
					</c:when>
					<c:otherwise>
						<td colspan="5" align="center">
					</c:otherwise>
				</c:choose>
		
				<!-- 페이징 -->
				<div id="paging_block">
					<c:if test="${startPage > block }">
						[ <a href="${contextPath }/board/notice/noticeBoardAllList?num=${startPage-1 }" id="paging"> 이전 </a> ]
					</c:if>
					<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
						<c:if test="${i == num}">
							[ <a href="${contextPath }/board/notice/noticeBoardAllList?num=${i }" id="currentPaging"> ${i } </a> ]
						</c:if>
						<c:if test="${i != num}">
							[ <a href="${contextPath }/board/notice/noticeBoardAllList?num=${i }" id="paging"> ${i } </a> ]
						</c:if>
					</c:forEach>
					<c:if test="${endPage < totalPage }">
						[ <a href="${contextPath }/board/notice/noticeBoardAllList?num=${endPage+1 }" id="paging"> 다음 </a> ]
					</c:if>
				</div>
				</td>
			</tr>
			
			<tr>
				<c:choose>
					<c:when test="${info.grade == admin}">
						<td colspan="7" align="center">	
						<a href="${contextPath }/board/notice/noticeBoardWriteForm">글작성</a> <!-- 관리자만 글 작성 가능 -->
					</c:when>
					<c:otherwise>
						<td colspan="6" align="center">
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
		</table>
		
		<a href="${contextPath }/index">메인으로</a>
	</div>
<%-- <c:import url="../../default/footer.jsp"/> --%>
</body>
</html>