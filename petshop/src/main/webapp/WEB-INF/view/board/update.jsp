<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>

    <script src="https://cdn.ckeditor.com/4.5.7/full-all/ckeditor.js"></script>

    <script type="text/javascript">
        function file_delete() {
            document.getElementById("file_desc").innerHTML ="<input type=\"file\" name=\"file1\">";
        }
    </script>

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">
</head>
<body>
<br>
<form:form modelAttribute="board" action="update.shop" enctype="multipart/form-data" name="f">
    <form:hidden path="num" />
    <form:hidden path="type" />
    <input type="hidden" name="member_id" value="${sessionScope.loginMember.id}">

    <table>
        <tr>
            <td>제목</td>
            <td>
                <form:input path="title" />
                <font color="red"><form:errors path="title" /></font>
            </td>
        </tr>
        <tr>
	        <td>상품이름</td>
	        <td>${board.item_name}</td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <form:textarea path="content" rows="15" cols="80" />
                <font color="red"><form:errors path="content" /></font>
                <script type="text/javascript">
                    CKEDITOR.replace("content", {filebrowserImageUploadUrl : "imgupload.shop"});
                </script>
            </td>
        </tr>
        <tr>
            <td>첨부파일</td>
            <td>
                <c:choose>
                    <c:when test="${!empty board.fileurl}">
                        <div id="file_desc">
                            <a href="file/${board.num}/${board.fileurl}">${board.fileurl}</a>
                            <a class="w3-button w3-bar-item w3-deep-purple" href="javascript:file_delete()">첨부 파일 삭제</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <input type="file" name="file1">
                    </c:otherwise>
                </c:choose>
                <form:hidden path="fileurl" />
            </td>
        </tr>
        <tr>
            <td colspan="2" style="border: 0; padding-top: 20px">
                <a class="w3-button w3-bar-item w3-deep-purple" href="javascript:document.f.submit()"
                   style="margin-right: 10px">게시글 수정</a>
                <a class="w3-button w3-bar-item w3-deep-purple" href="list.shop">게시글 목록</a>
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>
