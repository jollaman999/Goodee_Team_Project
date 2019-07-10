<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 답글 쓰기</title>
    <script src="https://cdn.ckeditor.com/4.5.7/full-all/ckeditor.js"></script>
</head>
<body>
<form:form modelAttribute="board" action="reply.shop" enctype="multipart/form-data" name="f">
    <form:hidden path="num"/>
    <form:hidden path="ref"/>
    <form:hidden path="reflevel"/>
    <form:hidden path="refstep"/>

    <table>
        <caption>게시판 답글 등록</caption>

        <tr>
            <td>글쓴이</td>
            <td>
                <form:input path="name" />
                <font color="red"><form:errors path="name" /></font>
            </td>
        </tr>
        <tr>
            <td>비밀번호</td>
            <td>
                <form:password path="pass" />
                <font color="red"><form:errors path="pass" /></font>
            </td>
        </tr>
        <tr>
            <td>제목</td>
            <td>
                <form:input path="subject" value="RE: ${board.subject}: " />
                <font color="red"><form:errors path="subject" /></font>
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" rows="15" cols="80"></textarea>
                <font color="red"><form:errors path="content" /></font>
                <script type="text/javascript">
                    CKEDITOR.replace("content", {filebrowserImageUploadUrl : "imgupload.shop?CKEditorFuncNum=1"})
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
                <a href="javascript:document.f.submit()">[답변글등록]</a>
            </td>
        </tr>
    </table>
</form:form>

</body>
</html>
