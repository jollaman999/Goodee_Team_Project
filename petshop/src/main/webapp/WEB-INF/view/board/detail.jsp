<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 상세 보기</title>
</head>
<body>
<table>
    <tr>
        <td colspan="2">Spring 게시판</td>
    </tr>
    <tr>
        <td width="15%">글쓴이</td>
        <td width="85%">${board.name}</td>
    </tr>
    <tr>
        <td>제목</td>
        <td>${board.subject}</td>
    </tr>
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
        <td>
            <c:if test="${!empty board.fileurl}">
                <a href="file/${board.num}/${board.fileurl}">${board.fileurl}</a>
            </c:if>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <a href="reply.shop?num=${board.num}">[답변]</a>
            <a href="update.shop?num=${board.num}">[수정]</a>
            <a href="delete.shop?num=${board.num}">[삭제]</a>
            <a href="list.shop">[게시물 목록]</a>
        </td>
    </tr>
</table>
</body>
</html>
