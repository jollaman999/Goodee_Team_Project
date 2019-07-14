<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
</head>
<body>
<form:form modelAttribute="member" method="post" action="login.shop">
    <input type="hidden" name="name" value="유효성 검증 통과">
    <input type="hidden" name="phone" value="유효성 검증 통과">
    <input type="hidden" name="email" value="유효성 검증 통과">
    <input type="hidden" name="address" value="유효성 검증 통과">
    <spring:hasBindErrors name="member">
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
                <form:input path="id" />
                <font color="red"><form:errors path="id" /></font>
            </td>
        </tr>
        <tr height="40px">
            <td>비밀번호</td>
            <td>
                <form:password path="pass" />
                <font color="red"><form:errors path="pass" /></font>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <input type="submit" value="로그인">&nbsp;
                <input type="button" value="회원가입" onclick="location.href='memberEntry.shop'">
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>
