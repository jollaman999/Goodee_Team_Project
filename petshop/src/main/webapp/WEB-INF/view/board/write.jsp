<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 작성</title>

	<link rel="stylesheet" type="text/css" href="${path}/css/w3.css">
</head>
<body>
	<form name="f" method="post" action="write.shop"
		enctype="multipart/form-data">
		<input type="hidden" name="type" value="${param.type}"> 
		<input type="hidden" name="member_id" value="${sessionScope.loginMember.id}">
		<input type="hidden" name="item_no" value="${param.item_no}">
		<br>
		<table>
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" size="100"></td>
			</tr>
			<tr>
				<td>상품 이름</td>
				<td>
				<c:forEach items="${param.item_no}" var="item_no">
				<c:forEach items="${itemList}" var="itemList">
				<c:if test="${itemList.item_no eq board.item_no}">
				<c:out value="${item.name}"/>
				</c:if>                
                </c:forEach>
                </c:forEach>
				</td>
				<!-- <input type="text" name="item_no" value="${param.item_no}"> -->
			</tr>
			<tr>
				<td>첨부파일</td>
				<td><input type="file" name="file1"></td>
			</tr>

			<tr>
				<td colspan="2"><textarea name="content" cols="120" rows="10"></textarea>
					<script type="text/javascript">
						CKEDITOR.replace("content", {
							filebrowserImageUploadUrl : "imgupload.shop",
							language : "ko",
							skin : "moono"
						});
					</script></td>
			</tr>
			<tr>
				<td colspan="2" style="border: 0; padding-top: 20px">
					<input class="w3-button w3-bar-item w3-deep-purple" type="submit" value="게시판 등록"
						   style="margin-right: 10px">
					<input class="w3-button w3-bar-item w3-deep-purple" type="button" onclick="location.href='list.shop?type=${param.type}'" value="게시글 목록">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
