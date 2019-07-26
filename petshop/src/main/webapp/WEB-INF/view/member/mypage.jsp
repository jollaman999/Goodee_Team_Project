<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet" type="text/css" href="${path}/css/submitform.css">

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
    <div class="container-contact100-form-btn">
        <a href="update.shop?id=${member.id}" class="submit-btn contact100-form-btn">회원 정보 수정</a>
        <a href="update_pw.shop" class="submit-btn contact100-form-btn" style="margin-left: 30px">비밀번호 변경</a>
        <c:if test="${member.id != 'admin'}">
            <a href="delete.shop?id=${member.id}" class="submit-btn contact100-form-btn" style="margin-left: 30px">회원 탈퇴</a>
        </c:if>
        <c:if test="${loginMember.id == 'admin'}">
            <a href="${path}/admin/list.shop" class="submit-btn contact100-form-btn" style="margin-left: 30px">회원 목록</a>
        </c:if>
    </div>
</body>
</html>
