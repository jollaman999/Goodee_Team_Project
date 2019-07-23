<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet" type="text/css" href="${path}/css/style.css" />

    <title>댓글 삭제 확인</title>

    <style type="text/css">
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 11pt;
        }

        th, td {
            border: 0;
            text-align: center;
            padding: 8px;
        }
    </style>
</head>
<body>
<div style="margin: 15px">
    <form action="delete.shop" name="f" method="post">
        <input type="hidden" name="num" value="${param.num}">
        <input type="hidden" name="type" value="${param.type}">
        <input type="hidden" name="itemno" value="${param.itemno}">
        <input type="hidden" name="pageNum" value="${param.pageNum}">

        <table>
            <tr>
                <td><h6>댓글을 삭제하시겠습니까?</h6></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="삭제" class="btn musica-btn">&nbsp;&nbsp;&nbsp;
                    <input type="button" name="cancel" value="취소" class="btn musica-btn" onclick="self.close()">
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>