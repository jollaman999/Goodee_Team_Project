<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath}" var="path" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <link rel="stylesheet" type="text/css" href="${path}/css/submitform.css">

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
        <form class="header-search-form" action="delete.shop" method="post" name="deleteform">
            <input type="hidden" name="id" value="${param.id}" class="w3-input">
            <c:if test="${sessionScope.loginMember.id != 'admin'}">
                <div style="text-align: center; margin-top: 30px; margin-right: 10%; width: 100%">
                    비밀번호<input type="password" name="pass" style="margin-top: 10px; margin-left: 30px; width: 70%" placeholder="PASSWORD">
                </div>
            </c:if>
            <div class="container-contact100-form-btn">
                <a href="javascript:deleteform.submit()" class="submit-btn contact100-form-btn" style="margin-top: 30px">회원탈퇴</a>
            </div>
        </form>
    </div>
</body>
</html>
