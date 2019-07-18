<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
</head>
<body>
<h2>장바구니</h2>
<table>
    <tr>
        <td colspan="4">장바구니 상품 목록</td>
    </tr>
    <tr>
        <th>상품명</th>
        <th>가격</th>
        <th>수량</th>
        <th>합계</th>
    </tr>
    <c:set var="tot" value="${0}" />
    <c:forEach items="${sessionScope.CART.itemSetList}" var="itemSet" varStatus="stat">
        <tr>
            <td>${itemSet.item.name}</td>
            <td>${itemSet.item.price}</td>
            <td>${itemSet.quantity}</td>
            <td>${itemSet.item.price * itemSet.quantity}<a href="cartDelete.shop?index=${stat.index}">ⓧ</a></td>
            <c:set var="tot" value="${tot + (itemSet.item.price * itemSet.quantity)}" />
        </tr>
    </c:forEach>
    <tr>
        <td colspan="4" align="right">
            총 구입 금액: <fmt:formatNumber value="${tot}" pattern="###,###" />원
        </td>
    </tr>
    <tr>
        <td colspan="4">
            <a href="checkout.shop">주문 하기</a>
            <a href="../item/list.shop">상품 목록</a>&nbsp;
        </td>
    </tr>
</table>
<br>
${message}<br>
${message2}<br>
<a href="../item/list.shop">상품 목록</a>
<a href="checkout.shop">주문 하기</a>
</body>
</html>
