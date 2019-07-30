<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 상세 보기</title>

	<link rel="stylesheet" type="text/css" href="${path}/css/w3.css">
</head>
<body>
	<br>
	<table>
		<tr>
			<td>글쓴이</td>
			<td>${board.name}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${board.title}</td>
		</tr>
		<c:if test="${param.type != 0}">
			<tr>
				<td>상품 이름</td>
				<td>${board.item_name}</td>
			</tr>
		</c:if>
		<tr>
			<td>내용</td>
			<td>
				<table width="100%" height="250">
					<tr>
						<td>${board.content}</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>첨부 파일</td>
			<td><c:if test="${!empty board.fileurl}">
					<a href="file/${board.num}/${board.fileurl}" target="_blank">${board.fileurl}</a>
				</c:if></td>
		</tr>
		<tr>
			<td colspan="2" style="border: 0; padding-top: 20px">
				<c:if test="${board.refstep == 0}">
					<a class="w3-button w3-bar-item w3-deep-purple" href="reply.shop?type=${param.type}&num=${board.num}&item_no=${board.item_no}"
					   style="margin-right: 10px">답변</a>
				</c:if>
				<a class="w3-button w3-bar-item w3-deep-purple" href="update.shop?type=${param.type}&num=${board.num}"
				   style="margin-right: 10px">수정</a>
				<a class="w3-button w3-bar-item w3-deep-purple" href="delete.shop?type=${param.type}&num=${board.num}"
				   style="margin-right: 10px">삭제</a>
				<a class="w3-button w3-bar-item w3-deep-purple" href="list.shop?type=${param.type}">게시물 목록</a></td>
		</tr>
	</table>
</body>
</html>
