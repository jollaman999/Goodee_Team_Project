<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>
    	게시글 작성 - ${board_title}
    </title>
</head>
<body>
<form name="f" method="post" action="write.shop" enctype="multipart/form-data">
	<input type="hidden" name="type" value="${param.type}">
	<input type="hidden" name="member_id" value="${sessionScope.loginMember.id}">

	<br>
	<table>
		<tr>
			<td>제목</td>
			<td><input type="text" name="title" size="100"></td>
		</tr>
		<tr>
			<td>첨부파일 1</td>
			<td><input type="file" name="file1"></td>
		</tr>

		<tr>
			<td colspan="2"><textarea name="content" cols="120" rows="10"></textarea>
				<script type="text/javascript">
                   	CKEDITOR.replace("content", {filebrowserImageUploadUrl : "imgupload.shop", language : "ko", skin : "moono"});
               	</script>
               </td>
		</tr>
		<tr>
			<td colspan="2"><input type="submit" value="게시판 등록"></td>
		</tr>
	</table>
</form>
</body>
</html>
