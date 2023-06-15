
<!-- manager_qna -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mate With 문의 관리</title>
<link href="${pageContext.request.contextPath}/resources/chenggyu/board.css?v=2" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/chenggyu/page.css" rel="stylesheet" type="text/css">
<style type="text/css">
table             { 
  border-spacing: 1; 
  border-collapse: collapse; 
  background:white;
  border-radius:6px;
  overflow:hidden;
  max-width:800px; 
  width:100%;
  margin:0 auto;
  position:relative;
  }
    td,th           { 
    padding-left:8px;
    text-align: center;
    }

  thead tr  { 
    height:50px;
    background:#A996DB;
    font-size:16px;
  }
  
  tbody tr     { 
  height:48px; 
  border-bottom:1px solid #E3F1D5 ;
    &:last-child  { border:0; }
  }
 
</style>
</head>
<body>

	<c:import url="../default/header.jsp"/>
	
	<section><!-- body -->
		<div class="form-box"> <!--  container  -->
		<div class="title" >문의 관리</div>
		<table >
		<thead>
			<tr>
					<th>작성자</th>
					<th>제목</th>
					<th>작성일</th>
					<th >상태</th>
			</tr>
		</thead>
			<c:if test="${qnaList.size() == 0 }">
				<tr>	
					<th colspan="4"> 등록된 글이 없습니다. </th>
				</tr>
			</c:if>
			<c:forEach var="dto"  items="${qnaList }">
				<tr>	
					<th> ${dto.id }</th>
					<th> <a href="${contextPath}/board/ContentView?write_no=${dto.write_no}">${dto.title }</a></th>
					<th> ${dto.savedate }</th>
					<c:if test="${dto.status == 1}">
					<th>대기</th>
					</c:if>
					<c:if test="${dto.status != 1}">
					<th>완료</th>
					</c:if>
				</tr>
			</c:forEach>	
		</table>
			<div class="page_wrap">
			   <div class="page_nation">
			      <!-- <a class="arrow pprev" href="#"></a> -->  
					<c:forEach  var="num" begin="1" end="${repeat }">
								<a href="manager_qna?num=${num }" class="active"> &nbsp; ${num } &nbsp;</a>
					</c:forEach>
			      <!-- <a class="arrow nnext" href="#"></a> -->
			   </div>
			</div>		
		</div>
	</section>
	
	<c:import url="../default/footer.jsp"/>

</body>
</html>