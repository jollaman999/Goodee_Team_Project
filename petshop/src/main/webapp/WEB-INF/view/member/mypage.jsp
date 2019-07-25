<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">

    <title>마이페이지</title>
</head>
<body>
    <h3 style="text-align: center; margin-bottom: 25px">회원 정보</h3>
    <table>
        <tbody>
        <tr>
            <td>아이디</td>
            <td>${member.id}</td>
        </tr>
        <tr>
            <td>이름</td>
            <td>${member.name}</td>
        </tr>
        <tr>
            <td>전화번호</td>
            <td>${member.phone}</td>
        </tr>
        <tr>
            <td>이메일</td>
            <td>${member.email}</td>
        </tr>
        <tr>
            <td>주소</td>
            <td>${member.address}</td>
        </tr>
        <tr>
            <td>상세 주소</td>
            <td>${member.address_detail}</td>
        </tr>
        <tr>
            <td>우편번호</td>
            <td>${member.postcode}</td>
        </tr>
        <tbody>
    </table>
    <br>
    <div style="text-align: center">
        <a href="update.shop?id=${member.id}" class="w3-btn w3-purple">회원 정보 수정</a>&nbsp;&nbsp;
        <c:if test="${member.id != 'admin'}">
            <a href="delete.shop?id=${member.id}" class="w3-btn w3-purple">회원 탈퇴</a>
        </c:if>
        <c:if test="${loginMember.id == 'admin'}">
            &nbsp;&nbsp;<a href="${path}/admin/list.shop" class="w3-btn w3-purple">회원 목록</a>
        </c:if>
    </div>
</body>
</html>
