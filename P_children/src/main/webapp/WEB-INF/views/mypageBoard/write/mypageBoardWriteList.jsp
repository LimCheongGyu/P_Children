<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>    
<script src="https://code.jquery.com/jquery-3.6.4.js" integrity="sha256-a9jBBRygX1Bh5lt8GZjXDzyOB+bWve9EiO7tROUtj/E=" crossorigin="anonymous"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 작성한 게시판</title>
<style type="text/css">
table, th, tr, td {
	border: 1px solid black;
	border-collapse: collapse;
}

/* 숨기기 */
.valueHiddenView {
	display: none;
}

/* 검색 버튼 */
.search_area {
	text-align: center;
}
</style>
</head>
<body>
	 <h1>작성한 게시글</h1>
		<table>
			<!-- 제목 칼럼 -->
			<tr>
				<th>구 분</th>
				<th>제 목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>		
			</tr>
			<!-- // 제목 칼럼 끝 -->
			
			<!-- 내용 시작 -->
				<c:choose>
					<c:when test="${empty mypageBoardList}">
						<tr>
							<td colspan="5">등록된 글이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach var="mypageBoardList" items="${mypageBoardList}">
							<tr>
								<td class="valueHiddenView" id="write_no">${mypageBoardList.write_no}</td> <!-- 숨기는 값 -->
								<td class="valueHiddenView" id="file_name">${mypageBoardList.file_name}</td> <!-- 숨기는 값 -->
								<td>
									<c:if test="${mypageBoardList.category == 'informationSharing' }">
									 정보 공유 
									</c:if>
									<c:if test="${mypageBoardList.category == 'friendshipPromotion' }">
									 친목 도모 
									</c:if>
									<c:if test="${mypageBoardList.category == 'petSneak' }">
									 펫 간식 
									</c:if>
									<c:if test="${mypageBoardList.category == 'smallChat' }">
									 잡담 
									</c:if>
									<c:if test="${mypageBoardList.category == 'lookForPetFriend' }">
									 펫프랜드 구합니다 
									</c:if>
									<c:if test="${mypageBoardList.category == 'BeingPetFriend' }">
									 펫프랜드 합니다 
									</c:if>
								</td>
								<c:choose>
									<c:when test="${myBoard_category == null}">
										<td><a href="${contextPath }/board/contentView?write_no=${mypageBoardList.write_no}&num=${num}">${mypageBoardList.title }</a></td>
									</c:when>
									<c:otherwise>
										<td><a href="${contextPath }/mypageBoard/write/myBoardSearchForm?write_no=${mypageBoardList.write_no}&num=${num}&myBoard_category=${myBoard_category }&myBoard_searchCategory=${myBoard_searchCategory}&myBoard_searchKeyword=${myBoard_searchKeyword}">${mypageBoardList.title }</a></td>
									</c:otherwise>
								</c:choose>
								<td>${mypageBoardList.id}</td>
								<td>${mypageBoardList.savedate}</td>
								<td>${mypageBoardList.hit}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			<!-- 내용 끝 -->
			
			<!-- 페이징 시작 -->
			<tr>
				<td colspan="5" align="center">
					<div>
						<!-- 카테고리 선택이 null 이면 -> 검색 안했을 때 -->
						<c:if test="${myBoard_category == null}">
							<c:if test="${startPage > block }">
								[ <a href="${contextPath }/mypageBoard/write/mypageBoardWriteList?num=${startPage-1 }" id="paging"> 이전 </a> ]
							</c:if>
							<c:forEach var="i" begin="${startPage }" end="${endPage }" step="1">
								<c:if test="${i == num}">
									[ <a href="${contextPath }/mypageBoard/write/mypageBoardWriteList?num=${i }" id="currentPaging"> ${i } </a> ]
								</c:if>
								<c:if test="${i != num}">
									[ <a href="${contextPath }/mypageBoard/write/mypageBoardWriteList?num=${i }" id="paging"> ${i } </a> ]
								</c:if>
							</c:forEach>
							<c:if test="${endPage < totalPage }">
								[ <a href="${contextPath }/mypageBoard/write/mypageBoardWriteList?num=${endPage+1 }" id="paging"> 다음 </a> ]
							</c:if>
						</c:if>
					</div>
				</td>
			</tr>
			<!-- 페이징 끝 -->
	
		</table>	
		<!-- 테이블 끝 -->
		
		<a href="${contextPath }/index">메인으로</a>
</body>
</html>