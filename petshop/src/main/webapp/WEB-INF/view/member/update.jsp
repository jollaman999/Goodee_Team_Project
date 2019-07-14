<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 정보 수정</title>
</head>
<body>
<h2>사용자 정보 수정</h2>
<form:form modelAttribute="member" method="post" action="update.shop">
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
                <form:input path="id" readonly="true" />
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
        <tr height="40px">
            <td>이름</td>
            <td>
                <form:input path="name" />
                <font color="red"><form:errors path="name" /></font>
            </td>
        </tr>
        <tr height="40px">
            <td>전화번호</td>
            <td>
                <form:input path="phone" />
                <font color="red"><form:errors path="phone" /></font>
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
            <td>주소</td>
            <td>
                <form:input path="address" />
                <font color="red"><form:errors path="address" /></font>
            </td>
        </tr>
        <tr height="40px">
            <td>상세 주소</td>
            <td>
                <form:input path="address_detail" />
                <font color="red"><form:errors path="address_detail" /></font>
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
            <td colspan="2" align="center">
                <input type="submit" value="수정">
                <input type="reset" value="초기화">
            </td>
        </tr>
    </table>
</form:form>
</body>
</html>
