<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><decorator:title /></title>
    <script type="text/javascript" src="${path}/js/jquery-3.2.1.min.js"></script>
    <decorator:head />
</head>
<body>
<table>
    <tr>
        <td colspan="3" align="right">
            <c:if test="${empty sessionScope.loginUser}">
                <a href="${path}/user/login.shop">로그인</a>&nbsp;
                <a href="${path}/user/memberEntry.shop">회원 가입</a>
            </c:if>
            <c:if test="${!empty sessionScope.loginUser}">
                ${sessionScope.loginUser.userName}님
                <a href="${path}/user/logout.shop">로그아웃</a>
            </c:if>
        </td>
    </tr>
    <tr>
        <td width="15%" valign="top">
            <a href="${path}/user/mypage.shop?id=${sessionScope.loginUser.userId}">회원 관리</a><br>
            <a href="${path}/item/list.shop">상품 관리</a><br>
            <a href="${path}/board/list.shop">게시판</a><br>
            <a href="${path}/chat/chat.shop">채팅</a>
        </td>
        <td colspan="2" style="text-align: left; vertical-align: top">
            <decorator:body />
        </td>
    </tr>
    <tr>
        <td colspan="3">구디아카데이 Since 2016</td>
    </tr>
</table>
<link rel="stylesheet" href="${path}/css/main.css">
</body>
</html>
