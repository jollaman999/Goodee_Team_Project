<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 등록</title>
</head>
<body>
<h2>사용자 등록</h2>
<form:form modelAttribute="user" method="post" action="userEntry.shop">
    <spring:hasBindErrors name="user">
        <font color="red">
            <c:forEach items="${errors.globalErrors}" var="error">
                <spring:message code="${error.code}" />
            </c:forEach>
        </font>
    </spring:hasBindErrors>
    <table border="1" style="border-collapse: collapse">
        <tr height="40px">
            <td>아이디</td>
            <td>
                <form:input path="userId" />
                <font color="red"><form:errors path="userId" /></font>
            </td>
        </tr>
        <tr height="40px">
            <td>비밀번호</td>
            <td>
                <form:password path="password" />
                <font color="red"><form:errors path="password" /></font>
            </td>
        </tr>
        <tr height="40px">
            <td>이름</td>
            <td>
                <form:input path="userName" />
                <font color="red"><form:errors path="userName" /></font>
            </td>
        </tr>
        <tr height="40px">
            <td>전화번호</td>
            <td>
                <form:input path="phoneNo" />
                <font color="red"><form:errors path="phoneNo" /></font>
            </td>
        </tr>
        <tr height="40px">
            <td>우편번호</td>
            <td>
                <form:input path="postcode" />
                <font color="red"><form:errors path="postcode" /></font>
            </td>
        </tr>
        <tr height="40px">
            <td>주소</td>
            <td>
                <form:input path="address" />
                <font color="red"><form:errors path="address" /></font>
            </td>
        </tr>
        <tr height="40px">
            <td>이메일</td>
            <td>
                <form:input path="email" />
                <font color="red"><form:errors path="email" /></font>
            </td>
        </tr>
        <tr height="40px">
            <td>생년월일</td>
            <td>
                <form:input path="birthDay" />
                <font color="red"><form:errors path="birthDay" /></font>
            </td>
        </tr>
        <tr height="40px">
            <td colspan="2" align="center">
                <input type="submit" value="등록">
                <input type="reset" value="초기화">
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>
