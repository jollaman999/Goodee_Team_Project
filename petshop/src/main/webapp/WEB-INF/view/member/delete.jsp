<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet" type="text/css" href="${path}/css/w3.css">

    <title>회원 탈퇴 확인</title>
</head>
<body>
    <h3 style="text-align: center; margin-bottom: 25px">회원 탈퇴 확인</h3>
    <table>
        <tr>
            <td>아이디</td>
            <td>${member.id}</td>
        </tr>
        <tr>
            <td>이름</td>
            <td>${member.name}</td>
        </tr>
    </table>

    <div style="text-align: center; width: 100%">
        <form action="delete.shop" method="post" name="deleteform">
            <input type="hidden" name="id" value="${param.id}" class="w3-input">
            <div style="text-align: center; margin-top: 30px; margin-left: 100px; margin-right: 100px">
                비밀번호<input type="password" name="pass" style="margin-top: 10px; margin-bottom: 30px">
            </div>
            <a href="javascript:deleteform.submit()" class="w3-btn w3-purple">회원탈퇴</a>
        </form>
    </div>
</body>
</html>
