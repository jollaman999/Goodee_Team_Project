<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <script src="https://cdn.ckeditor.com/4.5.7/full-all/ckeditor.js"></script>
</head>
<body>
<form:form modelAttribute="board" action="write.shop" enctype="multipart/form-data" name="f">
    <table>
        <tr>
            <td>제목</td>
            <td>
                <form:input path="title" />
                <font color="red"><form:errors path="title" /></font>
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <form:textarea path="content" rows="15" cols="80" />
                <font color="red"><form:errors path="content" /></font>
                <script type="text/javascript">
                    CKEDITOR.replace("content", {filebrowserImageUploadUrl : "imgupload.shop", language : "ko", skin : "moono"});
                </script>
            </td>
        </tr>
        <tr>
            <td>첨부파일</td>
            <td>
                <input type="file" name="file1">
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <a href="javascript:document.f.submit()">[게시글 등록]</a>
                <a href="list.shop">[게시글 목록]</a>
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>
